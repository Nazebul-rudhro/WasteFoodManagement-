// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/app/app_theme.dart';
//
// class CommunityCard extends StatelessWidget {
//   final String imagePath; // Image asset path
//   final String title; // Main title text
//   final String actionText; // Action text (like 'Know More')
//   final VoidCallback? onActionTap; // Optional click callback
//
//   const CommunityCard({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.actionText,
//     this.onActionTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       // color: AppColor.backgrouGray,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         children: [
//           // Image section
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//           ),
//
//           // Text section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: AppData.heading3.copyWith(color: AppColor.black, fontSize: 12),
//                 ),
//                 const SizedBox(height: 4),
//                 GestureDetector(
//                   onTap: onActionTap,
//                   child: Text(
//                     actionText,
//                     style: AppData.heading3.copyWith(
//                       color: AppColor.green,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/app/app_theme.dart';

class CommunityCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;

  const CommunityCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক করার জন্য
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 0 : 2,
      // ডার্ক মোডে হালকা গ্রে এবং লাইট মোডে সাদা বা ব্যাকগ্রাউন্ড গ্রে
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // একটু বেশি রাউন্ডেড করা হয়েছে মডার্ন লুকের জন্য
        side: BorderSide(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Text section
          Padding(
            padding: const EdgeInsets.all(10), // প্যাডিং একটু বাড়ানো হয়েছে
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppData.heading3.copyWith(
                    // ডার্ক মোডে সাদা এবং লাইট মোডে ব্ল্যাক টেক্সট
                    color: isDark ? AppColor.white : AppColor.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: onActionTap,
                  child: Row(
                    children: [
                      Text(
                        actionText,
                        style: AppData.heading3.copyWith(
                          color: AppColor.green, // আপনার ব্র্যান্ড গ্রিন
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColor.green
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}