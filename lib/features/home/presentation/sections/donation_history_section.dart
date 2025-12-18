import 'package:flutter/material.dart';
import '../../../auth/data/model/donation_history_model.dart';
import '../widgets/donation_history.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class DonationHistorySection extends StatelessWidget {
  final List<DonationHistoryModel> list;

  const DonationHistorySection({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Donation History", style: AppTheme.heading2),
            Text(
              "View All",
              style: AppTheme.heading2.copyWith(color: AppColor.primary),
            ),
          ],
        ),
        const Divider(thickness: 1),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            return DonationHistoryItem(data: list[index]);
          },
        ),
      ],
    );
  }
}
