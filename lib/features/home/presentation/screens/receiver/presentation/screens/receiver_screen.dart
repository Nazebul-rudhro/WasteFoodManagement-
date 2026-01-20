import 'package:flutter/material.dart';
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
      pages: [
        ReceiverHomeScreen(),
        ReceiverSearchScreen(),
        ReceiverMessageScreen(),
        ReceiverProfileScreen(),
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
