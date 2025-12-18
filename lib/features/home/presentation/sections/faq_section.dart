import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("FAQs", style: AppTheme.heading2),
            const SizedBox(width: 16),
            const Expanded(child: Divider(thickness: 2)),
          ],
        ),
        ExpansionTile(
          title: const Text("Who will pick up the food?"),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                  "Verified volunteers or nearby receivers will pick up the food."),
            )
          ],
        ),
        ExpansionTile(
          title: const Text("Can we perform a one-time donation?"),
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text("Yes, you can donate only once if you want."),
            )
          ],
        ),
      ],
    );
  }
}
