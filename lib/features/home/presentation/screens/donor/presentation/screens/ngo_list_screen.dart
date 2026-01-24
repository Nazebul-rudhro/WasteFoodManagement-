import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../../sections/generic_ngo_list.dart';

class NgoListScreen extends StatelessWidget {
  const NgoListScreen({super.key});
  static const String routeName = "/ngo-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "List of NGOs",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.soft_green,
        elevation: 2,
      ),
      body: const SafeArea(child: GenericNGOList()),
    );
  }
}
