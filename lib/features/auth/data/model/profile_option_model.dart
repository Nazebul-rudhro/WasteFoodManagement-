import 'package:flutter/cupertino.dart';

class ProfileOptionItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  ProfileOptionItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
