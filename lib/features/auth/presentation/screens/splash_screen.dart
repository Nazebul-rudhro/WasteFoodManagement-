import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_image.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
import 'package:waste_food_management/features/home/presentation/screens/main_screen.dart';
import '../../../../core/constants/widgets/splash_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';


class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: "Welcome!",
      subtitle: "Manage your food waste easily.",
      buttonText: "Next",
      image: AppImage.splashScreen1,

      onSkip: () {
        Navigator.pushNamed(context, SplashScreenTwo.routeName);
      },

      onNext: () {
        Navigator.pushNamed(context, SplashScreenTwo.routeName);
      },
    );
  }
}

