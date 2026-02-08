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
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Flutter framework errors send to Crashlytics
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    // Platform errors
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GenericAuthProvider()),
          ChangeNotifierProvider(create: (_) => DonorProvider()),
          ChangeNotifierProvider(create: (_) => ReciverProvider()),
        ],
        child: const WasteFoodManagementApp(),
      ),
    );
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
