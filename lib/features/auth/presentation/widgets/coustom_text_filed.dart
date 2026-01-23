// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String hint;
//   final TextInputType keyboardType;
//   final IconData prefixIcon;
//   final bool isPassword;
//   final String? Function(String?)? validator;
//   final FocusNode? focusNode;
//
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     required this.hint,
//     required this.keyboardType,
//     required this.prefixIcon,
//     this.isPassword = false,
//     this.validator,
//     this.focusNode
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       focusNode: focusNode,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(prefixIcon),
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String hint;
//   final TextInputType keyboardType;
//   final IconData prefixIcon;
//   final bool isPassword;
//   final String? Function(String?)? validator;
//   final FocusNode? focusNode;
//
//   const CustomTextField({
//     super.key,
//     required this.controller,
//     required this.label,
//     required this.hint,
//     required this.keyboardType,
//     required this.prefixIcon,
//     this.isPassword = false,
//     this.validator,
//     this.focusNode
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       focusNode: focusNode,
//       validator: validator,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(prefixIcon),
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.keyboardType,
    required this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      focusNode: focusNode,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black), // normal label
        floatingLabelStyle: TextStyle(
          color: AppColor.lightGreen, // floating label color
          fontWeight: FontWeight.w600,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: AppColor.black.withOpacity(0.6)),
        prefixIcon: Icon(prefixIcon, color: AppColor.lightGreen),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.black, width: 2),
        ),
      ),
    );
  }
}

