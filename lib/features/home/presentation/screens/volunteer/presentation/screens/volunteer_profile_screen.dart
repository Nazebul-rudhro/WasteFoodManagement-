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
import '../../../../sections/base_screen.dart';
import '../../../../sections/generic_profile_section.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {

  void _showRewards() {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final profile = authProvider.userData?['profile'] as Map<String, dynamic>? ?? {};
    final dynamic activityCount = profile['totalTasks'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AchievementRoadmapSheet(
        activityData: activityCount,
        title: "Volunteer Journey",
      ),
    );
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SettingsBottomSheet(),
    );
  }

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
    // ডার্ক মোড চেক
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<ProfileOptionItem> volunteerOptions = [
      ProfileOptionItem(
          title: "Personal Info",
          icon: Icons.person_outline,
          onTap: _showPersonalDetails
      ),
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
      // ProfileOptionItem(
      //     title: "Help & Support",
      //     icon: Icons.help_outline,
      //     onTap: () => _showSnackBar("Support feature coming soon!")
      // ),



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
      // backgroundColor এখন থিম অনুযায়ী চেঞ্জ হবে
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(
            child: GenericProfileWidget(
              options: volunteerOptions,
              onSignOut: _handleLogout,
            ),
          ),
        ),
      ),
    );
  }
}