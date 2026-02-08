import 'package:flutter/material.dart';
import '../../../auth/data/model/ngo_model.dart';
import '../widgets/ngo_card.dart';

class GenericNGOList extends StatelessWidget {
   GenericNGOList({super.key});

  final List<NGOModel> ngoList = [
    NGOModel(
      name: "Helping Hands",
      imageUrl: "assets/images/splash_screen/splashscreen_1.png",
      location: "Dhaka",
      foodRequirement: "20 people",
      pickupTime: "2 km",
    ),
    NGOModel(
      name: "Food For All",
      imageUrl: "assets/images/splash_screen/splashscreen_1.png",
      location: "Chittagong",
      foodRequirement: "15 people",
      pickupTime: "5 km",
    ),
    NGOModel(
      name: "Hope Foundation",
      imageUrl: "assets/images/splash_screen/splashscreen_1.png",
      location: "Sylhet",
      foodRequirement: "30 people",
      pickupTime: "10 km",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: ngoList.length,
      itemBuilder: (context, index) {
        final ngo = ngoList[index];
        return NGOCard(
          ngo: ngo,
          onViewDetails: () => print("View details ${ngo.name}"),
          onDonate: () => print("Donate to ${ngo.name}"),
        );
      },
    );
  }
}
