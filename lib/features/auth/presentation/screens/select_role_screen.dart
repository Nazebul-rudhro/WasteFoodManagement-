// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// import '../../../home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
// import 'custom_title_select_profile.dart';
// import 'dynamic_screen_wrapper.dart';
// import 'role_option.dart';
//
// class RoleSelectionScreen extends StatefulWidget {
//   const RoleSelectionScreen({super.key});
//
//   static const String routeName = '/selected_profile';
//
//   @override
//   State<RoleSelectionScreen> createState() => SelectProfileState();
// }
//
// class SelectProfileState extends State<RoleSelectionScreen> {
//   String? selectedRole; // Holds the currently selected role
//   bool isLoading = false;
//
//   /// Continue button pressed
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
//       final uid = FirebaseAuth.instance.currentUser!.uid;
//
//       // Firestore এ role save করা
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(uid)
//           .set({"role": selectedRole!.toLowerCase()}, SetOptions(merge: true));
//
//       // Role অনুযায়ী navigate করা
//       if (selectedRole == "Donor") {
//         Navigator.pushReplacementNamed(context, "/donor");
//       } else if (selectedRole == "Receiver") {
//         Navigator.pushReplacementNamed(context, "/receiver");
//       } else if (selectedRole == "Volunteer") {
//         Navigator.pushReplacementNamed(context, "/volunteer");
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: DynamicScreenWrapper(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: screenHeight * 0.01),
//
//             const CustomTitleSelectProfile(
//               title: "Want to Share food?",
//               description:
//               "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
//             ),
//
//             SizedBox(height: screenHeight * 0.03),
//
//             // Role Options (Single Selection)
//             RoleOption(
//               title: "Donor",
//               description: "Donate some food to the needful",
//               selected: selectedRole == "Donor",
//               onTap: () => setState(() => selectedRole = "Donor"),
//             ),
//             RoleOption(
//               title: "Receiver",
//               description: "Pickup and deliver food to the needful",
//               selected: selectedRole == "Receiver",
//               onTap: () => setState(() => selectedRole = "Receiver"),
//             ),
//             RoleOption(
//               title: "Volunteer",
//               description: "Pickup and deliver food to the needful",
//               selected: selectedRole == "Volunteer",
//               onTap: () => setState(() => selectedRole = "Volunteer"),
//             ),
//
//             SizedBox(height: screenHeight * 0.05),
//
//             // Continue Button
//             ElevatedButton(
//               onPressed: isLoading ? null : onContinue,
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 backgroundColor: AppColor.primary,
//                 foregroundColor: AppColor.white,
//               ),
//               child: isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   color: AppColor.white,
//                   strokeWidth: 2,
//                 ),
//               )
//                   : const Text(
//                 "Continue",
//                 style:
//                 TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../sections/custom_title_select_profile.dart';
import '../sections/dynamic_screen_wrapper.dart';
import '../sections/role_option.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});
  static const String routeName = '/selected_profile';

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}



class _RoleSelectionScreenState extends State<RoleSelectionScreen> {





  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    debugPrint("LOGIN USER: ${user?.email}");
  }

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User not found")),
        );
        return;
      }

      final uid = user.uid;

      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({"role": selectedRole!.toLowerCase()}, SetOptions(merge: true));

      if (selectedRole == "Donor") {
        Navigator.pushReplacementNamed(context, "/donor");
      } else if (selectedRole == "Receiver") {
        Navigator.pushReplacementNamed(context, "/receiver");
      } else if (selectedRole == "Volunteer") {
        Navigator.pushReplacementNamed(context, "/volunteer");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
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
              title: "Choose your role",
              description: "Select one role to continue",
            ),

            SizedBox(height: screenHeight * 0.03),

            RoleOption(
              title: "Donor",
              description: "Donate food to the needful",
              selected: selectedRole == "Donor",
              onTap: () => setState(() => selectedRole = "Donor"),
            ),
            RoleOption(
              title: "Receiver",
              description: "Receive food and deliver to the needful",
              selected: selectedRole == "Receiver",
              onTap: () => setState(() => selectedRole = "Receiver"),
            ),
            RoleOption(
              title: "Volunteer",
              description: "Help in delivery of food",
              selected: selectedRole == "Volunteer",
              onTap: () => setState(() => selectedRole = "Volunteer"),
            ),

            SizedBox(height: screenHeight * 0.05),

            ElevatedButton(
              onPressed: isLoading ? null : onContinue,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.white,
              ),
              child: isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: AppColor.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text(
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

