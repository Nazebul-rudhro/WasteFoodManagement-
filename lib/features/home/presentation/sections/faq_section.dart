import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import '../../../auth/data/model/faq_item_model.dart';


class FaqSection extends StatelessWidget {
  final List<FaqItem> faqs;

  const FaqSection({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    if (faqs.isEmpty) return const SizedBox(); // Empty check

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Text("FAQs", style: AppData.heading2),
            const SizedBox(width: 16),
            const Expanded(child: Divider(thickness: 2)),
          ],
        ),

        // FAQ List
        ...faqs.map(
              (item) => ExpansionTile(
            title: Text(item.question),
            children: [
              Padding(
                padding:  EdgeInsets.all(8),
                child: Text(item.answer),
              )
            ],
          ),
        ),
      ],
    );
  }
}
