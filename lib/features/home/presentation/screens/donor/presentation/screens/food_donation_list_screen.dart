// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../../sections/generic_donation_list.dart';
//
// class FoodDonationListScreen extends StatelessWidget {
//   const FoodDonationListScreen({super.key});
//   static const String routeName = "/Food-Donation-List";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: const Text(
//           "Food Donation List",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: AppColor.soft_green,
//         elevation: 2,
//       ),
//       body: SafeArea(child: GenericDonorList()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../../sections/generic_donation_list.dart';

class FoodDonationListScreen extends StatelessWidget {
  const FoodDonationListScreen({super.key});
  static const String routeName = "/Food-Donation-List";

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক করার জন্য
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // ব্যাকগ্রাউন্ড কালার অ্যাডাপ্টিভ করা হয়েছে
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded, // একটু আধুনিক আইকন ব্যবহার করা হয়েছে
            color: isDark ? AppColor.white : Colors.black87,
            size: 20,
          ),
        ),
        title: Text(
          "Food Donation List",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColor.white : Colors.black87,
          ),
        ),
        // AppBar ব্যাকগ্রাউন্ড ডার্ক মোডে ডার্ক গ্রে এবং লাইট মোডে সফট গ্রিন
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
        elevation: isDark ? 0 : 2, // ডার্ক মোডে ফ্ল্যাট ডিজাইন
        centerTitle: true, // টাইটেলটি মাঝখানে রাখা হয়েছে প্রফেশনাল লুকের জন্য
      ),
      body: const SafeArea(
        child: GenericDonorList(),
      ),
    );
  }
}