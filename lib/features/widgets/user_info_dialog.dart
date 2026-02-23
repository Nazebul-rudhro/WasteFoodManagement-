import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart'; // আপনার প্রোজেক্টের পাথ অনুযায়ী ইমপোর্ট করুন

class UserInfoDialog extends StatelessWidget {
  final Map<String, dynamic> data;

  const UserInfoDialog({super.key, required this.data});

  /// 🔹 Helper function to capitalize only the first letter
  String _capitalizeFirstLetter(dynamic value) {
    String text = value?.toString() ?? "";
    if (text.isEmpty) return "Not Provided";
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // Firestore structure অনুযায়ী 'profile' map বের করা
    final profile = data['profile'] as Map<String, dynamic>? ?? {};

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColor.green, // আপনার Emerald Green
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const Row(
          children: [
            Icon(Icons.badge_outlined, color: AppColor.white, size: 28),
            SizedBox(width: 10),
            Text(
                "Personal Info",
                style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold)
            ),
          ],
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoTile(
                  context,
                  Icons.category_outlined,
                  "User Role",
                  _capitalizeFirstLetter(profile['role'])
              ),
              _infoTile(
                  context,
                  Icons.person_outline,
                  "Name",
                  profile['contactPerson']?.toString().toUpperCase()
              ),
              _infoTile(context, Icons.email_outlined, "Email Address", profile['email']),
              _infoTile(context, Icons.phone_android_outlined, "Phone Number", profile['phone']),
              _infoTile(context, Icons.location_city_outlined, "City", profile['city']),
              _infoTile(context, Icons.map_outlined, "Full Address", profile['address']),
              _infoTile(context, Icons.pin_drop_outlined, "Post Code", profile['postCode']),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
              "CLOSE",
              style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)
          ),
        ),
      ],
    );
  }

  Widget _infoTile(BuildContext context, IconData icon, String label, dynamic value) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColor.green.withOpacity(0.1),
        child: Icon(icon, color: AppColor.green, size: 20),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
          label,
          style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColor.mediumtgray : AppColor.gray,
              letterSpacing: 0.5
          )
      ),
      subtitle: Text(
        value?.toString() ?? "Not Provided",
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? AppColor.white : AppColor.black
        ),
      ),
    );
  }
}