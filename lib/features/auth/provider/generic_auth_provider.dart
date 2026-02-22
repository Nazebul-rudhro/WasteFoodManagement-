//
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
// //   StreamSubscription? _notificationSubscription;
// //   StreamSubscription? _postSubscription;
// //   StreamSubscription? _requestSubscription;
// //
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) async {
// //       _currentUser = user;
// //       if (user != null) {
// //         // ইউজার লগইন থাকলে ডাটা ফেচ করা হবে
// //         await fetchUserData();
// //         // রিয়েল টাইম লিসেনার চালু করা হবে
// //         _initRealTimeListeners();
// //         saveDeviceToken();
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
// //   }
// //
// //   // ================= 1. Real-time Listeners (সঠিক লজিক) =================
// //
// //   void _initRealTimeListeners() {
// //     _cancelAllSubscriptions();
// //     if (user == null || selectedRole == null) return;
// //
// //     final uid = user!.uid;
// //
// //     // ১. নোটিফিকেশন লিসেনার (রোল অনুযায়ী ভিন্ন ফিল্ড চেক করবে)
// //     String notifyField = (selectedRole == 'donor') ? 'donorId' : 'receiverId';
// //     String notifyStatus = (selectedRole == 'donor') ? 'pending' : 'approved';
// //
// //     _notificationSubscription = _firestore
// //         .collection('requests')
// //         .where(notifyField, isEqualTo: uid)
// //         .where('status', isEqualTo: notifyStatus)
// //         .snapshots().listen((snap) {
// //       notificationCount = snap.docs.length;
// //       notifyListeners();
// //     });
// //
// //     // ২. ডোনারের জন্য 'Total Posts' লিসেনার
// //     if (selectedRole == 'donor') {
// //       _postSubscription = _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: uid)
// //           .snapshots().listen((snap) {
// //         totalPosts = snap.docs.length;
// //         notifyListeners();
// //       });
// //     }
// //
// //     // ৩. রিকোয়েস্ট লিসেনার (Donations, Received, Pending সব কিছুর জন্য)
// //     _requestSubscription = _firestore
// //         .collection('requests')
// //         .where(selectedRole == 'donor' ? 'donorId' : 'receiverId', isEqualTo: uid)
// //         .snapshots().listen((snap) {
// //
// //       if (selectedRole == 'donor') {
// //         // ডোনারের ক্ষেত্রে শুধু delivered হলেই সেটি সফল দান
// //         totalDonations = snap.docs.where((d) => d['status'] == 'delivered').length;
// //       } else if (selectedRole == 'receiver') {
// //         // রিসিভারের ক্ষেত্রে
// //         pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
// //         totalReceived = snap.docs.where((d) =>
// //             ['approved', 'delivered', 'completed'].contains(d['status'])
// //         ).length;
// //       }
// //       notifyListeners();
// //     });
// //   }
// //
// //   void _cancelAllSubscriptions() {
// //     _notificationSubscription?.cancel();
// //     _postSubscription?.cancel();
// //     _requestSubscription?.cancel();
// //   }
// //
// //   // ================= 2. Auth Operations (Login & Signup) =================
// //
// //   Future<String?> signup(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.createUserWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password.trim(),
// //       );
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
// //       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
// //       // লগইন এর পর ডাটা লোড করা এবং লিসেনার শুরু করা
// //       await fetchUserData();
// //       _initRealTimeListeners();
// //       return null;
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
// //       _setLoading(true);
// //       String roleFormatted = role.trim().toLowerCase();
// //
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "uid": user!.uid,
// //         "email": user!.email,
// //         "role": roleFormatted,
// //         "updatedAt": FieldValue.serverTimestamp(),
// //         "profile": {"completed": false}
// //       }, SetOptions(merge: true));
// //
// //       selectedRole = roleFormatted;
// //       _initRealTimeListeners(); // রোল পরিবর্তনের পর লিসেনার রিস্টার্ট
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Save Role Error: $e");
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   // ================= 3. User Data & Manual Stats =================
// //
// //   Future<void> fetchUserData() async {
// //     if (user == null) return;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       if (doc.exists) {
// //         userData = doc.data();
// //         selectedRole = userData?['role']?.toString().toLowerCase();
// //         // ডাটাবেজ থেকে ডাটা পাওয়ার পর স্ট্যাটাস ক্যালকুলেট করা
// //         await countUserStats();
// //       }
// //     } catch (e) {
// //       debugPrint("Fetch Data Error: $e");
// //     }
// //   }
// //
// //   Future<void> countUserStats() async {
// //     if (user == null || selectedRole == null) return;
// //     final String uid = user!.uid;
// //     try {
// //       if (selectedRole == 'donor') {
// //         final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
// //         totalPosts = postSnap.docs.length;
// //
// //         final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
// //         totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered').length;
// //       } else if (selectedRole == 'receiver') {
// //         final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
// //         pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
// //         totalReceived = receiverReqSnap.docs.where((d) =>
// //             ['approved', 'delivered', 'completed'].contains(d['status'])
// //         ).length;
// //       }
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= 4. Profile Management =================
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
// //   // ================= 5. Helpers & UI Actions =================
// //
// //   void resetNotificationCount() {
// //     notificationCount = 0;
// //     notifyListeners();
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
// //   Future<void> logout() async {
// //     _clearData();
// //     await _auth.signOut();
// //     notifyListeners();
// //   }
// //
// //   Future<void> saveDeviceToken() async {
// //     if (user == null) return;
// //     try {
// //       String? token = await _fcm.getToken();
// //       if (token != null) {
// //         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
// //       }
// //     } catch (_) {}
// //   }
// // }
//
//
//
//
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
// //   StreamSubscription? _notificationSubscription;
// //   StreamSubscription? _postSubscription;
// //   StreamSubscription? _requestSubscription;
// //
// //   User? get user => _currentUser ?? _auth.currentUser;
// //
// //   GenericAuthProvider() {
// //     _auth.authStateChanges().listen((user) async {
// //       _currentUser = user;
// //       if (user != null) {
// //         await fetchUserData();
// //         _initRealTimeListeners();
// //         saveDeviceToken();
// //       } else {
// //         _clearData();
// //       }
// //       notifyListeners();
// //     });
// //   }
// //
// //   // ================= 1. Real-time Listeners (Donor & Receiver Logic) =================
// //
// //   void _initRealTimeListeners() {
// //     _cancelAllSubscriptions();
// //     if (user == null || selectedRole == null) return;
// //
// //     final uid = user!.uid;
// //
// //     // ১. নোটিফিকেশন লিসেনার (সঠিক লজিক আপডেট করা হয়েছে)
// //     if (selectedRole == 'donor') {
// //       // ডোনারের জন্য: কেউ খাবার রিকোয়েস্ট করলে (status: pending) নোটিফিকেশন আসবে
// //       _notificationSubscription = _firestore
// //           .collection('requests')
// //           .where('donorId', isEqualTo: uid)
// //           .where('status', isEqualTo: 'pending')
// //           .snapshots()
// //           .listen((snap) {
// //         notificationCount = snap.docs.length;
// //         notifyListeners();
// //       });
// //     } else if (selectedRole == 'receiver') {
// //       // রিসিভারের জন্য: ডোনার এপ্রুভ করলে অথবা ভলান্টিয়ার খাবার রিসিভ/ডেলিভার করলে নোটিফিকেশন আসবে
// //       _notificationSubscription = _firestore
// //           .collection('requests')
// //           .where('receiverId', isEqualTo: uid)
// //           .where('status', whereIn: ['approved', 'received', 'delivered', 'rejected'])
// //           .snapshots()
// //           .listen((snap) {
// //         notificationCount = snap.docs.length;
// //         notifyListeners();
// //       });
// //     }
// //
// //     // ২. ডোনারের জন্য 'Total Posts' লিসেনার
// //     if (selectedRole == 'donor') {
// //       _postSubscription = _firestore
// //           .collection('posts')
// //           .where('donorId', isEqualTo: uid)
// //           .snapshots()
// //           .listen((snap) {
// //         totalPosts = snap.docs.length;
// //         notifyListeners();
// //       });
// //     }
// //
// //     // ৩. রিকোয়েস্ট লিসেনার (Stats Updates)
// //     _requestSubscription = _firestore
// //         .collection('requests')
// //         .where(selectedRole == 'donor' ? 'donorId' : 'receiverId', isEqualTo: uid)
// //         .snapshots()
// //         .listen((snap) {
// //       if (selectedRole == 'donor') {
// //         // ডোনারের ক্ষেত্রে delivered হলেই সেটি সফল দান
// //         totalDonations = snap.docs.where((d) => d['status'] == 'delivered').length;
// //       } else if (selectedRole == 'receiver') {
// //         // রিসিভারের ক্ষেত্রে আপডেট
// //         pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
// //         totalReceived = snap.docs.where((d) =>
// //             ['approved', 'received', 'delivered', 'completed'].contains(d['status'])
// //         ).length;
// //       }
// //       notifyListeners();
// //     });
// //   }
// //
// //   void _cancelAllSubscriptions() {
// //     _notificationSubscription?.cancel();
// //     _postSubscription?.cancel();
// //     _requestSubscription?.cancel();
// //   }
// //
// //   // ================= 2. Auth Operations (Login & Signup) =================
// //
// //   Future<String?> signup(String email, String password) async {
// //     try {
// //       _setLoading(true);
// //       await _auth.createUserWithEmailAndPassword(
// //         email: email.trim(),
// //         password: password.trim(),
// //       );
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
// //       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
// //       await fetchUserData();
// //       _initRealTimeListeners();
// //       return null;
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
// //       _setLoading(true);
// //       String roleFormatted = role.trim().toLowerCase();
// //
// //       await _firestore.collection('accounts').doc(user!.uid).set({
// //         "uid": user!.uid,
// //         "email": user!.email,
// //         "role": roleFormatted,
// //         "updatedAt": FieldValue.serverTimestamp(),
// //         "profile": {"completed": false}
// //       }, SetOptions(merge: true));
// //
// //       selectedRole = roleFormatted;
// //       _initRealTimeListeners();
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Save Role Error: $e");
// //     } finally {
// //       _setLoading(false);
// //     }
// //   }
// //
// //   // ================= 3. User Data & Manual Stats =================
// //
// //   Future<void> fetchUserData() async {
// //     if (user == null) return;
// //     try {
// //       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
// //       if (doc.exists) {
// //         userData = doc.data();
// //         selectedRole = userData?['role']?.toString().toLowerCase();
// //         await countUserStats();
// //       }
// //     } catch (e) {
// //       debugPrint("Fetch Data Error: $e");
// //     }
// //   }
// //
// //   Future<void> countUserStats() async {
// //     if (user == null || selectedRole == null) return;
// //     final String uid = user!.uid;
// //     try {
// //       if (selectedRole == 'donor') {
// //         final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
// //         totalPosts = postSnap.docs.length;
// //
// //         final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
// //         totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered').length;
// //       } else if (selectedRole == 'receiver') {
// //         final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
// //         pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
// //         totalReceived = receiverReqSnap.docs.where((d) =>
// //             ['approved', 'delivered', 'completed'].contains(d['status'])
// //         ).length;
// //       }
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Stats Error: $e");
// //     }
// //   }
// //
// //   // ================= 4. Profile Management =================
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
// //   // ================= 5. Helpers & UI Actions =================
// //
// //   void resetNotificationCount() {
// //     notificationCount = 0;
// //     notifyListeners();
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
// //   Future<void> logout() async {
// //     _clearData();
// //     await _auth.signOut();
// //     notifyListeners();
// //   }
// //
// //   Future<void> saveDeviceToken() async {
// //     if (user == null) return;
// //     try {
// //       String? token = await _fcm.getToken();
// //       if (token != null) {
// //         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
// //       }
// //     } catch (_) {}
// //   }
// // }
//
//
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
//   int totalDonations = 0;
//   int totalReceived = 0;
//   int totalDeliveries = 0;
//   int pendingCount = 0;
//   int totalPosts = 0;
//   int notificationCount = 0;
//
//   // --- Listeners ---
//   StreamSubscription? _notificationSubscription;
//   StreamSubscription? _postSubscription;
//   StreamSubscription? _requestSubscription;
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
//   // ================= 1. Real-time Listeners (Donor, Receiver & Volunteer) =================
//
//   void _initRealTimeListeners() {
//     _cancelAllSubscriptions();
//     if (user == null || selectedRole == null) return;
//
//     final uid = user!.uid;
//
//     // ১. নোটিফিকেশন লিসেনার (রোল অনুযায়ী আলাদা লজিক)
//     if (selectedRole == 'donor') {
//       // ডোনারের জন্য: নতুন রিকোয়েস্ট (status: pending) আসলে নোটিফিকেশন
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('donorId', isEqualTo: uid)
//           .where('status', isEqualTo: 'pending')
//           .snapshots()
//           .listen((snap) {
//         notificationCount = snap.docs.length;
//         notifyListeners();
//       });
//     } else if (selectedRole == 'receiver') {
//       // রিসিভারের জন্য: ডোনার এপ্রুভ করলে বা ভলান্টিয়ার রিসিভ/ডেলিভার করলে নোটিফিকেশন
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .where('status', whereIn: ['approved', 'received', 'delivered', 'rejected'])
//           .snapshots()
//           .listen((snap) {
//         notificationCount = snap.docs.length;
//         notifyListeners();
//       });
//     } else if (selectedRole == 'volunteer') {
//       // ভলান্টিয়ারের জন্য: যে খাবারগুলো Approved কিন্তু এখনো কেউ পিক-আপ করেনি
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('status', isEqualTo: 'approved')
//           .snapshots()
//           .listen((snap) {
//         notificationCount = snap.docs.length;
//         notifyListeners();
//       });
//     }
//
//     // ২. ডোনারের জন্য 'Total Posts' লিসেনার
//     if (selectedRole == 'donor') {
//       _postSubscription = _firestore
//           .collection('posts')
//           .where('donorId', isEqualTo: uid)
//           .snapshots()
//           .listen((snap) {
//         totalPosts = snap.docs.length;
//         notifyListeners();
//       });
//     }
//
//     // ৩. রিকোয়েস্ট লিসেনার (Dashboard Stats Updates)
//     _requestSubscription = _firestore
//         .collection('requests')
//         .where(selectedRole == 'volunteer' ? 'volunteerId' : (selectedRole == 'donor' ? 'donorId' : 'receiverId'), isEqualTo: uid)
//         .snapshots()
//         .listen((snap) {
//       if (selectedRole == 'donor') {
//         totalDonations = snap.docs.where((d) => d['status'] == 'delivered').length;
//       } else if (selectedRole == 'receiver') {
//         pendingCount = snap.docs.where((d) => d['status'] == 'pending').length;
//         totalReceived = snap.docs.where((d) =>
//             ['approved', 'received', 'delivered', 'completed'].contains(d['status'])
//         ).length;
//       } else if (selectedRole == 'volunteer') {
//         totalDeliveries = snap.docs.where((d) => d['status'] == 'delivered').length;
//         // Ongoing deliveries (যেগুলো সে একসেপ্ট করেছে কিন্তু এখনো ডেলিভারি দেয়নি)
//         pendingCount = snap.docs.where((d) => d['status'] == 'received').length;
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
//   // ================= 2. Auth Operations (Login & Signup) =================
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
//   Future<String?> login(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
//       await fetchUserData();
//       _initRealTimeListeners();
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
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= 3. User Data & Manual Stats =================
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
//         final donorReqSnap = await _firestore.collection('requests').where('donorId', isEqualTo: uid).get();
//         totalDonations = donorReqSnap.docs.where((d) => d['status'] == 'delivered').length;
//       } else if (selectedRole == 'receiver') {
//         final receiverReqSnap = await _firestore.collection('requests').where('receiverId', isEqualTo: uid).get();
//         pendingCount = receiverReqSnap.docs.where((d) => d['status'] == 'pending').length;
//         totalReceived = receiverReqSnap.docs.where((d) =>
//             ['approved', 'received', 'delivered', 'completed'].contains(d['status'])
//         ).length;
//       } else if (selectedRole == 'volunteer') {
//         final volunteerReqSnap = await _firestore.collection('requests').where('volunteerId', isEqualTo: uid).get();
//         totalDeliveries = volunteerReqSnap.docs.where((d) => d['status'] == 'delivered').length;
//         pendingCount = volunteerReqSnap.docs.where((d) => d['status'] == 'received').length;
//       }
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Stats Error: $e");
//     }
//   }
//
//   // ================= 4. Profile Management =================
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
//     notifyListeners();
//   }
//
//   Future<void> saveDeviceToken() async {
//     if (user == null) return;
//     try {
//       String? token = await _fcm.getToken();
//       if (token != null) {
//         await _firestore.collection('accounts').doc(user!.uid).set({'fcmToken': token}, SetOptions(merge: true));
//       }
//     } catch (_) {}
//   }
// }

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
//   int totalDonations = 0;
//   int totalReceived = 0;
//   int totalDeliveries = 0;
//   int pendingCount = 0;
//   int totalPosts = 0;
//   int notificationCount = 0;
//
//   // --- Listeners ---
//   StreamSubscription? _notificationSubscription;
//   StreamSubscription? _postSubscription;
//   StreamSubscription? _requestSubscription;
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
//   // ================= 1. Real-time Listeners (Optimized) =================
//
//   void _initRealTimeListeners() {
//     _cancelAllSubscriptions();
//     if (user == null || selectedRole == null) return;
//
//     final uid = user!.uid;
//
//     // ১. নোটিফিকেশন লিসেনার (Role based)
//     if (selectedRole == 'donor') {
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('donorId', isEqualTo: uid)
//           .where('status', isEqualTo: 'pending')
//           .snapshots().listen((snap) {
//         notificationCount = snap.docs.length;
//         notifyListeners();
//       });
//     } else if (selectedRole == 'receiver') {
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('receiverId', isEqualTo: uid)
//           .where('status', whereIn: ['approved', 'received', 'delivered', 'rejected'])
//           .snapshots().listen((snap) {
//         notificationCount = snap.docs.length;
//         notifyListeners();
//       });
//     } else if (selectedRole == 'volunteer') {
//       _notificationSubscription = _firestore
//           .collection('requests')
//           .where('status', isEqualTo: 'approved')
//           .snapshots().listen((snap) {
//         notificationCount = snap.docs.where((d) {
//           final data = d.data();
//           return data['volunteerId'] == null || data['volunteerId'] == "";
//         }).length;
//         notifyListeners();
//       });
//     }
//
//     // ২. ড্যাশবোর্ড স্ট্যাটস লিসেনার
//     _requestSubscription = _firestore
//         .collection('requests')
//         .snapshots().listen((snap) {
//       _calculateStatsLocally(snap.docs, uid);
//     });
//
//     if (selectedRole == 'donor') {
//       _postSubscription = _firestore
//           .collection('posts')
//           .where('donorId', isEqualTo: uid)
//           .snapshots().listen((snap) {
//         totalPosts = snap.docs.length;
//         notifyListeners();
//       });
//     }
//   }
//
//   void _calculateStatsLocally(List<QueryDocumentSnapshot> docs, String uid) {
//     if (selectedRole == 'donor') {
//       totalDonations = docs.where((d) => d['donorId'] == uid && d['status'] == 'delivered').length;
//     } else if (selectedRole == 'receiver') {
//       pendingCount = docs.where((d) => d['receiverId'] == uid && d['status'] == 'pending').length;
//       totalReceived = docs.where((d) => d['receiverId'] == uid && ['approved', 'received', 'delivered'].contains(d['status'])).length;
//     } else if (selectedRole == 'volunteer') {
//       totalDeliveries = docs.where((d) => d['volunteerId'] == uid && d['status'] == 'delivered').length;
//       pendingCount = docs.where((d) => d['volunteerId'] == uid && d['status'] == 'received').length;
//     }
//     notifyListeners();
//   }
//
//   void _cancelAllSubscriptions() {
//     _notificationSubscription?.cancel();
//     _postSubscription?.cancel();
//     _requestSubscription?.cancel();
//   }
//
//   // ================= 2. Auth & User Operations =================
//
//   Future<String?> signup(String email, String password) async {
//     try {
//       _setLoading(true);
//       await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
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
//       _initRealTimeListeners();
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     } finally {
//       _setLoading(false);
//     }
//   }
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
//     }
//   }
//
//   Future<void> countUserStats() async {
//     if (user == null || selectedRole == null) return;
//     final String uid = user!.uid;
//     try {
//       final querySnapshot = await _firestore.collection('requests').get();
//       _calculateStatsLocally(querySnapshot.docs, uid);
//
//       if (selectedRole == 'donor') {
//         final postSnap = await _firestore.collection('posts').where('donorId', isEqualTo: uid).get();
//         totalPosts = postSnap.docs.length;
//       }
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Stats Calculation Error: $e");
//     }
//   }
//
//   // ================= 3. Profile Management (Complete Methods) =================
//
//   Future<void> saveUserProfile(Map<String, dynamic> profileData) async {
//     if (user == null) return;
//     try {
//       _setLoading(true);
//       String? currentRole = selectedRole ?? userData?['role'];
//
//       await _firestore.collection('accounts').doc(user!.uid).set({
//         "role": currentRole,
//         "profile": { ...profileData, "completed": true },
//         "updatedAt": FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//
//       await fetchUserData();
//     } catch (e) {
//       rethrow;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // Eita age miss hoichilo, ekhon fix kora hoyeche
//   Future<bool> isProfileCompleted() async {
//     if (user == null) return false;
//     try {
//       final doc = await _firestore.collection('accounts').doc(user!.uid).get();
//       if (doc.exists && doc.data() != null) {
//         final data = doc.data()!;
//         return data['profile'] != null && data['profile']['completed'] == true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint("Check Profile Error: $e");
//       return false;
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
//       }, SetOptions(merge: true));
//
//       selectedRole = roleFormatted;
//       _initRealTimeListeners();
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Save Role Error: $e");
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // ================= 4. Helpers & Cleanup =================
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
//     notifyListeners();
//   }
//
//   Future<void> saveDeviceToken() async {
//     if (user == null) return;
//     try {
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