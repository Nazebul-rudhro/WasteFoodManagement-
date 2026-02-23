
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;

  Future<void> _handlePasswordReset() async {
    setState(() => _isLoading = true);
    try {
      // ওটিপি ভেরিফাই হওয়ার পর আমরা তাকে অফিসিয়াল রিসেট লিঙ্ক পাঠাব যাতে সে তার পাসওয়ার্ড রিসেট করতে পারে।
      // সরাসরি অ্যাপ থেকে চেঞ্জ করা সম্ভব নয় যদি না ইউজার লগইন করা থাকে।
      await FirebaseAuth.instance.sendPasswordResetEmail(email: widget.email);

      if (!mounted) return;
      _showSuccessDialog();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Success!"),
        content: const Text("A secure link has been sent to your email to reset your password. Please check your inbox."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text("Go to Login"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user, size: 80, color: AppColor.green),
              const SizedBox(height: 20),
              const Text("OTP Verified Successfully!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text("To complete the process, click the button below to receive your new password link.", textAlign: TextAlign.center),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: AppColor.green)
                  : LoginButton(buttonName: "RECEIVE PASSWORD LINK", onPressed: _handlePasswordReset),
            ],
          ),
        ),
      ),
    );
  }
}