// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../../../../core/constants/app_image.dart';
// import '../../../home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import '../../../home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import '../../../home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
//
// class SplashScreenTwo extends StatefulWidget {
//   const SplashScreenTwo({super.key});
//   static const String routeName = "/splash2";
//
//   @override
//   State<SplashScreenTwo> createState() => _SplashScreenTwoState();
// }
//
// class _SplashScreenTwoState extends State<SplashScreenTwo> {
//   bool _loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginAndRole();
//   }
//
//   Future<void> _checkLoginAndRole() async {
//     final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//
//     // অপেক্ষা করো যতক্ষণ currentUser initialize হয়
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     if (auth.user == null) {
//       _navigateAndRemove(LoginScreen.routeName);
//       return;
//     }
//
//     // role এবং profile load
//     await auth.loadUserRole();
//     final role = auth.selectedRole?.toLowerCase();
//     final profileCompleted = await auth.isProfileCompleted();
//
//     if (!mounted) return;
//
//     if (role == null || role.isEmpty) {
//       _navigateAndRemove(RoleSelectionScreen.routeName);
//     } else if (!profileCompleted) {
//       _navigateAndRemove(GenericInformationFormScreen.routeName);
//     } else {
//       _navigateToHome(role);
//     }
//   }
//
//   void _navigateToHome(String role) {
//     switch (role) {
//       case 'donor':
//         _navigateAndRemove(DonorScreen.routeName);
//         break;
//       case 'receiver':
//         _navigateAndRemove(ReceiverScreen.routeName);
//         break;
//       case 'volunteer':
//         _navigateAndRemove(VolunteerScreen.routeName);
//         break;
//       default:
//         _navigateAndRemove(RoleSelectionScreen.routeName);
//     }
//   }
//
//   void _navigateAndRemove(String routeName) {
//     AppRoutes.pushAndRemoveUntil(context, routeName, (route) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BaseScreen(
//           child: Center(
//             child: _loading
//                 ? Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   AppImage.splashScreen1,
//                   height: isLandscape ? size.height * 0.35 : size.height * 0.4,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(height: 20),
//                  CircularProgressIndicator(color: AppColor.lightGreen),
//                 const SizedBox(height: 12),
//                 const Text(
//                   "Loading...",
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ],
//             )
//                 : Container(),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/core/constants/app_image.dart';
import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import '../../../home/presentation/sections/base_screen.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({super.key});
  static const String routeName = "/splash2";

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginAndRole();
    });
  }

  Future<void> _checkLoginAndRole() async {
    final auth = Provider.of<GenericAuthProvider>(context, listen: false);

    // অপেক্ষা করো যতক্ষণ currentUser initialize হয়
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    if (auth.user == null) {
      _navigateAndRemove(LoginScreen.routeName);
      return;
    }

    // role এবং profile load
    await auth.loadUserRole();
    final role = auth.selectedRole?.toLowerCase();
    final profileCompleted = await auth.isProfileCompleted();

    if (!mounted) return;

    if (role == null || role.isEmpty) {
      _navigateAndRemove(RoleSelectionScreen.routeName);
    } else if (!profileCompleted) {
      _navigateAndRemove(GenericInformationFormScreen.routeName);
    } else {
      _navigateToHome(role);
    }
  }

  void _navigateToHome(String role) {
    switch (role) {
      case 'donor':
        _navigateAndRemove(DonorScreen.routeName);
        break;
      case 'receiver':
        _navigateAndRemove(ReceiverScreen.routeName);
        break;
      case 'volunteer':
        _navigateAndRemove(VolunteerScreen.routeName);
        break;
      default:
        _navigateAndRemove(RoleSelectionScreen.routeName);
    }
  }

  void _navigateAndRemove(String routeName) {
    // Smooth push and remove previous routes
    AppRoutes.pushAndRemoveUntil(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseScreen(
          child: Center(
            child: _loading
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImage.splashScreen1,
                  height: isLandscape ? size.height * 0.35 : size.height * 0.4,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: AppColor.lightGreen),
                const SizedBox(height: 12),
                const Text(
                  "Loading...",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

