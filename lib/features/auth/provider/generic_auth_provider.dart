
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class GenericAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // --- State Variables ---
  bool isLoading = false;
  String? selectedRole;
  Map<String, dynamic>? userData;
  User? _currentUser;

  // --- Dashboard Stats ---
  int totalDonations = 0;
  int totalReceived = 0;
  int totalDeliveries = 0;
  int pendingCount = 0;
  int totalPosts = 0;
  int notificationCount = 0;

  // --- Listeners ---
  StreamSubscription? _notificationSubscription;
  StreamSubscription? _postSubscription;
  StreamSubscription? _requestSubscription;

  User? get user => _currentUser ?? _auth.currentUser;

  GenericAuthProvider() {
    _auth.authStateChanges().listen((user) async {
      _currentUser = user;
      if (user != null) {
        await fetchUserData();
        _initRealTimeListeners();
        saveDeviceToken();
      } else {
        _clearData();
      }
      notifyListeners();
    });
  }

  // ================= 1. Real-time Listeners (Donor, Receiver & Volunteer) =================

  void _initRealTimeListeners() {
    _cancelAllSubscriptions();
    if (user == null || selectedRole == null) return;

    final uid = user!.uid;

    // 1. Notification Listener (Based on Role)
    if (selectedRole == 'donor') {
      _notificationSubscription = _firestore
          .collection('requests')
          .where('donorId', isEqualTo: uid)
          .where('status', isEqualTo: 'pending')
          .snapshots().listen((snap) {
        notificationCount = snap.docs.length;
        notifyListeners();
      });
    } else if (selectedRole == 'receiver') {
      _notificationSubscription = _firestore
          .collection('requests')
          .where('receiverId', isEqualTo: uid)
          .where('status', whereIn: ['approved', 'received', 'delivered', 'rejected'])
          .snapshots().listen((snap) {
        notificationCount = snap.docs.length;
        notifyListeners();
      });
    } else if (selectedRole == 'volunteer') {
      _notificationSubscription = _firestore
          .collection('requests')
          .where('status', isEqualTo: 'approved')
          .snapshots().listen((snap) {
        // "Available" logic: status is approved and no volunteer is assigned yet
        notificationCount = snap.docs.where((d) {
          final data = d.data();
          return data['volunteerId'] == null || data['volunteerId'] == "";
        }).length;
        notifyListeners();
      });
    }

    // 2. Real-time Stats Listener
    _requestSubscription = _firestore
        .collection('requests')
        .snapshots().listen((snap) {
      _calculateStatsLocally(snap.docs, uid);
    });

    if (selectedRole == 'donor') {
      _postSubscription = _firestore
          .collection('posts')
          .where('donorId', isEqualTo: uid)
          .snapshots().listen((snap) {
        totalPosts = snap.docs.length;
        notifyListeners();
      });
    }
  }

  void _calculateStatsLocally(List<QueryDocumentSnapshot> docs, String uid) {
    if (selectedRole == 'donor') {
      totalDonations = docs.where((d) => d['donorId'] == uid && d['status'] == 'delivered').length;
    } else if (selectedRole == 'receiver') {
      pendingCount = docs.where((d) => d['receiverId'] == uid && d['status'] == 'pending').length;
      totalReceived = docs.where((d) => d['receiverId'] == uid && ['approved', 'received', 'delivered'].contains(d['status'])).length;
    } else if (selectedRole == 'volunteer') {
      totalDeliveries = docs.where((d) => d['volunteerId'] == uid && d['status'] == 'delivered').length;
      pendingCount = docs.where((d) => d['volunteerId'] == uid && d['status'] == 'received').length;
    }
    notifyListeners();
  }

  void _cancelAllSubscriptions() {
    _notificationSubscription?.cancel();
    _postSubscription?.cancel();
    _requestSubscription?.cancel();
  }

  // ================= 2. Auth Operations =================

  Future<String?> signup(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      await fetchUserData();
      _initRealTimeListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  // ================= 3. User & Profile Management =================

  Future<void> fetchUserData() async {
    if (user == null) return;
    try {
      final doc = await _firestore.collection('accounts').doc(user!.uid).get();
      if (doc.exists) {
        userData = doc.data();
        selectedRole = userData?['role']?.toString().toLowerCase();
        await countUserStats();
      }
    } catch (e) {
      debugPrint("Fetch Data Error: $e");
    }
  }

  Future<void> countUserStats() async {
    if (user == null || selectedRole == null) return;
    try {
      final querySnapshot = await _firestore.collection('requests').get();
      _calculateStatsLocally(querySnapshot.docs, user!.uid);
      if (selectedRole == 'donor') {
        final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: user!.uid).get();
        totalPosts = postSnap.docs.length;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Stats Calculation Error: $e");
    }
  }

  Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
    if (user == null) return;
    try {
      _setLoading(true);
      String? currentRole = selectedRole ?? userData?['role'];

      await _firestore.collection('accounts').doc(user!.uid).set({
        "role": currentRole,
        "profile": { ...profileData, "completed": true },
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await fetchUserData();
    } catch (e) {
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> isProfileCompleted() async {
    if (user == null) return false;
    try {
      final doc = await _firestore.collection('accounts').doc(user!.uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return data['profile'] != null && data['profile']['completed'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveUserRole(String role) async {
    if (user == null) return;
    try {
      _setLoading(true);
      String roleFormatted = role.trim().toLowerCase();
      await _firestore.collection('accounts').doc(user!.uid).set({
        "uid": user!.uid,
        "email": user!.email,
        "role": roleFormatted,
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      selectedRole = roleFormatted;
      _initRealTimeListeners();
      notifyListeners();
    } catch (e) {
      debugPrint("Save Role Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  // ================= 4. Helpers & Cleanup =================

  void resetNotificationCount() {
    notificationCount = 0;
    notifyListeners();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _clearData() {
    userData = null;
    selectedRole = null;
    totalDonations = totalReceived = totalDeliveries = pendingCount = totalPosts = notificationCount = 0;
    _cancelAllSubscriptions();
    notifyListeners();
  }

  Future<void> logout() async {
    _clearData();
    await _auth.signOut();
  }

  Future<void> saveDeviceToken() async {
    if (user == null) return;
    try {
      String? token = await _fcm.getToken();
      if (token != null) {
        await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
      }
    } catch (_) {}
  }
}