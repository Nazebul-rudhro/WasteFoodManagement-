import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/main_screen.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    SplashScreenPage.routeName: (_) => const SplashScreenPage(),
    SplashScreenTwo.routeName: (_) => const SplashScreenTwo(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    MainScreen.routeName: (_) => const MainScreen(),


    HomePageScreen.routeName: (_) => const HomePageScreen(),
  };

  static Route<dynamic> onGenerate(RouteSettings settings) {
    final builder = routes[settings.name];
    return MaterialPageRoute(builder: builder ?? (_) =>
    const Scaffold(
      body: Center(child: Text("Page Not Found"),),));
  }

}
