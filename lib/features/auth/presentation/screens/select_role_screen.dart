import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import '../sections/custom_title_select_profile.dart';
import '../sections/role_option.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  static const String routeName = '/selected_profile';

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;
  bool isLoading = false;

  Future<void> onContinue() async {
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          ShowAlertMessage(context: context, title: 'Error', message: 'User not found');
        }
        return;
      }

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "role": selectedRole,
        "email": user.email,
        "updatedAt": FieldValue.serverTimestamp(),
        "profileCompleted": false,
      }, SetOptions(merge: true));

      if (!mounted) return;

      if (selectedRole == "Donor") {
        Navigator.pushReplacementNamed(context, DonorScreen.routeName);
      }else if(selectedRole == "Receiver"){
        Navigator.pushReplacementNamed(context, ReceiverScreen.routeName);
      } else if(selectedRole == "Volunteer") {
        // Apnar onno route gulo main.dart e define kora thakte hobe
        Navigator.pushReplacementNamed(context, VolunteerScreen.routeName);
      }
    } catch (e) {
      debugPrint("Firebase Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Screen blank thakle color white rakhun
      body: SafeArea(
        child: SingleChildScrollView( // Screen content scrollable hobe
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitleSelectProfile(
                title: "Choose your role",
                description: "Select one role to continue",
              ),
              const SizedBox(height: 40),

              RoleOption(
                title: "Donor",
                description: "Donate food to the needful",
                selected: selectedRole == "Donor",
                onTap: () => setState(() => selectedRole = "Donor"),
              ),
              const SizedBox(height: 16),

              RoleOption(
                title: "Receiver",
                description: "Receive food and deliver to the needful",
                selected: selectedRole == "Receiver",
                onTap: () => setState(() => selectedRole = "Receiver"),
              ),
              const SizedBox(height: 16),

              RoleOption(
                title: "Volunteer",
                description: "Help in delivery of food",
                selected: selectedRole == "Volunteer",
                onTap: () => setState(() => selectedRole = "Volunteer"),
              ),
              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: isLoading ? null : onContinue,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColor.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}