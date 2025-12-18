import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
class HeaderSection extends StatelessWidget {
  final String name;
  final String role;
  final int notificationCount;

  const HeaderSection({
    super.key,
    required this.name,
    required this.role,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi $name", style: AppTheme.heading3),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You are a ",
                    style: AppTheme.heading2,
                  ),
                  TextSpan(
                    text: role,
                    style: AppTheme.heading2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Badge(
          label: Text(
            "$notificationCount",
            style: const TextStyle(color: Colors.white),
          ),
          child: const Icon(Icons.notifications),
        ),
      ],
    );
  }
}