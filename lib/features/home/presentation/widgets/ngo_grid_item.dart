import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../auth/data/model/ngo_model.dart';

class NgoGridItem extends StatelessWidget {
  final NgoModel data;

  const NgoGridItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: AppColor.soft_green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  data.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    data.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppData.heading3.copyWith(color: AppColor.black, fontSize: 12)),
                Text(data.distance, style: AppData.heading3.copyWith(color: AppColor.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
