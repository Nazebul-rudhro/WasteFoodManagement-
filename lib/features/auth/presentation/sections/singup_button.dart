import 'package:flutter/material.dart';

class SignupSection extends StatelessWidget {
  const SignupSection({
    super.key,
    required this.title,
    required this.onPressed
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            "Signup",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}