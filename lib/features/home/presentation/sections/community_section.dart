import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

import '../widgets/community_card.dart';

class CommunitySection extends StatelessWidget {
  const CommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Community", style: AppTheme.heading2),
            Text("View Feed",
                style: AppTheme.heading2.copyWith(color: AppColor.primary)),
          ],
        ),
        const Divider(thickness: 1),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: const [
            CommunityCard(),
            CommunityCard(),
          ],
        ),
      ],
    );
  }
}
