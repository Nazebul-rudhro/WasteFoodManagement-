import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../sections/generic_profile_section.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, VoidCallback> donorOptions = {
      "Personal Info": () { print("Donor Personal Info tapped"); },
      "Your Donations": () { print("Your Donations tapped"); },
      "Rewards & Achievement": () { print("Rewards tapped"); },
      "Community": () { print("Community tapped"); },
      "Settings": () { print("Settings tapped"); },
      "Help and Support": () { print("Help tapped"); },
    };

    return Scaffold(
      body: SingleChildScrollView(
        child: BaseScreen(
          child: GenericProfileWidget(
            options: donorOptions,
            onSignOut: () { print("Donor Sign Out"); },
          ),
        ),
      ),
    );
  }
}
