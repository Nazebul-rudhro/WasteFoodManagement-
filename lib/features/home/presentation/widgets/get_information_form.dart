import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

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
  final VoidCallback onPinLocation;

  // 🔹 Validators
  final String? Function(String?)? consumerValidator;
  final String? Function(String?)? contactValidator;
  final String? Function(String?)? phoneValidator;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? addressValidator;
  final String? Function(String?)? postCodeValidator;
  final String? Function(String?)? cityValidator;

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
    required this.onPinLocation,
    required this.consumerValidator,
    required this.contactValidator,
    required this.phoneValidator,
    required this.emailValidator,
    required this.addressValidator,
    required this.postCodeValidator,
    required this.cityValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 Consumer Name
        TextFormField(
          controller: consumerNameController,
          keyboardType: consumerKeyboard,
          validator: consumerValidator,
          decoration: InputDecoration(labelText: consumerNameLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Contact Person
        TextFormField(
          controller: contactNameController,
          keyboardType: contactKeyboard,
          validator: contactValidator,
          decoration: InputDecoration(labelText: contactNameLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Phone
        TextFormField(
          controller: phoneNumberController,
          keyboardType: phoneKeyboard,
          validator: phoneValidator,
          decoration: InputDecoration(labelText: phoneNumberLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Email (read-only)
        TextFormField(
          controller: emailController,
          keyboardType: emailKeyboard,
          validator: emailValidator,
          readOnly: true,
          decoration: InputDecoration(labelText: emailLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Address
        TextFormField(
          controller: addressController,
          keyboardType: addressKeyboard,
          validator: addressValidator,
          decoration: InputDecoration(labelText: addressLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Post Code
        TextFormField(
          controller: postCodeController,
          keyboardType: postCodeKeyboard,
          validator: postCodeValidator,
          decoration: InputDecoration(labelText: postCodeLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 City
        TextFormField(
          controller: cityController,
          keyboardType: cityKeyboard,
          validator: cityValidator,
          decoration: InputDecoration(labelText: cityLabel),
        ),
        const SizedBox(height: 12),

        // 🔹 Pin Location Button
        // TextButton(
        //   onPressed: onPinLocation,
        //   child: const Text(
        //     "Pin Location by map",
        //     style: TextStyle(color: Colors.blueAccent),
        //   ),
        // ),
        // const SizedBox(height: 20),

        // 🔹 Submit Button
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.green,
              foregroundColor: AppColor.white,
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
