import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';

class WasteFoodManagementApp extends StatefulWidget{
  const WasteFoodManagementApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WasteFoodManagementAppState();
  }

}

class _WasteFoodManagementAppState  extends State<WasteFoodManagementApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreenPage.routeName,
      onGenerateRoute: AppRoutes.onGenerate,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: AppData.themeData,
      themeMode: ThemeMode.light,

    );
  }
}