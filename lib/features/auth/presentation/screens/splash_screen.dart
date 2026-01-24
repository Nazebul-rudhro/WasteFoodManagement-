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
    // MediaQuery দিয়ে স্ক্রিনের সাইজ এবং মোড (Portrait/Landscape) বের করা
    final size = MediaQuery.of(context).size;
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                // এটি নিশ্চিত করে যে কন্টেন্ট পুরো স্ক্রিন জুড়ে থাকবে এবং স্ক্রল করা যাবে
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // কন্টেন্ট উপরে এবং বাটন নিচে রাখবে
                    children: [
                      // 🔹 ইমেজ এবং টেক্সট সেকশন
                      Column(
                        children: [
                          SizedBox(height: isLandscape ? 10 : size.height * 0.05),

                          // ডাইনামিক ইমেজ সাইজ
                          Image.asset(
                            AppImage.splashScreen1,
                            height: isLandscape ? size.height * 0.35 : size.height * 0.4,
                            fit: BoxFit.contain,
                          ),

                          SizedBox(height: size.height * 0.04),

                          // টাইটেল
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: isLandscape ? 24 : 30,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D3132),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 12),

                          // সাবটাইটেল
                          Text(
                            "Manage your food waste easily.",
                            style: TextStyle(
                              fontSize: isLandscape ? 14 : 16,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      // 🔹 বাটন সেকশন (বামে Skip, ডানে Next)
                      Padding(
                        padding: EdgeInsets.only(top: isLandscape ? 20 : 40, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // বাটনগুলোকে দুই প্রান্তে ঠেলে দিবে
                          children: [
                            // বাম দিকের Skip বাটন
                            TextButton(
                              onPressed: () {
                                AppRoutes.pushNamed(context, SplashScreenTwo.routeName);
                              },
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // ডান দিকের Next বাটন
                            ElevatedButton(
                              onPressed: () {
                                AppRoutes.pushNamed(context, SplashScreenTwo.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.lightGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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