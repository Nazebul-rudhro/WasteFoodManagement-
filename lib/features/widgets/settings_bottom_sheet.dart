// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../app/app_theme.dart';
// import '../../core/constants/app_colors.dart';
// import '../auth/provider/theme_notifier.dart';
//
// class SettingsBottomSheet extends StatelessWidget {
//   const SettingsBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = context.watch<ThemeNotifier>();
//     final isDark = themeNotifier.isDark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // ড্র্যাগ বার
//           Container(
//             width: 45, height: 5,
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: AppColor.lightGray,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//
//           Text(
//               "Settings",
//               style: AppData.heading1.copyWith(
//                   color: isDark ? AppColor.white : AppColor.black,
//                   fontSize: 22
//               )
//           ),
//           const SizedBox(height: 20),
//
//           // ডার্ক মোড সুইচ (AppColor.primary এবং soft_green এর টাচ)
//           _buildTile(
//             context,
//             icon: isDark ? Icons.dark_mode : Icons.light_mode,
//             title: "Dark Appearance",
//             iconBgColor: AppColor.soft_green, // আপনার soft_green ব্যবহার করা হয়েছে
//             iconColor: AppColor.green,       // আপনার green ব্যবহার করা হয়েছে
//             trailing: Switch.adaptive(
//               value: isDark,
//               activeColor: AppColor.primary,
//               onChanged: (val) => themeNotifier.toggleTheme(val),
//             ),
//           ),
//
//           const Divider(height: 25, thickness: 0.5),
//
//           // ডিলিট অ্যাকাউন্ট (AppColor.red ব্যবহার করে)
//           _buildTile(
//             context,
//             icon: Icons.delete_forever_outlined,
//             title: "Delete Account",
//             iconBgColor: const Color(0xFFFFEBEE), // হালকা লাল শেড
//             iconColor: AppColor.red,             // আপনার red ব্যবহার করা হয়েছে
//             titleColor: AppColor.red,
//             onTap: () => _confirmDelete(context),
//           ),
//
//           const SizedBox(height: 15),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTile(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required Color iconBgColor,
//         required Color iconColor,
//         Color? titleColor,
//         Widget? trailing,
//         VoidCallback? onTap,
//       }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return ListTile(
//       onTap: onTap,
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: iconBgColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(icon, color: iconColor, size: 22),
//       ),
//       title: Text(
//           title,
//           style: AppData.heading2.copyWith(
//               fontSize: 16,
//               color: titleColor ?? (isDark ? AppColor.white : AppColor.black)
//           )
//       ),
//       trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColor.mediumtgray),
//     );
//   }
//
//   void _confirmDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: const Text("Are you sure?"),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context),
//             style: ElevatedButton.styleFrom(backgroundColor: AppColor.red),
//             child: const Text("Delete", style: TextStyle(color: AppColor.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }


//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../app/app_theme.dart';
// import '../../core/constants/app_colors.dart';
// import '../auth/provider/theme_notifier.dart';
//
// class SettingsBottomSheet extends StatelessWidget {
//   const SettingsBottomSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = context.watch<ThemeNotifier>();
//     final isDark = themeNotifier.isDark;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // ড্র্যাগ বার
//           Container(
//             width: 45, height: 5,
//             margin: const EdgeInsets.only(bottom: 20),
//             decoration: BoxDecoration(
//               color: AppColor.lightGray,
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//
//           Text(
//               "Settings",
//               style: AppData.heading1.copyWith(
//                   color: isDark ? AppColor.white : AppColor.black,
//                   fontSize: 22
//               )
//           ),
//           const SizedBox(height: 20),
//
//           // ডার্ক মোড সুইচ
//           _buildTile(
//             context,
//             icon: isDark ? Icons.dark_mode : Icons.light_mode,
//             title: "Dark Appearance",
//             iconBgColor: AppColor.soft_green,
//             iconColor: AppColor.green,
//             trailing: Switch.adaptive(
//               value: isDark,
//               activeColor: AppColor.primary,
//               onChanged: (val) => themeNotifier.toggleTheme(val),
//             ),
//           ),
//
//           const Divider(height: 25, thickness: 0.5),
//
//           // ডিলিট অ্যাকাউন্ট
//           _buildTile(
//             context,
//             icon: Icons.delete_forever_outlined,
//             title: "Delete Account",
//             iconBgColor: const Color(0xFFFFEBEE),
//             iconColor: AppColor.red,
//             titleColor: AppColor.red,
//             onTap: () => _confirmDelete(context),
//           ),
//
//           const SizedBox(height: 15),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTile(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required Color iconBgColor,
//         required Color iconColor,
//         Color? titleColor,
//         Widget? trailing,
//         VoidCallback? onTap,
//       }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return ListTile(
//       onTap: onTap,
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: iconBgColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Icon(icon, color: iconColor, size: 22),
//       ),
//       title: Text(
//           title,
//           style: AppData.heading2.copyWith(
//               fontSize: 16,
//               color: titleColor ?? (isDark ? AppColor.white : AppColor.black)
//           )
//       ),
//       trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColor.mediumtgray),
//     );
//   }
//
//   // অ্যাকাউন্ট ডিলিট করার কনফার্মেশন ডায়ালগ
//   void _confirmDelete(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: const Text("Are you sure?"),
//         content: const Text(
//           "This will permanently delete your account. You will not be able to recover your data later.",
//           style: TextStyle(fontSize: 14),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext),
//             child: const Text("Cancel", style: TextStyle(color: AppColor.mediumtgray)),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(dialogContext); // ডায়ালগ বন্ধ করা
//               _handleDeleteAccount(context); // মেইন ডিলিট লজিক শুরু
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.red,
//               elevation: 0,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//             child: const Text("Delete", style: TextStyle(color: AppColor.white)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // মেইন ডিলিট লজিক
//   Future<void> _handleDeleteAccount(BuildContext context) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;
//
//     // লোডিং দেখানো
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator(color: AppColor.green)),
//     );
//
//     try {
//       final uid = user.uid;
//
//       // ১. Firestore থেকে ইউজার ডাটা ডিলিট করা
//       await FirebaseFirestore.instance.collection('accounts').doc(uid).delete();
//
//       // ২. Firebase Authentication থেকে ইউজার ডিলিট করা
//       await user.delete();
//
//       if (context.mounted) {
//         Navigator.pop(context); // লোডিং বন্ধ করা
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Account deleted successfully")),
//         );
//         // লগইন বা ওয়েলকাম স্ক্রিনে নিয়ে যাওয়া
//         Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//       }
//     } on FirebaseAuthException catch (e) {
//       if (context.mounted) Navigator.pop(context); // লোডিং বন্ধ করা
//
//       if (e.code == 'requires-recent-login') {
//         _showError(context, "Please logout and login again to verify your identity before deleting account.");
//       } else {
//         _showError(context, e.message ?? "Something went wrong.");
//       }
//     } catch (e) {
//       if (context.mounted) Navigator.pop(context);
//       _showError(context, "Error: $e");
//     }
//   }
//
//   void _showError(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: AppColor.red),
//     );
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app/app_theme.dart';
import '../../core/constants/app_colors.dart';
import '../auth/provider/theme_notifier.dart';

class SettingsBottomSheet extends StatelessWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ThemeNotifier>();
    final isDark = themeNotifier.isDark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45, height: 5,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: AppColor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            "Settings",
            style: AppData.heading1.copyWith(
              color: isDark ? AppColor.white : AppColor.black,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          _buildTile(
            context,
            icon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: "Dark Appearance",
            iconBgColor: AppColor.soft_green,
            iconColor: AppColor.green,
            trailing: Switch.adaptive(
              value: isDark,
              activeColor: AppColor.primary,
              onChanged: (val) => themeNotifier.toggleTheme(val),
            ),
          ),
          const Divider(height: 25, thickness: 0.5),
          _buildTile(
            context,
            icon: Icons.delete_forever_outlined,
            title: "Delete Account",
            iconBgColor: const Color(0xFFFFEBEE),
            iconColor: AppColor.red,
            titleColor: AppColor.red,
            onTap: () => _confirmDelete(context),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, {required IconData icon, required String title, required Color iconBgColor, required Color iconColor, Color? titleColor, Widget? trailing, VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(title, style: AppData.heading2.copyWith(fontSize: 16, color: titleColor ?? (isDark ? AppColor.white : AppColor.black))),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: AppColor.mediumtgray),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Confirm Deletion"),
        content: const Text("This will permanently remove your email from our login system. You will NOT be able to log back in."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text("Cancel")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.red),
            onPressed: () {
              Navigator.pop(dialogContext);
              _handleAbsoluteDeletion(context);
            },
            child: const Text("Delete Permanently", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<void> _handleAbsoluteDeletion(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: AppColor.green)),
    );

    try {
      final String uid = user.uid;

      // 1. Delete from Firestore first
      await FirebaseFirestore.instance.collection('accounts').doc(uid).delete();

      // 2. Delete from Firebase Authentication (The important part!)
      await user.delete();

      // 3. Clear the local session
      await FirebaseAuth.instance.signOut();

      if (context.mounted) {
        Navigator.pop(context); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account destroyed successfully.")));

        // Go to login screen and clear all history
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) Navigator.pop(context);

      if (e.code == 'requires-recent-login') {
        // This is a SECURITY FEATURE.
        // If this happens, the ONLY professional way is to force logout.
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Security timeout. Please log in again to delete."))
        );
        await FirebaseAuth.instance.signOut();
        if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        _showError(context, e.message ?? "Error occurred.");
      }
    } catch (e) {
      if (context.mounted) Navigator.pop(context);
      _showError(context, "System Error: $e");
    }
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: AppColor.red));
  }
}