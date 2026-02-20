// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // //
// // // class NotificationItem extends StatefulWidget {
// // //   final String id;
// // //   final String message;
// // //   final VoidCallback onApprove;
// // //   final VoidCallback onReject;
// // //
// // //   const NotificationItem({
// // //     super.key,
// // //     required this.id,
// // //     required this.message,
// // //     required this.onApprove,
// // //     required this.onReject,
// // //   });
// // //
// // //   @override
// // //   State<NotificationItem> createState() => _NotificationItemState();
// // // }
// // //
// // // class _NotificationItemState extends State<NotificationItem> {
// // //   bool _isExpanded = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final backgroundColor = _isExpanded
// // //         ? Colors.green.withOpacity(0.1)
// // //         : Colors.grey.shade200;
// // //
// // //     return GestureDetector(
// // //       onTap: () {
// // //         setState(() {
// // //           _isExpanded = !_isExpanded;
// // //         });
// // //       },
// // //       child: Container(
// // //         width: double.infinity,
// // //         margin: const EdgeInsets.symmetric(vertical: 6),
// // //         padding: const EdgeInsets.all(12),
// // //         decoration: BoxDecoration(
// // //           color: backgroundColor,
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text("ID: ${widget.id}", style: AppData.heading3),
// // //             const SizedBox(height: 5),
// // //             Text(widget.message, style: AppData.heading2),
// // //             const SizedBox(height: 10),
// // //
// // //             if (_isExpanded)
// // //               Row(
// // //                 mainAxisAlignment: MainAxisAlignment.end,
// // //                 children: [
// // //                   TextButton(
// // //                     onPressed: widget.onReject,
// // //                     style: TextButton.styleFrom(
// // //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //                       backgroundColor: Colors.red.withOpacity(0.1),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
// // //                     ),
// // //                     child: const Text(
// // //                       "Reject",
// // //                       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
// // //                     ),
// // //                   ),
// // //
// // //                   const SizedBox(width: 10),
// // //                   TextButton(
// // //                     onPressed: widget.onApprove,
// // //                     style: TextButton.styleFrom(
// // //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //                       backgroundColor: Colors.red.withOpacity(0.1),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
// // //                     ),
// // //                     child: const Text("Approve",
// // //                         style: TextStyle(color: Colors.green)),
// // //                   ),
// // //                 ],
// // //               ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// //
// // class NotificationItem extends StatelessWidget {
// //   final String id;
// //   final String message;
// //   final String requestBy;
// //   final String time;
// //   final VoidCallback onApprove;
// //   final VoidCallback onReject;
// //
// //   const NotificationItem({
// //     super.key,
// //     required this.id,
// //     required this.message,
// //     required this.requestBy,
// //     required this.time,
// //     required this.onApprove,
// //     required this.onReject,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       padding: const EdgeInsets.all(12),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Colors.grey.shade200),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               // খাবারের নাম (Food Name)
// //               Text(
// //                 message,
// //                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //               ),
// //               // সময় (Time)
// //               Text(
// //                 time,
// //                 style: const TextStyle(color: Colors.grey, fontSize: 12),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 5),
// //           // রিকোয়েস্টকারীর নাম (Request By)
// //           Text(
// //             requestBy,
// //             style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
// //           ),
// //           const SizedBox(height: 10),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: ElevatedButton(
// //                   onPressed: onApprove,
// //                   style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
// //                   child: const Text("Approve", style: TextStyle(color: Colors.white)),
// //                 ),
// //               ),
// //               const SizedBox(width: 10),
// //               Expanded(
// //                 child: OutlinedButton(
// //                   onPressed: onReject,
// //                   style: OutlinedButton.styleFrom(foregroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
// //                   child: const Text("Reject"),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// //
// // class NotificationItem extends StatelessWidget {
// //   final String id;
// //   final String message;
// //   final String requestBy;
// //   final String time;
// //   final String status; // এটি নিশ্চিত করুন আছে
// //   final VoidCallback onApprove;
// //   final VoidCallback onReject;
// //
// //   const NotificationItem({
// //     super.key,
// //     required this.id,
// //     required this.message,
// //     required this.requestBy,
// //     required this.time,
// //     required this.status, // কনস্ট্রাক্টরে এটি যোগ করুন
// //     required this.onApprove,
// //     required this.onReject,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
// //       child: ListTile(
// //         title: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
// //         subtitle: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(requestBy),
// //             Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
// //           ],
// //         ),
// //         // নিচের এই অংশটি বাটন হাইড করার লজিক হ্যান্ডেল করে
// //         trailing: status == 'pending'
// //             ? Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             IconButton(
// //               icon: const Icon(Icons.check_circle, color: Colors.green),
// //               onPressed: onApprove,
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.cancel, color: Colors.red),
// //               onPressed: onReject,
// //             ),
// //           ],
// //         )
// //             : Container(
// //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //           decoration: BoxDecoration(
// //             color: status == 'approved' ? Colors.green[100] : Colors.red[100],
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //           child: Text(
// //             status.toUpperCase(),
// //             style: TextStyle(
// //               color: status == 'approved' ? Colors.green[800] : Colors.red[800],
// //               fontWeight: FontWeight.bold,
// //               fontSize: 12,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class NotificationItem extends StatelessWidget {
//   final String id;
//   final String message;
//   final String requestBy;
//   final String time;
//   final String status;
//   final VoidCallback? onApprove;
//   final VoidCallback? onReject;
//
//   const NotificationItem({
//     super.key,
//     required this.id,
//     required this.message,
//     required this.requestBy,
//     required this.time,
//     required this.status,
//     this.onApprove,
//     this.onReject,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     bool isPending = status == 'pending';
//
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         contentPadding: const EdgeInsets.all(12),
//         title: Text(message, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(requestBy, style: TextStyle(color: Colors.grey[700])),
//             Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         trailing: isPending
//             ? Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.check_circle, color: Colors.green, size: 30),
//               onPressed: onApprove,
//             ),
//             IconButton(
//               icon: const Icon(Icons.cancel, color: Colors.red, size: 30),
//               onPressed: onReject,
//             ),
//           ],
//         )
//             : Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: status == 'approved' ? Colors.green[100] : Colors.red[100],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             status.toUpperCase(),
//             style: TextStyle(
//               color: status == 'approved' ? Colors.green[800] : Colors.red[800],
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String id;
  final String message;
  final String requestBy;
  final String time;
  final String status;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  const NotificationItem({
    super.key,
    required this.id,
    required this.message,
    required this.requestBy,
    required this.time,
    required this.status,
    this.onApprove,
    this.onReject,
  });

  // 🔹 স্ট্যাটাস অনুযায়ী কালার কোড পাওয়ার মেথড
  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green; // ডেলিভারি হলে গ্রিন
      case 'rejected':
        return Colors.red;   // রিজেক্ট হলে রেড
      case 'approved':
        return Colors.blue;  // এপ্রুভ হলে ব্লু
      default:
        return Colors.orange; // পেন্ডিং থাকলে অরেঞ্জ
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor();
    final bool isPending = status.toLowerCase() == 'pending';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                // 🔹 স্ট্যাটাস ব্যাজ (এখানেই গ্রিন/রেড কালার দেখা যাবে)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor, width: 1),
                  ),
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(requestBy, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            const SizedBox(height: 4),
            Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),

            // 🔹 যদি পেন্ডিং থাকে তবেই বাটন দেখাবে, নাহলে হাইড থাকবে
            if (isPending) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onReject,
                    child: const Text("Reject", style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: onApprove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Approve"),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}