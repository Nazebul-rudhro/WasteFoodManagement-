// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../../app/app_theme.dart'; // পাথ আপনার প্রজেক্ট অনুযায়ী চেক করে নেবেন
//
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
//     required this.notificationCount,
//     required this.noticicationOnActionTap,
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
//           child: notificationCount > 0
//               ? Badge(
//             backgroundColor: AppColor.green,
//             label: Text(
//               "$notificationCount",
//               style: const TextStyle(color: Colors.white, fontSize: 10),
//             ),
//             child: const Icon(Icons.notifications, size: 28),
//           )
//               : const Icon(Icons.notifications, size: 28), // কাউন্ট ০ হলে সাধারণ আইকন
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // থিম অনুযায়ী টেক্সট কালার
            Text(
                "Hi $name",
                style: AppData.heading3.copyWith(
                    color: isDark ? AppColor.white : AppColor.gray
                )
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You are a ",
                    style: AppData.heading2.copyWith(
                        color: isDark ? AppColor.white : AppColor.black
                    ),
                  ),
                  TextSpan(
                    text: role,
                    style: AppData.heading2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.green, // আপনার Emerald Green
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: noticicationOnActionTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                  Icons.notifications_none_rounded,
                  size: 30,
                  color: isDark ? AppColor.white : AppColor.black
              ),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColor.red, // নোটিফিকেশনের জন্য লাল কালার
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      "$notificationCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}