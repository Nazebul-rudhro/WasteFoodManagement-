//
// import 'dart:typed_data';
// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
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
//   // ================= PICK IMAGES =================
//   Future<void> pickImages() async {
//     if (kIsWeb) {
//       final result = await FilePicker.platform.pickFiles(
//         allowMultiple: true,
//         type: FileType.image,
//         withData: true,
//       );
//
//       if (result != null) {
//         selectedImages.addAll(
//           result.files.map(
//                 (f) => XFile.fromData(f.bytes!, name: f.name),
//           ),
//         );
//       }
//     } else {
//       final images = await _picker.pickMultiImage(imageQuality: 70);
//       if (images != null) {
//         selectedImages.addAll(images);
//       }
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
//     if (selectedImages.isEmpty) {
//       throw Exception("Please add at least one image");
//     }
//
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final user = _auth.currentUser!;
//       final imageUrls =
//       await CloudinaryService.uploadImages(selectedImages);
//
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
//         'status': 'available',         // default
//         'requestedBy': [],             // empty initially
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       selectedImages.clear();
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }
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
//     // Real-time snapshots use করা হয়েছে যেন ডেটা আসার সাথে সাথে UI আপডেট হয়
//     _db.collection('requests')
//         .where('donorId', isEqualTo: user.uid)
//         .where('status', isEqualTo: 'pending')
//         .snapshots()
//         .listen((snapshot) {
//       receiverRequests = snapshot.docs.map((doc) => {
//         "requestId": doc.id,
//         ...doc.data(),
//       }).toList();
//       notifyListeners();
//     });
//   }
//
//   // ================= APPROVE/REJECT ACTION =================
//   Future<void> handleRequest(String requestId, String postId, String status) async {
//     try {
//       WriteBatch batch = _db.batch();
//
//       // ১. requests কালেকশন আপডেট
//       DocumentReference reqRef = _db.collection('requests').doc(requestId);
//       batch.update(reqRef, {'status': status});
//
//       // ২. posts কালেকশন আপডেট
//       DocumentReference postRef = _db.collection('posts').doc(postId);
//       batch.update(postRef, {'status': status});
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

  // ================= PICK IMAGES =================
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

  // ================= SUBMIT POST =================
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
        'status': 'available',
        'requestedBy': [],
        'createdAt': FieldValue.serverTimestamp(),
      });
      selectedImages.clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ================= FETCH RECEIVER REQUESTS =================
  void fetchRequests() {
    final user = _auth.currentUser;
    if (user == null) return;

    _db.collection('requests')
        .where('donorId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .listen((snapshot) {
      receiverRequests = snapshot.docs.map((doc) => {
        "requestId": doc.id,
        ...doc.data(),
      }).toList();
      notifyListeners();
    });
  }

  // ================= APPROVE/REJECT ACTION =================
  // Approve বা Reject করলে এটি requests এবং posts উভয় টেবিল আপডেট করবে
  Future<void> handleRequest(String requestId, String postId, String status) async {
    try {
      WriteBatch batch = _db.batch();

      // ১. requests কালেকশন আপডেট (pending থেকে approved/rejected হবে)
      DocumentReference reqRef = _db.collection('requests').doc(requestId);
      batch.update(reqRef, {'status': status});

      // ২. posts কালেকশন আপডেট (available থেকে approved/rejected হবে)
      // নোট: যদি আপনি চান Reject করলে পোস্টটি আবারও 'available' থাকুক,
      // তবে এখানে একটি কন্ডিশন দিতে পারেন। আপাতত আপনার রিকোয়েস্ট অনুযায়ী স্ট্যাটাস চেঞ্জ করা হলো।
      DocumentReference postRef = _db.collection('posts').doc(postId);
      batch.update(postRef, {'status': status});

      await batch.commit();

      // লোকাল লিস্ট থেকে রিমুভ করা (অপশনাল, কারণ snapshot অটো আপডেট করবে)
      receiverRequests.removeWhere((element) => element['requestId'] == requestId);
      notifyListeners();
    } catch (e) {
      debugPrint("Update Error: $e");
    }
  }
}