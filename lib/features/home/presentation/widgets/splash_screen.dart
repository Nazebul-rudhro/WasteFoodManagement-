import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class SplashScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final String image;
  final VoidCallback? onSkip;
  final VoidCallback? onNext;

  const SplashScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.image,
    this.onSkip,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: onSkip,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Splash Image
              Image.asset(image, height: screenHeight * 0.5),

              const SizedBox(height: 15),

              // Title
              Text(title, style: AppTheme.heading2),

              const SizedBox(height: 10),

              // Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),

              const Spacer(),

              // Next button
              // width: double.infinity,
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 10.0,
                  ),
                  foregroundColor: AppColor.black,
                  backgroundColor: AppColor.lightGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
