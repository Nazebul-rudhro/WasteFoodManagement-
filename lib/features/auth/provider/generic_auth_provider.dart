// // //
// // //
// // // import 'dart:async';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // class GenericAuthProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// // //
// // //   // --- State Variables ---
// // //   bool isLoading = false;
// // //   String? selectedRole;
// // //   Map<String, dynamic>? userData;
// // //   User? _currentUser;
// // //
// // //   // --- Dashboard Stats ---
// // //   int totalDonations = 0;
// // //   int totalReceived = 0;
// // //   int totalDeliveries = 0;
// // //   int pendingCount = 0;
// // //   int totalPosts = 0;
// // //   int notificationCount = 0;
// // //
// // //   // --- Listeners ---
// // //   StreamSubscription<QuerySnapshot>? _notificationSubscription;
// // //   StreamSubscription<QuerySnapshot>? _postSubscription;
// // //
// // //   User? get user => _currentUser ?? _auth.currentUser;
// // //
// // //   GenericAuthProvider() {
// // //     _auth.authStateChanges().listen((user) async {
// // //       _currentUser = user;
// // //       if (user != null) {
// // //         await fetchUserData();
// // //         _initRealTimePostCount();
// // //         _initRealTimeNotifications();
// // //         saveDeviceToken();
// // //       } else {
// // //         _clearData();
// // //       }
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // ================= 1. Real-time Listeners =================
// // //   void _initRealTimePostCount() {
// // //     _postSubscription?.cancel();
// // //     if (user == null) return;
// // //     _postSubscription = _firestore
// // //         .collection('posts')
// // //         .where('donorId', isEqualTo: user!.uid)
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       totalPosts = snapshot.docs.length;
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   void _initRealTimeNotifications() {
// // //     _notificationSubscription?.cancel();
// // //     if (user == null) return;
// // //     _notificationSubscription = _firestore
// // //         .collection('requests')
// // //         .where('donorId', isEqualTo: user!.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       notificationCount = snapshot.docs.length;
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // 🔹 Reset Notification Method (Re-added)
// // //   void resetNotificationCount() {
// // //     notificationCount = 0;
// // //     notifyListeners();
// // //   }
// // //
// // //   // ================= 2. Role & User Data =================
// // //   Future<void> loadUserRole() async {
// // //     if (user == null) return;
// // //     try {
// // //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// // //       if (doc.exists) {
// // //         selectedRole = doc.data()?['role'];
// // //         notifyListeners();
// // //       }
// // //     } catch (e) {
// // //       debugPrint("Load Role Error: $e");
// // //     }
// // //   }
// // //
// // //   Future<void> saveUserRole(String role) async {
// // //     if (user == null) return;
// // //     try {
// // //       selectedRole = role.toLowerCase();
// // //       await _firestore.collection('accounts').doc(user!.uid).set({
// // //         "role": selectedRole,
// // //         "updatedAt": FieldValue.serverTimestamp(),
// // //       }, SetOptions(merge: true));
// // //       notifyListeners();
// // //     } catch (e) {
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   Future<void> fetchUserData() async {
// // //     if (user == null) return;
// // //     try {
// // //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// // //       if (doc.exists) {
// // //         userData = doc.data();
// // //         selectedRole = userData?['role'];
// // //         await countUserStats();
// // //       }
// // //     } catch (e) {
// // //       debugPrint("Fetch Data Error: $e");
// // //     } finally {
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // ================= 3. Dashboard Stats =================
// // //   Future<void> countUserStats() async {
// // //     if (user == null) return;
// // //     final String uid = user!.uid;
// // //     try {
// // //       final donorSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).where('status', isEqualTo: 'approved').get();
// // //       totalDonations = donorSnap.docs.length;
// // //
// // //       final reqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
// // //       totalReceived = reqSnap.docs.where((d) => d['status'] == 'approved').length;
// // //       pendingCount = reqSnap.docs.where((d) => d['status'] == 'pending').length;
// // //
// // //       final volSnap = await _firestore.collection('requests').where('volunteerId', isEqualTo: uid).where('status', isEqualTo: 'completed').get();
// // //       totalDeliveries = volSnap.docs.length;
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Stats Error: $e");
// // //     }
// // //   }
// // //
// // //   // ================= 4. Profile Management =================
// // //   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
// // //     if (user == null) return;
// // //     try {
// // //       _setLoading(true);
// // //       await _firestore.collection('accounts').doc(user!.uid).set({
// // //         "profile": { ...profileData, "completed": true },
// // //         "updatedAt": FieldValue.serverTimestamp(),
// // //       }, SetOptions(merge: true));
// // //       await fetchUserData();
// // //     } catch (e) {
// // //       rethrow;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }
// // //
// // //   Future<bool> isProfileCompleted() async {
// // //     if (user == null) return false;
// // //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// // //     return doc.exists && doc.data()?['profile']?['completed'] == true;
// // //   }
// // //
// // //   // ================= 5. AUTH OPERATIONS (FIXED & FULL) =================
// // //
// // //   // 🔹 SIGNUP Method (Re-added)
// // //   Future<String?> signup(String email, String password) async {
// // //     try {
// // //       _setLoading(true);
// // //       await _auth.createUserWithEmailAndPassword(
// // //           email: email.trim(), password: password.trim());
// // //       return null; // Success
// // //     } on FirebaseAuthException catch (e) {
// // //       return e.message;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }
// // //
// // //   // 🔹 LOGIN Method
// // //   Future<String?> login(String email, String password) async {
// // //     try {
// // //       _setLoading(true);
// // //       await _auth.signInWithEmailAndPassword(
// // //           email: email.trim(), password: password.trim());
// // //       await fetchUserData();
// // //       return null;
// // //     } on FirebaseAuthException catch (e) {
// // //       return e.message;
// // //     } finally {
// // //       _setLoading(false);
// // //     }
// // //   }
// // //
// // //   Future<void> logout() async {
// // //     _clearData();
// // //     await _auth.signOut();
// // //   }
// // //
// // //   // ================= 6. FCM & Helpers =================
// // //   Future<void> saveDeviceToken() async {
// // //     if (user == null) return;
// // //     try {
// // //       await _fcm.requestPermission();
// // //       String? token = await _fcm.getToken();
// // //       if (token != null) {
// // //         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
// // //       }
// // //     } catch (_) {}
// // //   }
// // //
// // //   void _setLoading(bool value) {
// // //     isLoading = value;
// // //     notifyListeners();
// // //   }
// // //
// // //   void _clearData() {
// // //     userData = null;
// // //     selectedRole = null;
// // //     totalDonations = totalReceived = totalDeliveries = pendingCount = totalPosts = notificationCount = 0;
// // //     _notificationSubscription?.cancel();
// // //     _postSubscription?.cancel();
// // //   }
// // // }
// // //
// // //
// // //
// // //
// //
// //
// //
// //
// // import 'dart:async';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// //
// // class GenericAuthProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
// //
// //   // --- State Variables ---
// //   bool isLoading = false;
// //   String? selectedRole;
// //   Map<String, dynamic>? userData;
// //   User? _currentUser;
// //
// //   // --- Dashboard Stats ---
// //   int totalDonations = 0;
// //   int totalReceived = 0;
// //   int totalDeliveries = 0;
// //   int pendingCount = 0;
// //   int totalPosts = 0;
// //   int notificationCount = 0;
// //
// //   // --- Listeners ---
// //   StreamSubscription<QuerySnapshot>? _notificationSubscription;
// //   StreamSubscription<QuerySnapshot>? _postSubscription;
// //   StreamSubscription<QuerySnapshot>? _receiverStatsSubscription;
// //
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) async {
// //       _currentUser = user;
// //       if (user != null) {
// //         await fetchUserData();
// //         _initAllRealTimeListeners();
// //         saveDeviceToken();
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
// //   }
// //
// //   // ================= 1. Real-time Listeners =================
// //   void _initAllRealTimeListeners() {
// //     _cancelAllSubscriptions();
// //     if (user == null || selectedRole == null) return;
// //
// //     // ১. নোটিফিকেশন লিসেনার (রোল অনুযায়ী)
// //     String field = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
// //     String targetStatus = (selectedRole == 'donor') ? 'pending' : 'approved';
// //
// //     _notificationSubscription = _firestore
// //         .collection('requests')
// //         .where(field, isEqualTo: user!.uid)
// //         .where('status', isEqualTo: targetStatus)
// //         .snapshots().listen((snap) {
// //       notificationCount = snap.docs.length;
// //       notifyListeners();
// //     });
// //
// //     // ২. ডোনারের পোস্ট কাউন্ট লিসেনার
// //     _postSubscription = _firestore
// //         .collection('posts')
// //         .where('donorId', isEqualTo: user!.uid)
// //         .snapshots().listen((snap) {
// //       totalPosts = snap.docs.length;
// //       notifyListeners();
// //     });
// //
// //     // ৩. রিসিভারের ডাটা লিসেনার
// //     _receiverStatsSubscription = _firestore
// //         .collection('requests')
// //         .where('receiverId', isEqualTo: user!.uid)
// //         .snapshots().listen((snap) {
// //       pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
// //       totalReceived = snap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed').length;
// //       notifyListeners();
// //     });
// //   }
// //
// //   void _cancelAllSubscriptions() {
// //     _notificationSubscription?.cancel();
// //     _postSubscription?.cancel();
// //     _receiverStatsSubscription?.cancel();
// //   }
// //
// //   // ================= 2. Auth & Role (The Error Fix) =================
// //
// //   // 🔹 সাইনআপ মেথড (এখন আপনার দেওয়া কলিং স্টাইলের সাথে মিলবে)
// //   Future<String?> signup(String email, String password, {String role = 'receiver'}) async {
// //     try {
// //       _setLoading(true);
// //       UserCredential credential = await _auth.createUserWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password.trim(),
// //       );
// //
// //       if (credential.user != null) {
// //         // ফায়ারস্টোরে ইউজার অ্যাকাউন্ট তৈরি ও রোল সেভ
// //         await _firestore.collection('accounts').doc(credential.user!.uid).set({
// //           "uid": credential.user!.uid,
// //           "email": email.trim(),
// //           "role": role.toLowerCase(),
// //           "createdAt": FieldValue.serverTimestamp(),
// //           "profile": {"completed": false}
// //         });
// //
// //         selectedRole = role.toLowerCase();
// //         notifyListeners();
// //         return null;
// //       }
// //       return "Signup failed";
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<void> saveUserRole(String role) async {
// //     if (user == null) return;
// //     try {
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "role": role.toLowerCase(),
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //       selectedRole = role.toLowerCase();
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Role Save Error: $e");
// //     }
// //   }
// //
// //   // ================= 3. Stats & User Data =================
// //
// //   Future<void> loadUserRole() async {
// //     await fetchUserData();
// //   }
// //
// //   Future<void> fetchUserData() async {
// //     if (user == null) return;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       if (doc.exists) {
// //         userData = doc.data();
// //         selectedRole = userData?['role'];
// //         await countUserStats();
// //       }
// //     } catch (e) {
// //       debugPrint("Fetch Data Error: $e");
// //     } finally {
// //       notifyListeners();
// //     }
// //   }
// //
// //   Future<void> countUserStats() async {
// //     if (user == null) return;
// //     final String uid = user!.uid;
// //     try {
// //       final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
// //       totalPosts = postSnap.docs.length;
// //
// //       final dSnap = await _firestore.collection('requests')
// //           .where('donorId', isEqualTo: uid)
// //           .where('status', isEqualTo: 'delivered').get();
// //       totalDonations = dSnap.docs.length;
// //
// //       final rSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
// //       totalReceived = rSnap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed').length;
// //       pendingCount = rSnap.docs.where((d) => d['status'] == 'pending').length;
// //
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= 4. Profile & Helpers =================
// //
// //   Future<bool> isProfileCompleted() async {
// //     if (user == null) return false;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       return doc.exists && (doc.data()?['profile']?['completed'] == true);
// //     } catch (e) {
// //       return false;
// //     }
// //   }
// //
// //   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
// //     if (user == null) return;
// //     try {
// //       _setLoading(true);
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "profile": { ...profileData, "completed": true },
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //       await fetchUserData();
// //     } catch (e) {
// //       rethrow;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<String?> login(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
// //       await fetchUserData();
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   void _setLoading(bool value) {
// //     isLoading = value;
// //     notifyListeners();
// //   }
// //
// //   void _clearData() {
// //     userData = null;
// //     selectedRole = null;
// //     totalDonations = totalReceived = totalDeliveries = pendingCount = totalPosts = notificationCount = 0;
// //     _cancelAllSubscriptions();
// //   }
// //
// //   void resetNotificationCount() {
// //     notificationCount = 0;
// //     notifyListeners();
// //   }
// //
// //   Future<void> logout() async {
// //     _clearData();
// //     await _auth.signOut();
// //   }
// //
// //   Future<void> saveDeviceToken() async {
// //     if (user == null) return;
// //     try {
// //       await _fcm.requestPermission();
// //       String? token = await _fcm.getToken();
// //       if (token != null) {
// //         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
// //       }
// //     } catch (_) {}
// //   }
// // }
//
//
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class GenericAuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   // --- State Variables ---
//   bool isLoading = false;
//   String? selectedRole;
//   Map<String, dynamic>? userData;
//   User? _currentUser;
//
//   // --- Dashboard Stats ---
//   int totalDonations = 0;   // Donor এর সফল দান (delivered/completed)
//   int totalReceived = 0;    // Receiver এর পাওয়া খাবার
//   int totalDeliveries = 0;  // Volunteer এর ডেলিভারি
//   int pendingCount = 0;     // Receiver এর পেন্ডিং রিকোয়েস্ট
//   int totalPosts = 0;       // Donor এর মোট পোস্ট সংখ্যা
//   int notificationCount = 0;
//
//   // --- Listeners ---
//   StreamSubscription<QuerySnapshot>? _notificationSubscription;
//   StreamSubscription<QuerySnapshot>? _postSubscription;
//   StreamSubscription<QuerySnapshot>? _requestSubscription;
//
//   User? get user => _currentUser ?? _auth.currentUser;
//
//   GenericAuthProvider() {
//     _auth.authStateChanges().listen((user) async {
//       _currentUser = user;
//       if (user != null) {
//         await fetchUserData();
//         _initRealTimeListeners();
//         saveDeviceToken();
//       } else {
//         _clearData();
//       }
//       notifyListeners();
//     });
//   }
//
//   // ================= 1. Real-time Listeners (Fixed) =================
//
//   void _initRealTimeListeners() {
//     _cancelAllSubscriptions();
//     if (user == null || selectedRole == null) return;
//
//     // ১. নোটিফিকেশন লিসেনার
//     String notifyField = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
//     String notifyStatus = (selectedRole == 'donor') ? 'pending' : 'approved';
//
//     _notificationSubscription = _firestore
//         .collection('requests')
//         .where(notifyField, isEqualTo: user!.uid)
//         .where('status', isEqualTo: notifyStatus)
//         .snapshots().listen((snap) {
//       notificationCount = snap.docs.length;
//       notifyListeners();
//     });
//
//     // ২. ডোনারের 'Total Posts' লিসেনার
//     _postSubscription = _firestore
//         .collection('posts')
//         .where('donorId', isEqualTo: user!.uid)
//         .snapshots().listen((snap) {
//       totalPosts = snap.docs.length; // রিয়েল-টাইমে পোস্ট কাউন্ট হবে
//       notifyListeners();
//     });
//
//     // ৩. রিকোয়েস্ট লিসেনার (Donations, Received, Pending সব কিছুর জন্য)
//     String reqField = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
//     _requestSubscription = _firestore
//         .collection('requests')
//         .where(reqField, isEqualTo: user!.uid)
//         .snapshots().listen((snap) {
//
//       if (selectedRole == 'donor') {
//         // ডোনারের ক্ষেত্রে সফল দান (Donations)
//         totalDonations = snap.docs.where((d) =>
//         d['status'] == 'delivered' || d['status'] == 'completed'
//         ).length;
//       } else {
//         // রিসিভারের ক্ষেত্রে
//         pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
//         totalReceived = snap.docs.where((d) =>
//         d['status'] == 'delivered' || d['status'] == 'completed' || d['status'] == 'approved'
//         ).length;
//       }
//       notifyListeners();
//     });
//   }
//
//   void _cancelAllSubscriptions() {
//     _notificationSubscription?.cancel();
//     _postSubscription?.cancel();
//     _requestSubscription?.cancel();
//   }
//
//   // ================= 2. Auth Operations =================
//
//   Future<String?> signup(String email, String password, {String role = 'receiver'}) async {
//     try {
//       _setLoading(true);
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       if (credential.user != null) {
//         await _firestore.collection('accounts').doc(credential.user!.uid).set({
//           "uid": credential.user!.uid,
//           "email": email.trim(),
//           "role": role.toLowerCase(),
//           "createdAt": FieldValue.serverTimestamp(),
//           "profile": {"completed": false}
//         });
//         selectedRole = role.toLowerCase();
//         notifyListeners();
//       }
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<String?> login(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
//       await fetchUserData();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= 3. User Data & Stats =================
//
//   Future<void> fetchUserData() async {
//     if (user == null) return;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       if (doc.exists) {
//         userData = doc.data();
//         selectedRole = userData?['role']?.toString().toLowerCase();
//         await countUserStats(); // স্ট্যাটিক্যাল কাউন্ট
//       }
//     } catch (e) {
//       debugPrint("Fetch Data Error: $e");
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   Future<void> countUserStats() async {
//     if (user == null || selectedRole == null) return;
//     final String uid = user!.uid;
//     try {
//       if (selectedRole == 'donor') {
//         final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
//         totalPosts = postSnap.docs.length;
//
//         final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
//         totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed').length;
//       } else if (selectedRole == 'receiver') {
//         final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
//         pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
//         totalReceived = receiverReqSnap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed' || d['status'] == 'approved').length;
//       }
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Stats Error: $e");
//     }
//   }
//
//   Future<void> loadUserRole() async {
//     await fetchUserData();
//   }
//
//   // ================= 4. Profile & Helpers =================
//
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//     return doc.exists && (doc.data()?['profile']?['completed'] == true);
//   }
//
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "profile": { ...profileData, "completed": true },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//       await fetchUserData();
//     } catch (e) {
//       rethrow;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   void resetNotificationCount() {
//     notificationCount = 0;
//     notifyListeners();
//   }
//
//   void _setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
//
//   void _clearData() {
//     userData = null;
//     selectedRole = null;
//     totalDonations = totalReceived = totalDeliveries = pendingCount = totalPosts = notificationCount = 0;
//     _cancelAllSubscriptions();
//   }
//
//   Future<void> logout() async {
//     _clearData();
//     await _auth.signOut();
//   }
//
//   Future<void> saveDeviceToken() async {
//     if (user == null) return;
//     try {
//       await _fcm.requestPermission();
//       String? token = await _fcm.getToken();
//       if (token != null) {
//         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
//       }
//     } catch (_) {}
//   }
// }

//
// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
//
// class GenericAuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
//   // --- State Variables ---
//   bool isLoading = false;
//   String? selectedRole;
//   Map<String, dynamic>? userData;
//   User? _currentUser;
//
//   // --- Dashboard Stats ---
//   int totalDonations = 0;
//   int totalReceived = 0;
//   int totalDeliveries = 0;
//   int pendingCount = 0;
//   int totalPosts = 0;
//   int notificationCount = 0;
//
//   // --- Listeners ---
//   StreamSubscription<QuerySnapshot>? _notificationSubscription;
//   StreamSubscription<QuerySnapshot>? _postSubscription;
//   StreamSubscription<QuerySnapshot>? _requestSubscription;
//
//   User? get user => _currentUser ?? _auth.currentUser;
//
//   GenericAuthProvider() {
//     _auth.authStateChanges().listen((user) async {
//       _currentUser = user;
//       if (user != null) {
//         await fetchUserData();
//         _initRealTimeListeners();
//         saveDeviceToken();
//       } else {
//         _clearData();
//       }
//       notifyListeners();
//     });
//   }
//
//   // ================= 1. Real-time Listeners (Fixed Stats Logic) =================
//
//   void _initRealTimeListeners() {
//     _cancelAllSubscriptions();
//     if (user == null || selectedRole == null) return;
//
//     // ১. নোটিফিকেশন লিসেনার
//     String notifyField = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
//     String notifyStatus = (selectedRole == 'donor') ? 'pending' : 'approved';
//
//     _notificationSubscription = _firestore
//         .collection('requests')
//         .where(notifyField, isEqualTo: user!.uid)
//         .where('status', isEqualTo: notifyStatus)
//         .snapshots().listen((snap) {
//       notificationCount = snap.docs.length;
//       notifyListeners();
//     });
//
//     // ২. ডোনারের 'Total Posts' লিসেনার
//     _postSubscription = _firestore
//         .collection('posts')
//         .where('donorId', isEqualTo: user!.uid)
//         .snapshots().listen((snap) {
//       totalPosts = snap.docs.length;
//       notifyListeners();
//     });
//
//     // ৩. রিকোয়েস্ট লিসেনার (Donations, Received, Pending সব কিছুর জন্য)
//     _requestSubscription = _firestore
//         .collection('requests')
//         .snapshots().listen((snap) {
//
//       if (selectedRole == 'donor') {
//         // ডোনারের ক্ষেত্রে সফল দান (Donations)
//         totalDonations = snap.docs.where((d) =>
//         d['donorId'] == user!.uid && (d['status'] == 'delivered' || d['status'] == 'completed')
//         ).length;
//       } else if (selectedRole == 'receiver') {
//         // রিসিভারের ক্ষেত্রে
//         pendingCount = snap.docs.where((d) => d['receiverId'] == user!.uid && d['status'] == 'pending').length;
//         totalReceived = snap.docs.where((d) =>
//         d['receiverId'] == user!.uid && (d['status'] == 'delivered' || d['status'] == 'completed' || d['status'] == 'approved')
//         ).length;
//       }
//       notifyListeners();
//     });
//   }
//
//   void _cancelAllSubscriptions() {
//     _notificationSubscription?.cancel();
//     _postSubscription?.cancel();
//     _requestSubscription?.cancel();
//   }
//
//   // ================= 2. Auth & Role Operations (Fixed saveUserRole) =================
//
//   Future<String?> signup(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<void> saveUserRole(String role) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       String roleFormatted = role.trim().toLowerCase();
//
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "uid": user!.uid,
//         "email": user!.email,
//         "role": roleFormatted,
//         "updatedAt": FieldValue.serverTimestamp(),
//         "profile": {"completed": false}
//       }, SetOptions(merge: true));
//
//       selectedRole = roleFormatted;
//       _initRealTimeListeners();
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Save Role Error: $e");
//       rethrow;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<String?> login(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
//       await fetchUserData();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= 3. User Data & Stats =================
//
//   Future<void> fetchUserData() async {
//     if (user == null) return;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       if (doc.exists) {
//         userData = doc.data();
//         selectedRole = userData?['role']?.toString().toLowerCase();
//         await countUserStats();
//       }
//     } catch (e) {
//       debugPrint("Fetch Data Error: $e");
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   Future<void> countUserStats() async {
//     if (user == null || selectedRole == null) return;
//     final String uid = user!.uid;
//     try {
//       if (selectedRole == 'donor') {
//         final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
//         totalPosts = postSnap.docs.length;
//
//         final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
//         totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed').length;
//       } else if (selectedRole == 'receiver') {
//         final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
//         pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
//         totalReceived = receiverReqSnap.docs.where((d) => d['status'] == 'delivered' || d['status'] == 'completed' || d['status'] == 'approved').length;
//       }
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Stats Error: $e");
//     }
//   }
//
//   Future<void> loadUserRole() async {
//     await fetchUserData();
//   }
//
//   // ================= 4. Profile Management =================
//
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       return doc.exists && (doc.data()?['profile']?['completed'] == true);
//     } catch (e) {
//       return false;
//     }
//   }
//
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "profile": { ...profileData, "completed": true },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//       await fetchUserData();
//     } catch (e) {
//       rethrow;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= 5. Helpers & UI Actions =================
//
//   void resetNotificationCount() {
//     notificationCount = 0;
//     notifyListeners();
//   }
//
//   void _setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
//
//   void _clearData() {
//     userData = null;
//     selectedRole = null;
//     totalDonations = totalReceived = totalDeliveries = pendingCount = totalPosts = notificationCount = 0;
//     _cancelAllSubscriptions();
//   }
//
//   Future<void> logout() async {
//     _clearData();
//     await _auth.signOut();
//   }
//
//   Future<void> saveDeviceToken() async {
//     if (user == null) return;
//     try {
//       await _fcm.requestPermission();
//       String? token = await _fcm.getToken();
//       if (token != null) {
//         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
//       }
//     } catch (_) {}
//   }
// }

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
        // ইউজার লগইন থাকলে ডাটা ফেচ করা হবে
        await fetchUserData();
        // রিয়েল টাইম লিসেনার চালু করা হবে
        _initRealTimeListeners();
        saveDeviceToken();
      } else {
        _clearData();
      }
      notifyListeners();
    });
  }

  // ================= 1. Real-time Listeners (সঠিক লজিক) =================

  void _initRealTimeListeners() {
    _cancelAllSubscriptions();
    if (user == null || selectedRole == null) return;

    final uid = user!.uid;

    // ১. নোটিফিকেশন লিসেনার (রোল অনুযায়ী ভিন্ন ফিল্ড চেক করবে)
    String notifyField = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
    String notifyStatus = (selectedRole == 'donor') ? 'pending' : 'approved';

    _notificationSubscription = _firestore
        .collection('requests')
        .where(notifyField, isEqualTo: uid)
        .where('status', isEqualTo: notifyStatus)
        .snapshots().listen((snap) {
      notificationCount = snap.docs.length;
      notifyListeners();
    });

    // ২. ডোনারের জন্য 'Total Posts' লিসেনার
    if (selectedRole == 'donor') {
      _postSubscription = _firestore
          .collection('posts')
          .where('donorId', isEqualTo: uid)
          .snapshots().listen((snap) {
        totalPosts = snap.docs.length;
        notifyListeners();
      });
    }

    // ৩. রিকোয়েস্ট লিসেনার (Donations, Received, Pending সব কিছুর জন্য)
    _requestSubscription = _firestore
        .collection('requests')
        .where(selectedRole == 'donor' ? 'donorId' : 'receiverId', isEqualTo: uid)
        .snapshots().listen((snap) {

      if (selectedRole == 'donor') {
        // ডোনারের ক্ষেত্রে শুধু delivered হলেই সেটি সফল দান
        totalDonations = snap.docs.where((d) => d['status'] == 'delivered').length;
      } else if (selectedRole == 'receiver') {
        // রিসিভারের ক্ষেত্রে
        pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
        totalReceived = snap.docs.where((d) =>
            ['approved', 'delivered', 'completed'].contains(d['status'])
        ).length;
      }
      notifyListeners();
    });
  }

  void _cancelAllSubscriptions() {
    _notificationSubscription?.cancel();
    _postSubscription?.cancel();
    _requestSubscription?.cancel();
  }

  // ================= 2. Auth Operations (Login & Signup) =================

  Future<String?> signup(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
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
      // লগইন এর পর ডাটা লোড করা এবং লিসেনার শুরু করা
      await fetchUserData();
      _initRealTimeListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
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
        "profile": {"completed": false}
      }, SetOptions(merge: true));

      selectedRole = roleFormatted;
      _initRealTimeListeners(); // রোল পরিবর্তনের পর লিসেনার রিস্টার্ট
      notifyListeners();
    } catch (e) {
      debugPrint("Save Role Error: $e");
    } finally {
      _setLoading(false);
    }
  }

  // ================= 3. User Data & Manual Stats =================

  Future<void> fetchUserData() async {
    if (user == null) return;
    try {
      final doc = await _firestore.collection('accounts').doc(user!.uid).get();
      if (doc.exists) {
        userData = doc.data();
        selectedRole = userData?['role']?.toString().toLowerCase();
        // ডাটাবেজ থেকে ডাটা পাওয়ার পর স্ট্যাটাস ক্যালকুলেট করা
        await countUserStats();
      }
    } catch (e) {
      debugPrint("Fetch Data Error: $e");
    }
  }

  Future<void> countUserStats() async {
    if (user == null || selectedRole == null) return;
    final String uid = user!.uid;
    try {
      if (selectedRole == 'donor') {
        final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
        totalPosts = postSnap.docs.length;

        final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
        totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered').length;
      } else if (selectedRole == 'receiver') {
        final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
        pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
        totalReceived = receiverReqSnap.docs.where((d) =>
            ['approved', 'delivered', 'completed'].contains(d['status'])
        ).length;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Stats Error: $e");
    }
  }

  // ================= 4. Profile Management =================

  Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
    if (user == null) return;
    try {
      _setLoading(true);
      await _firestore.collection('accounts').doc(user!.uid).set({
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
      return doc.exists && (doc.data()?['profile']?['completed'] == true);
    } catch (e) {
      return false;
    }
  }

  // ================= 5. Helpers & UI Actions =================

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
  }

  Future<void> logout() async {
    _clearData();
    await _auth.signOut();
    notifyListeners();
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