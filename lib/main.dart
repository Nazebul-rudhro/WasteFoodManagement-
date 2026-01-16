import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'features/home/presentation/screens/donor/presentation/provider/donor_provider.dart';
import 'features/home/presentation/screens/receiver/presentation/provider/receiver_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase inside runZonedGuarded
  await runZonedGuarded(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Catch Flutter framework errors and send to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true; // handled
    };

    runApp(MultiProvider(providers: [
      // ChangeNotifierProvider(create: (_) => AuthProvider(),),
      ChangeNotifierProvider(create: (_)=> DonerProvider()),
      ChangeNotifierProvider(create: (_)=> ReciverProvider())
    ], child: const WasteFoodManagementApp(),));
  }, (error, stack) {
    // Catch all uncaught errors
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
