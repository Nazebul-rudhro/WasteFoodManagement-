// import 'package:flutter/material.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_message_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_profile_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_search_screen.dart';
//
// import '../../../generic_main_screen.dart';
//
//
// class ReceiverScreen extends StatefulWidget {
//   static String routeName = "/reciver-home";
//   const ReceiverScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ReceiverScreen> createState() => _ReceiverScreenState();
// }
//
// class _ReceiverScreenState extends State<ReceiverScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return GenericMainScreen(
//       pages: [
//         ReceiverHomeScreen(),
//         ReceiverSearchScreen(),
//         ReceiverMessageScreen(),
//         ReceiverProfileScreen(),
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
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_message_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_profile_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_search_screen.dart';

import '../../../generic_main_screen.dart';

class ReceiverScreen extends StatefulWidget {
  static String routeName = "/reciver-home";
  const ReceiverScreen({Key? key}) : super(key: key);

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericMainScreen(
      pages:  [
        ReceiverHomeScreen(),
        ReceiverSearchScreen(),
        ReceiverMessageScreen(),
        ReceiverProfileScreen(),
      ],
      navItems: [
        // CurvedNavigationBarItem ব্যবহার করা হয়েছে প্রফেশনাল কার্ভ লুকের জন্য
        CurvedNavigationBarItem(
          child: const Icon(Icons.home_outlined),
          label: "Home",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.search),
          label: "Search",
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        CurvedNavigationBarItem(
          child: const Icon(Icons.mail_outline), // মেসেজের জন্য একটু ভিন্ন আইকন ব্যবহার করা হয়েছে
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