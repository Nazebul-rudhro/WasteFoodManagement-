import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';

import '../../../../core/constants/widgets/homescreen_info_card.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomePageScreen> createState() => HomePageState();
}

class HomePageState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Column(
        children: [
          // Header part
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Greeting Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi Mandeep", style: AppTheme.heading3),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "You are a ", style: AppTheme.heading2),
                        TextSpan(
                          text: "Donar",
                          style: AppTheme.heading2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Notification Badge
              Badge(
                label: const Text("1", style: TextStyle(color: Colors.white)),
                child: const Icon(Icons.notifications),
              ),
            ],
          ),

          // Gap
          SizedBox(height: screenHeight * 0.01), // 2% of screen height

          Row(
            children: [
              // card 1
              Expanded(child: HomeScreenInfoCart(title: 'Donations', value: 500,color: Colors.white.withOpacity(0.6))),
            //   card 2
              Expanded(child: HomeScreenInfoCart(title: "Feedback", value: 500, color: AppTheme.primaryColor.withOpacity(0.6),)),
            //   card 3
              Expanded(child: HomeScreenInfoCart(title: "Points earned", value: 1000, color: Colors.white.withOpacity(0.6)))
            ],
          )
        ],
      ),
    );
  }
}


