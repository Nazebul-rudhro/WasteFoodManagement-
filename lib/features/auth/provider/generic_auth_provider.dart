// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // class GenericAuthProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   bool isLoading = false;
// //   String? selectedRole;
// //   Map<String, dynamic>? userData;
// //
// //   int totalDonations = 0; // ডোনারের জন্য সফল ডোনেশন কাউন্ট
// //   int totalReceived = 0;  // রিসিভারের জন্য সফল রিসিভ কাউন্ট
// //
// //   User? _currentUser;
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) {
// //       _currentUser = user;
// //       if (user != null) {
// //         fetchUserData(); // ইউজার থাকলে প্রোফাইল ও কাউন্ট লোড হবে
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
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
// //     totalDonations = 0;
// //     totalReceived = 0;
// //   }
// //
// //   // ================= কাউন্ট স্ট্যাটাস (ডোনার ও রিসিভার) =================
// //   Future<void> countUserStats() async {
// //     if (user == null) return;
// //     try {
// //       // ১. ডোনার হিসেবে সফল ডোনেশন (posts কালেকশন থেকে)
// //       final donorQuery = await _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: user!.uid)
// //           .where('status', isEqualTo: 'approved')
// //           .get();
// //       totalDonations = donorQuery.docs.length;
// //
// //       // ২. রিসিভার হিসেবে সফল রিসিভ (requests কালেকশন থেকে)
// //       final receiverQuery = await _firestore
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: user!.uid)
// //           .where('status', isEqualTo: 'approved')
// //           .get();
// //       totalReceived = receiverQuery.docs.length;
// //
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Count Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= প্রোফাইল ডাটা ফেচ করা =================
// //   Future<void> fetchUserData() async {
// //     if (user == null) return;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       if (doc.exists) {
// //         userData = doc.data();
// //         selectedRole = userData?['role'];
// //         await countUserStats(); // ডাটা আসার পর কাউন্ট আপডেট হবে
// //       }
// //     } catch (e) {
// //       debugPrint("Error fetching user data: $e");
// //     } finally {
// //       notifyListeners();
// //     }
// //   }
// //
// //   // ================= অথেন্টিকেশন ফাংশনস =================
// //
// //   Future<String?> signup(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.createUserWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<String?> login(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.signInWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       await fetchUserData(); // লগইনের পর প্রোফাইল ও রোল লোড
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<void> logout() async {
// //     await _auth.signOut();
// //     _clearData();
// //     notifyListeners();
// //   }
// //
// //   // ================= প্রোফাইল ও রোল ম্যানেজমেন্ট =================
// //
// //   Future<void> saveUserRole(String role) async {
// //     if (user == null) return;
// //     selectedRole = role.toLowerCase();
// //     await _firestore.collection('accounts').doc(user!.uid).set({
// //       "role": selectedRole,
// //       "status": true,
// //       "updatedAt": FieldValue.serverTimestamp(),
// //     }, SetOptions(merge: true));
// //     notifyListeners();
// //   }
// //
// //   Future<void> loadUserRole() async {
// //     if (user == null) return;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     if (doc.exists && doc.data()!.containsKey('role')) {
// //       selectedRole = doc['role'];
// //       notifyListeners();
// //     }
// //   }
// //
// //   Future<bool> isProfileCompleted() async {
// //     if (user == null) return false;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     return doc.exists && doc.data()?['profile']?['completed'] == true;
// //   }
// //
// //   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
// //     if (user == null) return;
// //     try {
// //       _setLoading(true);
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "profile": {
// //           ...profileData,
// //           "completed": true,
// //         },
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //       await fetchUserData(); // সেভ করার পর সাথে সাথে UI আপডেট হবে
// //     } catch (e) {
// //       debugPrint("Save Profile Error: $e");
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// // }
//
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // class GenericAuthProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   bool isLoading = false;
// //   String? selectedRole;
// //   Map<String, dynamic>? userData;
// //
// //   int totalDonations = 0;
// //   int totalReceived = 0;
// //
// //   User? _currentUser;
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) {
// //       _currentUser = user;
// //       if (user != null) {
// //         fetchUserData();
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
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
// //     totalDonations = 0;
// //     totalReceived = 0;
// //   }
// //
// //   // ================= কাউন্ট স্ট্যাটাস (ডোনার ও রিসিভার) =================
// //   Future<void> countUserStats() async {
// //     if (user == null) return;
// //     try {
// //       // ১. ডোনার হিসেবে সফল ডোনেশন (posts কালেকশন থেকে)
// //       final donorQuery = await _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: user!.uid)
// //           .where('status', isEqualTo: 'approved') // বানান চেক করুন (সব ছোট হাতের)
// //           .get();
// //
// //       totalDonations = donorQuery.docs.length;
// //
// //       // ২. রিসিভার হিসেবে সফল রিসিভ (requests কালেকশন থেকে)
// //       final receiverQuery = await _firestore
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: user!.uid)
// //           .where('status', isEqualTo: 'approved') // বানান চেক করুন
// //           .get();
// //
// //       totalReceived = receiverQuery.docs.length;
// //
// //       debugPrint("--- Stats Updated ---");
// //       debugPrint("Received Count: $totalReceived");
// //       debugPrint("Donation Count: $totalDonations");
// //
// //       notifyListeners(); // এটি UI কে জানাবে যে ডাটা বদলেছে
// //     } catch (e) {
// //       debugPrint("Count Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= প্রোফাইল ডাটা ফেচ করা =================
// //   Future<void> fetchUserData() async {
// //     if (user == null) return;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       if (doc.exists) {
// //         userData = doc.data();
// //         selectedRole = userData?['role'];
// //         // ডাটা পাওয়ার পর সরাসরি কাউন্ট কল করা
// //         await countUserStats();
// //       }
// //     } catch (e) {
// //       debugPrint("Error fetching user data: $e");
// //     } finally {
// //       notifyListeners();
// //     }
// //   }
// //
// //   // ================= অথেন্টিকেশন ফাংশনস =================
// //   Future<String?> signup(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.createUserWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<String?> login(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.signInWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       await fetchUserData();
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<void> logout() async {
// //     await _auth.signOut();
// //     _clearData();
// //     notifyListeners();
// //   }
// //
// //   // ================= প্রোফাইল ও রোল ম্যানেজমেন্ট =================
// //   Future<void> saveUserRole(String role) async {
// //     if (user == null) return;
// //     selectedRole = role.toLowerCase();
// //     await _firestore.collection('accounts').doc(user!.uid).set({
// //       "role": selectedRole,
// //       "status": true,
// //       "updatedAt": FieldValue.serverTimestamp(),
// //     }, SetOptions(merge: true));
// //     notifyListeners();
// //   }
// //
// //   Future<void> loadUserRole() async {
// //     if (user == null) return;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     if (doc.exists && doc.data()!.containsKey('role')) {
// //       selectedRole = doc['role'];
// //       notifyListeners();
// //     }
// //   }
// //
// //   Future<bool> isProfileCompleted() async {
// //     if (user == null) return false;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     return doc.exists && doc.data()?['profile']?['completed'] == true;
// //   }
// //
// //   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
// //     if (user == null) return;
// //     try {
// //       _setLoading(true);
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "profile": {
// //           ...profileData,
// //           "completed": true,
// //         },
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //       await fetchUserData();
// //     } catch (e) {
// //       debugPrint("Save Profile Error: $e");
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// // }
//
//
//
// //
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // class GenericAuthProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   bool isLoading = false;
// //   String? selectedRole;
// //   Map<String, dynamic>? userData;
// //
// //   int totalDonations = 0;
// //   int totalReceived = 0;
// //
// //   User? _currentUser;
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) {
// //       _currentUser = user;
// //       if (user != null) {
// //         fetchUserData();
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
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
// //     totalDonations = 0;
// //     totalReceived = 0;
// //   }
// //
// //   // ================= কাউন্ট স্ট্যাটাস (ডোনার ও রিসিভার) =================
// //   Future<void> countUserStats() async {
// //     if (user == null) return;
// //     try {
// //       final String uid = user!.uid;
// //
// //       // --- ১. ডোনার হিসেবে সফল ডোনেশন কাউন্ট ---
// //       // 'approved' এবং 'Accepted' দুইটাই চেক করছি যাতে মিস না হয়
// //       final donorQuery1 = await _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: uid)
// //           .where('status', isEqualTo: 'approved')
// //           .get();
// //
// //       final donorQuery2 = await _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: uid)
// //           .where('status', isEqualTo: 'Accepted')
// //           .get();
// //
// //       totalDonations = donorQuery1.docs.length + donorQuery2.docs.length;
// //
// //       // --- ২. রিসিভার হিসেবে সফল রিসিভ কাউন্ট ---
// //
// //       // ক) requests কালেকশন থেকে (status: approved)
// //       final receiverReqQuery = await _firestore
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: uid)
// //           .where('status', isEqualTo: 'approved')
// //           .get();
// //
// //       // খ) posts কালেকশন থেকে (যেখানে status Accepted এবং আপনি requestedBy লিস্টে আছেন)
// //       final receiverPostsQuery = await _firestore
// //           .collection('posts')
// //           .where('status', isEqualTo: 'Accepted')
// //           .where('requestedBy', arrayContains: uid)
// //           .get();
// //
// //       totalReceived = receiverReqQuery.docs.length + receiverPostsQuery.docs.length;
// //
// //       debugPrint("--- Count Success ---");
// //       debugPrint("Total Donations: $totalDonations");
// //       debugPrint("Total Received: $totalReceived");
// //
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Count Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= প্রোফাইল ডাটা ফেচ করা =================
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
// //       debugPrint("Error fetching user data: $e");
// //     } finally {
// //       notifyListeners();
// //     }
// //   }
// //
// //   // ================= অথেন্টিকেশন ফাংশনস =================
// //   Future<String?> signup(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.createUserWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<String?> login(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.signInWithEmailAndPassword(
// //           email: email.trim(), password: password.trim());
// //       _currentUser = _auth.currentUser;
// //       await fetchUserData();
// //       return null;
// //     } on FirebaseAuthException catch (e) {
// //       return e.message;
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   Future<void> logout() async {
// //     await _auth.signOut();
// //     _clearData();
// //     notifyListeners();
// //   }
// //
// //   // ================= প্রোফাইল ও রোল ম্যানেজমেন্ট =================
// //   Future<void> saveUserRole(String role) async {
// //     if (user == null) return;
// //     selectedRole = role.toLowerCase();
// //     await _firestore.collection('accounts').doc(user!.uid).set({
// //       "role": selectedRole,
// //       "status": true,
// //       "updatedAt": FieldValue.serverTimestamp(),
// //     }, SetOptions(merge: true));
// //     notifyListeners();
// //   }
// //
// //   Future<void> loadUserRole() async {
// //     if (user == null) return;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     if (doc.exists && doc.data()!.containsKey('role')) {
// //       selectedRole = doc['role'];
// //       notifyListeners();
// //     }
// //   }
// //
// //   Future<bool> isProfileCompleted() async {
// //     if (user == null) return false;
// //     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //     return doc.exists && doc.data()?['profile']?['completed'] == true;
// //   }
// //
// //   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
// //     if (user == null) return;
// //     try {
// //       _setLoading(true);
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "profile": {
// //           ...profileData,
// //           "completed": true,
// //         },
// //         "updatedAt": FieldValue.serverTimestamp(),
// //       }, SetOptions(merge: true));
// //       await fetchUserData();
// //     } catch (e) {
// //       debugPrint("Save Profile Error: $e");
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// // }
//
//
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
//   Map<String, dynamic>? userData;
//
//   int totalDonations = 0; // Donor er jonno
//   int totalReceived = 0;  // Receiver er jonno
//
//   User? _currentUser;
//   User? get user => _currentUser ?? _auth.currentUser;
//
//   GenericAuthProvider() {
//     _auth.authStateChanges().listen((user) {
//       _currentUser = user;
//       if (user != null) {
//         fetchUserData();
//       } else {
//         _clearData();
//       }
//       notifyListeners();
//     });
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
//     totalDonations = 0;
//     totalReceived = 0;
//   }
//
//   // ================= Stats Counting Logic =================
//   Future<void> countUserStats() async {
//     if (user == null) return;
//     try {
//       final String uid = user!.uid;
//
//       // ১. Donor hishebe koita post 'approved' hoiyeche (posts collection)
//       final donorQuery = await _firestore
//           .collection('posts')
//           .where('donorId', isEqualTo: uid)
//           .where('status', isEqualTo: 'approved')
//           .get();
//       totalDonations = donorQuery.docs.length;
//
//       // ২. Receiver hishebe koita request 'approved' hoiyeche (requests collection)
//       // Apnar dewa data onujayi receiverId eikhane thake
//       final receiverQuery = await _firestore
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .where('status', isEqualTo: 'approved')
//           .get();
//
//       totalReceived = receiverQuery.docs.length;
//
//       debugPrint("--- Sync Success ---");
//       debugPrint("Total Donations: $totalDonations");
//       debugPrint("Total Received: $totalReceived");
//
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Count Stats Error: $e");
//     }
//   }
//
//   // ================= Fetch User Profile =================
//   Future<void> fetchUserData() async {
//     if (user == null) return;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       if (doc.exists) {
//         userData = doc.data();
//         selectedRole = userData?['role'];
//         await countUserStats(); // Data load hoyar por count hobe
//       }
//     } catch (e) {
//       debugPrint("Error fetching user data: $e");
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   // ================= Auth Functions =================
//   Future<String?> signup(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.createUserWithEmailAndPassword(
//           email: email.trim(), password: password.trim());
//       _currentUser = _auth.currentUser;
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
//       await _auth.signInWithEmailAndPassword(
//           email: email.trim(), password: password.trim());
//       _currentUser = _auth.currentUser;
//       await fetchUserData();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<void> logout() async {
//     await _auth.signOut();
//     _clearData();
//     notifyListeners();
//   }
//
//   // ================= Profile & Role Management =================
//   Future<void> saveUserRole(String role) async {
//     if (user == null) return;
//     selectedRole = role.toLowerCase();
//     await _firestore.collection('accounts').doc(user!.uid).set({
//       "role": selectedRole,
//       "status": true,
//       "updatedAt": FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//     notifyListeners();
//   }
//
//   Future<void> loadUserRole() async {
//     if (user == null) return;
//     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//     if (doc.exists && doc.data()!.containsKey('role')) {
//       selectedRole = doc['role'];
//       notifyListeners();
//     }
//   }
//
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//     return doc.exists && doc.data()?['profile']?['completed'] == true;
//   }
//
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "profile": {
//           ...profileData,
//           "completed": true,
//         },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//       await fetchUserData();
//     } catch (e) {
//       debugPrint("Save Profile Error: $e");
//     } finally {
//       _setLoading(false);
//     }
//   }
// }
//
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
//   Map<String, dynamic>? userData;
//
//   int totalDonations = 0;
//   int totalReceived = 0;
//
//   User? _currentUser;
//   User? get user => _currentUser ?? _auth.currentUser;
//
//   GenericAuthProvider() {
//     _auth.authStateChanges().listen((user) {
//       _currentUser = user;
//       if (user != null) {
//         fetchUserData();
//       } else {
//         _clearData();
//       }
//       notifyListeners();
//     });
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
//     totalDonations = 0;
//     totalReceived = 0;
//   }
//
//   // ================= কাউন্ট স্ট্যাটাস লজিক (শুধুমাত্র Approved Data) =================
//   Future<void> countUserStats() async {
//     if (user == null) return;
//     try {
//       final String uid = user!.uid;
//
//       // ১. ডোনার হিসেবে কয়টা খাবার দান সফল হয়েছে (Status: approved)
//       final donorQuery = await _firestore
//           .collection('posts')
//           .where('donorId', isEqualTo: uid)
//           .where('status', isEqualTo: 'approved')
//           .get();
//       totalDonations = donorQuery.docs.length;
//
//       // ২. রিসিভার হিসেবে কয়টা রিকোয়েস্ট ডোনার 'approved' করেছে (Status: approved)
//       // লজিক: requests কালেকশনে যেখানে receiverId আমার আইডি এবং status 'approved'
//       final receiverQuery = await _firestore
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .where('status', isEqualTo: 'approved')
//           .get();
//
//       totalReceived = receiverQuery.docs.length;
//
//       debugPrint("--- Count Success ---");
//       debugPrint("Total Donations: $totalDonations");
//       debugPrint("Confirmed Received (Approved Only): $totalReceived");
//
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Count Stats Error: $e");
//     }
//   }
//
//   // ================= ডাটা ফেচিং ও অন্যান্য ফাংশন =================
//   Future<void> fetchUserData() async {
//     if (user == null) return;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       if (doc.exists) {
//         userData = doc.data();
//         selectedRole = userData?['role'];
//         await countUserStats(); // প্রোফাইল লোড হওয়ার সাথে সাথে কাউন্ট হবে
//       }
//     } catch (e) {
//       debugPrint("Error fetching user data: $e");
//     } finally {
//       notifyListeners();
//     }
//   }
//
//   Future<String?> signup(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.createUserWithEmailAndPassword(
//           email: email.trim(), password: password.trim());
//       _currentUser = _auth.currentUser;
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
//       await _auth.signInWithEmailAndPassword(
//           email: email.trim(), password: password.trim());
//       _currentUser = _auth.currentUser;
//       await fetchUserData();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<void> logout() async {
//     await _auth.signOut();
//     _clearData();
//     notifyListeners();
//   }
//
//   Future<void> saveUserRole(String role) async {
//     if (user == null) return;
//     selectedRole = role.toLowerCase();
//     await _firestore.collection('accounts').doc(user!.uid).set({
//       "role": selectedRole,
//       "status": true,
//       "updatedAt": FieldValue.serverTimestamp(),
//     }, SetOptions(merge: true));
//     notifyListeners();
//   }
//
//   Future<void> loadUserRole() async {
//     if (user == null) return;
//     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//     if (doc.exists && doc.data()!.containsKey('role')) {
//       selectedRole = doc['role'];
//       notifyListeners();
//     }
//   }
//
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//     final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//     return doc.exists && doc.data()?['profile']?['completed'] == true;
//   }
//
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "profile": {
//           ...profileData,
//           "completed": true,
//         },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//       await fetchUserData();
//     } catch (e) {
//       debugPrint("Save Profile Error: $e");
//     } finally {
//       _setLoading(false);
//     }
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
  Map<String, dynamic>? userData;

  int totalDonations = 0;
  int totalReceived = 0;

  User? _currentUser;
  User? get user => _currentUser ?? _auth.currentUser;

  GenericAuthProvider() {
    _auth.authStateChanges().listen((user) {
      _currentUser = user;
      if (user != null) {
        fetchUserData();
      } else {
        _clearData();
      }
      notifyListeners();
    });
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _clearData() {
    userData = null;
    selectedRole = null;
    totalDonations = 0;
    totalReceived = 0;
  }

  // ================= কাউন্ট লজিক: UID মিলবে এবং Status Approved হবে =================
  // Future<void> countUserStats() async {
  //   if (user == null) return;
  //   try {
  //     final String uid = user!.uid; // আপনার বর্তমান লগইন আইডি
  //
  //     // ১. ডোনার হিসেবে কাউন্ট (আপনি দান করলে)
  //     final donorQuery = await _firestore
  //         .collection('posts')
  //         .where('donorId', isEqualTo: uid)
  //         .where('status', isEqualTo: 'approved')
  //         .get();
  //     totalDonations = donorQuery.docs.length;
  //
  //     // ২. রিসিভার হিসেবে কাউন্ট (সবচেয়ে গুরুত্বপূর্ণ অংশ)
  //     // লজিক: receiverId == UID এবং status == "approved"
  //     final receiverQuery = await _firestore
  //         .collection('requests')
  //         .where('receiverId', isEqualTo: uid)
  //         .where('status', isEqualTo: 'approved')
  //         .get();
  //
  //     totalReceived = receiverQuery.docs.length;
  //
  //     debugPrint("Matched Receiver UID: $uid");
  //     debugPrint("Found Approved Requests: $totalReceived");
  //
  //     notifyListeners();
  //   } catch (e) {
  //     debugPrint("Count Stats Error: $e");
  //   }
  // }


  Future<void> countUserStats() async {
    if (user == null) return;
    try {
      final String currentUid = user!.uid;

      // ১. ডোনার কাউন্ট
      final donorQuery = await _firestore
          .collection('posts')
          .where('donorId', isEqualTo: currentUid)
          .where('status', isEqualTo: 'approved')
          .get();
      totalDonations = donorQuery.docs.length;

      // ২. রিসিভার কাউন্ট (নিখুঁত পদ্ধতি)
      // আমরা প্রথমে requests কালেকশনের সব ডাটা নিয়ে আসবো যেখানে আপনি রিসিভার
      final receiverQuery = await _firestore
          .collection('requests')
          .where('receiverId', isEqualTo: currentUid)
          .get();

      // এখন কোডের ভেতর চেক করবো কয়টা 'approved' আছে
      int approvedCount = 0;
      for (var doc in receiverQuery.docs) {
        String status = doc.data()['status']?.toString().toLowerCase() ?? "";
        if (status == 'approved') {
          approvedCount++;
        }
      }

      totalReceived = approvedCount;

      debugPrint("--- Manual Debug ---");
      debugPrint("Current UID: $currentUid");
      debugPrint("Total matching requests: ${receiverQuery.docs.length}");
      debugPrint("Approved count: $totalReceived");

      notifyListeners();
    } catch (e) {
      debugPrint("Count Stats Error: $e");
    }
  }
  // ================= আপনার দরকারি প্রোফাইল ফাংশনগুলো =================
  Future<void> fetchUserData() async {
    if (user == null) return;
    try {
      final doc = await _firestore.collection('accounts').doc(user!.uid).get();
      if (doc.exists) {
        userData = doc.data();
        selectedRole = userData?['role'];
        await countUserStats();
      }
    } catch (e) {
      debugPrint("Error fetching user data: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<String?> signup(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _currentUser = _auth.currentUser;
      return null;
    } on FirebaseAuthException catch (e) { return e.message; } finally { _setLoading(false); }
  }

  Future<String?> login(String email, String password) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      _currentUser = _auth.currentUser;
      await fetchUserData();
      return null;
    } on FirebaseAuthException catch (e) { return e.message; } finally { _setLoading(false); }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _clearData();
    notifyListeners();
  }

  Future<void> saveUserRole(String role) async {
    if (user == null) return;
    selectedRole = role.toLowerCase();
    await _firestore.collection('accounts').doc(user!.uid).set({
      "role": selectedRole,
      "status": true,
      "updatedAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    notifyListeners();
  }

  Future<void> loadUserRole() async {
    if (user == null) return;
    final doc = await _firestore.collection('accounts').doc(user!.uid).get();
    if (doc.exists && doc.data()!.containsKey('role')) {
      selectedRole = doc['role'];
      notifyListeners();
    }
  }

  Future<bool> isProfileCompleted() async {
    if (user == null) return false;
    final doc = await _firestore.collection('accounts').doc(user!.uid).get();
    return doc.exists && doc.data()?['profile']?['completed'] == true;
  }

  Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
    if (user == null) return;
    try {
      _setLoading(true);
      await _firestore.collection('accounts').doc(user!.uid).set({
        "profile": { ...profileData, "completed": true, },
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await fetchUserData();
    } catch (e) { debugPrint("Save Profile Error: $e"); } finally { _setLoading(false); }
  }
}