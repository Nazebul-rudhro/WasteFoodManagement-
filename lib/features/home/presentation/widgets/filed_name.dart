import 'package:flutter/material.dart';

class FiledName extends StatelessWidget {
  final String filedname;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool readOnly;

  const FiledName({
    super.key,
    required this.filedname,
    required this.textEditingController,
    required this.keyboardType,
    this.readOnly = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          filedname,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: "Enter $filedname",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
