
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';
import 'reset_password_screen.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String email;
  final String correctOTP;
  final _otpController = TextEditingController();

  OTPVerificationScreen({super.key, required this.email, required this.correctOTP});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Text("Verification code sent to $email", textAlign: TextAlign.center),
            const SizedBox(height: 40),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: const TextStyle(fontSize: 24, letterSpacing: 10, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(counterText: "", hintText: "000000"),
            ),
            const SizedBox(height: 40),
            LoginButton(
              buttonName: "VERIFY",
              onPressed: () {
                if (_otpController.text.trim() == correctOTP) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: email)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Invalid OTP!"), backgroundColor: Colors.red),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}