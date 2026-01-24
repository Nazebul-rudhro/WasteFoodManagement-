import 'package:flutter/material.dart';
import '../../../auth/data/model/ngo_model.dart';
import '../widgets/ngo_card.dart';

class GenericNGOList extends StatelessWidget {
  const GenericNGOList({super.key});

  final List<NGOModel> ngoList = const [
    NGOModel(
      name: "Helping Hands",
      image: "assets/images/splash_screen/splashscreen_1.png",
      location: "Dhaka",
      foodRequirement: "20 people",
      distance: "2 km",
    ),
    NGOModel(
      name: "Food For All",
      image: "assets/images/splash_screen/splashscreen_1.png",
      location: "Chittagong",
      foodRequirement: "15 people",
      distance: "5 km",
    ),
    NGOModel(
      name: "Hope Foundation",
      image: "assets/images/splash_screen/splashscreen_1.png",
      location: "Sylhet",
      foodRequirement: "30 people",
      distance: "10 km",
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
