import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/coustom_text_filed.dart';
import '../widgets/login_button.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Mobile Number Field
        CustomTextField(
          controller: _mobileController,
          label: "Mobile number",
          hint: "Enter your mobile number",
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone,
        ),
        const SizedBox(height: 15),

        // Password Field
        CustomTextField(
          controller: _passwordController,
          label: "Password",
          hint: "Enter your password",
          isPassword: true, // Obscure text enable hobe
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: Icons.lock, // 'password' icon er cheye 'lock' beshi manasai
        ),

        const SizedBox(height: 10),

        // Remember me & Forgot Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (val) {
                    setState(() {
                      rememberMe = val ?? false;
                    });
                  },
                ),
                const Text("Remember me"),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Forgot Password?"),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Login Button
        LoginButton(buttonName: 'Login',)
        // SizedBox(
        //   width: double.infinity,
        //   height: 50,
        //   child: ElevatedButton(
        //     onPressed: () {},
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: AppColor.primary,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //     ),
        //     child: Text(
        //       "Login",
        //       style: AppTheme.heading2.copyWith(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}