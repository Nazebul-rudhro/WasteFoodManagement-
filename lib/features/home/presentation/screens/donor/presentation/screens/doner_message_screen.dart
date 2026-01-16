import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

import '../../../../sections/chat_screen_section.dart';

class DonorMessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DonorMessageScreenState();
}

class _DonorMessageScreenState extends State<DonorMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreen(
        child: ChatScreen(),
      ),
    );
  }
}
