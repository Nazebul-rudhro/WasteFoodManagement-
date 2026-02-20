// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// class RoleOption extends StatelessWidget {
//   final String title;
//   final String description;
//   final bool selected;
//   final VoidCallback onTap; // Call when tapped
//
//   const RoleOption({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.selected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // Handle single selection
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, 3),
//             ),
//           ],
//           border: Border.all(
//             color: selected ? AppColor.lightGreen : Colors.grey.shade200,
//             width: selected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Custom checkbox indicator
//             Container(
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 color: selected ? AppColor.lightGreen : Colors.white,
//                 border: Border.all(
//                   color: selected ? AppColor.lightGreen : Colors.grey,
//                   width: 2,
//                 ),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: selected
//                   ? const Icon(Icons.check, size: 16, color: Colors.white)
//                   : null,
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     description,
//                     style: const TextStyle(fontSize: 14, color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

class RoleOption extends StatelessWidget {
  final String title;
  final String description;
  final bool selected;
  final VoidCallback? onTap; // Nullable করা হয়েছে এরর এড়াতে

  const RoleOption({
    super.key,
    required this.title,
    required this.description,
    required this.selected,
    this.onTap, // Required কেটে দেওয়া হয়েছে
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: selected ? AppColor.lightGreen : Colors.grey.shade200,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected ? AppColor.lightGreen : Colors.white,
                border: Border.all(
                  color: selected ? AppColor.lightGreen : Colors.grey.shade400,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: selected ? AppColor.green : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}