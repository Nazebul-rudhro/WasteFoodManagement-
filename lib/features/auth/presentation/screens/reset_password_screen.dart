import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';
import '../widgets/coustom_text_filed.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Password")),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            CustomTextField(
              controller: _passController,
              label: "New Password",
              hint: "********",
              prefixIcon: Icons.lock_outline,
              isPassword: true, keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _confirmPassController,
              label: "Confirm Password",
              hint: "********",
              prefixIcon: Icons.lock_reset,
              isPassword: true, keyboardType: TextInputType.visiblePassword,
            ),
            const SizedBox(height: 40),
            LoginButton(
              buttonName: "UPDATE PASSWORD",
              onPressed: () {
                if (_passController.text == _confirmPassController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password updated successfully!")),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match!"), backgroundColor: Colors.red),
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