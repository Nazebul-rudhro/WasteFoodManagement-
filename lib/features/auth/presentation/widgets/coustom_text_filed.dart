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

// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
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
//     this.focusNode,
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
//         labelStyle: const TextStyle(color: Colors.black), // normal label
//         floatingLabelStyle: TextStyle(
//           color: AppColor.lightGreen, // floating label color
//           fontWeight: FontWeight.w600,
//         ),
//         hintText: hint,
//         hintStyle: TextStyle(color: AppColor.black.withOpacity(0.6)),
//         prefixIcon: Icon(prefixIcon, color: AppColor.lightGreen),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColor.black),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColor.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: AppColor.black, width: 2),
//         ),
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
  final Function(String)? onFieldSubmitted; // Added for focus navigation

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
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        floatingLabelStyle: TextStyle(
          color: AppColor.lightGreen,
          fontWeight: FontWeight.w600,
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3), fontSize: 14),
        prefixIcon: Icon(prefixIcon, color: AppColor.lightGreen, size: 22),

        // Borders
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColor.lightGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),

        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
