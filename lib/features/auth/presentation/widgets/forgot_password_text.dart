import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot your password?",
          style: AppTheme.heading2,
        ),
        const SizedBox(height: 8),
        Text(
          "Enter your mobile number or email ID\nWe will send you an OTP to reset your password.",
          style: AppTheme.heading3.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}