import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_image.dart';

import '../sections/custom_message.dart';

class OTPSuccess extends StatelessWidget {
  const OTPSuccess({super.key});

  static const String routeName = "/Success";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: CustomMessage(
              img: AppImage.doneIcon,
              title: "OTP Successful!",
              message:
              "Your Phone number has been registered\nchanged successfully",
            ),
          ),
        ),
      ),
    );
  }
}


