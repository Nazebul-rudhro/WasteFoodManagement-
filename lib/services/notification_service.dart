// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// //
// // class NotificationService {
// //   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
// //   FlutterLocalNotificationsPlugin();
// //
// //   static Future<void> initialize() async {
// //     const AndroidInitializationSettings androidSettings =
// //     AndroidInitializationSettings('@mipmap/ic_launcher');
// //
// //     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
// //       requestAlertPermission: true,
// //       requestBadgePermission: true,
// //       requestSoundPermission: true,
// //     );
// //
// //     const InitializationSettings settings = InitializationSettings(
// //       android: androidSettings,
// //       iOS: iosSettings,
// //     );
// //
// //     // settings সরাসরি প্রথম আর্গুমেন্ট, অন্য কোনো নাম ছাড়া
// //     await _notificationsPlugin.initialize(
// //       settings,
// //       onDidReceiveNotificationResponse: (NotificationResponse details) {
// //         debugPrint("Notification Clicked: ${details.payload}");
// //       },
// //     );
// //   }
// //
// //   static void display(RemoteMessage message) async {
// //     try {
// //       final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
// //
// //       const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
// //         "waste_food_channel_id",
// //         "Waste Food Notifications",
// //         importance: Importance.max,
// //         priority: Priority.high,
// //         playSound: true,
// //       );
// //
// //       const NotificationDetails notificationDetails = NotificationDetails(
// //         android: androidDetails,
// //         iOS: const DarwinNotificationDetails(),
// //       );
// //
// //       await _notificationsPlugin.show(
// //         id,
// //         message.notification?.title ?? "Waste Food Management",
// //         message.notification?.body ?? message.data['message'],
// //         notificationDetails,
// //         payload: message.data['targetId']?.toString() ?? "default",
// //       );
// //     } catch (e) {
// //       debugPrint("Display Error: $e");
// //     }
// //   }
// // }
//
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   // ১. মেথডটি অবশ্যই Future এবং async হতে হবে
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
//     // ২. settings সরাসরি প্রথম আর্গুমেন্ট হিসেবে যাবে
//     await _notificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (NotificationResponse details) {
//         if (details.payload != null) {
//           debugPrint("Notification Clicked with payload: ${details.payload}");
//         }
//       },
//     );
//   }
//
//   static void display(RemoteMessage message) async {
//     try {
//       // ৩. ইউনিক আইডি জেনারেট করা
//       final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//
//       const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//         "waste_food_channel_id",
//         "Waste Food Notifications",
//         channelDescription: "Notifications for food requests",
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//         playSound: true,
//       );
//
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidDetails,
//         iOS: DarwinNotificationDetails(),
//       );
//
//       String? title = message.notification?.title ?? "Waste Food Management";
//       String? body = message.notification?.body ?? message.data['message'];
//
//       if (title != null || body != null) {
//         await _notificationsPlugin.show(
//           id,
//           title,
//           body,
//           notificationDetails,
//           payload: message.data['targetId']?.toString() ?? "default_id",
//         );
//       }
//     } catch (e) {
//       debugPrint("Notification Display Error: $e");
//     }
//   }
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class NotificationService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // ১. ডাইনামিক নোটিফিকেশন পাঠানোর মেইন ফাংশন (সময়সহ)
//   static Future<void> _sendNotification({
//     required String targetId,
//     required String title,
//     required String message,
//     required String type,
//     required String postId,
//   }) async {
//     try {
//       await _firestore.collection('notifications').add({
//         'targetId': targetId,
//         'title': title,
//         'message': message,
//         'type': type,
//         'status': "unread",
//         'postId': postId,
//         'createdAt': FieldValue.serverTimestamp(), // এটি ফায়ারবেসের সার্ভার টাইম নিবে
//       });
//     } catch (e) {
//       print("Notification Error: $e");
//     }
//   }
//
//   // ২. যখন রিকোয়েস্ট Approve হবে
//   static Future<void> sendApprovalNotification({
//     required String requesterId,
//     required String foodName,
//     required String postId,
//   }) async {
//     await _sendNotification(
//       targetId: requesterId,
//       title: "Request Approved",
//       message: "Great news! Your request for '$foodName' was approved.",
//       type: "approval",
//       postId: postId,
//     );
//   }
//
//   // ৩. যখন ডেলিভারি কমপ্লিট হবে
//   static Future<void> sendDeliveryCompleteNotification({
//     required String requesterId,
//     required String foodName,
//     required String postId,
//   }) async {
//     await _sendNotification(
//       targetId: requesterId,
//       title: "Delivery Complete",
//       message: "The delivery of '$foodName' is finished. Hope you enjoy the food!",
//       type: "delivery_complete",
//       postId: postId,
//     );
//   }
//
//   // ৪. যখন নতুন কোনো রিকোয়েস্ট আসবে (Donor এর জন্য)
//   static Future<void> sendNewRequestNotification({
//     required String donorId,
//     required String foodName,
//     required String postId,
//   }) async {
//     await _sendNotification(
//       targetId: donorId,
//       title: "New Food Request",
//       message: "Someone has requested your donated food: '$foodName'.",
//       type: "request",
//       postId: postId,
//     );
//   }
//
//   // ৪. যখন ডোনার রিকোয়েস্ট Reject করবে
//   static Future<void> sendRejectionNotification({
//     required String requesterId,
//     required String foodName,
//     required String postId,
//   }) async {
//     await _sendNotification(
//       targetId: requesterId,
//       title: "Request Declined",
//       message: "We're sorry, your request for '$foodName' could not be accepted at this time.",
//       type: "rejection",
//       postId: postId,
//     );
//   }
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// class NotificationService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   // ১. ইনিশিয়ালাইজ (পপ-আপ সেটিংস)
//   static Future<void> initialize() async {
//     const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
//
//     const InitializationSettings settings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//
//     await _localNotificationsPlugin.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (details) {
//         // নোটিফিকেশনে ক্লিক করলে কি হবে তা এখানে লিখুন
//       },
//     );
//   }
//
//   // ২. পপ-আপ দেখানোর ফাংশন
//   static void displayPopup(String title, String body) async {
//     try {
//       final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           "food_management_channel",
//           "Food Management Notifications",
//           importance: Importance.max,
//           priority: Priority.high,
//           showWhen: true,
//         ),
//         iOS: DarwinNotificationDetails(),
//       );
//
//       await _localNotificationsPlugin.show(id, title, body, notificationDetails);
//     } catch (e) {
//       debugPrint("Display Error: $e");
//     }
//   }
//
//   // ৩. ডাটাবেজে নোটিফিকেশন সেভ করার প্রাইভেট মেথড
//   static Future<void> _saveToFirestore({
//     required String targetId,
//     required String title,
//     required String message,
//     required String type,
//     required String postId,
//   }) async {
//     try {
//       await _firestore.collection('notifications').add({
//         'targetId': targetId,
//         'title': title,
//         'message': message,
//         'type': type,
//         'status': "unread",
//         'postId': postId,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//       // ডাটাবেজে সেভ করার সাথে সাথে একটি লোকাল পপ-আপ সিমুলেশন
//       displayPopup(title, message);
//     } catch (e) {
//       debugPrint("Firestore Notification Error: $e");
//     }
//   }
//
//   // --- পাবলিক মেথডসমূহ ---
//
//   static Future<void> sendApprovalNotification({required String requesterId, required String foodName, required String postId}) async {
//     await _saveToFirestore(
//       targetId: requesterId,
//       title: "Request Approved ✅",
//       message: "Great news! Your request for '$foodName' was approved.",
//       type: "approval",
//       postId: postId,
//     );
//   }
//
//   static Future<void> sendRejectionNotification({required String requesterId, required String foodName, required String postId}) async {
//     await _saveToFirestore(
//       targetId: requesterId,
//       title: "Request Declined ❌",
//       message: "We're sorry, your request for '$foodName' was not accepted this time.",
//       type: "rejection",
//       postId: postId,
//     );
//   }
//
//   static Future<void> sendNewRequestNotification({required String donorId, required String foodName, required String postId}) async {
//     await _saveToFirestore(
//       targetId: donorId,
//       title: "New Food Request 🍏",
//       message: "Someone has requested your donated food: '$foodName'.",
//       type: "request",
//       postId: postId,
//     );
//   }
//
//   static Future<void> sendDeliveryCompleteNotification({required String requesterId, required String foodName, required String postId}) async {
//     await _saveToFirestore(
//       targetId: requesterId,
//       title: "Delivery Complete 🚚",
//       message: "The delivery of '$foodName' is finished. Enjoy!",
//       type: "delivery_complete",
//       postId: postId,
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotificationsPlugin.initialize(settings);
  }

  // সরাসরি স্ট্রিং দিয়ে পপ-আপ দেখানোর জন্য (Internal Use)
  static void showLocalNotification(String title, String body) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          "food_mgmt_channel",
          "Food Management",
          importance: Importance.max,
          priority: Priority.high
      ),
      iOS: DarwinNotificationDetails(),
    );
    await _localNotificationsPlugin.show(id, title, body, notificationDetails);
  }

  // FCM থেকে আসা RemoteMessage হ্যান্ডেল করার জন্য
  static void displayPopup(RemoteMessage message) {
    String? title = message.notification?.title ?? message.data['title'];
    String? body = message.notification?.body ?? message.data['body'];

    if (title != null && body != null) {
      showLocalNotification(title, body);
    }
  }

  static Future<void> _saveAndNotify({
    required String targetId,
    required String title,
    required String message,
    required String type,
    required String postId,
  }) async {
    try {
      await _firestore.collection('notifications').add({
        'targetId': targetId,
        'title': title,
        'message': message,
        'type': type,
        'status': "unread",
        'postId': postId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      // নিজের অ্যাপে সাথে সাথে পপ-আপ দেখাবে
      showLocalNotification(title, message);
    } catch (e) {
      debugPrint("Notification Error: $e");
    }
  }

  // ১. যখন রিকোয়েস্ট অ্যাপ্রুভ হয় (Receiver পাবে)
  static Future<void> sendApprovalNotification({required String requesterId, required String foodName, required String postId}) async {
    await _saveAndNotify(
        targetId: requesterId,
        title: "Request Approved ✅",
        message: "Your request for '$foodName' was approved.",
        type: "approval",
        postId: postId
    );
  }

  // ২. যখন রিকোয়েস্ট রিজেক্ট হয় (Receiver পাবে)
  static Future<void> sendRejectionNotification({required String requesterId, required String foodName, required String postId}) async {
    await _saveAndNotify(
        targetId: requesterId,
        title: "Request Declined ❌",
        message: "Your request for '$foodName' was not accepted.",
        type: "rejection",
        postId: postId
    );
  }

  // ✅ ৩. নতুন রিকোয়েস্ট আসলে (Donor পাবে) - নতুন যুক্ত করা হয়েছে
  static Future<void> sendNewRequestNotification({required String donorId, required String foodName, required String postId}) async {
    await _saveAndNotify(
        targetId: donorId,
        title: "New Food Request 🍏",
        message: "Someone has requested your donated food: '$foodName'.",
        type: "request",
        postId: postId
    );
  }

  // ✅ ৪. ডেলিভারি সম্পন্ন হলে (Receiver পাবে) - নতুন যুক্ত করা হয়েছে
  static Future<void> sendDeliveryCompleteNotification({required String requesterId, required String foodName, required String postId}) async {
    await _saveAndNotify(
        targetId: requesterId,
        title: "Delivery Complete 🚚",
        message: "The delivery of '$foodName' is finished. Enjoy your meal!",
        type: "delivery_complete",
        postId: postId
    );
  }
}