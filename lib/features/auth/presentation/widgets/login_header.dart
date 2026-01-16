import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Login",
      style: AppData.heading1,
    );
  }
}