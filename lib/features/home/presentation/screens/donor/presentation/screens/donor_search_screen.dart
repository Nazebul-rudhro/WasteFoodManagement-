import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

class DonorSearchScreen extends StatefulWidget{
  @override
  State<DonorSearchScreen> createState()=> _DonorSearchScreenState();

}

class _DonorSearchScreenState  extends State<DonorSearchScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BaseScreen(child: Center(child: Text("Coming Soon", style: TextStyle(color: AppColor.mediumtgray),),)),);
  }
}