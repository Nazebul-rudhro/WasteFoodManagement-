import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../app/app_routes.dart';
import '../../../../../../auth/data/model/profile_option_model.dart';
import '../../../../../../auth/presentation/screens/login_screen.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../../../widgets/achievement_roadmap_screen.dart';
import '../../../../../../widgets/user_info_dialog.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/generic_profile_section.dart';


class ReceiverProfileScreen extends StatefulWidget {
  const ReceiverProfileScreen({super.key});

  @override
  State<ReceiverProfileScreen> createState() => _ReceiverProfileScreenState();
}

class _ReceiverProfileScreenState extends State<ReceiverProfileScreen> {

  // --- Rewards & Achievements Dialog ---
  void _showAchievements() {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final profile = authProvider.userData?['profile'] as Map<String, dynamic>? ?? {};

    // Receiver এর জন্য 'totalReceives' চেক করবে, না থাকলে ডিফল্ট ০
    final dynamic currentActivity = profile['totalReceives'] ?? profile['totalTasks'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AchievementRoadmapSheet(
        activityData: currentActivity,
        title: "Receiver Journey",
      ),
    );
  }

  // --- Personal Info Dialog ---
  Future<void> _showPersonalDetails() async {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final String? uid = authProvider.user?.uid;

    if (uid == null) {
      _showSnackBar("Session expired. Please login again.");
      return;
    }

    _showLoading();

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('accounts')
          .doc(uid)
          .get();

      if (!mounted) return;
      _hideLoading();

      if (userDoc.exists && userDoc.data() != null) {
        showDialog(
          context: context,
          builder: (context) => UserInfoDialog(data: userDoc.data()!),
        );
      } else {
        _showSnackBar("No profile data found.");
      }
    } catch (e) {
      if (!mounted) return;
      _hideLoading();
      _showSnackBar("Could not load data. Check internet connection.");
    }
  }

  // --- Utility Functions ---
  void _showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: true,
      builder: (_) => const Center(child: CircularProgressIndicator(color: Colors.green)),
    );
  }

  void _hideLoading() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
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

  @override
  Widget build(BuildContext context) {
    final List<ProfileOptionItem> receiverOptions = [
      ProfileOptionItem(title: "Personal Info", icon: Icons.person_outline, onTap: _showPersonalDetails),
      ProfileOptionItem(title: "Rewards & Achievement", icon: Icons.emoji_events_outlined, onTap: _showAchievements),
      ProfileOptionItem(title: "Community", icon: Icons.groups_outlined, onTap: () {}),
      ProfileOptionItem(title: "Settings", icon: Icons.settings_outlined, onTap: () {}),
      ProfileOptionItem(title: "Help & Support", icon: Icons.help_outline, onTap: () {}),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // ব্যাকগ্রাউন্ড কালার অ্যাড করা হলো
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(
            child: GenericProfileWidget(
              options: receiverOptions,
              onSignOut: _handleLogout,
            ),
          ),
        ),
      ),
    );
  }
}