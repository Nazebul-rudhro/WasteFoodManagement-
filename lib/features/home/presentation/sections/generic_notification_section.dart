//
// import 'package:flutter/material.dart';
// import '../../../auth/data/model/notification_model.dart';
// import '../widgets/notification_item_widget.dart';
// import 'package:waste_food_management/app/app_theme.dart';
//
// class NotificationSection extends StatelessWidget {
//   final List<NotificationModel> notifications;
//   final void Function(String id) onApprove;
//   final void Function(String id) onReject;
//
//   const NotificationSection({
//     super.key,
//     required this.notifications,
//     required this.onApprove,
//     required this.onReject,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (notifications.isEmpty) return const Center(child: Padding(
//       padding: EdgeInsets.all(20.0),
//       child: Text("No notifications available"),
//     ));
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Requests History", style: AppData.heading1),
//         const Divider(thickness: 2),
//         const SizedBox(height: 10),
//         ...notifications.map((notif) => NotificationItem(
//           id: notif.id,
//           message: notif.message,
//           requestBy: notif.requestBy,
//           time: notif.time,
//           status: notif.status,
//           onApprove: notif.status == 'pending' ? () => onApprove(notif.id) : null,
//           onReject: notif.status == 'pending' ? () => onReject(notif.id) : null,
//         )),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../auth/data/model/notification_model.dart';
import '../widgets/notification_item_widget.dart';

class NotificationSection extends StatelessWidget {
  final List<NotificationModel> notifications;
  final Function(String id) onApprove;
  final Function(String id) onReject;

  const NotificationSection({
    super.key,
    required this.notifications,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notif = notifications[index];
        return NotificationItem(
          id: notif.id,
          message: notif.message,
          requestBy: notif.requestBy,
          time: notif.time,
          status: notif.status, // 🔹 এটি গ্রিন/রেড কালার কন্ট্রোল করবে
          onApprove: () => onApprove(notif.id),
          onReject: () => onReject(notif.id),
        );
      },
    );
  }
}