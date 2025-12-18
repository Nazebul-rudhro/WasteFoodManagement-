import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/screens/home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/message_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/profile_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/search_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  // ৪টি পেজের লিস্ট
  final List<Widget> pages = [
    HomePageScreen(),
    SearchScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Dynamic body
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: pages[currentIndex]),
        ),


      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: AppColor.lightGray,       // Background color
        selectedItemColor: AppColor.black,       // Active icon color
        unselectedItemColor: Colors.grey,          // Inactive icon color
        type: BottomNavigationBarType.fixed,       // Fixed type
        items: const [
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
      ),
    );
  }
}
