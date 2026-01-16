import 'package:flutter/material.dart';
import '../../../auth/data/model/notification_section_model.dart';
import '../widgets/notification_item_widget.dart';
import 'package:waste_food_management/app/app_theme.dart';

class NotificationSection extends StatelessWidget {
  final List<NotificationModel> notifications;
  final void Function(String id) onApprove;
  final void Function(String id) onReject;

  const NotificationSection({
    super.key,
    required this.notifications,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    if (notifications.isEmpty) {
      return const Center(child: Text("No notifications"));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Notifications", style: AppData.heading1),
        const Divider(thickness: 2),
        const SizedBox(height: 10),
        ...notifications.map((notif) => NotificationItem(
          id: notif.id,
          message: notif.message,
          onApprove: () => onApprove(notif.id),
          onReject: () => onReject(notif.id),
        )),
      ],
    );
  }
}
