// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // class PostModel {
// // // //   final String id,
// // // //   final String postId;
// // // //   final String donorId;
// // // //   final String foodName;
// // // //   final String quantity;
// // // //   final String pickupTime;
// // // //   final String pickupAddress;
// // // //   final String description;
// // // //   final List<String> imageUrls;
// // // //   final String status;
// // // //   final String requestedBy; // <-- নতুন field
// // // //   final Timestamp? createdAt;
// // // //
// // // //   const PostModel({
// // // //     required this.id,
// // // //     required this.postId,
// // // //     required this.donorId,
// // // //     required this.foodName,
// // // //     required this.quantity,
// // // //     required this.pickupTime,
// // // //     required this.pickupAddress,
// // // //     required this.description,
// // // //     required this.imageUrls,
// // // //     required this.status,
// // // //     required this.requestedBy,
// // // //     this.createdAt,
// // // //   });
// // // //
// // // //   factory PostModel.fromMap(Map<String, dynamic> map) {
// // // //     return PostModel(
// // // //       id: doc.id,
// // // //       postId: map['postId'] ?? '',
// // // //       donorId: map['donorId'] ?? '',
// // // //       foodName: map['foodName'] ?? '',
// // // //       quantity: map['quantity'] ?? '',
// // // //       pickupTime: map['pickupTime'] ?? '',
// // // //       pickupAddress: map['pickupAddress'] ?? '',
// // // //       description: map['description'] ?? '',
// // // //       imageUrls: List<String>.from(map['imageUrls'] ?? []),
// // // //       status: map['status'] ?? 'available',
// // // //       requestedBy: 'requestedBy',
// // // //       // requestedBy: List<String>.from(map['requestedBy'] ?? []),
// // // //
// // // //     );
// // // //   }
// // // //
// // // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // // //     final data = doc.data() as Map<String, dynamic>;
// // // //     return PostModel.fromMap(data);
// // // //   }
// // // //
// // // //   Map<String, dynamic> toMap() {
// // // //     return {
// // // //       'postId': postId,
// // // //       'donorId': donorId,
// // // //       'foodName': foodName,
// // // //       'quantity': quantity,
// // // //       'pickupTime': pickupTime,
// // // //       'pickupAddress': pickupAddress,
// // // //       'description': description,
// // // //       'imageUrls': imageUrls,
// // // //       'status': status,
// // // //       'requestedBy': requestedBy,
// // // //       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
// // // //     };
// // // //   }
// // // // }
// // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // class PostModel {
// // // //   final String id; // ডক আইডি
// // // //   final String postId;
// // // //   final String donorId;
// // // //   final String foodName;
// // // //   final String quantity;
// // // //   final String pickupTime;
// // // //   final String pickupAddress;
// // // //   final String description;
// // // //   final List<String> imageUrls;
// // // //   final String status;
// // // //   final List<String> requestedBy; // এটি List<String> হওয়া উচিত যাতে অনেক আইডি থাকতে পারে
// // // //   final Timestamp? createdAt;
// // // //
// // // //   const PostModel({
// // // //     required this.id,
// // // //     required this.postId,
// // // //     required this.donorId,
// // // //     required this.foodName,
// // // //     required this.quantity,
// // // //     required this.pickupTime,
// // // //     required this.pickupAddress,
// // // //     required this.description,
// // // //     required this.imageUrls,
// // // //     required this.status,
// // // //     required this.requestedBy,
// // // //     this.createdAt,
// // // //   });
// // // //
// // // //   /// 🔹 Firestore থেকে আসা ম্যাপকে মডেলে রূপান্তর
// // // //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// // // //     return PostModel(
// // // //       id: docId,
// // // //       postId: map['postId'] ?? '',
// // // //       donorId: map['donorId'] ?? '',
// // // //       foodName: map['foodName'] ?? '',
// // // //       quantity: map['quantity'] ?? '',
// // // //       pickupTime: map['pickupTime'] ?? '',
// // // //       pickupAddress: map['pickupAddress'] ?? '',
// // // //       description: map['description'] ?? '',
// // // //       imageUrls: List<String>.from(map['imageUrls'] ?? []),
// // // //       status: map['status'] ?? 'available',
// // // //       requestedBy: List<String>.from(map['requestedBy'] ?? []), // সঠিক লিস্ট ফরম্যাট
// // // //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// // // //     );
// // // //   }
// // // //
// // // //   /// 🔹 সরাসরি ডকিউমেন্ট স্ন্যাপশট থেকে তৈরি করার জন্য
// // // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // // //     final data = doc.data() as Map<String, dynamic>? ?? {};
// // // //     return PostModel.fromMap(data, doc.id);
// // // //   }
// // // //
// // // //   /// 🔹 ফায়ারবেসে ডাটা পাঠানোর জন্য
// // // //   Map<String, dynamic> toMap() {
// // // //     return {
// // // //       'postId': postId,
// // // //       'donorId': donorId,
// // // //       'foodName': foodName,
// // // //       'quantity': quantity,
// // // //       'pickupTime': pickupTime,
// // // //       'pickupAddress': pickupAddress,
// // // //       'description': description,
// // // //       'imageUrls': imageUrls,
// // // //       'status': status,
// // // //       'requestedBy': requestedBy,
// // // //       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
// // // //     };
// // // //   }
// // // // }
// // //
// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // class PostModel {
// // // //   final String id;
// // // //   final String postId;
// // // //   final String donorId;
// // // //   final String foodName;
// // // //   final String quantity;
// // // //   final String pickupTime;
// // // //   final String pickupAddress;
// // // //   final String description;
// // // //   final List<String> imageUrls;
// // // //   final String status;
// // // //   final List<String> requestedBy;
// // // //   final Timestamp? createdAt;
// // // //
// // // //   const PostModel({
// // // //     required this.id,
// // // //     required this.postId,
// // // //     required this.donorId,
// // // //     required this.foodName,
// // // //     required this.quantity,
// // // //     required this.pickupTime,
// // // //     required this.pickupAddress,
// // // //     required this.description,
// // // //     required this.imageUrls,
// // // //     required this.status,
// // // //     required this.requestedBy,
// // // //     this.createdAt,
// // // //   });
// // // //
// // // //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// // // //     return PostModel(
// // // //       id: docId,
// // // //       postId: map['postId'] ?? '',
// // // //       donorId: map['donorId'] ?? '',
// // // //       foodName: map['foodName'] ?? '',
// // // //       quantity: map['quantity'] ?? '',
// // // //       pickupTime: map['pickupTime'] ?? '',
// // // //       pickupAddress: map['pickupAddress'] ?? '',
// // // //       description: map['description'] ?? '',
// // // //       imageUrls: List<String>.from(map['imageUrls'] ?? []),
// // // //       status: map['status'] ?? 'available',
// // // //       requestedBy: List<String>.from(map['requestedBy'] ?? []),
// // // //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// // // //     );
// // // //   }
// // // //
// // // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // // //     final data = doc.data() as Map<String, dynamic>? ?? {};
// // // //     return PostModel.fromMap(data, doc.id);
// // // //   }
// // // //
// // // //   Map<String, dynamic> toMap() {
// // // //     return {
// // // //       'postId': postId,
// // // //       'donorId': donorId,
// // // //       'foodName': foodName,
// // // //       'quantity': quantity,
// // // //       'pickupTime': pickupTime,
// // // //       'pickupAddress': pickupAddress,
// // // //       'description': description,
// // // //       'imageUrls': imageUrls,
// // // //       'status': status,
// // // //       'requestedBy': requestedBy,
// // // //       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
// // // //     };
// // // //   }
// // // // }
// // //
// // //
// // //
// // //
// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // class PostModel {
// // // //   final String id;
// // // //   final String postId;
// // // //   final String donorId;
// // // //   final String foodName;
// // // //   final String quantity;
// // // //   final String pickupTime;
// // // //   final DateTime? expiryDate;
// // // //   final String pickupAddress;
// // // //   final String description;
// // // //   final List<String> imageUrls;
// // // //   final String status;
// // // //   final List<String> requestedBy;
// // // //   final Timestamp? createdAt;
// // // //
// // // //   const PostModel({
// // // //     required this.id,
// // // //     required this.postId,
// // // //     required this.donorId,
// // // //     required this.foodName,
// // // //     required this.quantity,
// // // //     required this.pickupTime,
// // // //     this.expiryDate,
// // // //     required this.pickupAddress,
// // // //     required this.description,
// // // //     required this.imageUrls,
// // // //     required this.status,
// // // //     required this.requestedBy,
// // // //     this.createdAt,
// // // //   });
// // // //
// // // //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// // // //     return PostModel(
// // // //       id: docId,
// // // //       postId: map['postId'] ?? '',
// // // //       donorId: map['donorId'] ?? '',
// // // //       foodName: map['foodName'] ?? '',
// // // //       quantity: map['quantity'] ?? '',
// // // //       pickupTime: map['pickupTime'] ?? '',
// // // //       expiryDate: map['expiryDate'] != null ? (map['expiryDate'] as Timestamp).toDate() : null,
// // // //       pickupAddress: map['pickupAddress'] ?? '',
// // // //       description: map['description'] ?? '',
// // // //       imageUrls: List<String>.from(map['imageUrls'] ?? []),
// // // //       status: map['status'] ?? 'available',
// // // //       requestedBy: List<String>.from(map['requestedBy'] ?? []),
// // // //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// // // //     );
// // // //   }
// // // //
// // // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // // //     final data = doc.data() as Map<String, dynamic>? ?? {};
// // // //     return PostModel.fromMap(data, doc.id);
// // // //   }
// // // // }
// // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // //
// // // // class PostModel {
// // // //   final String id;              // Firestore Document ID
// // // //   final String postId;          // Unique Post ID
// // // //   final String donorId;         // Donor's UID
// // // //   final String foodName;
// // // //   final String foodType;        // Vegetarian / Non-Vegetarian
// // // //   final String foodCondition;   // Freshly Cooked / Leftover
// // // //   final String estimatePersons; // How many people can eat
// // // //   final String quantity;        // e.g., 2kg, 5 packets
// // // //   final String pickupTime;      // Formatted String for UI
// // // //   final DateTime? expiryDate;   // DateTime object for logic
// // // //   final String pickupAddress;
// // // //   final String description;     // Special Note
// // // //   final List<String> imageUrls;
// // // //   final String status;          // available / pending / delivered
// // // //   final List<String> requestedBy;
// // // //   final Timestamp? createdAt;
// // // //
// // // //   const PostModel({
// // // //     required this.id,
// // // //     required this.postId,
// // // //     required this.donorId,
// // // //     required this.foodName,
// // // //     required this.foodType,
// // // //     required this.foodCondition,
// // // //     required this.estimatePersons,
// // // //     required this.quantity,
// // // //     required this.pickupTime,
// // // //     this.expiryDate,
// // // //     required this.pickupAddress,
// // // //     required this.description,
// // // //     required this.imageUrls,
// // // //     required this.status,
// // // //     required this.requestedBy,
// // // //     this.createdAt,
// // // //   });
// // // //
// // // //   // 🔹 Firestore Map থেকে অবজেক্ট তৈরি করা
// // // //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// // // //     return PostModel(
// // // //       id: docId,
// // // //       postId: map['postId'] ?? '',
// // // //       donorId: map['donorId'] ?? '',
// // // //       foodName: map['foodName'] ?? 'No Name',
// // // //       foodType: map['foodType'] ?? 'General',
// // // //       foodCondition: map['foodCondition'] ?? 'Fresh',
// // // //       estimatePersons: map['estimatePersons']?.toString() ?? '0',
// // // //       quantity: map['quantity'] ?? '',
// // // //       pickupTime: map['pickupTime'] ?? '',
// // // //       expiryDate: map['expiryDate'] != null
// // // //           ? (map['expiryDate'] as Timestamp).toDate()
// // // //           : null,
// // // //       pickupAddress: map['pickupAddress'] ?? 'No Address',
// // // //       description: map['description'] ?? '',
// // // //       imageUrls: List<String>.from(map['imageUrls'] ?? []),
// // // //       status: map['status'] ?? 'available',
// // // //       requestedBy: List<String>.from(map['requestedBy'] ?? []),
// // // //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// // // //     );
// // // //   }
// // // //
// // // //   // 🔹 Firestore Snapshot থেকে অবজেক্ট তৈরি করা
// // // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // // //     final data = doc.data() as Map<String, dynamic>? ?? {};
// // // //     return PostModel.fromMap(data, doc.id);
// // // //   }
// // // //
// // // //   // 🔹 Firestore-এ ডাটা পাঠানোর জন্য Map-এ রূপান্তর করা
// // // //   Map<String, dynamic> toMap() {
// // // //     return {
// // // //       'postId': postId,
// // // //       'donorId': donorId,
// // // //       'foodName': foodName,
// // // //       'foodType': foodType,
// // // //       'foodCondition': foodCondition,
// // // //       'estimatePersons': estimatePersons,
// // // //       'quantity': quantity,
// // // //       'pickupTime': pickupTime,
// // // //       'expiryDate': expiryDate != null ? Timestamp.fromDate(expiryDate!) : null,
// // // //       'pickupAddress': pickupAddress,
// // // //       'description': description,
// // // //       'imageUrls': imageUrls,
// // // //       'status': status,
// // // //       'requestedBy': requestedBy,
// // // //       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
// // // //     };
// // // //   }
// // // // }
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // //
// // // class PostModel {
// // //   final String id;
// // //   final String postId;
// // //   final String donorId;
// // //   final String foodName;
// // //   final String foodType;
// // //   final String foodCondition;
// // //   final String estimatePersons;
// // //   final String quantity;
// // //   final String pickupTime;
// // //   final DateTime? expiryDate; // Changed to DateTime for easier UI handling
// // //   final String pickupAddress;
// // //   final String description;
// // //   final List<String> imageUrls;
// // //   final String status;
// // //   final List<String> requestedBy;
// // //   final Timestamp? createdAt;
// // //
// // //   const PostModel({
// // //     required this.id,
// // //     required this.postId,
// // //     required this.donorId,
// // //     required this.foodName,
// // //     required this.foodType,
// // //     required this.foodCondition,
// // //     required this.estimatePersons,
// // //     required this.quantity,
// // //     required this.pickupTime,
// // //     this.expiryDate,
// // //     required this.pickupAddress,
// // //     required this.description,
// // //     required this.imageUrls,
// // //     required this.status,
// // //     required this.requestedBy,
// // //     this.createdAt,
// // //   });
// // //
// // //   // 🔹 Professional Time Remaining Helper
// // //   // Use this in your PostCard to show "2h left" or "Expired"
// // //   String get timeRemaining {
// // //     if (expiryDate == null) return "No expiry set";
// // //     final duration = expiryDate!.difference(DateTime.now());
// // //
// // //     if (duration.isNegative) return "Expired";
// // //     if (duration.inDays > 0) return "${duration.inDays}d left";
// // //     if (duration.inHours > 0) return "${duration.inHours}h left";
// // //     if (duration.inMinutes > 0) return "${duration.inMinutes}m left";
// // //     return "Expiring soon";
// // //   }
// // //
// // //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// // //     return PostModel(
// // //       id: docId,
// // //       postId: map['postId'] ?? '',
// // //       donorId: map['donorId'] ?? '',
// // //       foodName: map['foodName'] ?? 'Unnamed Food',
// // //       foodType: map['foodType'] ?? 'General',
// // //       foodCondition: map['foodCondition'] ?? 'Standard',
// // //       estimatePersons: map['estimatePersons']?.toString() ?? '0',
// // //       quantity: map['quantity'] ?? 'N/A',
// // //       pickupTime: map['pickupTime'] ?? '',
// // //       // 🔹 Robust Expiry Parsing
// // //       expiryDate: map['expiryDate'] is Timestamp
// // //           ? (map['expiryDate'] as Timestamp).toDate()
// // //           : null,
// // //       pickupAddress: map['pickupAddress'] ?? 'No address provided',
// // //       description: map['description'] ?? '',
// // //       imageUrls: map['imageUrls'] != null ? List<String>.from(map['imageUrls']) : [],
// // //       status: map['status'] ?? 'available',
// // //       requestedBy: map['requestedBy'] != null ? List<String>.from(map['requestedBy']) : [],
// // //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// // //     );
// // //   }
// // //
// // //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// // //     final data = doc.data() as Map<String, dynamic>? ?? {};
// // //     return PostModel.fromMap(data, doc.id);
// // //   }
// // //
// // //   Map<String, dynamic> toMap() {
// // //     return {
// // //       'postId': postId,
// // //       'donorId': donorId,
// // //       'foodName': foodName,
// // //       'foodType': foodType,
// // //       'foodCondition': foodCondition,
// // //       'estimatePersons': estimatePersons,
// // //       'quantity': quantity,
// // //       'pickupTime': pickupTime,
// // //       // 🔹 Convert DateTime back to Timestamp for Firestore
// // //       'expiryDate': expiryDate != null ? Timestamp.fromDate(expiryDate!) : null,
// // //       'pickupAddress': pickupAddress,
// // //       'description': description,
// // //       'imageUrls': imageUrls,
// // //       'status': status,
// // //       'requestedBy': requestedBy,
// // //       'createdAt': createdAt ?? FieldValue.serverTimestamp(),
// // //     };
// // //   }
// // // }
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // class PostModel {
// //   final String id;
// //   final String postId;
// //   final String donorId;
// //   final String foodName;
// //   final String foodType;
// //   final String foodCondition;
// //   final String estimatePersons;
// //   final String quantity;
// //   final String pickupTime;
// //   final DateTime? expiryDate;
// //   final String pickupAddress;
// //   final String description;
// //   final List<String> imageUrls;
// //   final String status;
// //   final List<String> requestedBy;
// //   final Timestamp? createdAt;
// //
// //   const PostModel({
// //     required this.id,
// //     required this.postId,
// //     required this.donorId,
// //     required this.foodName,
// //     required this.foodType,
// //     required this.foodCondition,
// //     required this.estimatePersons,
// //     required this.quantity,
// //     required this.pickupTime,
// //     this.expiryDate,
// //     required this.pickupAddress,
// //     required this.description,
// //     required this.imageUrls,
// //     required this.status,
// //     required this.requestedBy,
// //     this.createdAt,
// //   });
// //
// //   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
// //     return PostModel(
// //       id: docId,
// //       postId: map['postId'] ?? '',
// //       donorId: map['donorId'] ?? '',
// //       foodName: map['foodName'] ?? 'Unnamed Food',
// //       foodType: map['foodType'] ?? 'General',
// //       foodCondition: map['foodCondition'] ?? 'Standard',
// //       estimatePersons: map['estimatePersons']?.toString() ?? '0',
// //       quantity: map['quantity'] ?? 'N/A',
// //       pickupTime: map['pickupTime'] ?? '',
// //       expiryDate: map['expiryDate'] is Timestamp
// //           ? (map['expiryDate'] as Timestamp).toDate()
// //           : null,
// //       pickupAddress: map['pickupAddress'] ?? 'No Address',
// //       description: map['description'] ?? '',
// //       imageUrls: map['imageUrls'] != null ? List<String>.from(map['imageUrls']) : [],
// //       status: map['status'] ?? 'available',
// //       requestedBy: map['requestedBy'] != null ? List<String>.from(map['requestedBy']) : [],
// //       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
// //     );
// //   }
// //
// //   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
// //     final data = doc.data() as Map<String, dynamic>? ?? {};
// //     return PostModel.fromMap(data, doc.id);
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PostModel {
//   final String id;
//   final String postId;
//   final String donorId;
//   final String foodName;
//   final String foodType;
//   final String foodCondition;
//   final String estimatePersons;
//   final String quantity;
//   final String pickupTime;
//   final DateTime? expiryDate;
//   final String pickupAddress;
//   final String description;
//   final List<String> imageUrls;
//   final String status;
//   final List<String> requestedBy;
//   final Timestamp? createdAt;
//
//   const PostModel({
//     required this.id,
//     required this.postId,
//     required this.donorId,
//     required this.foodName,
//     required this.foodType,
//     required this.foodCondition,
//     required this.estimatePersons,
//     required this.quantity,
//     required this.pickupTime,
//     this.expiryDate,
//     required this.pickupAddress,
//     required this.description,
//     required this.imageUrls,
//     required this.status,
//     required this.requestedBy,
//     this.createdAt,
//   });
//
//   factory PostModel.fromMap(Map<String, dynamic> map, String docId) {
//     return PostModel(
//       id: docId,
//       postId: map['postId'] ?? '',
//       donorId: map['donorId'] ?? '',
//       foodName: map['foodName'] ?? 'No Name',
//       foodType: map['foodType'] ?? 'General',
//       foodCondition: map['foodCondition'] ?? 'Fresh',
//       estimatePersons: map['estimatePersons']?.toString() ?? '0',
//       quantity: map['quantity'] ?? '',
//       pickupTime: map['pickupTime'] ?? '',
//       expiryDate: map['expiryDate'] is Timestamp
//           ? (map['expiryDate'] as Timestamp).toDate()
//           : null,
//       pickupAddress: map['pickupAddress'] ?? 'No Address',
//       description: map['description'] ?? '',
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//       status: map['status'] ?? 'available',
//       requestedBy: List<String>.from(map['requestedBy'] ?? []),
//       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
//     );
//   }
//
//   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>? ?? {};
//     return PostModel.fromMap(data, doc.id);
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class PostModel {
//   final String id;
//   final String postId;
//   final String donorId;
//   final String foodName;
//   final String foodType; // 🔹 নতুন যোগ করা হলো
//   final String foodCondition; // 🔹 এটি না থাকায় এরর দিচ্ছিল
//   final String quantity;
//   final String pickupTime;
//   final DateTime? expiryDate;
//   final String pickupAddress;
//   final String description;
//   final List<String> imageUrls;
//   final String status;
//   final String estimatePersons;
//   final Timestamp? createdAt;
//
//   const PostModel({
//     required this.id,
//     required this.postId,
//     required this.donorId,
//     required this.foodName,
//     required this.foodType,
//     required this.foodCondition,
//     required this.quantity,
//     required this.pickupTime,
//     this.expiryDate,
//     required this.pickupAddress,
//     required this.description,
//     required this.imageUrls,
//     required this.status,
//     required this.estimatePersons,
//     this.createdAt,
//   });
//
//   factory PostModel.fromSnapshot(DocumentSnapshot doc) {
//     final map = doc.data() as Map<String, dynamic>;
//     return PostModel(
//       id: doc.id,
//       postId: map['postId'] ?? '',
//       donorId: map['donorId'] ?? '',
//       foodName: map['foodName'] ?? 'No Name',
//       foodType: map['foodType'] ?? 'General',
//       foodCondition: map['foodCondition'] ?? 'Fresh', // 🔹 এখানে ডাটা পার্স করা হচ্ছে
//       quantity: map['quantity'] ?? '',
//       pickupTime: map['pickupTime'] ?? '',
//       expiryDate: map['expiryDate'] is Timestamp
//           ? (map['expiryDate'] as Timestamp).toDate()
//           : null,
//       pickupAddress: map['pickupAddress'] ?? '',
//       description: map['description'] ?? '',
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//       status: map['status'] ?? 'available',
//       estimatePersons: map['estimatePersons']?.toString() ?? '0',
//       createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String postId;
  final String donorId;
  final String foodName;
  final String foodType;
  final String foodCondition;
  final String quantity;
  final String pickupTime;
  final DateTime? expiryDate;
  final String pickupAddress;
  final String description;
  final List<String> imageUrls;
  final String estimatePersons;
  final Timestamp? createdAt;
  final String deliveryType;


  // 🔹 এই দুইটা পরিবর্তনযোগ্য রাখা হয়েছে প্রোভাইডারের ডাটা ইনজেকশনের জন্য
  String status;
  String deliveryStatus;

  PostModel({
    required this.id, required this.postId, required this.donorId,
    required this.foodName, required this.foodType, required this.foodCondition,
    required this.quantity, required this.pickupTime, this.expiryDate,
    required this.pickupAddress, required this.description, required this.imageUrls,
    required this.status, required this.estimatePersons, this.createdAt,
    required this.deliveryStatus, required this.deliveryType,
  });

  factory PostModel.fromSnapshot(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return PostModel(
      id: doc.id,
      postId: map['postId'] ?? '',
      donorId: map['donorId'] ?? '',
      foodName: map['foodName'] ?? 'No Name',
      foodType: map['foodType'] ?? 'General',
      foodCondition: map['foodCondition'] ?? 'Fresh',
      quantity: map['quantity'] ?? '',
      pickupTime: map['pickupTime'] ?? '',
      expiryDate: map['expiryDate'] is Timestamp ? (map['expiryDate'] as Timestamp).toDate() : null,
      pickupAddress: map['pickupAddress'] ?? '',
      description: map['description'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      status: map['status'] ?? 'available',
      estimatePersons: map['estimatePersons']?.toString() ?? '0',
      createdAt: map['createdAt'] is Timestamp ? map['createdAt'] : null,
      deliveryStatus: map['deliverystatus']?.toString() ?? 'none',
      deliveryType: map['deliveryType']?.toString() ?? 'none',
    );
  }
}