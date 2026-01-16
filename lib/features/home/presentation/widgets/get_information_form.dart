import 'package:flutter/material.dart';
import 'filed_name.dart';

class GetInformationForm extends StatelessWidget {
  // 🔹 Field Labels
  final String consumerNameLabel;
  final String contactNameLabel;
  final String phoneNumberLabel;
  final String emailLabel;
  final String addressLabel;
  final String postCodeLabel;
  final String cityLabel;

  // 🔹 Controllers
  final TextEditingController consumerNameController;
  final TextEditingController contactNameController;
  final TextEditingController phoneNumberController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController postCodeController;
  final TextEditingController cityController;

  // 🔹 Keyboard Types
  final TextInputType consumerKeyboard;
  final TextInputType contactKeyboard;
  final TextInputType phoneKeyboard;
  final TextInputType emailKeyboard;
  final TextInputType addressKeyboard;
  final TextInputType postCodeKeyboard;
  final TextInputType cityKeyboard;

  // 🔹 Callbacks
  final VoidCallback onSubmit;
  final VoidCallback onPinLocation; // ← New callback for Pin Location

  const GetInformationForm({
    super.key,
    required this.consumerNameLabel,
    required this.contactNameLabel,
    required this.phoneNumberLabel,
    required this.emailLabel,
    required this.addressLabel,
    required this.postCodeLabel,
    required this.cityLabel,
    required this.consumerNameController,
    required this.contactNameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.addressController,
    required this.postCodeController,
    required this.cityController,
    required this.consumerKeyboard,
    required this.contactKeyboard,
    required this.phoneKeyboard,
    required this.emailKeyboard,
    required this.addressKeyboard,
    required this.postCodeKeyboard,
    required this.cityKeyboard,
    required this.onSubmit,
    required this.onPinLocation, // ← Receive callback from parent
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 Fields
        FiledName(
          filedname: consumerNameLabel,
          textEditingController: consumerNameController,
          keyboardType: consumerKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: contactNameLabel,
          textEditingController: contactNameController,
          keyboardType: contactKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: phoneNumberLabel,
          textEditingController: phoneNumberController,
          keyboardType: phoneKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: emailLabel,
          textEditingController: emailController,
          keyboardType: emailKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: addressLabel,
          textEditingController: addressController,
          keyboardType: addressKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: postCodeLabel,
          textEditingController: postCodeController,
          keyboardType: postCodeKeyboard,
        ),
        const SizedBox(height: 12),
        FiledName(
          filedname: cityLabel,
          textEditingController: cityController,
          keyboardType: cityKeyboard,
        ),
        const SizedBox(height: 12),

        // 🔹 OR Divider
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.grey.shade400, thickness: 1),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('or', style: TextStyle(color: Colors.grey)),
            ),
            Expanded(
              child: Divider(color: Colors.grey.shade400, thickness: 1),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 🔹 Pin Location Button
        TextButton(
          onPressed: onPinLocation, // ← Call parent callback
          child: const Text(
            "Pin Location by map",
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
        const SizedBox(height: 20),

        // 🔹 Submit Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Submit", style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }
}
