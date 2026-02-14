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
// import 'firebase_options.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await runZonedGuarded(() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//
//     // Flutter framework errors send to Crashlytics
//     FlutterError.onError = (FlutterErrorDetails details) {
//       FlutterError.dumpErrorToConsole(details);
//       FirebaseCrashlytics.instance.recordFlutterFatalError(details);
//     };
//
//     // Platform errors
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
//         ],
//         child: const WasteFoodManagementApp(),
//       ),
//     );
//   }, (error, stack) {
//     FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
//   });
// }
import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';

import 'app/app.dart';
import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
import 'features/home/presentation/screens/volunteer/presentation/provider/volunteer_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // জোন মিসম্যাচ এড়াতে runZonedGuarded এর ভেতরেই সব ইনিশিয়ালাইজ করতে হবে
  runZonedGuarded(() async {
    // ১. বাইন্ডিং ইনিশিয়ালাইজেশন জোনের ভেতরে থাকতে হবে
    WidgetsFlutterBinding.ensureInitialized();

    // ২. ফায়ারবেস ইনিশিয়ালাইজেশন
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // ৩. ক্র্যাশলিটিক্স কনফিগারেশন
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    // ৪. অ্যাপ রান করা
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
    // জোনের বাইরের যেকোনো আনহ্যান্ডেলড এরর এখানে আসবে
    debugPrint("Zone Error: $error");
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}