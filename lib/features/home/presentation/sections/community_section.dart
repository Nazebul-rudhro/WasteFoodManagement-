import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

import '../../../auth/data/model/community_section_model.dart';
import '../widgets/community_card.dart';

class CommunitySection extends StatelessWidget {
  final List<CommunitySectionModel> list;
  final VoidCallback onActionTab;

  const CommunitySection({
    super.key,
    required this.list,
    required this.onActionTab,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return const SizedBox(); // Empty check

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Community", style: AppData.heading2),
            GestureDetector(
              onTap: onActionTab,
              child: Text(
                "View Feed",
                style: AppData.heading2.copyWith(color: AppColor.primary),
              ),
            ),
          ],
        ),
        const Divider(thickness: 1),

        // GridView of CommunityCards
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: List.generate(
            list.length,
                (index) {
              final item = list[index];
              return CommunityCard(
                imagePath: item.image,
                title: item.title,
                actionText: item.status, // Example: use status as action
                onActionTap: onActionTab, // Or separate callback per card
              );
            },
          ),
        ),
      ],
    );
  }
}
