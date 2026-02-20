import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

class VolunteerMessageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return VolunteerMessageScreenState();
  }
}

class VolunteerMessageScreenState  extends State<VolunteerMessageScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreen(child: Center(child: Text("Coming Soon.....", style: TextStyle(color: Colors.grey),),)),
    );
  }
}
