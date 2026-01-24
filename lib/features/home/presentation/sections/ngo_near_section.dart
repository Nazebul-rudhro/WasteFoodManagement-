// import 'package:flutter/material.dart';
// import '../../../auth/data/model/ngo_model.dart';
// import '../widgets/ngo_grid_item.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/app/app_theme.dart';
//
// class NgoNearYouSection extends StatelessWidget {
//   final List<NGOModel> list;
//   final VoidCallback onActionTap;
//
//   const NgoNearYouSection({super.key, required this.list, required this.onActionTap});
//
//   @override
//   Widget build(BuildContext context) {
//     if (list.isEmpty) return const SizedBox();
//
//     final displayList = list.length > 4 ? list.take(0).toList() : list;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("NGOs Near You", style: AppData.heading2),
//             GestureDetector(
//               onTap: onActionTap,
//               child: Text("See More",
//                   style: AppData.heading2.copyWith(color: AppColor.green)),
//             ),
//           ],
//         ),
//         const Divider(thickness: 1),
//         GridView.count(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisCount: 2,
//           mainAxisSpacing: 5,
//           crossAxisSpacing: 5,
//           children: List.generate(displayList.length, (index) {
//             return NgoGridItem(data: displayList[index]);
//           }),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../../auth/data/model/ngo_model.dart';
import '../widgets/ngo_grid_item.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class NgoNearYouSection extends StatelessWidget {
  final List<NGOModel> list;
  final VoidCallback onActionTap;

  const NgoNearYouSection({super.key, required this.list, required this.onActionTap});

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Text(
            "NGO Not Found",
            style: AppData.heading3.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    final displayList = list; // সব data দেখাবে

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("NGOs Near You", style: AppData.heading2),
              GestureDetector(
                onTap: onActionTap,
                child: Text(
                  "See More",
                  style: AppData.heading2.copyWith(color: AppColor.green),
                ),
              ),
            ],
          ),
        ),

        const Divider(thickness: 1),

        /// Grid of NGOs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return NgoGridItem(data: displayList[index]);
            },
          ),
        ),
      ],
    );
  }
}
