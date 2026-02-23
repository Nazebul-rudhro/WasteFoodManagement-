// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
//
// // Import correctly
// import '../../../../../../auth/data/model/profile_option_model.dart';
// import '../../../../../../auth/presentation/screens/login_screen.dart';
// import '../../../../../../widgets/achievement_roadmap_screen.dart';
// import '../../../../../../widgets/user_info_dialog.dart';
// import '../../../../sections/Create_ngo_dialog.dart';
// import '../../../../sections/generic_profile_section.dart';
//
//
//
// class DonorProfileScreen extends StatefulWidget {
//   const DonorProfileScreen({super.key});
//
//   @override
//   State<DonorProfileScreen> createState() => _DonorProfileScreenState();
// }
//
// class _DonorProfileScreenState extends State<DonorProfileScreen> {
//
//   /// 🔹 Rewards & Achievements Dialog (Universal Roadmap)
//   void _showRewards() {
//     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
//     final profile = authProvider.userData?['profile'] as Map<String, dynamic>? ?? {};
//
//     // 🔹 Donor এর জন্য 'totalDonations' বা 'totalTasks' চেক করা হচ্ছে
//     final dynamic activityCount = profile['totalDonations'] ?? profile['totalTasks'] ?? 0;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => AchievementRoadmapSheet(
//         activityData: activityCount,
//         title: "Donor Achievement Journey",
//       ),
//     );
//   }
//
//   /// 🔹 Personal Info Fetcher & Dialog Caller
//   Future<void> _showPersonalDetails() async {
//     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
//     final String? uid = authProvider.user?.uid;
//
//     if (uid == null) return;
//
//     _showLoading();
//
//     try {
//       final userDoc = await FirebaseFirestore.instance
//           .collection('accounts')
//           .doc(uid)
//           .get();
//
//       if (!mounted) return;
//       _hideLoading();
//
//       if (userDoc.exists && userDoc.data() != null) {
//         showDialog(
//           context: context,
//           builder: (context) => UserInfoDialog(data: userDoc.data()!),
//         );
//       }
//     } catch (e) {
//       if (!mounted) return;
//       _hideLoading();
//       _showSnackBar("Failed to load profile data");
//     }
//   }
//
//   /// 🔹 Show blocking loading dialog
//   void _showLoading() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       useRootNavigator: true,
//       builder: (_) => PopScope(
//         canPop: false,
//         child: const Center(
//           child: CircularProgressIndicator(
//             color: Colors.green,
//             strokeWidth: 4,
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 Hide loading dialog safely
//   void _hideLoading() {
//     if (Navigator.of(context, rootNavigator: true).canPop()) {
//       Navigator.of(context, rootNavigator: true).pop();
//     }
//   }
//
//   void _showSnackBar(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
//     );
//   }
//
//   /// 🔹 Logout handler
//   Future<void> _handleLogout() async {
//     _showLoading();
//     try {
//       final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//       await Future.delayed(const Duration(milliseconds: 800));
//       await auth.logout();
//       if (!mounted) return;
//       _hideLoading();
//       AppRoutes.pushAndRemoveUntil(context, LoginScreen.routeName);
//     } catch (e) {
//       if (!mounted) return;
//       _hideLoading();
//       _showSnackBar("Logout failed. Please try again.");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     /// 🔹 Donor specific profile options
//     final List<ProfileOptionItem> donorOptions = [
//       ProfileOptionItem(
//         title: "Personal Info",
//         icon: Icons.person_outline,
//         onTap: _showPersonalDetails,
//       ),
//       ProfileOptionItem(
//         title: "Create NGO",
//         icon: Icons.volunteer_activism_outlined,
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (_) => const CreateNgoDialog(),
//           );
//         },
//       ),
//       ProfileOptionItem(
//         title: "Rewards & Achievement",
//         icon: Icons.emoji_events_outlined,
//         onTap: _showRewards, // 👈 eikhane function call kora hoyeche
//       ),
//       ProfileOptionItem(
//         title: "Community",
//         icon: Icons.groups_outlined,
//         onTap: () {},
//       ),
//       ProfileOptionItem(
//         title: "Settings",
//         icon: Icons.settings_outlined,
//         onTap: () {},
//       ),
//       ProfileOptionItem(
//         title: "Help & Support",
//         icon: Icons.help_outline,
//         onTap: () {},
//       ),
//     ];
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: BaseScreen(
//             child: GenericProfileWidget(
//               options: donorOptions,
//               onSignOut: _handleLogout,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../app/app_routes.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/profile_option_model.dart';
import '../../../../../../auth/presentation/screens/login_screen.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';

import '../../../../../../widgets/achievement_roadmap_screen.dart';
import '../../../../../../widgets/support_screen.dart';
import '../../../../../../widgets/user_info_dialog.dart';
import '../../../../../../widgets/settings_bottom_sheet.dart';
import '../../../../sections/Create_ngo_dialog.dart'; // Donor specific
import '../../../../sections/base_screen.dart';
import '../../../../sections/generic_profile_section.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {

  // --- Rewards & Achievements (Mapped to Donor Activity) ---
  void _showRewards() {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final profile = authProvider.userData?['profile'] as Map<String, dynamic>? ?? {};

    // Using totalDonations for Donor Journey roadmap
    final dynamic activityCount = profile['totalDonations'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AchievementRoadmapSheet(
        activityData: activityCount,
        title: "Donor Journey",
      ),
    );
  }

  // --- Settings Bottom Sheet ---
  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsBottomSheet(),
    );
  }

  // --- Personal Info Logic ---
  Future<void> _showPersonalDetails() async {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final String? uid = authProvider.user?.uid;
    if (uid == null) return;

    _showLoading();
    try {
      final userDoc = await FirebaseFirestore.instance.collection('accounts').doc(uid).get();
      if (!mounted) return;
      _hideLoading();

      if (userDoc.exists && userDoc.data() != null) {
        showDialog(
            context: context,
            builder: (context) => UserInfoDialog(data: userDoc.data()!)
        );
      } else {
        _showSnackBar("Profile data not found.");
      }
    } catch (e) {
      if (!mounted) return;
      _hideLoading();
      _showSnackBar("Error loading profile");
    }
  }

  // --- Logout Logic ---
  Future<void> _handleLogout() async {
    _showLoading();
    try {
      final auth = Provider.of<GenericAuthProvider>(context, listen: false);
      await auth.logout();
      if (!mounted) return;
      _hideLoading();
      AppRoutes.pushAndRemoveUntil(context, LoginScreen.routeName);
    } catch (e) {
      if (!mounted) return;
      _hideLoading();
      _showSnackBar("Logout failed.");
    }
  }

  // --- Utility Functions ---
  void _showLoading() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
            child: CircularProgressIndicator(color: AppColor.primary)
        )
    );
  }

  void _hideLoading() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(msg),
            backgroundColor: AppColor.gray,
            behavior: SnackBarBehavior.floating
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Defines the donor options list
    final List<ProfileOptionItem> donorOptions = [
      ProfileOptionItem(
          title: "Personal Info",
          icon: Icons.person_outline,
          onTap: _showPersonalDetails
      ),
      // ProfileOptionItem(
      //   title: "Create NGO",
      //   icon: Icons.volunteer_activism_outlined,
      //   onTap: () {
      //     showDialog(
      //       context: context,
      //       builder: (_) => const CreateNgoDialog(),
      //     );
      //   },
      // ),
      ProfileOptionItem(
          title: "Rewards & Achievement",
          icon: Icons.emoji_events_outlined,
          onTap: _showRewards
      ),
      ProfileOptionItem(
          title: "Settings",
          icon: Icons.settings_outlined,
          onTap: _showSettings
      ),
      ProfileOptionItem(
          title: "Help & Support",
          icon: Icons.help_outline,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SupportScreen())
            );
          }
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BaseScreen(
            child: GenericProfileWidget(
              options: donorOptions,
              onSignOut: _handleLogout,
            ),
          ),
        ),
      ),
    );
  }
}