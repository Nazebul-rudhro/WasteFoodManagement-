import 'package:flutter/material.dart';

class GenericMainScreen extends StatefulWidget {
    static const routeName = '/main_screen';
  final List<Widget> pages;
  final List<BottomNavigationBarItem> navItems;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widget.pages[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade200,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: widget.navItems,
      ),
    );
  }
}
