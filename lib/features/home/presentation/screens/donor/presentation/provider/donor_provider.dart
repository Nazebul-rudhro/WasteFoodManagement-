// // //
// // // import 'dart:typed_data';
// // // import 'package:flutter/foundation.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:firebase_auth/firebase_auth.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // import '../../../../../../../services/cloudinary_service.dart';
// // //
// // // class DonorProvider extends ChangeNotifier {
// // //   final FirebaseAuth _auth = FirebaseAuth.instance;
// // //   final FirebaseFirestore _db = FirebaseFirestore.instance;
// // //   final ImagePicker _picker = ImagePicker();
// // //
// // //   bool isLoading = false;
// // //   List<XFile> selectedImages = [];
// // //
// // //   // ================= PICK IMAGES =================
// // //   Future<void> pickImages() async {
// // //     if (kIsWeb) {
// // //       final result = await FilePicker.platform.pickFiles(
// // //         allowMultiple: true,
// // //         type: FileType.image,
// // //         withData: true,
// // //       );
// // //
// // //       if (result != null) {
// // //         selectedImages.addAll(
// // //           result.files.map(
// // //                 (f) => XFile.fromData(f.bytes!, name: f.name),
// // //           ),
// // //         );
// // //       }
// // //     } else {
// // //       final images = await _picker.pickMultiImage(imageQuality: 70);
// // //       if (images != null) {
// // //         selectedImages.addAll(images);
// // //       }
// // //     }
// // //     notifyListeners();
// // //   }
// // //
// // //   // ================= SUBMIT POST =================
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //   }) async {
// // //     if (selectedImages.isEmpty) {
// // //       throw Exception("Please add at least one image");
// // //     }
// // //
// // //     isLoading = true;
// // //     notifyListeners();
// // //
// // //     try {
// // //       final user = _auth.currentUser!;
// // //       final imageUrls =
// // //       await CloudinaryService.uploadImages(selectedImages);
// // //
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
// // //         'pickupAddress': pickupAddress,
// // //         'description': description,
// // //         'imageUrls': imageUrls,
// // //         'status': 'available',         // default
// // //         'requestedBy': [],             // empty initially
// // //         'createdAt': FieldValue.serverTimestamp(),
// // //       });
// // //
// // //       selectedImages.clear();
// // //     } finally {
// // //       isLoading = false;
// // //       notifyListeners();
// // //     }
// // //   }
// // // }
// // // import 'dart:typed_data';
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
// // //
// // //   // ================= PICK IMAGES =================
// // //   Future<void> pickImages() async {
// // //     if (kIsWeb) {
// // //       final result = await FilePicker.platform.pickFiles(
// // //         allowMultiple: true, type: FileType.image, withData: true,
// // //       );
// // //       if (result != null) {
// // //         selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// // //       }
// // //     } else {
// // //       final images = await _picker.pickMultiImage(imageQuality: 70);
// // //       if (images != null) selectedImages.addAll(images);
// // //     }
// // //     notifyListeners();
// // //   }
// // //
// // //   // ================= SUBMIT POST =================
// // //   Future<void> submitPost({
// // //     required String foodName,
// // //     required String quantity,
// // //     required String pickupTime,
// // //     required String pickupAddress,
// // //     required String description,
// // //   }) async {
// // //     if (selectedImages.isEmpty) throw Exception("Please add at least one image");
// // //     isLoading = true;
// // //     notifyListeners();
// // //     try {
// // //       final user = _auth.currentUser!;
// // //       final imageUrls = await CloudinaryService.uploadImages(selectedImages);
// // //       final postRef = _db.collection('posts').doc();
// // //
// // //       await postRef.set({
// // //         'postId': postRef.id,
// // //         'donorId': user.uid,
// // //         'foodName': foodName,
// // //         'quantity': quantity,
// // //         'pickupTime': pickupTime,
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
// // //   // ================= FETCH RECEIVER REQUESTS =================
// // //   void fetchRequests() {
// // //     final user = _auth.currentUser;
// // //     if (user == null) return;
// // //
// // //     // Real-time snapshots use করা হয়েছে যেন ডেটা আসার সাথে সাথে UI আপডেট হয়
// // //     _db.collection('requests')
// // //         .where('donorId', isEqualTo: user.uid)
// // //         .where('status', isEqualTo: 'pending')
// // //         .snapshots()
// // //         .listen((snapshot) {
// // //       receiverRequests = snapshot.docs.map((doc) => {
// // //         "requestId": doc.id,
// // //         ...doc.data(),
// // //       }).toList();
// // //       notifyListeners();
// // //     });
// // //   }
// // //
// // //   // ================= APPROVE/REJECT ACTION =================
// // //   Future<void> handleRequest(String requestId, String postId, String status) async {
// // //     try {
// // //       WriteBatch batch = _db.batch();
// // //
// // //       // ১. requests কালেকশন আপডেট
// // //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// // //       batch.update(reqRef, {'status': status});
// // //
// // //       // ২. posts কালেকশন আপডেট
// // //       DocumentReference postRef = _db.collection('posts').doc(postId);
// // //       batch.update(postRef, {'status': status});
// // //
// // //       await batch.commit();
// // //       notifyListeners();
// // //     } catch (e) {
// // //       debugPrint("Update Error: $e");
// // //     }
// // //   }
// // // }
// //
// //
// // import 'dart:typed_data';
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
// //
// //   // ================= PICK IMAGES =================
// //   Future<void> pickImages() async {
// //     if (kIsWeb) {
// //       final result = await FilePicker.platform.pickFiles(
// //         allowMultiple: true, type: FileType.image, withData: true,
// //       );
// //       if (result != null) {
// //         selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
// //       }
// //     } else {
// //       final images = await _picker.pickMultiImage(imageQuality: 70);
// //       if (images != null) selectedImages.addAll(images);
// //     }
// //     notifyListeners();
// //   }
// //
// //   // ================= SUBMIT POST =================
// //   Future<void> submitPost({
// //     required String foodName,
// //     required String quantity,
// //     required String pickupTime,
// //     required String pickupAddress,
// //     required String description,
// //   }) async {
// //     if (selectedImages.isEmpty) throw Exception("Please add at least one image");
// //     isLoading = true;
// //     notifyListeners();
// //     try {
// //       final user = _auth.currentUser!;
// //       final imageUrls = await CloudinaryService.uploadImages(selectedImages);
// //       final postRef = _db.collection('posts').doc();
// //
// //       await postRef.set({
// //         'postId': postRef.id,
// //         'donorId': user.uid,
// //         'foodName': foodName,
// //         'quantity': quantity,
// //         'pickupTime': pickupTime,
// //         'pickupAddress': pickupAddress,
// //         'description': description,
// //         'imageUrls': imageUrls,
// //         'status': 'available',
// //         'requestedBy': [],
// //         'createdAt': FieldValue.serverTimestamp(),
// //       });
// //       selectedImages.clear();
// //     } finally {
// //       isLoading = false;
// //       notifyListeners();
// //     }
// //   }
// //
// //   // ================= FETCH RECEIVER REQUESTS =================
// //   void fetchRequests() {
// //     final user = _auth.currentUser;
// //     if (user == null) return;
// //
// //     _db.collection('requests')
// //         .where('donorId', isEqualTo: user.uid)
// //         .where('status', isEqualTo: 'pending')
// //         .snapshots()
// //         .listen((snapshot) {
// //       receiverRequests = snapshot.docs.map((doc) => {
// //         "requestId": doc.id,
// //         ...doc.data(),
// //       }).toList();
// //       notifyListeners();
// //     });
// //   }
// //
// //   // ================= APPROVE/REJECT ACTION (Updated Logic) =================
// //   Future<void> handleRequest(String requestId, String postId, String action) async {
// //     try {
// //       WriteBatch batch = _db.batch();
// //       DocumentReference reqRef = _db.collection('requests').doc(requestId);
// //       DocumentReference postRef = _db.collection('posts').doc(postId);
// //
// //       if (action == 'approved') {
// //         // ১. requests কালেকশন আপডেট
// //         batch.update(reqRef, {'status': 'approved'});
// //         // ২. posts কালেকশন আপডেট (আপনার চাওয়া অনুযায়ী 'Accepted')
// //         batch.update(postRef, {'status': 'Accepted'});
// //       }
// //       else if (action == 'rejected') {
// //         // ১. requests কালেকশন আপডেট
// //         batch.update(reqRef, {'status': 'rejected'});
// //         // ২. posts কালেকশন আবারও 'available' থাকবে যেন অন্য কেউ রিকোয়েস্ট করতে পারে
// //         batch.update(postRef, {'status': 'available'});
// //       }
// //
// //       await batch.commit();
// //
// //       // লোকাল লিস্ট থেকে রিমুভ (তাত্ক্ষণিক UI আপডেটের জন্য)
// //       receiverRequests.removeWhere((element) => element['requestId'] == requestId);
// //       notifyListeners();
// //     } catch (e) {
// //       debugPrint("Update Error: $e");
// //     }
// //   }
// // }
//
//
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
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
//   List<Map<String, dynamic>> receiverRequests = [];
//
//   // ================= PICK IMAGES =================
//   Future<void> pickImages() async {
//     if (kIsWeb) {
//       final result = await FilePicker.platform.pickFiles(
//         allowMultiple: true, type: FileType.image, withData: true,
//       );
//       if (result != null) {
//         selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
//       }
//     } else {
//       final images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null) selectedImages.addAll(images);
//     }
//     notifyListeners();
//   }
//
//   // ================= SUBMIT POST =================
//   Future<void> submitPost({
//     required String foodName,
//     required String quantity,
//     required String pickupTime,
//     required String pickupAddress,
//     required String description,
//   }) async {
//     if (selectedImages.isEmpty) throw Exception("Please add at least one image");
//     isLoading = true;
//     notifyListeners();
//     try {
//       final user = _auth.currentUser!;
//       final imageUrls = await CloudinaryService.uploadImages(selectedImages);
//       final postRef = _db.collection('posts').doc();
//
//       await postRef.set({
//         'postId': postRef.id,
//         'donorId': user.uid,
//         'foodName': foodName,
//         'quantity': quantity,
//         'pickupTime': pickupTime,
//         'pickupAddress': pickupAddress,
//         'description': description,
//         'imageUrls': imageUrls,
//         'status': 'available',
//         'requestedBy': [],
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       selectedImages.clear();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
//
//   // ================= FETCH RECEIVER REQUESTS =================
//   void fetchRequests() {
//     final user = _auth.currentUser;
//     if (user == null) return;
//
//     // লজিক: শুধু সেই রিকোয়েস্টগুলোই আসবে যাদের স্ট্যাটাস 'pending'
//     // এবং যাদের পোস্টের স্ট্যাটাস এখনও 'available'
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .listen((snapshot) async {
//
//       List<Map<String, dynamic>> tempRequests = [];
//
//       for (var doc in snapshot.docs) {
//         var reqData = doc.data();
//         // পোস্টের বর্তমান স্ট্যাটাস চেক করা হচ্ছে
//         var postDoc = await _db.collection('posts').doc(reqData['postId']).get();
//
//         if (postDoc.exists && postDoc.data()?['status'] == 'available') {
//           tempRequests.add({
//             "requestId": doc.id,
//             ...reqData,
//           });
//         }
//       }
//
//       receiverRequests = tempRequests;
//       notifyListeners();
//     });
//   }
//
//   // ================= APPROVE/REJECT ACTION =================
//   Future<void> handleRequest(String requestId, String postId, String action) async {
//     try {
//       WriteBatch batch = _db.batch();
//       DocumentReference reqRef = _db.collection('requests').doc(requestId);
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//
//       if (action == 'approved') {
//         // ১. এই রিকোয়েস্টটি approved হবে
//         batch.update(reqRef, {'status': 'approved'});
//         // ২. পোস্টটি Accepted হবে (ফলে অন্য সব রিকোয়েস্ট ফিল্টার আউট হয়ে যাবে)
//         batch.update(postRef, {'status': 'approved'});
//
//         // ৩. (ঐচ্ছিক) ওই পোস্টের অন্য সকল পেন্ডিং রিকোয়েস্ট অটো রিজেক্ট করতে চাইলে:
//         // এটি করলে রিসিভাররা নোটিফিকেশন পাবে যে তাদের রিকোয়েস্ট রিজেক্ট হয়েছে।
//         var otherRequests = await _db.collection('requests')
//             .where('postId', isEqualTo: postId)
//             .where('status', isEqualTo: 'pending')
//             .get();
//
//         for (var otherDoc in otherRequests.docs) {
//           if (otherDoc.id != requestId) {
//             batch.update(otherDoc.reference, {'status': 'rejected'});
//           }
//         }
//       }
//       else if (action == 'rejected') {
//         // ১. শুধুমাত্র এই রিকোয়েস্টটি rejected হবে
//         batch.update(reqRef, {'status': 'rejected'});
//         // ২. পোস্টটি available ই থাকবে যাতে অন্যরা শো করে
//         batch.update(postRef, {'status': 'available'});
//       }
//
//       await batch.commit();
//       notifyListeners();
//     } catch (e) {
//       debugPrint("Update Error: $e");
//     }
//   }
// }

import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../../services/cloudinary_service.dart';

class DonorProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  bool isLoading = false;
  List<XFile> selectedImages = [];
  List<Map<String, dynamic>> receiverRequests = [];

  // ================= ইমেজ সিলেক্ট করা =================
  Future<void> pickImages() async {
    if (kIsWeb) {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.image, withData: true,
      );
      if (result != null) {
        selectedImages.addAll(result.files.map((f) => XFile.fromData(f.bytes!, name: f.name)));
      }
    } else {
      final images = await _picker.pickMultiImage(imageQuality: 70);
      if (images != null) selectedImages.addAll(images);
    }
    notifyListeners();
  }

  // ================= পোস্ট সাবমিট করা =================
  Future<void> submitPost({
    required String foodName,
    required String quantity,
    required String pickupTime,
    required String pickupAddress,
    required String description,
  }) async {
    if (selectedImages.isEmpty) throw Exception("Please add at least one image");
    isLoading = true;
    notifyListeners();
    try {
      final user = _auth.currentUser!;
      final imageUrls = await CloudinaryService.uploadImages(selectedImages);
      final postRef = _db.collection('posts').doc();

      await postRef.set({
        'postId': postRef.id,
        'donorId': user.uid,
        'foodName': foodName,
        'quantity': quantity,
        'pickupTime': pickupTime,
        'pickupAddress': pickupAddress,
        'description': description,
        'imageUrls': imageUrls,
        'status': 'available', // প্রাথমিক স্ট্যাটাস
        'createdAt': FieldValue.serverTimestamp(),
      });
      selectedImages.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= পেন্ডিং রিকোয়েস্ট ফেচ করা =================
  void fetchRequests() {
    final user = _auth.currentUser;
    if (user == null) return;

    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((snapshot) async {
      List<Map<String, dynamic>> tempRequests = [];
      for (var doc in snapshot.docs) {
        var reqData = doc.data();
        var postDoc = await _db.collection('posts').doc(reqData['postId']).get();

        // লজিক: পোস্টটি যদি এখনও available থাকে তবেই রিকোয়েস্ট দেখাবে
        if (postDoc.exists && postDoc.data()?['status'] == 'available') {
          tempRequests.add({
            "requestId": doc.id,
            ...reqData,
          });
        }
      }
      receiverRequests = tempRequests;
      notifyListeners();
    });
  }

  // ================= এপ্রুভ বা রিজেক্ট হ্যান্ডেল করা =================
  Future<void> handleRequest(String requestId, String postId, String action) async {
    try {
      WriteBatch batch = _db.batch();
      DocumentReference reqRef = _db.collection('requests').doc(requestId);
      DocumentReference postRef = _db.collection('posts').doc(postId);

      if (action == 'approved') {
        // ১. এই রিকোয়েস্টটি approved হবে
        batch.update(reqRef, {'status': 'approved'});
        // ২. পোস্টটি approved হবে (ফলে এটি আর ফিডে শো করবে না)
        batch.update(postRef, {'status': 'approved'});

        // ৩. এই পোস্টের অন্য সব রিকোয়েস্ট অটো রিজেক্ট করা
        var otherRequests = await _db.collection('requests')
            .where('postId', isEqualTo: postId)
            .where('status', isEqualTo: 'pending')
            .get();

        for (var otherDoc in otherRequests.docs) {
          if (otherDoc.id != requestId) {
            batch.update(otherDoc.reference, {'status': 'rejected'});
          }
        }
      } else {
        // রিজেক্ট করলে পোস্ট available ই থাকবে
        batch.update(reqRef, {'status': 'rejected'});
      }

      await batch.commit();
      notifyListeners();
    } catch (e) {
      debugPrint("Handle Request Error: $e");
    }
  }
}