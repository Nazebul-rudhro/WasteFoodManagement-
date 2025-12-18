import 'package:flutter/material.dart';
class SocialButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
