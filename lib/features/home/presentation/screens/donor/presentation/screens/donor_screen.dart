import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return GenericMainScreen(
      pages: [
        DonorHomeScreen(),
        DonorSearchScreen(),
        DonorMessageScreen(),
        DonorProfileScreen(),
      ],
      navItems: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: "Message",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
