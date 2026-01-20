import 'package:flutter/cupertino.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/generic_main_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';

import '../../../../core/constants/app_image.dart';
import '../../../home/presentation/widgets/splash_screen.dart';

class SplashScreenTwo extends StatelessWidget {
  const SplashScreenTwo({super.key});
  static const String routeName = "/splash2";

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      title: "Save Food!",
      subtitle: "Manage your food waste easily ......",
      buttonText: "Next",
      image: AppImage.splashScreen1,
      onSkip: () => Navigator.pushNamed(context, LoginScreen.routeName),
      onNext: () => Navigator.pushNamed(context, LoginScreen.routeName),
    );
  }
}
