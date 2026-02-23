import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // টার্মিনালে 'flutter pub add http' দিন
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
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // 📧 EmailJS লজিক - আপনার দেওয়া সঠিক আইডিগুলো বসানো হয়েছে
  Future<void> _sendOTPEmail(String userEmail, String otp) async {
    const serviceId = 'service_t2hi1um'; // আপনার সার্ভিস আইডি
    const templateId = 'template_88oc91m'; // আপনার টেমপ্লেট আইডি
    const publicKey = 'mQQpuWpvwFdTMkrso'; // আপনার পাবলিক কি

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'origin': 'http://localhost',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {
          'email': userEmail,    // আপনার টেমপ্লেটের {{email}}
          'passcode': otp,       // আপনার টেমপ্লেটের {{passcode}}
          'time': '15 minutes',  // আপনার টেমপ্লেটের {{time}}
        }
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send email: ${response.body}');
    }
  }

  void _handleSendOTP() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // ৬ ডিজিটের র‍্যান্ডম ওটিপি তৈরি
        String generatedOTP = (Random().nextInt(900000) + 100000).toString();

        await _sendOTPEmail(_emailController.text.trim(), generatedOTP);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Success! Check your Gmail for OTP.")),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              email: _emailController.text.trim(),
              correctOTP: generatedOTP,
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Icon(Icons.lock_reset_rounded, size: 80, color: AppColor.green),
              const SizedBox(height: 20),
              const Text("Forgot Password", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                label: "Email Address",
                hint: "example@mail.com",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || !value.contains('@')) ? "Enter valid email" : null,
              ),
              const SizedBox(height: 40),
              _isLoading
                  ? const CircularProgressIndicator(color: AppColor.green)
                  : LoginButton(buttonName: "SEND OTP", onPressed: _handleSendOTP),
            ],
          ),
        ),
      ),
    );
  }
}