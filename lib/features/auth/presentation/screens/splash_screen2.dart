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
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/core/constants/app_image.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import '../../../home/presentation/sections/base_screen.dart';
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
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkLoginAndRole();
//     });
//   }
//
//   Future<void> _checkLoginAndRole() async {
//     final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//
//     // অপেক্ষা করো যতক্ষণ currentUser initialize হয়
//     await Future.delayed(const Duration(milliseconds: 500));
//
//     if (!mounted) return;
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
//     // Smooth push and remove previous routes
//     AppRoutes.pushAndRemoveUntil(context, routeName);
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
//                 const CircularProgressIndicator(color: AppColor.lightGreen),
//                 const SizedBox(height: 12),
//                 const Text(
//                   "Loading...",
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               ],
//             )
//                 : const SizedBox.shrink(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/core/constants/app_image.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import '../../../home/presentation/sections/base_screen.dart';
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
//   bool _checkingAuth = false; // লজিক চেক শুরু হয়েছে কি না
//
//   @override
//   void initState() {
//     super.initState();
//     // আমরা সরাসরি চেক শুরু করব না, ইউজারকে আগে মেসেজটি পড়তে সময় দেব
//   }
//
//   // লজিক চেক করার ফাংশন (প্রফেশনাল ফ্লো)
//   Future<void> _checkLoginAndRole() async {
//     setState(() => _checkingAuth = true); // লোডার দেখাবে
//
//     final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//
//     // সামান্য বিলম্ব যাতে ইউজার এক্সপেরিয়েন্স স্মুথ হয়
//     await Future.delayed(const Duration(seconds: 1));
//
//     if (!mounted) return;
//
//     if (auth.user == null) {
//       _navigateAndRemove(LoginScreen.routeName);
//       return;
//     }
//
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
//       case 'donor': _navigateAndRemove(DonorScreen.routeName); break;
//       case 'receiver': _navigateAndRemove(ReceiverScreen.routeName); break;
//       case 'volunteer': _navigateAndRemove(VolunteerScreen.routeName); break;
//       default: _navigateAndRemove(RoleSelectionScreen.routeName);
//     }
//   }
//
//   void _navigateAndRemove(String routeName) {
//     AppRoutes.pushAndRemoveUntil(context, routeName);
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
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // 🔹 Top Section: Image & Simple Message
//                 Column(
//                   children: [
//                     SizedBox(height: isLandscape ? 10 : size.height * 0.05),
//                     Image.asset(
//                       AppImage.splashScreen1, // এখানে চাইলে ২য় ইমেজের আইকন দিতে পারেন
//                       height: isLandscape ? size.height * 0.35 : size.height * 0.38,
//                       fit: BoxFit.contain,
//                     ),
//                     SizedBox(height: size.height * 0.05),
//
//                     // সহজ টাইটেল
//                     const Text(
//                       "Share Extra Food",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w800,
//                         color: Color(0xFF1A1D1E),
//                         letterSpacing: 0.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//
//                     // একদম সহজ সাবটাইটেল (সহজ ইংরেজি)
//                     Text(
//                       "Don't waste food. Give it to someone who needs it today.",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade600,
//                         height: 1.5,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//
//                 // 🔹 Bottom Section: Button & Loading Indicator
//                 Column(
//                   children: [
//                     if (_checkingAuth)
//                       const CircularProgressIndicator(color: AppColor.lightGreen)
//                     else
//                       ElevatedButton(
//                         onPressed: _checkLoginAndRole,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColor.lightGreen,
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size(double.infinity, 55), // ফুল উইথ বাটন
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           elevation: 3,
//                           shadowColor: AppColor.lightGreen.withOpacity(0.4),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text(
//                               "GET STARTED",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1.0,
//                               ),
//                             ),
//                             SizedBox(width: 10),
//                             Icon(Icons.arrow_forward, size: 20),
//                           ],
//                         ),
//                       ),
//                     SizedBox(height: size.height * 0.02),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
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
  bool _checkingAuth = false;

  // প্রফেশনাল ফ্লো চেক করার ফাংশন
  Future<void> _checkLoginAndRole() async {
    if (_checkingAuth) return; // একাধিকবার ক্লিক রোধ করতে

    setState(() => _checkingAuth = true);

    final auth = Provider.of<GenericAuthProvider>(context, listen: false);

    try {
      // ১. ইউজার লগইন আছে কি না চেক
      if (auth.user == null) {
        _navigateAndRemove(LoginScreen.routeName);
        return;
      }

      // ২. ইউজারের ডাটা এবং রোল লোড করা
      await auth.fetchUserData();

      final role = auth.selectedRole?.toLowerCase();

      // ৩. প্রোফাইল কমপ্লিট কি না চেক
      final profileCompleted = await auth.isProfileCompleted();

      if (!mounted) return;

      // ৪. নেভিগেশন লজিক
      if (role == null || role.isEmpty) {
        // রোল না থাকলে রোল সিলেকশন
        _navigateAndRemove(RoleSelectionScreen.routeName);
      } else if (!profileCompleted) {
        // রোল আছে কিন্তু প্রোফাইল অসম্পূর্ণ
        _navigateAndRemove(GenericInformationFormScreen.routeName);
      } else {
        // সব ঠিক থাকলে সরাসরি হোমে
        _navigateToHome(role);
      }
    } catch (e) {
      debugPrint("Auth Check Error: $e");
      setState(() => _checkingAuth = false);
      // কোনো এরর হলে লগইন স্ক্রিনে পাঠানো নিরাপদ
      _navigateAndRemove(LoginScreen.routeName);
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
    if (!mounted) return;
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 🔹 Top Section: UI
                Column(
                  children: [
                    SizedBox(height: isLandscape ? 10 : size.height * 0.05),
                    Image.asset(
                      AppImage.splashScreen1,
                      height: isLandscape ? size.height * 0.35 : size.height * 0.38,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: size.height * 0.05),

                    const Text(
                      "Share Extra Food",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A1D1E),
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      "Don't waste food. Give it to someone who needs it today.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                // 🔹 Bottom Section: Button & Loading Indicator
                Column(
                  children: [
                    if (_checkingAuth)
                      const CircularProgressIndicator(color: AppColor.green)
                    else
                      ElevatedButton(
                        onPressed: _checkLoginAndRole,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                          shadowColor: AppColor.green.withOpacity(0.4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "GET STARTED",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, size: 20),
                          ],
                        ),
                      ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}