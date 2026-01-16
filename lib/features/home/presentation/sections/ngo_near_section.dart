import 'package:flutter/material.dart';
import '../../../auth/data/model/ngo_model.dart';
import '../widgets/ngo_grid_item.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class NgoNearYouSection extends StatelessWidget {
  final List<NgoModel> list;
  final VoidCallback onActionTap;

  const NgoNearYouSection({super.key, required this.list, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) return const SizedBox();

    final displayList = list.length > 4 ? list.take(4).toList() : list;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("NGOs Near You", style: AppData.heading2),
            GestureDetector(
              onTap: onActionTap,
              child: Text("See More",
                  style: AppData.heading2.copyWith(color: AppColor.primary)),
            ),
          ],
        ),
        const Divider(thickness: 1),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          children: List.generate(displayList.length, (index) {
            return NgoGridItem(data: displayList[index]);
          }),
        ),
      ],
    );
  }
}
