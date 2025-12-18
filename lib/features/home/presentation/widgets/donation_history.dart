import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../auth/data/model/donation_history_model.dart';
import '../../../../core/constants/app_colors.dart';

class DonationHistoryItem extends StatelessWidget {
  final DonationHistoryModel data;

  const DonationHistoryItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          data.image,
          width: width * 0.4,
          height: 120,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ID: ${data.id}",
                    style: AppTheme.heading3.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                  Text(
                    data.timeAgo,
                    style: AppTheme.heading3.copyWith(
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                data.title,
                style: AppTheme.heading3.copyWith(
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                data.quantity,
                style: AppTheme.heading3.copyWith(
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.status,
                    style: AppTheme.heading3.copyWith(
                      color: data.status == "Completed"
                          ? AppColor.lime_green
                          : AppColor.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.share, size: 20),
                      SizedBox(width: 8),
                      Icon(Icons.copy, size: 20),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
