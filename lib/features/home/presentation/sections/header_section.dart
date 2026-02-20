// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// import '../../../../app/app_theme.dart';
// class HeaderSection extends StatelessWidget {
//   final String name;
//   final String role;
//   final int notificationCount;
//   final VoidCallback noticicationOnActionTap;
//
//   const HeaderSection({
//     super.key,
//     required this.name,
//     required this.role,
//     required this.notificationCount, required this.noticicationOnActionTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Hi $name", style: AppData.heading3),
//             RichText(
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text: "You are a ",
//                     style: AppData.heading2,
//                   ),
//                   TextSpan(
//                     text: role,
//                     style: AppData.heading2.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: AppColor.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         GestureDetector(
//           onTap: noticicationOnActionTap,
//           child: Badge(
//             backgroundColor: AppColor.green,
//             label: Text(
//               "$notificationCount",
//               style:  TextStyle(color: AppColor.white),
//             ),
//             child: const Icon(Icons.notifications),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../../app/app_theme.dart'; // পাথ আপনার প্রজেক্ট অনুযায়ী চেক করে নেবেন

class HeaderSection extends StatelessWidget {
  final String name;
  final String role;
  final int notificationCount;
  final VoidCallback noticicationOnActionTap;

  const HeaderSection({
    super.key,
    required this.name,
    required this.role,
    required this.notificationCount,
    required this.noticicationOnActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi $name", style: AppData.heading3),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You are a ",
                    style: AppData.heading2,
                  ),
                  TextSpan(
                    text: role,
                    style: AppData.heading2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: noticicationOnActionTap,
          child: notificationCount > 0
              ? Badge(
            backgroundColor: AppColor.green,
            label: Text(
              "$notificationCount",
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            child: const Icon(Icons.notifications, size: 28),
          )
              : const Icon(Icons.notifications, size: 28), // কাউন্ট ০ হলে সাধারণ আইকন
        ),
      ],
    );
  }
}