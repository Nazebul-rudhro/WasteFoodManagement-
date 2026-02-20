// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import '../sections/custom_title_select_profile.dart';
// import '../sections/role_option.dart';
// import 'generic_information_form_screen.dart';
//
// class RoleSelectionScreen extends StatefulWidget {
//   const RoleSelectionScreen({super.key});
//
//   static const String routeName = '/selected_role';
//
//   @override
//   State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
// }
//
// class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
//   String? selectedRole;
//   bool isLoading = false;
//
//
//   Future<void> onContinue() async {
//     if (selectedRole == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please select a role")),
//       );
//       return;
//     }
//
//     setState(() => isLoading = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) return;
//
//       final authProvider =
//       Provider.of<GenericAuthProvider>(context, listen: false);
//
//       await authProvider.saveUserRole(
//         selectedRole!,
//       );
//
//       if (!mounted) return;
//
//       Navigator.pushReplacementNamed(
//         context,
//         GenericInformationFormScreen.routeName,
//       );
//     } catch (e) {
//       ShowAlertMessage(
//         context: context,
//         title: 'Error',
//         boldText: 'Authentication Failed',
//         message:  'Something went wrong',
//         isSuccess: false
//       );
//     debugPrint("Firebase Error: $e");
//     } finally {
//     if (mounted) setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Screen blank thakle color white rakhun
//       body: SafeArea(
//         child: SingleChildScrollView( // Screen content scrollable hobe
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const CustomTitleSelectProfile(
//                 title: "Choose Your Role",
//                 description: "Select one role to continue",
//               ),
//               const SizedBox(height: 40),
//
//               RoleOption(
//                 title: "Donor",
//                 description: "Donate food to the needful",
//                 selected: selectedRole == "Donor",
//                 onTap: () => setState(() => selectedRole = "Donor"),
//               ),
//               const SizedBox(height: 16),
//
//               RoleOption(
//                 title: "Receiver",
//                 description: "Receive food and deliver to the needful",
//                 selected: selectedRole == "Receiver",
//                 onTap: () => setState(() => selectedRole = "Receiver"),
//               ),
//               const SizedBox(height: 16),
//
//               RoleOption(
//                 title: "Volunteer",
//                 description: "Help in delivery of food",
//                 selected: selectedRole == "Volunteer",
//                 onTap: () => setState(() => selectedRole = "Volunteer"),
//               ),
//               const SizedBox(height: 60),
//
//               ElevatedButton(
//                 onPressed: isLoading ? null : onContinue,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: AppColor.green,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 child: isLoading
//                     ? const SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: CircularProgressIndicator(
//                       color: Colors.white, strokeWidth: 2),
//                 )
//                     : const Text(
//                   "Continue",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import '../sections/custom_title_select_profile.dart';
// import '../sections/role_option.dart';
// import 'generic_information_form_screen.dart';
//
// class RoleSelectionScreen extends StatefulWidget {
//   const RoleSelectionScreen({super.key});
//
//   static const String routeName = '/selected_role';
//
//   @override
//   State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
// }
//
// class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
//   String? selectedRole;
//   bool isLoading = false;
//
//   /// ===============================
//   /// Logic: On Continue Action
//   /// ===============================
//   Future<void> onContinue() async {
//     if (selectedRole == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Please select a role to continue"),
//           backgroundColor: Colors.redAccent,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       return;
//     }
//
//     setState(() => isLoading = true);
//
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) throw Exception("User session expired");
//
//       final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
//
//       // ৩. ডাটাবেসে রোল সেভ করা
//       await authProvider.saveUserRole(selectedRole!);
//
//       if (!mounted) return;
//
//       // ৫. পরবর্তী পেজে নেভিগেশন
//       Navigator.pushReplacementNamed(
//         context,
//         GenericInformationFormScreen.routeName,
//       );
//
//     } catch (e) {
//       if (!mounted) return;
//       ShowAlertMessage(
//           context: context,
//           title: 'Error',
//           boldText: 'Update Failed',
//           message: 'Something went wrong. Please try again.',
//           isSuccess: false
//       );
//       debugPrint("Role Selection Error: $e");
//     } finally {
//       if (mounted) {
//         setState(() => isLoading = false);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const CustomTitleSelectProfile(
//                 title: "Choose Your Role",
//                 description: "Select one role to continue",
//               ),
//               const SizedBox(height: 40),
//
//               // Donor Option
//               RoleOption(
//                 title: "Donor",
//                 description: "Donate food to the needful",
//                 selected: selectedRole == "Donor",
//                 onTap: isLoading ? null : () => setState(() => selectedRole = "Donor"),
//               ),
//               const SizedBox(height: 16),
//
//               // Receiver Option
//               RoleOption(
//                 title: "Receiver",
//                 description: "Receive food and deliver to the needful",
//                 selected: selectedRole == "Receiver",
//                 onTap: isLoading ? null : () => setState(() => selectedRole = "Receiver"),
//               ),
//               const SizedBox(height: 16),
//
//               // Volunteer Option
//               RoleOption(
//                 title: "Volunteer",
//                 description: "Help in delivery of food",
//                 selected: selectedRole == "Volunteer",
//                 onTap: isLoading ? null : () => setState(() => selectedRole = "Volunteer"),
//               ),
//               const SizedBox(height: 60),
//
//               // Continue Button
//               ElevatedButton(
//                 onPressed: isLoading ? null : onContinue,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   backgroundColor: AppColor.green,
//                   disabledBackgroundColor: AppColor.green.withOpacity(0.6),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: isLoading
//                     ? const SizedBox(
//                   height: 24,
//                   width: 24,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                     strokeWidth: 2.5,
//                   ),
//                 )
//                     : const Text(
//                   "Continue",
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/sections/show_aleart.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import '../sections/custom_title_select_profile.dart';
import '../sections/role_option.dart';
import 'generic_information_form_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  static const String routeName = '/selected_role';

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? selectedRole;
  bool isLoading = false;

  /// ===============================
  /// Logic: On Continue Action
  /// ===============================
  Future<void> onContinue() async {
    // ১. ভ্যালিডেশন: রোল সিলেক্ট না করলে এরর দেখাবে
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a role to continue"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User session expired");

      // ২. GenericAuthProvider এর রেফারেন্স নেওয়া
      final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);

      // ৩. ডাটাবেসে রোল সেভ করা (lowercase এ সেভ করা ভালো প্র্যাকটিস)
      await authProvider.saveUserRole(selectedRole!.toLowerCase());

      if (!mounted) return;

      // ৪. পরবর্তী পেজে (Information Form) নেভিগেশন
      Navigator.pushReplacementNamed(
        context,
        GenericInformationFormScreen.routeName,
      );

    } catch (e) {
      if (!mounted) return;
      ShowAlertMessage(
          context: context,
          title: 'Error',
          boldText: 'Update Failed',
          message: 'Something went wrong. Please try again.',
          isSuccess: false
      );
      debugPrint("Role Selection Error: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomTitleSelectProfile(
                title: "Choose Your Role",
                description: "Select one role to continue",
              ),
              const SizedBox(height: 40),

              // Donor Option
              RoleOption(
                title: "Donor",
                description: "Donate food to the needful",
                selected: selectedRole == "Donor",
                onTap: isLoading ? null : () => setState(() => selectedRole = "Donor"),
              ),
              const SizedBox(height: 16),

              // Receiver Option
              RoleOption(
                title: "Receiver",
                description: "Receive food and deliver to the needful",
                selected: selectedRole == "Receiver",
                onTap: isLoading ? null : () => setState(() => selectedRole = "Receiver"),
              ),
              const SizedBox(height: 16),

              // Volunteer Option
              RoleOption(
                title: "Volunteer",
                description: "Help in delivery of food",
                selected: selectedRole == "Volunteer",
                onTap: isLoading ? null : () => setState(() => selectedRole = "Volunteer"),
              ),
              const SizedBox(height: 60),

              // Continue Button
              ElevatedButton(
                onPressed: isLoading ? null : onContinue,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColor.green,
                  disabledBackgroundColor: AppColor.green.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: isLoading
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
                    : const Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}