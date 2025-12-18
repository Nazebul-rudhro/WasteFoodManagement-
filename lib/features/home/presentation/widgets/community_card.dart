import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.backgrouGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Image section
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image.asset(
                "assets/images/splash_screen/splashscreen_1.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Text section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We visit places to serve people",
                  style: AppTheme.heading3.copyWith(color: AppColor.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "Know More",
                  style: AppTheme.heading3.copyWith(
                      color: AppColor.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
