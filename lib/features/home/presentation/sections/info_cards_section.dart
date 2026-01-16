import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/homescreen_info_card.dart';

class InfoCardsSection extends StatelessWidget {
  final String title1;
  final int value1;
  final Color color1;

  final String title2;
  final int value2;
  final Color color2;

  final String title3;
  final int value3;
  final Color color3;

  const InfoCardsSection({
    super.key,
    required this.title1,
    required this.value1,
    required this.color1,
    required this.title2,
    required this.value2,
    required this.color2,
    required this.title3,
    required this.value3,
    required this.color3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeScreenInfoCart(
            title: title1,
            value: value1,
            color: color1,
          ),
        ),
        Expanded(
          child: HomeScreenInfoCart(
            title: title2,
            value: value2,
            color: color2,
          ),
        ),
        Expanded(
          child: HomeScreenInfoCart(
            title: title3,
            value: value3,
            color: color3,
          ),
        ),
      ],
    );
  }
}
