import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/homescreen_info_card.dart';
class InfoCardsSection extends StatelessWidget {
  const InfoCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: HomeScreenInfoCart(
            title: 'Donations',
            value: 500,
            color: AppColor.backgrouGray,
          ),
        ),
        Expanded(
          child: HomeScreenInfoCart(
            title: "Feedback",
            value: 500,
            color: AppTheme.primaryColor.withOpacity(0.6),
          ),
        ),
        Expanded(
          child: HomeScreenInfoCart(
            title: "Points earned",
            value: 1000,
            color: AppColor.backgrouGray,
          ),
        ),
      ],
    );
  }
}