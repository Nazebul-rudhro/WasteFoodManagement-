import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/home/presentation/screens/home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/generic_main_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';

import '../../../../core/constants/app_image.dart';
import '../../../home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import '../../../home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import '../../../home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import '../../../home/presentation/widgets/splash_screen.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({super.key});
  static const String routeName = "/splash2";

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  @override
  void initState(){
    super.initState();
    checkLoginAndRole();

  }
  Future<void> checkLoginAndRole() async{
    final genericAuthProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final user = genericAuthProvider.user;
    if(user != null){
      await genericAuthProvider.loadUserRole();
      switch (genericAuthProvider.selectedRole?.toLowerCase()) {
        case 'donor':
          Navigator.pushReplacementNamed(context, DonorScreen.routeName);
          break;
        case 'receiver':
          Navigator.pushReplacementNamed(context, ReceiverScreen.routeName);
          break;
        case 'volunteer':
          Navigator.pushReplacementNamed(context, VolunteerScreen.routeName);
          break;
        default:
          Navigator.pushReplacementNamed(context, RoleSelectionScreen.routeName);
      }

      }else{
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);

    }
  }

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
