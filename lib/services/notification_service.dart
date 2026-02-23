// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//
//     const InitializationSettings settings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//
//     // settings সরাসরি প্রথম আর্গুমেন্ট, অন্য কোনো নাম ছাড়া
//     await _notificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse details) {
//         debugPrint("Notification Clicked: ${details.payload}");
//       },
//     );
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//       const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//         "waste_food_channel_id",
//         "Waste Food Notifications",
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//       );
//
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: const DarwinNotificationDetails(),
//       );
//
//       await _notificationsPlugin.show(
//         id,
//         message.notification?.title ?? "Waste Food Management",
//         message.notification?.body ?? message.data['message'],
//         notificationDetails,
//         payload: message.data['targetId']?.toString() ?? "default",
//       );
//     } catch (e) {
//       debugPrint("Display Error: $e");
//     }
//   }
// }


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // ১. মেথডটি অবশ্যই Future এবং async হতে হবে
  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // ২. settings সরাসরি প্রথম আর্গুমেন্ট হিসেবে যাবে
    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        if (details.payload != null) {
          debugPrint("Notification Clicked with payload: ${details.payload}");
        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      // ৩. ইউনিক আইডি জেনারেট করা
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "waste_food_channel_id",
        "Waste Food Notifications",
        channelDescription: "Notifications for food requests",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
      );

      const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: DarwinNotificationDetails(),
      );

      String? title = message.notification?.title ?? "Waste Food Management";
      String? body = message.notification?.body ?? message.data['message'];

      if (title != null || body != null) {
        await _notificationsPlugin.show(
          id,
          title,
          body,
          notificationDetails,
          payload: message.data['targetId']?.toString() ?? "default_id",
        );
      }
    } catch (e) {
      debugPrint("Notification Display Error: $e");
    }
  }
}