// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// class GenericMainScreen extends StatefulWidget {
//     static const routeName = '/main_screen';
//   final List<Widget> pages;
//   final List<BottomNavigationBarItem> navItems;
//   const GenericMainScreen({
//     super.key,
//     required this.pages,
//     required this.navItems,
//   });
//
//   @override
//   State<GenericMainScreen> createState() => _GenericMainScreenState();
// }
//
// class _GenericMainScreenState extends State<GenericMainScreen> {
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: widget.pages[currentIndex],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) => setState(() => currentIndex = index),
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.grey.shade200,
//         selectedItemColor: AppColor.green,
//         unselectedItemColor: Colors.grey,
//         items: widget.navItems,
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// class GenericMainScreen extends StatefulWidget {
//   static const routeName = '/main_screen';
//   final List<Widget> pages;
//   final List<BottomNavigationBarItem> navItems;
//
//   const GenericMainScreen({
//     super.key,
//     required this.pages,
//     required this.navItems,
//   });
//
//   @override
//   State<GenericMainScreen> createState() => _GenericMainScreenState();
// }
//
// class _GenericMainScreenState extends State<GenericMainScreen> {
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.pages[currentIndex],
//
//       // নিচের পার্টটুকু খেয়াল করুন
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: currentIndex,
//           onTap: (index) => setState(() => currentIndex = index),
//           type: BottomNavigationBarType.fixed,
//
//           // 🔹 কালার ম্যাচিং পরিবর্তন
//           backgroundColor: AppColor.white, // ব্যাকগ্রাউন্ড সাদা রাখলে গ্রিন বেশি ফুটে ওঠে
//           selectedItemColor: AppColor.green, // মেইন গ্রিন
//           unselectedItemColor: AppColor.lightGreen, // হালকা গ্রে
//
//           // 🔹 টেক্সট স্টাইল
//           selectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 12,
//           ),
//           unselectedLabelStyle: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 11,
//           ),
//
//           // 🔹 আইকন সাইজ
//           selectedIconTheme: const IconThemeData(size: 28),
//           unselectedIconTheme: const IconThemeData(size: 24),
//
//           showUnselectedLabels: true,
//           items: widget.navItems,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class GenericMainScreen extends StatefulWidget {
  static const routeName = '/main_screen';
  final List<Widget> pages;
  final List<CurvedNavigationBarItem> navItems;

  const GenericMainScreen({
    super.key,
    required this.pages,
    required this.navItems,
  });

  @override
  State<GenericMainScreen> createState() => _GenericMainScreenState();
}

class _GenericMainScreenState extends State<GenericMainScreen> {
  int currentIndex = 0;

  // আপনার দেওয়া Emerald Green কালার
  // final Color emeraldGreen = const Color(0xFF2ECC71);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // বডিকে নেভিগেশন বারের নিচে নিয়ে যাবে যাতে কার্ভটি সুন্দরভাবে ভেসে থাকে
      extendBody: true,
      body: widget.pages[currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        // height: 70, // হাইট সামান্য বাড়িয়ে স্মুথ করা হয়েছে
        items: widget.navItems,


        color: Colors.white, // বারের ব্যাকগ্রাউন্ড
        buttonBackgroundColor: AppColor.lightGreen, // সিলেক্টেড আইকনের গোল ব্যাকগ্রাউন্ড
        backgroundColor: AppColor.green, // বারের বাইরের ট্রান্সপারেন্ট অংশ

        // 🔹 এনিমেশন আরও স্মুথ করার জন্য:
        // animationCurve: Curves.easeInOut, // কার্ভটি একটু বাউন্স করে যাবে যা দেখতে প্রিমিয়াম লাগে
        animationCurve: Curves.easeInOutQuart, // কার্ভটি একটু বাউন্স করে যাবে যা দেখতে প্রিমিয়াম লাগে
        animationDuration: const Duration(milliseconds: 600), // স্পিড মিডিয়াম রাখা হয়েছে

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}