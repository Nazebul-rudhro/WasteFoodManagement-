// // class NotificationModel {
// //   final String id;
// //   final String message;
// //   final String requestBy;
// //   final String time;
// //   final String postId;
// //   final String receiverId; // এটি নতুন যোগ করুন
// //
// //   NotificationModel({
// //     required this.id,
// //     required this.message,
// //     required this.requestBy,
// //     required this.postId,
// //     required this.time,
// //     required this.receiverId, // এখানেও যোগ করুন
// //   });
// // }
// //
//
//
// class NotificationModel {
//   final String id;
//   final String message;
//   final String requestBy;
//   final String time;
//   final String postId;
//   final String receiverId;
//
//   NotificationModel({
//     required this.id,
//     required this.message,
//     required this.requestBy,
//     required this.postId,
//     required this.time,
//     required this.receiverId,
//   });
// }

class NotificationModel {
final String id;
final String message;
final String requestBy;
final String time;
final String postId;
final String receiverId;
final String status;

NotificationModel({
  required this.id,
  required this.message,
  required this.requestBy,
  required this.postId,
  required this.time,
  required this.receiverId,
  required this.status,
});
}