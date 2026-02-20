// import 'package:flutter/material.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/core/constants/app_image.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
//
// class SplashScreenPage extends StatelessWidget {
//   const SplashScreenPage({super.key});
//   static const String routeName = '/splash';
//
//   @override
//   Widget build(BuildContext context) {
//     // MediaQuery দিয়ে স্ক্রিনের সাইজ এবং মোড (Portrait/Landscape) বের করা
//     final size = MediaQuery.of(context).size;
//     final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 // এটি নিশ্চিত করে যে কন্টেন্ট পুরো স্ক্রিন জুড়ে থাকবে এবং স্ক্রল করা যাবে
//                 constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween, // কন্টেন্ট উপরে এবং বাটন নিচে রাখবে
//                     children: [
//                       // 🔹 ইমেজ এবং টেক্সট সেকশন
//                       Column(
//                         children: [
//                           SizedBox(height: isLandscape ? 10 : size.height * 0.05),
//
//                           // ডাইনামিক ইমেজ সাইজ
//                           Image.asset(
//                             AppImage.splashScreen1,
//                             height: isLandscape ? size.height * 0.35 : size.height * 0.4,
//                             fit: BoxFit.contain,
//                           ),
//
//                           SizedBox(height: size.height * 0.04),
//
//                           // টাইটেল
//                           Text(
//                             "Welcome!",
//                             style: TextStyle(
//                               fontSize: isLandscape ? 24 : 30,
//                               fontWeight: FontWeight.bold,
//                               color: const Color(0xFF2D3132),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//
//                           const SizedBox(height: 12),
//
//                           // সাবটাইটেল
//                           Text(
//                             "Manage your food waste easily.",
//                             style: TextStyle(
//                               fontSize: isLandscape ? 14 : 16,
//                               color: Colors.grey.shade600,
//                               height: 1.5,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//
//                       // 🔹 বাটন সেকশন (বামে Skip, ডানে Next)
//                       Padding(
//                         padding: EdgeInsets.only(top: isLandscape ? 20 : 40, bottom: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween, // বাটনগুলোকে দুই প্রান্তে ঠেলে দিবে
//                           children: [
//                             // বাম দিকের Skip বাটন
//                             TextButton(
//                               onPressed: () {
//                                 AppRoutes.pushNamed(context, SplashScreenTwo.routeName);
//                               },
//                               child: const Text(
//                                 "Skip",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//
//                             // ডান দিকের Next বাটন
//                             ElevatedButton(
//                               onPressed: () {
//                                 AppRoutes.pushNamed(context, SplashScreenTwo.routeName);
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColor.lightGreen,
//                                 foregroundColor: Colors.white,
//                                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 elevation: 0,
//                               ),
//                               child: const Text(
//                                 "Next",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/core/constants/app_image.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});
  static const String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30), // Vertical padding slightly increased
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // --- Top Content Section ---
                      Column(
                        children: [
                          SizedBox(height: isLandscape ? 10 : size.height * 0.08),

                          // Image with a smooth fade-in effect (Professional touch)
                          Image.asset(
                            AppImage.splashScreen1,
                            height: isLandscape ? size.height * 0.35 : size.height * 0.38,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: size.height * 0.05),

                          // 🔹 Professional Title
                          Text(
                            "Welcome!", // More engaging than just "Welcome!"
                            style: TextStyle(
                              fontSize: isLandscape ? 22 : 28,
                              fontWeight: FontWeight.w800, // Extra bold for professional look
                              color: const Color(0xFF1A1D1E), // Slightly darker for contrast
                              letterSpacing: 0.5, // Added letter spacing
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 16),

                          // 🔹 Professional Subtitle
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "We are happy to have you here.",
                              style: TextStyle(
                                fontSize: isLandscape ? 14 : 15,
                                color: Colors.grey.shade600,
                                height: 1.6, // Increased line height for readability
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      // --- Bottom Navigation Section ---
                      Padding(
                        padding: EdgeInsets.only(bottom: isLandscape ? 10 : 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Skip Button
                            TextButton(
                              onPressed: () => AppRoutes.pushNamed(context, SplashScreenTwo.routeName),
                              style: TextButton.styleFrom(
                                splashFactory: NoSplash.splashFactory, // Removes cheap splash effect
                              ),
                              child: Text(
                                "SKIP",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2, // Professional uppercase style
                                ),
                              ),
                            ),

                            // Next Button with slight Shadow (Elevation)
                            ElevatedButton(
                              onPressed: () => AppRoutes.pushNamed(context, SplashScreenTwo.routeName),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.lightGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Fully rounded for modern look
                                ),
                                elevation: 3, // Subtle shadow
                                shadowColor: AppColor.lightGreen.withOpacity(0.4),
                              ),
                              child: Row( // Added an arrow icon for better UX
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "NEXT",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_ios, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}