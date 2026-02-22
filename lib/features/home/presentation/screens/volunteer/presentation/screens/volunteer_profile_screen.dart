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



class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {

  /// 🔹 রিওয়ার্ড এবং মাইলস্টোন দেখানোর ফাংশন (Universal & Error-Free)
  void _showRewards() {
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final profile = authProvider.userData?['profile'] as Map<String, dynamic>? ?? {};

    // ডাটাবেজে নাম না থাকলেও ?? 0 এর কারণে ক্র্যাশ করবে না
    // Volunteer এর জন্য 'totalTasks', Receiver এর জন্য 'totalReceives' ইত্যাদি
    final dynamic activityCount = profile['totalTasks'] ?? profile['totalReceives'] ?? profile['totalDonations'] ?? 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AchievementRoadmapSheet(
        activityData: activityCount,
        title: "Volunteer Journey", // তুমি চাইলে ডাইনামিক টাইটেল দিতে পারো
      ),
    );
  }

  /// 🔹 পার্সোনাল ইনফো ডায়ালগ
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
        showDialog(context: context, builder: (context) => UserInfoDialog(data: userDoc.data()!));
      } else {
        _showSnackBar("Profile not found.");
      }
    } catch (e) {
      if (!mounted) return;
      _hideLoading();
      _showSnackBar("Error loading profile");
    }
  }

  /// 🔹 ইউটিলিটি এবং হেল্পার ফাংশন
  void _showLoading() {
    showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: Colors.green)));
  }

  void _hideLoading() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
  }

  /// 🔹 লগআউট হ্যান্ডলার
  Future<void> _handleLogout() async {
    _showLoading();
    final auth = Provider.of<GenericAuthProvider>(context, listen: false);
    await auth.logout();
    if (!mounted) return;
    _hideLoading();
    AppRoutes.pushAndRemoveUntil(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final List<ProfileOptionItem> volunteerOptions = [
      ProfileOptionItem(title: "Personal Info", icon: Icons.person_outline, onTap: _showPersonalDetails),
      ProfileOptionItem(title: "Rewards & Achievement", icon: Icons.emoji_events_outlined, onTap: _showRewards),
      // ProfileOptionItem(title: "Community", icon: Icons.groups_outlined, onTap: () {}),
      ProfileOptionItem(title: "Settings", icon: Icons.settings_outlined, onTap: () {}),
      ProfileOptionItem(title: "Help & Support", icon: Icons.help_outline, onTap: () {}),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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