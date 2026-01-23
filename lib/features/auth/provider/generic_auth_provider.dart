// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class GenericAuthProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   bool isLoading = false;
//   String? selectedRole;
//
//   User? get user => _auth.currentUser;
//
//   // ================= AUTH HELPERS =================
//   void _setLoading(bool value) {
//     isLoading = value;
//     notifyListeners();
//   }
//
//   // ================= SIGNUP =================
//   Future<String?> signup(String email, String password) async {
//     try {
//       _setLoading(true);
//
//       await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= LOGIN =================
//   Future<String?> login(String email, String password) async {
//     try {
//       _setLoading(true);
//
//       await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       await loadUserRole();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= STEP 1: SAVE ROLE =================
//   Future<void> saveUserRole(String role) async {
//     if (user == null) return;
//
//     selectedRole = role.toLowerCase();
//
//     await _firestore.collection('accounts').doc(user!.uid).set({
//       "role": selectedRole,
//       "status": true,
//       "createdAt": FieldValue.serverTimestamp(),
//       "updatedAt": FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//
//     notifyListeners();
//   }
//
//   // ================= STEP 2: SAVE BASIC PROFILE =================
//   Future<void> saveBasicProfile({
//     required String userType,
//     required String businessOrFullName,
//     required String contactPerson,
//     required String phone,
//     required String address,
//     required String city,
//     required String postCode,
//
//
//   }) async {
//     if (user == null) return;
//
//     await _firestore.collection('accounts').doc(user!.uid).set({
//       "profile": {
//         "userType" : userType,
//         "businessOrFullName": businessOrFullName,
//         "contactPerson" :contactPerson,
//         "phone": phone,
//         "email" : user!.email,
//         "address" : address,
//         "postCode" : postCode,
//         "completed": false,
//       },
//       "updatedAt": FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//   }
//
//   // ================= STEP 3: SAVE FULL PROFILE =================
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//
//     await _firestore.collection('accounts').doc(user!.uid).set({
//       "profile": {
//         ...profileData,
//         "completed": true,
//       },
//       "updatedAt": FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//   }
//
//   // ================= LOAD ROLE =================
//   Future<void> loadUserRole() async {
//     if (user == null) return;
//
//     final doc =
//     await _firestore.collection('accounts').doc(user!.uid).get();
//
//     if (doc.exists && doc.data()!.containsKey("role")) {
//       selectedRole = doc['role'];
//     } else {
//       selectedRole = null;
//     }
//
//     notifyListeners();
//   }
//
//   // ================= CHECK PROFILE COMPLETION =================
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//
//     final doc =
//     await _firestore.collection('accounts').doc(user!.uid).get();
//
//     return doc.exists &&
//         doc.data()?['profile']?['completed'] == true;
//   }
//
//   // ================= LOGOUT =================
//   Future<void> logout() async {
//     selectedRole = null;
//     await _auth.signOut();
//     notifyListeners();
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenericAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  String? selectedRole;

  // Cached current user
  User? _currentUser;
  User? get user => _currentUser ?? _auth.currentUser;

  GenericAuthProvider() {
    // Listen for auth state changes
    _auth.authStateChanges().listen((user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Signup
  Future<String?> signup(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      _currentUser = _auth.currentUser;
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      _currentUser = _auth.currentUser;
      await loadUserRole();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    selectedRole = null;
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  // Save role
  Future<void> saveUserRole(String role) async {
    if (user == null) return;

    selectedRole = role.toLowerCase();

    await _firestore.collection('accounts').doc(user!.uid).set({
      "role": selectedRole,
      "status": true,
      "createdAt": FieldValue.serverTimestamp(),
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    notifyListeners();
  }

  // Load user role
  Future<void> loadUserRole() async {
    if (user == null) return;
    final doc = await _firestore.collection('accounts').doc(user!.uid).get();
    if (doc.exists && doc.data()!.containsKey('role')) {
      selectedRole = doc['role'];
    } else {
      selectedRole = null;
    }
    notifyListeners();
  }

  // Check if profile completed
  Future<bool> isProfileCompleted() async {
    if (user == null) return false;
    final doc = await _firestore.collection('accounts').doc(user!.uid).get();
    return doc.exists && doc.data()?['profile']?['completed'] == true;
  }

  // ================= Save full profile =================
  Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
    if (user == null) return;

    await _firestore.collection('accounts').doc(user!.uid).set({
      "profile": {
        ...profileData,
        "completed": true, // mark profile as completed
      },
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    notifyListeners();
  }
}
