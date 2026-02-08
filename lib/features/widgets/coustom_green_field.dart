import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class CustomGreenField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;

  const CustomGreenField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle:  TextStyle(color: Colors.grey),
          // Jokhon click korbe upore jabe tokhon color green hobe
          floatingLabelStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),

          // Normal obosthay line color green
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),

          // Click korle line color green
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),

          // Error obosthay line color
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }
}