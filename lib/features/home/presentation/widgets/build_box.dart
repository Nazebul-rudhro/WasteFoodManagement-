// import 'package:flutter/material.dart';
// class BuildBox extends StatelessWidget {
//   const BuildBox({
//     super.key,
//     required this.widthScreen,
//     required this.icon,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   final double widthScreen;
//   final IconData icon;
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 100,
//         width: widthScreen / 4,
//         decoration: BoxDecoration(
//           color: isSelected ? Colors.green.shade200 : Colors.green,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: isSelected
//               ? [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             )
//           ]
//               : [],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.white),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
