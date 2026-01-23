// import 'package:flutter/material.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_message_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_profile_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_search_screen.dart';
// import '../../../generic_main_screen.dart';
//
//
// class VolunteerScreen extends StatefulWidget {
//   static String routeName = "/volunteer-home";
//   const VolunteerScreen({Key? key}) : super(key: key);
//
//   @override
//   State<VolunteerScreen> createState() => _VolunteerScreenState();
// }
//
// class _VolunteerScreenState extends State<VolunteerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GenericMainScreen(
//       pages: [
//         VolunteerHomeScreen(),
//         VolunteerSearchScreen(),
//         VolunteerMessageScreen(),
//         VolunteerProfileScreen(),
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
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_message_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_profile_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_search_screen.dart';
import '../../../generic_main_screen.dart';

class VolunteerScreen extends StatefulWidget {
  static String routeName = "/volunteer-home";
  const VolunteerScreen({Key? key}) : super(key: key);

  @override
  State<VolunteerScreen> createState() => _VolunteerScreenState();
}

class _VolunteerScreenState extends State<VolunteerScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericMainScreen(
      pages: [
        const VolunteerHomeScreen(),
        VolunteerSearchScreen(),
        VolunteerMessageScreen(),
        VolunteerProfileScreen(),
      ],
      navItems: [
        // CurvedNavigationBarItem ব্যবহার করা হয়েছে প্রফেশনাল কার্ভ লুকের জন্য
        CurvedNavigationBarItem(
          child: const Icon(Icons.home_outlined),
          label: "Home",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.explore_outlined), // ভলান্টিয়ারদের জন্য Explore আইকনটি ভালো মানায়
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