import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileOption({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title, style: AppData.heading2),
    );
  }
}
