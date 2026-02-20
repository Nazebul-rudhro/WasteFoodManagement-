import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

class VolunteerSearchScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return VolunteerSearchScreenState();
  }

}

class VolunteerSearchScreenState  extends State<VolunteerSearchScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreen(child: Center(child: Text("Coming Soon.....", style: TextStyle(color: Colors.grey),),)),
    );
  }
}