// class PostModel {
//   final String postId;
//   final String foodName;
//   final String quantity;
//   final String pickupAddress;
//   final String pickupTime;
//   final String status;
//   final List<String> imageUrls;
//
//   PostModel({
//     required this.postId,
//     required this.foodName,
//     required this.quantity,
//     required this.pickupAddress,
//     required this.pickupTime,
//     required this.status,
//     required this.imageUrls,
//   });
//
//   factory PostModel.fromMap(Map<String, dynamic> map) {
//     return PostModel(
//       postId: map['postId'],
//       foodName: map['foodName'],
//       quantity: map['quantity'],
//       pickupAddress: map['pickupAddress'],
//       pickupTime: 'pickupTime',
//       status: 'status',
//       imageUrls: List<String>.from(map['imageUrls'] ?? []),
//     );
//   }
// }

class PostModel {
  final String postId;
  final String donorId;
  final String foodName;
  final String quantity;
  final String pickupTime;
  final String pickupAddress;
  final String description;
  final List<String> imageUrls;
  final String status;

  PostModel({
    required this.postId,
    required this.donorId,
    required this.foodName,
    required this.quantity,
    required this.pickupTime,
    required this.pickupAddress,
    required this.description,
    required this.imageUrls,
    required this.status,
  });

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] ?? '',
      donorId: map['donorId'] ?? '',
      foodName: map['foodName'] ?? '',
      quantity: map['quantity'] ?? '',
      pickupTime: map['pickupTime'] ?? '', // <-- ensure this line
      pickupAddress: map['pickupAddress'] ?? '',
      description: map['description'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      status: map['status'] ?? 'available',
    );
  }
}

