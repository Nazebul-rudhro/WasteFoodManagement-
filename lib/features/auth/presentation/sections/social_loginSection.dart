import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../widgets/social_button.dart';
class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Login with", style: AppData.heading3),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SocialButton(
              label: "Gmail",
              backgroundColor: Colors.red,
              icon: Icons.email,
              onPressed: () {},
            ),
            SocialButton(
              label: "Facebook",
              backgroundColor: Colors.blue,
              icon: Icons.facebook,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}