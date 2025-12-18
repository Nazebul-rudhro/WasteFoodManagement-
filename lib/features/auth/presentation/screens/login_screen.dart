import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

import '../sections/singup_button.dart';
import '../sections/social_loginSection.dart';
import '../widgets/divider.dart';
import '../sections/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static final String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    final double ScreenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenHight * 0.09,
              ),
              const LoginHeader(),
              const SizedBox(height: 30),
              const LoginForm(),
              const SizedBox(height: 20),
              const LoginDivider(title: 'or',),
              const SizedBox(height: 20),
              const SocialLoginSection(),
              const SizedBox(height: 20),
              SignupSection(title: 'Don\'t have an account', onPressed: () { Navigator.pushNamed(context, LoginScreen.routeName); },),
            ],
          ),
        ),
      ),
    );
  }
}



