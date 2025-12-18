import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';

class HomeScreenInfoCart extends StatelessWidget {
  final String title;
  final int value;
  final Color color;

  const HomeScreenInfoCart({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.width;
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: AppTheme.heading3.copyWith(color: Colors.black)),
            SizedBox(height: 8),
            Text(value.toString(), style: AppTheme.heading1.copyWith()),
          ],
        ),
      ),
    );
  }
}
