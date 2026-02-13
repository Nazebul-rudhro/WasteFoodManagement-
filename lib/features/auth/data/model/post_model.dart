//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PostModel {
//   final String id,
//   final String postId;
//   final String donorId;
//   final String foodName;
//   final String quantity;
//   final String pickupTime;
//   final String pickupAddress;
//   final String description;
//   final List<String> imageUrls;
//   final String status;
//   final String requestedBy; // <-- নতুন field
//   final Timestamp? createdAt;
//
//   const PostModel({
//     required this.id,
//     required this.postId,
//     required this.donorId,
//     required this.foodName,
//     required this.quantity,
//     required this.pickupTime,
//     required this.pickupAddress,
//     required this.description,
//     required this.imageUrls,
//     required this.status,
//     required this.requestedBy,
//     this.createdAt,
//   });
//
//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       id: doc.id,
//       postId: map['postId'] ?? '',
//       donorId: map['donorId'] ?? '',
//       foodName: map['foodName'] ?? '',
//       quantity: map['quantity'] ?? '',
//       pickupTime: map['pickupTime'] ?? '',
//       pickupAddress: map['pickupAddress'] ?? '',
//       description: map['description'] ?? '',
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//       status: map['status'] ?? 'available',
//       requestedBy: 'requestedBy',
//       // requestedBy: List<String>.from(map['requestedBy'] ?? []),
//
//     );
//   }
//
//   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return PostModel.fromMap(data);
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'postId': postId,
//       'donorId': donorId,
//       'foodName': foodName,
//       'quantity': quantity,
//       'pickupTime': pickupTime,
//       'pickupAddress': pickupAddress,
//       'description': description,
//       'imageUrls': imageUrls,
//       'status': status,
//       'requestedBy': requestedBy,
//       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id; // ডক আইডি
  final String postId;
  final String donorId;
  final String foodName;
  final String quantity;
  final String pickupTime;
  final String pickupAddress;
  final String description;
  final List<String> imageUrls;
  final String status;
  final List<String> requestedBy; // এটি List<String> হওয়া উচিত যাতে অনেক আইডি থাকতে পারে
  final Timestamp? createdAt;

  const PostModel({
    required this.id,
    required this.postId,
    required this.donorId,
    required this.foodName,
    required this.quantity,
    required this.pickupTime,
    required this.pickupAddress,
    required this.description,
    required this.imageUrls,
    required this.status,
    required this.requestedBy,
    this.createdAt,
  });

  /// 🔹 Firestore থেকে আসা ম্যাপকে মডেলে রূপান্তর
  factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
    return PostModel(
      id: docId,
      postId: map['postId'] ?? '',
      donorId: map['donorId'] ?? '',
      foodName: map['foodName'] ?? '',
      quantity: map['quantity'] ?? '',
      pickupTime: map['pickupTime'] ?? '',
      pickupAddress: map['pickupAddress'] ?? '',
      description: map['description'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      status: map['status'] ?? 'available',
      requestedBy: List<String>.from(map['requestedBy'] ?? []), // সঠিক লিস্ট ফরম্যাট
      createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
    );
  }

  /// 🔹 সরাসরি ডকিউমেন্ট স্ন্যাপশট থেকে তৈরি করার জন্য
  factory PostModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return PostModel.fromMap(data, doc.id);
  }

  /// 🔹 ফায়ারবেসে ডাটা পাঠানোর জন্য
  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'donorId': donorId,
      'foodName': foodName,
      'quantity': quantity,
      'pickupTime': pickupTime,
      'pickupAddress': pickupAddress,
      'description': description,
      'imageUrls': imageUrls,
      'status': status,
      'requestedBy': requestedBy,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}