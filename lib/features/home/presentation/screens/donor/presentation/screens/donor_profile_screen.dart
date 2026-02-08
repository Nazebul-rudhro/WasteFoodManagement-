// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../../../../../../auth/data/model/profile_option_model.dart';
// import '../../../../../../auth/presentation/screens/login_screen.dart';
// import '../../../../sections/generic_profile_section.dart';
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
//   /// 🔹 Show blocking loading dialog
//   void _showLoading() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       useRootNavigator: true,
//       builder: (_) => const WillPopScope(
//         onWillPop: _disableBack,
//         child: Center(
//           child: CircularProgressIndicator(
//             color: Colors.green,
//             strokeWidth: 4,
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Future<bool> _disableBack() async => false;
//
//   /// 🔹 Hide loading dialog safely
//   void _hideLoading() {
//     if (Navigator.of(context, rootNavigator: true).canPop()) {
//       Navigator.of(context, rootNavigator: true).pop();
//     }
//   }
//
//   /// 🔹 Logout handler
//   Future<void> _handleLogout() async {
//     _showLoading();
//
//     try {
//       final auth =
//       Provider.of<GenericAuthProvider>(context, listen: false);
//
//       await Future.delayed(const Duration(milliseconds: 800));
//       await auth.logout();
//
//       if (!mounted) return;
//
//       _hideLoading();
//
//       AppRoutes.pushNamedAndRemoveUntil(
//         context,
//         LoginScreen.routeName,
//             (_) => false,
//       );
//     } catch (e) {
//       if (!mounted) return;
//
//       _hideLoading();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Logout failed. Please try again."),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     /// 🔹 Donor specific profile options
//     final List<ProfileOptionItem> donorOptions = [
//       ProfileOptionItem(
//         title: "Personal Info",
//         icon: Icons.person_outline,
//         onTap: () {},
//       ),
//       ProfileOptionItem(
//         title: "Your Donations",
//         icon: Icons.volunteer_activism_outlined,
//         onTap: () {},
//       ),
//       ProfileOptionItem(
//         title: "Rewards & Achievement",
//         icon: Icons.emoji_events_outlined,
//         onTap: () {},
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../../../auth/data/model/profile_option_model.dart';
import '../../../../../../auth/presentation/screens/login_screen.dart';
import '../../../../sections/Create_ngo_dialog.dart';
import '../../../../sections/generic_profile_section.dart';

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  State<DonorProfileScreen> createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  /// 🔹 Show blocking loading dialog
  void _showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const WillPopScope(
        onWillPop: _disableBack,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
            strokeWidth: 4,
          ),
        ),
      ),
    );
  }

  static Future<bool> _disableBack() async => false;

  /// 🔹 Hide loading dialog safely
  void _hideLoading() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// 🔹 Logout handler with smooth navigation
  Future<void> _handleLogout() async {
    _showLoading();

    try {
      final auth = Provider.of<GenericAuthProvider>(context, listen: false);

      await Future.delayed(const Duration(milliseconds: 800));
      await auth.logout();

      if (!mounted) return;

      _hideLoading();

      // Smooth push and remove all previous routes
      AppRoutes.pushAndRemoveUntil(
        context,
        LoginScreen.routeName,
      );
    } catch (e) {
      if (!mounted) return;

      _hideLoading();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logout failed. Please try again."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 🔹 Donor specific profile options
    final List<ProfileOptionItem> donorOptions = [
      ProfileOptionItem(
        title: "Personal Info",
        icon: Icons.person_outline,
        onTap: () {},
      ),
      ProfileOptionItem(
        title: "Create NGO",
        icon: Icons.volunteer_activism_outlined,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => const CreateNgoDialog(),
          );
        },
      ),
      ProfileOptionItem(
        title: "Rewards & Achievement",
        icon: Icons.emoji_events_outlined,
        onTap: () {},
      ),
      ProfileOptionItem(
        title: "Community",
        icon: Icons.groups_outlined,
        onTap: () {},
      ),
      ProfileOptionItem(
        title: "Settings",
        icon: Icons.settings_outlined,
        onTap: () {},
      ),
      ProfileOptionItem(
        title: "Help & Support",
        icon: Icons.help_outline,
        onTap: () {},
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

