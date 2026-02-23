// import 'dart:async';
// import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/services/notification_service.dart';
// import 'app/app.dart';
// import 'features/auth/provider/theme_notifier.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
// import 'firebase_options.dart';
//
// // // ব্যাকগ্রাউন্ড নোটিফিকেশন হ্যান্ডলার (অবশ্যই মেইন ফাংশনের বাইরে থাকতে হবে)
// // @pragma('vm:entry-point')
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   // ব্যাকগ্রাউন্ডে ফায়ারবেস নতুন করে ইনশিলাইজ করতে হয়
// //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// //   debugPrint("Handling a background message: ${message.messageId}");
// // }
// //
// // Future<void> main() async {
// //   runZonedGuarded(() async {
// //     // ১. বাইন্ডিং ইনিশিয়ালাইজেশন
// //     WidgetsFlutterBinding.ensureInitialized();
// //
// //     // ২. ফায়ারবেস ইনিশিয়ালাইজেশন
// //     await Firebase.initializeApp(
// //       options: DefaultFirebaseOptions.currentPlatform,
// //     );
// //
// //     // ৩. নোটিফিকেশন সেটআপ (পারমিশন এবং ব্যাকগ্রাউন্ড হ্যান্ডলার)
// //     FirebaseMessaging messaging = FirebaseMessaging.instance;
// //
// //     // অ্যান্ড্রয়েড ১৩+ এবং আইওএস এর জন্য পারমিশন রিকোয়েস্ট
// //     await messaging.requestPermission(
// //       alert: true,
// //       announcement: false,
// //       badge: true,
// //       carPlay: false,
// //       criticalAlert: false,
// //       provisional: false,
// //       sound: true,
// //     );
// //
// //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //
// //     // ৪. ক্র্যাশলিটিক্স কনফিগারেশন
// //     FlutterError.onError = (FlutterErrorDetails details) {
// //       FlutterError.dumpErrorToConsole(details);
// //       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
// //     };
// //
// //     PlatformDispatcher.instance.onError = (error, stack) {
// //       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //       return true;
// //     };
// //
// //     // ৫. অ্যাপ রান করা
// //     runApp(
// //       MultiProvider(
// //         providers: [
// //           ChangeNotifierProvider(create: (_)=> ThemeNotifier()),
// //           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
// //           ChangeNotifierProvider(create: (_) => DonorProvider()),
// //           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
// //           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
// //         ],
// //         child: const WasteFoodManagementApp(),
// //       ),
// //     );
// //   }, (error, stack) {
// //     debugPrint("Zone Error: $error");
// //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //   });
// // }
//
//
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // Background-e notification auto display hoy jodi payload-e 'notification' object thake
// }
//
// Future<void> main() async {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//     // ১. Notification Service Initialize
//     NotificationService.initialize();
//
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     // ২. Permission Request
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // ৩. Background Handler Register
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // ৪. Foreground-e thakle notification show korar logic
//     FirebaseMessaging.onMessage.listen((message) {
//       if (message.notification != null) {
//         NotificationService.display(message);
//       }
//     });
//
//     // ৫. Crashlytics & Other Setups
//     FlutterError.onError = (details) {
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_)=> ThemeNotifier()),
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }


//
// import 'dart:async';
// import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/services/notification_service.dart';
//
// // Import your files
// import 'app/app.dart';
// import 'firebase_options.dart';
// import 'features/auth/provider/generic_auth_provider.dart';
// import 'features/auth/provider/theme_notifier.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
//
// // ১. Background Message Handler (Top-level)
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   print("Handling a background message: ${message.messageId}");
// }
//
// Future<void> main() async {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//
//     // ২. Firebase & Notification Initialization
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//     NotificationService.initialize();
//
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     // ৩. Permission and Token Setup
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // ৪. Register Background Handler
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // ৫. Handling Foreground Messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         NotificationService.display(message);
//       }
//     });
//
//     // ৬. App Open from Terminated State via Notification
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         print("App launched from terminated state");
//       }
//     });
//
//     // Crashlytics
//     FlutterError.onError = (details) {
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_)=> ThemeNotifier()),
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }
//
// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/services/notification_service.dart';
//
// import 'app/app.dart';
// import 'firebase_options.dart';
// import 'features/auth/provider/generic_auth_provider.dart';
// import 'features/auth/provider/theme_notifier.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   if (message.notification == null) {
//     NotificationService.display(message);
//   }
// }
//
// Future<void> main() async {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         debugPrint("Opened from terminated state via FCM");
//       }
//     });
//
//     FlutterError.onError = (details) {
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_)=> ThemeNotifier()),
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }


// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/services/notification_service.dart';
//
// import 'app/app.dart';
// import 'firebase_options.dart';
// import 'features/auth/provider/generic_auth_provider.dart';
// import 'features/auth/provider/theme_notifier.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
//
// // ব্যাকগ্রাউন্ড হ্যান্ডলার
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   // ব্যাকগ্রাউন্ডে ডাটা মেসেজ আসলে ডিসপ্লে করবে
//   if (message.notification == null) {
//     NotificationService.display(message);
//   }
// }
//
// Future<void> main() async {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//
//     // ফায়ারবেস ইনিশিয়ালাইজ
//     await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//
//     // ১. নোটিফিকেশন সার্ভিস ইনিশিয়ালাইজ (অবশ্যই await করতে হবে)
//     await NotificationService.initialize();
//
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     // পারমিশন রিকোয়েস্ট
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // ২. ব্যাকগ্রাউন্ড মেসেজ লিসেনার
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // ৩. ফোরগ্রাউন্ড (Foreground) মেসেজ লিসেনার
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       NotificationService.display(message);
//     });
//
//     // টার্মিনেটেড স্টেট থেকে অ্যাপ ওপেন হলে
//     FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
//       if (message != null) {
//         debugPrint("Opened from terminated state via FCM");
//       }
//     });
//
//     FlutterError.onError = (details) {
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_)=> ThemeNotifier()),
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/services/notification_service.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'features/auth/provider/generic_auth_provider.dart';
import 'features/auth/provider/theme_notifier.dart';
import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';

// ব্যাকগ্রাউন্ড হ্যান্ডলার (অবশ্যই টপ লেভেল হতে হবে)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
  // ব্যাকগ্রাউন্ডে ডাটা মেসেজ আসলে ডিসপ্লে করবে
  NotificationService.display(message);
}

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // ফায়ারবেস ইনিশিয়ালাইজ
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    // ১. নোটিফিকেশন সার্ভিস ইনিশিয়ালাইজ
    await NotificationService.initialize();

    // ২. ব্যাকগ্রাউন্ড মেসেজ লিসেনার
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // পারমিশন রিকোয়েস্ট (iOS এবং Android 13+)
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    }

    // টোকেন প্রিন্ট করুন (টেস্ট করার জন্য দরকার হবে)
    String? token = await messaging.getToken();
    debugPrint("FCM Token: $token");

    // ৩. ফোরগ্রাউন্ড (Foreground) মেসেজ লিসেনার
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground message received!");
      NotificationService.display(message);
    });

    // ৪. অ্যাপ ব্যাকগ্রাউন্ডে থাকলে নোটিফিকেশনে ক্লিক করলে যা হবে
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification clicked from background state!");
    });

    // ৫. টার্মিনেটেড স্টেট থেকে অ্যাপ ওপেন হলে
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint("Opened from terminated state via FCM");
      }
    });

    // ক্র্যাশলিটিক্স সেটআপ
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
          ChangeNotifierProvider(create: (_) => DonorProvider()),
          ChangeNotifierProvider(create: (_) => ReceiverProvider()),
          ChangeNotifierProvider(create: (_) => VolunteerProvider()),
        ],
        child: const WasteFoodManagementApp(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}