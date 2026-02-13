import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../../sections/generic_donation_list.dart';

class FoodDonationListScreen extends StatelessWidget {
  const FoodDonationListScreen({super.key});
  static const String routeName = "/Food-Donation-List";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Food Donation List",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.soft_green,
        elevation: 2,
      ),
      body: SafeArea(child: GenericDonorList()),
    );
  }
}