import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

import '../../../home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
import '../sections/custom_title_select_profile.dart';
import '../sections/dynamic_screen_wrapper.dart';
import '../sections/role_option.dart';

class SelectProfile extends StatefulWidget {
  const SelectProfile({super.key});

  static const String routeName = '/selected_profile';

  @override
  State<SelectProfile> createState() => SelectProfileState();
}

class SelectProfileState extends State<SelectProfile> {
  String? selectedRole; // Holds the currently selected role

  void onContinue() {
    if (selectedRole == "Donor") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a role $selectedRole")),
      );
      Navigator.pushNamed(context, GetInformationDetails.routeName);
      return;
    }

    print("Selected Role: $selectedRole");
    // Navigate to next screen if needed
    // Navigator.pushNamed(context, "/nextScreen");
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: DynamicScreenWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: screenHeight * 0.01),

            const CustomTitleSelectProfile(
              title: "Want to Share food?",
              description:
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
            ),

            SizedBox(height: screenHeight * 0.03),

            // Role Options (Single Selection)
            RoleOption(
              title: "Donor",
              description: "Donate some food to the needful",
              selected: selectedRole == "Donor",
              onTap: () => setState(() => selectedRole = "Donor"),
            ),
            RoleOption(
              title: "Receiver",
              description: "Pickup and deliver food to the needful",
              selected: selectedRole == "Receiver",
              onTap: () => setState(() => selectedRole = "Receiver"),
            ),
            RoleOption(
              title: "Volunteer",
              description: "Pickup and deliver food to the needful",
              selected: selectedRole == "Volunteer",
              onTap: () => setState(() => selectedRole = "Volunteer"),
            ),

            SizedBox(height: screenHeight * 0.05),

            // Continue Button
            ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
              ),
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
