import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

class VolunteerNotificationSection extends StatelessWidget{
  static String routeName = '/volunteer-notification';

  const VolunteerNotificationSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreen(child: Center(child: Text("data"),) ),
    );
  }
  
}