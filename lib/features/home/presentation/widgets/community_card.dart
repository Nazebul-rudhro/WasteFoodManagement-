import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class CommunityCard extends StatelessWidget {
  final String imagePath; // Image asset path
  final String title; // Main title text
  final String actionText; // Action text (like 'Know More')
  final VoidCallback? onActionTap; // Optional click callback

  const CommunityCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

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
                imagePath,
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
                  title,
                  style: AppData.heading3.copyWith(color: AppColor.black),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onActionTap,
                  child: Text(
                    actionText,
                    style: AppData.heading3.copyWith(
                      color: AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
