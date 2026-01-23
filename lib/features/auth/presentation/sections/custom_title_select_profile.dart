import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class CustomTitleSelectProfile extends StatelessWidget {
  final String title;
  final String description;

  const CustomTitleSelectProfile({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppData.heading1.copyWith(color: AppColor.green),
        ),
        const SizedBox(height: 15),
        Text(
          description,
          style: AppData.heading3.copyWith(fontSize: 16, color: AppColor.black),
        ),
      ],
    );
  }
}
