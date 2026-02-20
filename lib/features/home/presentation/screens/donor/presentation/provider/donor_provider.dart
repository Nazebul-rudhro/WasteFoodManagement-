// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // ================= Select Images =================
// // //   Future<void> pickImages() async {
// // //     try {
// // //       if (kIsWeb) {
// // //         final result = await FilePicker.platform.pickFiles(
// // //           allowMultiple: true, type: FileType.image, withData: true,
// // //         );
// // //         if (result != null) {
// // //           selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //         }
// // //       } else {
// // //         final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //         if (images != null) selectedImages.addAll(images);
// // //       }
// // //       notifyListeners();
// // //     } catch (e) { debugPrint("Pick Image Error: $e"); }
// // //   }
// // //
// // //   // ================= Submit Post =================
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     if (selectedImages.isEmpty) throw Exception("Images required");
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user!.uid,
// // //         'foodName': foodName,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'requestedBy': [],
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //       selectedImages.clear();
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // ================= Error-Free Fetch Logic =================
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
// // //       _safeNotify();
// // //     }, onError: (e) => debugPrint("Fetch Pending Error: $e"));
// // //   }
// // //
// // //   void fetchApprovedRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'approved')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
// // //       _safeNotify();
// // //     }, onError: (e) => debugPrint("Fetch Approved Error: $e"));
// // //   }
// // //
// // //   // ================= Handle Approve/Reject =================
// // //   Future<void> handleRequest(String requestId, String postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //       DocumentReference postRef = _db.collection('posts').doc(postId);
// // //
// // //       if (action == 'approved') {
// // //         batch.update(reqRef, {'status': 'approved'});
// // //         batch.update(postRef, {'status': 'approved'});
// // //
// // //         final others = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in others.docs) {
// // //           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
// // //         }
// // //       } else {
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //       await batch.commit();
// // //       _safeNotify();
// // //     } catch (e) { debugPrint("Handle Request Error: $e"); }
// // //   }
// // //
// // //   void _safeNotify() {
// // //     if (hasListeners) notifyListeners();
// // //   }
// // // }
// // //
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // ইমেজ সিলেক্ট করা
// // //   Future<void> pickImages() async {
// // //     try {
// // //       if (kIsWeb) {
// // //         final result = await FilePicker.platform.pickFiles(
// // //           allowMultiple: true, type: FileType.image, withData: true,
// // //         );
// // //         if (result != null) {
// // //           selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //         }
// // //       } else {
// // //         final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //         if (images != null) selectedImages.addAll(images);
// // //       }
// // //       notifyListeners();
// // //     } catch (e) { debugPrint("Pick Image Error: $e"); }
// // //   }
// // //
// // //   // পোস্ট সাবমিট
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     if (selectedImages.isEmpty) throw Exception("Images required");
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user!.uid,
// // //         'foodName': foodName,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //       selectedImages.clear();
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // পেন্ডিং রিকোয়েস্ট ফেচ করা
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data() as Map<String, dynamic>
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // এপ্রুভড রিকোয়েস্ট ফেচ করা
// // //   void fetchApprovedRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'approved')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data() as Map<String, dynamic>
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // রিকোয়েস্ট হ্যান্ডেল করা (এপ্রুভ/রিজেক্ট)
// // //   Future<void> handleRequest(String requestId, String? postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //
// // //       if (action == 'approved' && postId != null) {
// // //         DocumentReference postRef = _db.collection('posts').doc(postId);
// // //         batch.update(reqRef, {'status': 'approved'});
// // //         batch.update(postRef, {'status': 'approved'});
// // //
// // //         final others = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in others.docs) {
// // //           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
// // //         }
// // //       } else {
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //       await batch.commit();
// // //     } catch (e) { debugPrint("Handle Request Error: $e"); }
// // //   }
// // // }
// //
// // //
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // 🔹 ইমেজ সিলেক্ট করা
// // //   Future<void> pickImages() async {
// // //     try {
// // //       if (kIsWeb) {
// // //         final result = await FilePicker.platform.pickFiles(
// // //           allowMultiple: true,
// // //           type: FileType.image,
// // //           withData: true,
// // //         );
// // //         if (result != null) {
// // //           selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //         }
// // //       } else {
// // //         final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //         if (images != null) selectedImages.addAll(images);
// // //       }
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Pick Image Error: $e");
// // //     }
// // //   }
// // //
// // //   // 🔹 ইমেজ রিমুভ করা (প্রফেশনাল অ্যাপে এটি দরকার, ভুল ছবি সিলেক্ট করলে ইউজার কাটতে পারবে)
// // //   void removeImage(int index) {
// // //     selectedImages.removeAt(index);
// // //     notifyListeners();
// // //   }
// // //
// // //   // 🔹 পোস্ট সাবমিট (Updated with foodType)
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String foodType, // নতুন প্যারামিটার
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     // ডাটা ভ্যালিডেশন
// // //     if (selectedImages.isEmpty) throw "Please select at least one image.";
// // //     if (foodName.isEmpty || quantity.isEmpty) throw "Important fields are missing.";
// // //
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       if (user == null) throw "User not authenticated!";
// // //
// // //       // ইমেজ আপলোড
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       // ডাটাবেসে ডাটা সেট করা
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'foodType': foodType, // ভেজ নাকি নন-ভেজ
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //
// // //       // সাবমিট শেষে ইমেজ ক্লিয়ার করা
// // //       selectedImages.clear();
// // //
// // //     } catch (e) {
// // //       debugPrint("Submit Post Error: $e");
// // //       rethrow; // এররটি UI লেভেলে পাঠিয়ে দেওয়া যাতে Dialog বন্ধ না হয়
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // 🔹 রিকোয়েস্ট ডিলিট বা ক্যান্সেল করা (নতুন ফিচার)
// // //   Future<void> deletePost(String postId) async {
// // //     try {
// // //       await _db.collection('posts').doc(postId).delete();
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Delete Post Error: $e");
// // //     }
// // //   }
// // //
// // //   // 🔹 পেন্ডিং রিকোয়েস্ট ফেচ করা
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .orderBy('createdAt', descending: true) // লেটেস্ট আগে আসবে
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // 🔹 এপ্রুভড রিকোয়েস্ট ফেচ করা
// // //   void fetchApprovedRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'approved')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // 🔹 রিকোয়েস্ট হ্যান্ডেল করা (এপ্রুভ/রিজেক্ট)
// // //   Future<void> handleRequest(String requestId, String? postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //
// // //       if (action == 'approved' && postId != null) {
// // //         DocumentReference postRef = _db.collection('posts').doc(postId);
// // //
// // //         // রিকোয়েস্ট স্ট্যাটাস আপডেট
// // //         batch.update(reqRef, {'status': 'approved'});
// // //         // পোস্টের স্ট্যাটাস পরিবর্তন যাতে আর কেউ রিকোয়েস্ট করতে না পারে
// // //         batch.update(postRef, {'status': 'claimed'}); // claimed দিলে সুবিধা
// // //
// // //         // এই পোস্টের জন্য আসা বাকি সব পেন্ডিং রিকোয়েস্ট রিজেক্ট করে দেওয়া
// // //         final others = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in others.docs) {
// // //           if (doc.id != requestId) {
// // //             batch.update(doc.reference, {'status': 'rejected'});
// // //           }
// // //         }
// // //       } else {
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //       await batch.commit();
// // //     } catch (e) {
// // //       debugPrint("Handle Request Error: $e");
// // //     }
// // //   }
// // // }
// //
// // //
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // 🔹 ইমেজ সিলেক্ট করা
// // //   Future<void> pickImages() async {
// // //     try {
// // //       if (kIsWeb) {
// // //         final result = await FilePicker.platform.pickFiles(
// // //           allowMultiple: true,
// // //           type: FileType.image,
// // //           withData: true,
// // //         );
// // //         if (result != null) {
// // //           selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //         }
// // //       } else {
// // //         final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //         if (images != null) selectedImages.addAll(images);
// // //       }
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Pick Image Error: $e");
// // //     }
// // //   }
// // //
// // //   // 🔹 ইমেজ রিমুভ করা
// // //   void removeImage(int index) {
// // //     selectedImages.removeAt(index);
// // //     notifyListeners();
// // //   }
// // //
// // //   // 🔹 পোস্ট সাবমিট (Updated with all Professional Fields)
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String foodType,
// // //     required String foodCondition, // 🔹 নতুন
// // //     required String estimatePersons, // 🔹 নতুন
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     // ডাটা ভ্যালিডেশন
// // //     if (selectedImages.isEmpty) throw "Please select at least one image.";
// // //
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       if (user == null) throw "User not authenticated!";
// // //
// // //       // ইমেজ আপলোড
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       // ডাটাবেসে ডাটা সেট করা
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'foodType': foodType,
// // //         'foodCondition': foodCondition, // 🔹 ডাটাবেসে সেভ হচ্ছে
// // //         'estimatePersons': estimatePersons, // 🔹 ডাটাবেসে সেভ হচ্ছে
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //
// // //       // সাবমিট শেষে ইমেজ ক্লিয়ার করা
// // //       selectedImages.clear();
// // //
// // //     } catch (e) {
// // //       debugPrint("Submit Post Error: $e");
// // //       rethrow;
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // 🔹 রিকোয়েস্ট ডিলিট বা ক্যান্সেল করা
// // //   Future<void> deletePost(String postId) async {
// // //     try {
// // //       await _db.collection('posts').doc(postId).delete();
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Delete Post Error: $e");
// // //     }
// // //   }
// // //
// // //   // 🔹 পেন্ডিং রিকোয়েস্ট ফেচ করা
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .orderBy('createdAt', descending: true)
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // 🔹 এপ্রুভড রিকোয়েস্ট ফেচ করা
// // //   void fetchApprovedRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'approved')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // 🔹 রিকোয়েস্ট হ্যান্ডেল করা
// // //   Future<void> handleRequest(String requestId, String? postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //
// // //       if (action == 'approved' && postId != null) {
// // //         DocumentReference postRef = _db.collection('posts').doc(postId);
// // //
// // //         batch.update(reqRef, {'status': 'approved'});
// // //         batch.update(postRef, {'status': 'claimed'});
// // //
// // //         final others = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in others.docs) {
// // //           if (doc.id != requestId) {
// // //             batch.update(doc.reference, {'status': 'rejected'});
// // //           }
// // //         }
// // //       } else {
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //       await batch.commit();
// // //     } catch (e) {
// // //       debugPrint("Handle Request Error: $e");
// // //     }
// // //   }
// // // }
// //
// // //
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // 🔹 ইমেজ সিলেক্ট করা
// // //   Future<void> pickImages() async {
// // //     try {
// // //       if (selectedImages.length >= 5) throw "Maximum 5 images allowed";
// // //
// // //       if (kIsWeb) {
// // //         final result = await FilePicker.platform.pickFiles(
// // //           allowMultiple: true, type: FileType.image, withData: true,
// // //         );
// // //         if (result != null) {
// // //           selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //         }
// // //       } else {
// // //         final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //         if (images != null) {
// // //           selectedImages.addAll(images.take(5 - selectedImages.length));
// // //         }
// // //       }
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Pick Image Error: $e");
// // //     }
// // //   }
// // //
// // //   void removeImage(int index) {
// // //     selectedImages.removeAt(index);
// // //     notifyListeners();
// // //   }
// // //
// // //   // 🔹 পোস্ট সাবমিট
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String foodType,
// // //     required String foodCondition,
// // //     required String estimatePersons,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     if (selectedImages.isEmpty) throw "Please select images";
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       if (user == null) throw "User not authenticated";
// // //
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'foodType': foodType,
// // //         'foodCondition': foodCondition,
// // //         'estimatePersons': estimatePersons,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //
// // //       selectedImages.clear();
// // //     } catch (e) {
// // //       rethrow;
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // //
// // //   // 🔹 পেন্ডিং রিকোয়েস্ট ফেচ
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     }, onError: (e) => debugPrint("Fetch Pending Error: $e"));
// // //   }
// // //
// // //   // 🔹 এপ্রুভড রিকোয়েস্ট ফেচ (Fixed Error)
// // //   void fetchApprovedRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'approved')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     }, onError: (e) => debugPrint("Fetch Approved Error: $e"));
// // //   }
// // //
// // //   // 🔹 রিকোয়েস্ট হ্যান্ডেল
// // //   Future<void> handleRequest(String requestId, String? postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //
// // //       if (action == 'approved' && postId != null) {
// // //         batch.update(reqRef, {'status': 'approved'});
// // //         batch.update(_db.collection('posts').doc(postId), {'status': 'claimed'});
// // //
// // //         final others = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in others.docs) {
// // //           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
// // //         }
// // //       } else {
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //       await batch.commit();
// // //     } catch (e) {
// // //       debugPrint("Handle Request Error: $e");
// // //     }
// // //   }
// // // }
// //
// //
// //
// //
// // import 'package:flutter/foundation.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import '../../../../../../../services/cloudinary_service.dart';
// //
// // class DonorProvider extends ChangeNotifier {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// //   final ImagePicker _picker = ImagePicker();
// //
// //   bool isLoading = false;
// //   List<XFile> selectedImages = [];
// //   List<Map<String, dynamic>> receiverRequests = [];
// //   List<Map<String, dynamic>> approvedRequests = [];
// //
// //   // 🔹 রিয়েল-টাইম ডাটা ফেচিং (একবার কল করলেই সারাক্ষণ আপডেট থাকবে)
// //   void fetchAllRequests() {
// //     final user = _auth.currentUser;
// //     if (user == null) return;
// //
// //     // ১. পেন্ডিং রিকোয়েস্ট লিসেনার
// //     _db.collection('requests')
// //         .where('donorId', isEqualTo: user.uid)
// //         .where('status', isEqualTo: 'pending')
// //         .snapshots().listen((snapshot) {
// //       receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
// //       notifyListeners();
// //     });
// //
// //     // ২. এপ্রুভড এবং ডেলিভারি স্ট্যাটাস লিসেনার
// //     _db.collection('requests')
// //         .where('donorId', isEqualTo: user.uid)
// //         .where('status', whereIn: ['approved', 'delivered'])
// //         .snapshots().listen((snapshot) {
// //       approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
// //       notifyListeners();
// //     });
// //   }
// //
// //   // 🔹 এপ্রুভ বা রিজেক্ট লজিক (Atomic Update)
// //   Future<void> handleRequest(String requestId, String postId, String action) async {
// //     try {
// //       WriteBatch batch = _db.batch();
// //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// //       DocumentReference postRef = _db.collection('posts').doc(postId);
// //
// //       if (action == 'approved') {
// //         batch.update(reqRef, {'status': 'approved', 'approvedAt': FieldValue.serverTimestamp()});
// //         batch.update(postRef, {'status': 'claimed'});
// //
// //         // ঐ পোস্টের অন্য সব রিকোয়েস্ট রিজেক্ট করা
// //         final others = await _db.collection('requests')
// //             .where('postId', isEqualTo: postId)
// //             .where('status', isEqualTo: 'pending').get();
// //
// //         for (var doc in others.docs) {
// //           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
// //         }
// //       } else {
// //         batch.update(reqRef, {'status': 'rejected'});
// //       }
// //       await batch.commit();
// //     } catch (e) {
// //       debugPrint("Handle Request Error: $e");
// //     }
// //   }
// //
// //   // 🔹 ডেলিভারি কমপ্লিট করা (Professional Flow)
// //   Future<void> markAsDelivered(String requestId, String postId) async {
// //     try {
// //       WriteBatch batch = _db.batch();
// //       batch.update(_db.collection('requests').doc(requestId), {'status': 'delivered'});
// //       batch.update(_db.collection('posts').doc(postId), {'status': 'completed'});
// //       await batch.commit();
// //     } catch (e) {
// //       debugPrint("Delivery Error: $e");
// //     }
// //   }
// //
// //   // 🔹 ইমেজ ম্যানেজমেন্ট
// //   Future<void> pickImages() async {
// //     try {
// //       if (selectedImages.length >= 5) throw "Max 5 images";
// //       final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// //       if (images != null) {
// //         selectedImages.addAll(images.take(5 - selectedImages.length));
// //         notifyListeners();
// //       }
// //     } catch (e) { debugPrint(e.toString()); }
// //   }
// //
// //   void removeImage(int index) {
// //     selectedImages.removeAt(index);
// //     notifyListeners();
// //   }
// //
// //   // 🔹 পোস্ট সাবমিট
// //   Future<void> submitPost({
// //     required String foodName, required String foodType,
// //     required String foodCondition, required String estimatePersons,
// //     required String quantity, required String pickupTime,
// //     required String pickupAddress, required String description,
// //     required DateTime expiryDate,
// //   }) async {
// //     if (selectedImages.isEmpty) throw "Images required";
// //     isLoading = true;
// //     notifyListeners();
// //     try {
// //       final user = _auth.currentUser;
// //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// //       final postRef = _db.collection('posts').doc();
// //
// //       await postRef.set({
// //         'postId': postRef.id, 'donorId': user!.uid,
// //         'foodName': foodName, 'foodType': foodType,
// //         'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
// //         'quantity': quantity, 'pickupTime': pickupTime,
// //         'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
// //         'description': description, 'imageUrls': imageUrls,
// //         'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
// //       });
// //       selectedImages.clear();
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }
// // }
// // //
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   // State Variables
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //
// // //   // Requests Lists
// // //   List<Map<String, dynamic>> receiverRequests = [];
// // //   List<Map<String, dynamic>> approvedRequests = [];
// // //
// // //   // --- 🔹 রিয়েল-টাইম ডাটা ফেচিং (Listeners) 🔹 ---
// // //
// // //   void fetchAllRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     // ১. পেন্ডিং রিকোয়েস্ট লিসেনার (Pending Tab এর জন্য)
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots().listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     }, onError: (error) => debugPrint("Pending Listener Error: $error"));
// // //
// // //     // ২. এপ্রুভড এবং ডেলিভারি স্ট্যাটাস লিসেনার (Delivery Tab এর জন্য)
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', whereIn: ['approved', 'delivered', 'rejected'])
// // //         .snapshots().listen((snapshot) {
// // //       approvedRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data()
// // //       }).toList();
// // //       notifyListeners();
// // //     }, onError: (error) => debugPrint("History Listener Error: $error"));
// // //   }
// // //
// // //   // --- 🔹 রিকোয়েস্ট ম্যানেজমেন্ট (Approve/Reject) 🔹 ---
// // //
// // //   Future<void> handleRequest(String requestId, String postId, String action) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //       DocumentReference postRef = _db.collection('posts').doc(postId);
// // //
// // //       if (action == 'approved') {
// // //         // ১. মেইন রিকোয়েস্ট এপ্রুভ করা
// // //         batch.update(reqRef, {
// // //           'status': 'approved',
// // //           'approvedAt': FieldValue.serverTimestamp()
// // //         });
// // //
// // //         // ২. পোস্ট স্ট্যাটাস আপডেট করা (যাতে অন্য কেউ আর রিকোয়েস্ট না করতে পারে)
// // //         batch.update(postRef, {'status': 'claimed'});
// // //
// // //         // ৩. ঐ পোস্টের অন্য সব পেন্ডিং রিকোয়েস্ট অটোমেটিক রিজেক্ট করা
// // //         final otherRequests = await _db.collection('requests')
// // //             .where('postId', isEqualTo: postId)
// // //             .where('status', isEqualTo: 'pending').get();
// // //
// // //         for (var doc in otherRequests.docs) {
// // //           if (doc.id != requestId) {
// // //             batch.update(doc.reference, {'status': 'rejected'});
// // //           }
// // //         }
// // //       } else {
// // //         // রিজেক্ট করা হলে শুধু ঐ রিকোয়েস্ট আপডেট হবে
// // //         batch.update(reqRef, {'status': 'rejected'});
// // //       }
// // //
// // //       await batch.commit(); // সবগুলো আপডেট একসাথে ডাটাবেজে যাবে
// // //     } catch (e) {
// // //       debugPrint("Handle Request Error: $e");
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   // --- 🔹 ডেলিভারি কনফার্মেশন 🔹 ---
// // //
// // //   Future<void> markAsDelivered(String requestId, String postId) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //
// // //       // রিকোয়েস্ট স্ট্যাটাস Delivered করা
// // //       batch.update(_db.collection('requests').doc(requestId), {
// // //         'status': 'delivered',
// // //         'deliveredAt': FieldValue.serverTimestamp()
// // //       });
// // //
// // //       // পোস্ট স্ট্যাটাস Completed করা
// // //       batch.update(_db.collection('posts').doc(postId), {
// // //         'status': 'completed'
// // //       });
// // //
// // //       await batch.commit();
// // //     } catch (e) {
// // //       debugPrint("Delivery Confirmation Error: $e");
// // //       rethrow;
// // //     }
// // //   }
// // //
// // //   // --- 🔹 ইমেজ এবং পোস্ট সাবমিশন 🔹 ---
// // //
// // //   Future<void> pickImages() async {
// // //     try {
// // //       final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
// // //       if (images != null) {
// // //         // সর্বোচ্চ ৫টি ইমেজ লিমিট
// // //         if (selectedImages.length + images.length > 5) {
// // //           selectedImages.addAll(images.take(5 - selectedImages.length));
// // //         } else {
// // //           selectedImages.addAll(images);
// // //         }
// // //         notifyListeners();
// // //       }
// // //     } catch (e) {
// // //       debugPrint("Image Pick Error: $e");
// // //     }
// // //   }
// // //
// // //   void removeImage(int index) {
// // //     selectedImages.removeAt(index);
// // //     notifyListeners();
// // //   }
// // //
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String foodType,
// // //     required String foodCondition,
// // //     required String estimatePersons,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //     required DateTime expiryDate,
// // //   }) async {
// // //     if (selectedImages.isEmpty) throw "Please select at least one image";
// // //
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser;
// // //       if (user == null) throw "Unauthorized access";
// // //
// // //       // ক্লাউডিনারি-তে ইমেজ আপলোড
// // //       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'foodType': foodType,
// // //         'foodCondition': foodCondition,
// // //         'estimatePersons': estimatePersons,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'expiryDate': Timestamp.fromDate(expiryDate),
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //
// // //       selectedImages.clear(); // পোস্ট হয়ে গেলে ইমেজ লিস্ট খালি করা
// // //     } catch (e) {
// // //       debugPrint("Submit Post Error: $e");
// // //       rethrow;
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // // }
//
//
//
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../../../../services/cloudinary_service.dart';
//
// class DonorProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   bool isLoading = false;
//   List<XFile> selectedImages = [];
//
//   List<Map<String, dynamic>> receiverRequests = []; // Pending Tab
//   List<Map<String, dynamic>> approvedRequests = []; // Approved/Delivery Tab
//
//   // 🔹 রিয়েল-টাইম ডাটা ফেচিং
//   void fetchAllRequests() {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // ১. পেন্ডিং রিকোয়েস্ট (Pending Tab এর জন্য)
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots().listen((snapshot) {
//       receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     }, onError: (e) => debugPrint("Pending Error: $e"));
//
//     // ২. এপ্রুভড, ডেলিভারি এবং রিজেক্টেড (History Tab এর জন্য)
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', whereIn: ['approved', 'delivered', 'rejected'])
//         .snapshots().listen((snapshot) {
//       approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     }, onError: (e) => debugPrint("History Error: $e"));
//   }
//
//   // 🔹 রিকোয়েস্ট একশন (Approve/Reject)
//   Future<void> handleRequest(String requestId, String postId, String action) async {
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc(requestId);
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//
//       if (action == 'approved') {
//         batch.update(reqRef, {'status': 'approved', 'approvedAt': FieldValue.serverTimestamp()});
//         batch.update(postRef, {'status': 'claimed'});
//
//         // ঐ পোস্টের অন্য সব পেন্ডিং রিকোয়েস্ট অটো রিজেক্ট
//         final others = await _db.collection('requests')
//             .where('postId', isEqualTo: postId)
//             .where('status', isEqualTo: 'pending').get();
//
//         for (var doc in others.docs) {
//           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
//         }
//       } else {
//         batch.update(reqRef, {'status': 'rejected'});
//       }
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Handle Request Error: $e");
//     }
//   }
//
//   // 🔹 ডেলিভারি কমপ্লিট
//   Future<void> markAsDelivered(String requestId, String postId) async {
//     try {
//       WriteBatch batch = _db.batch();
//       batch.update(_db.collection('requests').doc(requestId), {'status': 'delivered'});
//       batch.update(_db.collection('posts').doc(postId), {'status': 'completed'});
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Delivery Error: $e");
//     }
//   }
//
//   // --- Image Picking & Submission Methods ---
//   Future<void> pickImages() async {
//     try {
//       final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null) {
//         if (selectedImages.length + images.length > 5) {
//           selectedImages.addAll(images.take(5 - selectedImages.length));
//         } else {
//           selectedImages.addAll(images);
//         }
//         notifyListeners();
//       }
//     } catch (e) { debugPrint(e.toString()); }
//   }
//
//   void removeImage(int index) {
//     selectedImages.removeAt(index);
//     notifyListeners();
//   }
//
//   Future<void> submitPost({
//     required String foodName, required String foodType,
//     required String foodCondition, required String estimatePersons,
//     required String quantity, required String pickupTime,
//     required String pickupAddress, required String description,
//     required DateTime expiryDate,
//   }) async {
//     if (selectedImages.isEmpty) throw "Images required";
//     isLoading = true;
//     notifyListeners();
//     try {
//       final user = _auth.currentUser;
//       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
//       final postRef = _db.collection('posts').doc();
//
//       await postRef.set({
//         'postId': postRef.id, 'donorId': user!.uid,
//         'foodName': foodName, 'foodType': foodType,
//         'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
//         'quantity': quantity, 'pickupTime': pickupTime,
//         'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
//         'description': description, 'imageUrls': imageUrls,
//         'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
//       });
//       selectedImages.clear();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

//
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../../../../services/cloudinary_service.dart';
//
// class DonorProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   bool isLoading = false;
//   List<XFile> selectedImages = [];
//
//   List<Map<String, dynamic>> receiverRequests = []; // Pending Tab
//   List<Map<String, dynamic>> approvedRequests = []; // Approved/Delivery/History Tab
//
//   // 🔹 রিয়েল-টাইম ডাটা ফেচিং
//   void fetchAllRequests() {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // ১. পেন্ডিং রিকোয়েস্ট (Pending Tab)
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots().listen((snapshot) {
//       receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     }, onError: (e) => debugPrint("Pending Error: $e"));
//
//     // ২. এপ্রুভড এবং ডেলিভারি (Approved/History Tab)
//     // নোট: এখানে 'rejected' সরালে শুধু সফলগুলো দেখাবে, আমি 'approved' ও 'delivered' রাখছি
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', whereIn: ['approved', 'delivered'])
//         .snapshots().listen((snapshot) {
//       approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     }, onError: (e) => debugPrint("Approved List Error: $e"));
//   }
//
//   // 🔹 রিকোয়েস্ট একশন (Approve/Reject)
//   Future<void> handleRequest(String requestId, String postId, String action) async {
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc(requestId);
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//
//       if (action == 'approved') {
//         batch.update(reqRef, {'status': 'approved', 'approvedAt': FieldValue.serverTimestamp()});
//         batch.update(postRef, {'status': 'claimed'});
//
//         // ঐ পোস্টের অন্য সব পেন্ডিং রিকোয়েস্ট অটো রিজেক্ট
//         final others = await _db.collection('requests')
//             .where('postId', isEqualTo: postId)
//             .where('status', isEqualTo: 'pending').get();
//
//         for (var doc in others.docs) {
//           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
//         }
//       } else {
//         batch.update(reqRef, {'status': 'rejected'});
//       }
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Handle Request Error: $e");
//     }
//   }
//
//   // 🔹 ডেলিভারি কমপ্লিট
//   Future<void> markAsDelivered(String requestId, String postId) async {
//     try {
//       WriteBatch batch = _db.batch();
//       batch.update(_db.collection('requests').doc(requestId), {
//         'status': 'delivered',
//         'deliveredAt': FieldValue.serverTimestamp(),
//       });
//       batch.update(_db.collection('posts').doc(postId), {'status': 'completed'});
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Delivery Error: $e");
//     }
//   }
//
//   // --- Image Methods (আগের মতই) ---
//   Future<void> pickImages() async {
//     try {
//       final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null) {
//         if (selectedImages.length + images.length > 5) {
//           selectedImages.addAll(images.take(5 - selectedImages.length));
//         } else {
//           selectedImages.addAll(images);
//         }
//         notifyListeners();
//       }
//     } catch (e) { debugPrint(e.toString()); }
//   }
//
//   void removeImage(int index) {
//     selectedImages.removeAt(index);
//     notifyListeners();
//   }
//
//   Future<void> submitPost({
//     required String foodName, required String foodType,
//     required String foodCondition, required String estimatePersons,
//     required String quantity, required String pickupTime,
//     required String pickupAddress, required String description,
//     required DateTime expiryDate,
//   }) async {
//     if (selectedImages.isEmpty) throw "Images required";
//     isLoading = true;
//     notifyListeners();
//     try {
//       final user = _auth.currentUser;
//       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
//       final postRef = _db.collection('posts').doc();
//
//       await postRef.set({
//         'postId': postRef.id, 'donorId': user!.uid,
//         'foodName': foodName, 'foodType': foodType,
//         'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
//         'quantity': quantity, 'pickupTime': pickupTime,
//         'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
//         'description': description, 'imageUrls': imageUrls,
//         'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
//       });
//       selectedImages.clear();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../../../../../services/cloudinary_service.dart';
//
// class DonorProvider extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   bool isLoading = false;
//   List<XFile> selectedImages = [];
//
//   List<Map<String, dynamic>> receiverRequests = []; // Pending Tab
//   List<Map<String, dynamic>> approvedRequests = []; // Delivery/Approved Tab
//
//   // 🔹 রিয়েল-টাইম ডাটা ফেচিং
//   void fetchAllRequests() {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // ১. পেন্ডিং রিকোয়েস্ট লিসেনার
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots().listen((snapshot) {
//       receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     });
//
//     // ২. অ্যাপ্রুভড এবং ডেলিভারি লিসেনার (ongoing সহ)
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', whereIn: ['approved', 'ongoing', 'delivered'])
//         .snapshots().listen((snapshot) {
//       approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
//       notifyListeners();
//     });
//   }
//
//   // 🔹 রিকোয়েস্ট একশন (Approve/Reject)
//   Future<void> handleRequest(String requestId, String postId, String action) async {
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc(requestId);
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//
//       if (action == 'approved') {
//         batch.update(reqRef, {
//           'status': 'approved',
//           'deliverystatus': 'pending', // রিসিভার এখন 'APPROVED' দেখবে
//           'approvedAt': FieldValue.serverTimestamp()
//         });
//         batch.update(postRef, {'status': 'claimed'});
//
//         // অন্য পেন্ডিং রিকোয়েস্ট রিজেক্ট করা
//         final others = await _db.collection('requests')
//             .where('postId', isEqualTo: postId)
//             .where('status', isEqualTo: 'pending').get();
//
//         for (var doc in others.docs) {
//           if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
//         }
//       } else {
//         batch.update(reqRef, {'status': 'rejected'});
//       }
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Handle Request Error: $e");
//     }
//   }
//
//   // 🔹 ডেলিভারি কমপ্লিট করা (Confirm Delivery)
//   Future<void> markAsDelivered(String requestId, String postId) async {
//     try {
//       WriteBatch batch = _db.batch();
//       batch.update(_db.collection('requests').doc(requestId), {
//         'status': 'delivered',
//         'deliverystatus': 'completed', // রিসিভার এখন 'RECEIVED' দেখবে
//         'deliveredAt': FieldValue.serverTimestamp(),
//       });
//       batch.update(_db.collection('posts').doc(postId), {'status': 'completed'});
//       await batch.commit();
//     } catch (e) {
//       debugPrint("Delivery Error: $e");
//     }
//   }
//
//   // 🔹 ইমেজ হ্যান্ডলিং (Pick & Remove)
//   Future<void> pickImages() async {
//     try {
//       final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null) {
//         selectedImages.addAll(images);
//         notifyListeners();
//       }
//     } catch (e) { debugPrint(e.toString()); }
//   }
//
//   void removeImage(int index) { // ✅ এই মেথডটি অ্যাড করা হয়েছে
//     selectedImages.removeAt(index);
//     notifyListeners();
//   }
//
//   // 🔹 নতুন পোস্ট সাবমিট
//   Future<void> submitPost({
//     required String foodName, required String foodType,
//     required String foodCondition, required String estimatePersons,
//     required String quantity, required String pickupTime,
//     required String pickupAddress, required String description,
//     required DateTime expiryDate,
//   }) async {
//     if (selectedImages.isEmpty) throw "Images required";
//     isLoading = true;
//     notifyListeners();
//     try {
//       final user = _auth.currentUser;
//       final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
//       final postRef = _db.collection('posts').doc();
//
//       await postRef.set({
//         'postId': postRef.id, 'donorId': user!.uid,
//         'foodName': foodName, 'foodType': foodType,
//         'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
//         'quantity': quantity, 'pickupTime': pickupTime,
//         'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
//         'description': description, 'imageUrls': imageUrls,
//         'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
//       });
//       selectedImages.clear();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../../services/cloudinary_service.dart';

class DonorProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  List<XFile> selectedImages = [];

  List<Map<String, dynamic>> receiverRequests = [];
  List<Map<String, dynamic>> approvedRequests = [];

  void fetchAllRequests() {
    final user = _auth.currentUser;
    if (user == null) return;

    // ১. পেন্ডিং ট্যাব: শুধুমাত্র 'pending' স্ট্যাটাস
    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .snapshots().listen((snapshot) {
      receiverRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
      notifyListeners();
    });

    // ২. ডেলিভারি ট্যাব: 'approved', 'ongoing', এবং 'delivered' স্ট্যাটাস
    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', whereIn: ['approved', 'ongoing', 'delivered'])
        .snapshots().listen((snapshot) {
      approvedRequests = snapshot.docs.map((doc) => {"requestId": doc.id, ...doc.data()}).toList();
      notifyListeners();
    });
  }

  Future<void> handleRequest(String requestId, String postId, String action) async {
    try {
      WriteBatch batch = _db.batch();
      DocumentReference reqRef = _db.collection('requests').doc(requestId);
      DocumentReference postRef = _db.collection('posts').doc(postId);

      if (action == 'approved') {
        // ✅ এখানে স্ট্যাটাস শুধু 'approved' হবে
        batch.update(reqRef, {
          'status': 'approved',
          'deliverystatus': 'pending',
          'approvedAt': FieldValue.serverTimestamp()
        });
        batch.update(postRef, {'status': 'claimed'});

        final others = await _db.collection('requests')
            .where('postId', isEqualTo: postId)
            .where('status', isEqualTo: 'pending').get();

        for (var doc in others.docs) {
          if (doc.id != requestId) batch.update(doc.reference, {'status': 'rejected'});
        }
      } else {
        batch.update(reqRef, {'status': 'rejected'});
      }
      await batch.commit();
    } catch (e) {
      debugPrint("Handle Request Error: $e");
    }
  }

  Future<void> markAsDelivered(String requestId, String postId) async {
    try {
      WriteBatch batch = _db.batch();
      // ✅ কনফার্ম ডেলিভারি করলেই কেবল 'delivered' হবে
      batch.update(_db.collection('requests').doc(requestId), {
        'status': 'delivered',
        'deliverystatus': 'pending',
        'deliveredAt': FieldValue.serverTimestamp(),
      });
      batch.update(_db.collection('posts').doc(postId), {'status': 'completed'});
      await batch.commit();
    } catch (e) {
      debugPrint("Delivery Error: $e");
    }
  }

  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 70);
      if (images != null) { selectedImages.addAll(images); notifyListeners(); }
    } catch (e) { debugPrint(e.toString()); }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    notifyListeners();
  }

  Future<void> submitPost({
    required String foodName, required String foodType,
    required String foodCondition, required String estimatePersons,
    required String quantity, required String pickupTime,
    required String pickupAddress, required String description,
    required DateTime expiryDate,
  }) async {
    if (selectedImages.isEmpty) throw "Images required";
    isLoading = true; notifyListeners();
    try {
      final user = _auth.currentUser;
      final List<String> imageUrls = await CloudinaryService.uploadImages(selectedImages);
      final postRef = _db.collection('posts').doc();

      await postRef.set({
        'postId': postRef.id, 'donorId': user!.uid,
        'foodName': foodName, 'foodType': foodType,
        'foodCondition': foodCondition, 'estimatePersons': estimatePersons,
        'quantity': quantity, 'pickupTime': pickupTime,
        'expiryDate': Timestamp.fromDate(expiryDate), 'pickupAddress': pickupAddress,
        'description': description, 'imageUrls': imageUrls,
        'status': 'available', 'createdAt': FieldValue.serverTimestamp(),
      });
      selectedImages.clear();
    } finally { isLoading = false; notifyListeners(); }
  }
}