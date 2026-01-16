import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../../../auth/data/model/notification_section_model.dart';
import '../../../../sections/generic_notification_section.dart';

class DonorNotificationScreen extends StatefulWidget {
  static String routeName = '/donor-notification';
  const DonorNotificationScreen({super.key});

  @override
  State<DonorNotificationScreen> createState() =>
      _DonorNotificationScreenState();
}

class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
  List<NotificationModel> notifications = [
    NotificationModel(id: "1245145", message: "NEO# 1 has asked for the food"),
    NotificationModel(id: "1245146", message: "NEO# 2 has asked for the food"),
  ];

  void _handleApprove(String id) {
    print("Approved $id");
    // setState(() {
    //   // notifications.removeWhere((notif) => notif.id == id);
    // });
  }

  void _handleReject(String id) {
    print("Rejected $id");
    // setState(() {
    //   notifications.removeWhere((notif) => notif.id == id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(
            child: NotificationSection(
              notifications: notifications,
              onApprove: _handleApprove,
              onReject: _handleReject,
            ),
          ),
        ),
      ),
    );
  }
}
