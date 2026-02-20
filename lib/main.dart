// // import 'dart:async';
// // import 'dart:ui';
// //
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// //
// // import 'app/app.dart';
// // import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// // import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// // import 'firebase_options.dart';
// //
// // Future<void> main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   await runZonedGuarded(() async {
// //     await Firebase.initializeApp(
// //       options: DefaultFirebaseOptions.currentPlatform,
// //     );
// //
// //     // Flutter framework errors send to Crashlytics
// //     FlutterError.onError = (FlutterErrorDetails details) {
// //       FlutterError.dumpErrorToConsole(details);
// //       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
// //     };
// //
// //     // Platform errors
// //     PlatformDispatcher.instance.onError = (error, stack) {
// //       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //       return true;
// //     };
// //
// //     runApp(
// //       MultiProvider(
// //         providers: [
// //           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
// //           ChangeNotifierProvider(create: (_) => DonorProvider()),
// //           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
// //         ],
// //         child: const WasteFoodManagementApp(),
// //       ),
// //     );
// //   }, (error, stack) {
// //     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
// //   });
// // }
// import 'dart:async';
// import 'dart:ui';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
//
// import 'app/app.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   // জোন মিসম্যাচ এড়াতে runZonedGuarded এর ভেতরেই সব ইনিশিয়ালাইজ করতে হবে
//   runZonedGuarded(() async {
//     // ১. বাইন্ডিং ইনিশিয়ালাইজেশন জোনের ভেতরে থাকতে হবে
//     WidgetsFlutterBinding.ensureInitialized();
//
//     // ২. ফায়ারবেস ইনিশিয়ালাইজেশন
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     // ৩. ক্র্যাশলিটিক্স কনফিগারেশন
//     FlutterError.onError = (FlutterErrorDetails details) {
//       FlutterError.dumpErrorToConsole(details);
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     PlatformDispatcher.instance.onError = (error, stack) {
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       return true;
//     };
//
//     // ৪. অ্যাপ রান করা
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     // জোনের বাইরের যেকোনো আনহ্যান্ডেলড এরর এখানে আসবে
//     debugPrint("Zone Error: $error");
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }
//
// import 'dart:async';
// import 'dart:ui';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'; // নতুন যোগ করা হয়েছে
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'app/app.dart';
// import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
// import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
// import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
// import 'firebase_options.dart';
//
// // ব্যাকগ্রাউন্ড নোটিফিকেশন হ্যান্ডলার
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }
//
// Future<void> main() async {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();
//
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     // ১. নোটিফিকেশন ব্যাকগ্রাউন্ড হ্যান্ডলার সেটআপ
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     // ২. ক্র্যাশলিটিক্স কনফিগারেশন
//     FlutterError.onError = (FlutterErrorDetails details) {
//       FlutterError.dumpErrorToConsole(details);
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     PlatformDispatcher.instance.onError = (error, stack) {
//       FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//       return true;
//     };
//
//     runApp(
//       MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
//           ChangeNotifierProvider(create: (_) => DonorProvider()),
//           ChangeNotifierProvider(create: (_) => ReceiverProvider()),
//           ChangeNotifierProvider(create: (_) => VolunteerProvider()),
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     debugPrint("Zone Error: $error");
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }

import 'dart:async';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'app/app.dart';
import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
import 'firebase_options.dart';

// ব্যাকগ্রাউন্ড নোটিফিকেশন হ্যান্ডলার (অবশ্যই মেইন ফাংশনের বাইরে থাকতে হবে)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // ব্যাকগ্রাউন্ডে ফায়ারবেস নতুন করে ইনশিলাইজ করতে হয়
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  runZonedGuarded(() async {
    // ১. বাইন্ডিং ইনিশিয়ালাইজেশন
    WidgetsFlutterBinding.ensureInitialized();

    // ২. ফায়ারবেস ইনিশিয়ালাইজেশন
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // ৩. নোটিফিকেশন সেটআপ (পারমিশন এবং ব্যাকগ্রাউন্ড হ্যান্ডলার)
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // অ্যান্ড্রয়েড ১৩+ এবং আইওএস এর জন্য পারমিশন রিকোয়েস্ট
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // ৪. ক্র্যাশলিটিক্স কনফিগারেশন
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // ৫. অ্যাপ রান করা
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
          ChangeNotifierProvider(create: (_) => DonorProvider()),
          ChangeNotifierProvider(create: (_) => ReceiverProvider()),
          ChangeNotifierProvider(create: (_) => VolunteerProvider()),
        ],
        child: const WasteFoodManagementApp(),
      ),
    );
  }, (error, stack) {
    debugPrint("Zone Error: $error");
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}