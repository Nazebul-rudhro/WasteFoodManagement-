// import 'package:flutter/material.dart';
//
// import '../../../generic_main_screen.dart';
// import 'doner_message_screen.dart';
// import 'donor_home_screen.dart';
// import 'donor_profile_screen.dart';
// import 'donor_search_screen.dart';
//
// class DonorScreen extends StatefulWidget {
//   static String routeName = "doner-home";
//   const DonorScreen({Key? key}) : super(key: key);
//
//   @override
//   State<DonorScreen> createState() => _DonorScreenState();
// }
//
// class _DonorScreenState extends State<DonorScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GenericMainScreen(
//       pages: [
//         DonorHomeScreen(),
//         DonorSearchScreen(),
//         DonorMessageScreen(),
//         DonorProfileScreen(),
//       ],
//       navItems: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: "Search",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.message),
//           label: "Message",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: "Profile",
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:waste_food_management/core/constants/app_colors.dart'; // নিশ্চিত করুন এখানে AppColor.green আছে

import '../../../generic_main_screen.dart';
import 'doner_message_screen.dart';
import 'donor_home_screen.dart';
import 'donor_profile_screen.dart';
import 'donor_search_screen.dart';

class DonorScreen extends StatefulWidget {
  static String routeName = "doner-home";
  const DonorScreen({Key? key}) : super(key: key);

  @override
  State<DonorScreen> createState() => _DonorScreenState();
}

class _DonorScreenState extends State<DonorScreen> {
  // আপনার পছন্দের গ্রিন কালার
  final Color emeraldGreen = const Color(0xFF2ECC71);

  @override
  Widget build(BuildContext context) {
    return GenericMainScreen(
      pages:  [
        DonorHomeScreen(),
        DonorSearchScreen(),
        DonorMessageScreen(),
        DonorProfileScreen(),
      ],
      navItems: [
        // এখানে CurvedNavigationBarItem ব্যবহার করা হয়েছে
        CurvedNavigationBarItem(
          child:  Icon(Icons.home_outlined,),
          label: "Home",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.search),
          label: "Search",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.chat_bubble_outline),
          label: "Message",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.person_outline),
          label: "Profile",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ],
    );
  }
}
