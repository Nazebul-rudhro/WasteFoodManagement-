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
//   // Signup
//   Future<String?> signup(String email, String password) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       // create user doc (future safe)
//       // await _firestore
//       //     .collection("users")
//       //     .doc(userCredential.user!.uid)
//       //     .set({
//       //   "email": email.trim(),
//       //   "createdAt": FieldValue.serverTimestamp(),
//       // }, SetOptions(merge: true));
//
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Login
//   Future<String?> login(String email, String password) async {
//     try {
//       isLoading = true;
//       notifyListeners();
//
//       await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // Save role
//   Future<void> saveRole(String role) async {
//     if (_auth.currentUser == null) return;
//
//     selectedRole = role;
//     isLoading = true;
//     notifyListeners();
//
//     await _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .set(
//       {"role": role.toLowerCase()},
//       SetOptions(merge: true),
//     );
//
//     isLoading = false;
//     notifyListeners();
//   }
//
//   // Logout
//   Future<void> logout() async {
//     await _auth.signOut();
//   }
//
//   User? get user => _auth.currentUser;
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenericAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;
  String? selectedRole;

  User? get user => _auth.currentUser;

  // ================= SIGNUP =================
  Future<String?> signup(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= LOGIN =================
  Future<String?> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= SAVE ROLE =================
  Future<void> saveRole(String role) async {
    if (_auth.currentUser == null) return;

    selectedRole = role;

    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set({
      "role": role,
      "email": _auth.currentUser!.email,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    notifyListeners();
  }

  // ================= LOGOUT =================
  Future<void> logout() async {
    selectedRole = null;
    await _auth.signOut();
    notifyListeners();
  }
}
