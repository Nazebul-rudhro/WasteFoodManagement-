import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/otp_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/otp_success.dart';
import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
import '../features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/generic_main_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {

    // splashscreen route
    SplashScreenPage.routeName: (_) => const SplashScreenPage(),
    SplashScreenTwo.routeName: (_) => const SplashScreenTwo(),
    RoleSelectionScreen.routeName:(_) => const RoleSelectionScreen(),


    // Auth route
    LoginScreen.routeName: (_) => const LoginScreen(),
    SignUpScreen.routeName: (_) => SignUpScreen(),
    ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
    OTPScreen.routeName: (_) => OTPScreen(),
    OTPSuccess.routeName: (_) => OTPSuccess(),
    DonorScreen.routeName: (_) => DonorScreen(),
    DonorNotificationScreen.routeName: (_) => DonorNotificationScreen(),




    //dontaion scree
    GetInformationDetails.routeName: (_) => GetInformationDetails(),

    HomePageScreen.routeName: (_) => const HomePageScreen(),
  };

  static Route<dynamic> onGenerate(RouteSettings settings) {
    final builder = routes[settings.name];
    return MaterialPageRoute(builder: builder ?? (_) =>
    const Scaffold(
      body: Center(child: Text("Page Not Found"),),));
  }

}
