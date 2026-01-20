import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/screens/otp_screen.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';

import '../widgets/coustom_text_filed.dart';
import '../widgets/forgot_password_text.dart';
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot_password';
  final TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final double screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHight * 0.1,
              ),
              const ForgotPasswordText(),
              SizedBox(
                height: screenHight * 0.05,
              ),

              SizedBox(
                height: screenHight * 0.1,
              ),
              // LoginButton(buttonName: "SEND OTP", buttonAction: () {
              //   Navigator.pushNamed(context, OTPScreen.routeName);
              // },),

            ],
          ),
        ),
      ),
    );
  }
}