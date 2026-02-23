

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';
import '../widgets/coustom_text_filed.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = '/forgot_password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _sendEmailViaEmailJS({required String targetEmail, required String otpCode}) async {
    const serviceId = 'service_t2hi1um';
    const templateId = 'template_88oc91m';
    const publicKey = 'mQQpuWpvwFdTMkrso';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'origin': 'http://localhost'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {'email': targetEmail, 'passcode': otpCode, 'time': '10 Minutes'}
        }),
      );
      if (response.statusCode != 200) throw 'Email failed with status: ${response.statusCode}';
    } catch (e) {
      throw 'Email Service Error: $e';
    }
  }

  Future<void> _processForgotPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final String email = _emailController.text.trim();

    try {
      // কালেকশন নেম 'accounts' না হলে সেটি আপনার ডাটাবেজ অনুযায়ী পরিবর্তন করুন (যেমন 'users')
      final userQuery = await FirebaseFirestore.instance
          .collection('accounts')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isEmpty) {
        _showNotification("No account found with this email.", isError: true);
        setState(() => _isLoading = false);
        return;
      }

      final String otp = (Random().nextInt(900000) + 100000).toString();
      await _sendEmailViaEmailJS(targetEmail: email, otpCode: otp);

      if (!mounted) return;
      _showNotification("Code sent to $email", isError: false);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OTPVerificationScreen(email: email, correctOTP: otp)),
      );
    } catch (e) {
      // আসল এররটি দেখার জন্য এখানে প্রিন্ট করুন
      debugPrint("Full Error: $e");
      _showNotification("Error: ${e.toString()}", isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showNotification(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.redAccent : AppColor.green,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.lock_reset, size: 80, color: AppColor.green),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                label: "Email Address",
                hint: "example@gmail.com",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Enter email";
                  if (!val.contains('@')) return "Enter valid email";
                  return null;
                },
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: AppColor.green)
                  : LoginButton(buttonName: "SEND OTP", onPressed: _processForgotPassword),
            ],
          ),
        ),
      ),
    );
  }
}