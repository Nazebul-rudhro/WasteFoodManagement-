import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
class CustomMessage extends StatelessWidget {
  final String img;
  final String title;
  final String message;

  const CustomMessage({
    super.key,
    required this.img,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: 250,
          width: 250,
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          title,
          style: AppData.heading1,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          message,
          style: AppData.heading2.copyWith(color: AppColor.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}