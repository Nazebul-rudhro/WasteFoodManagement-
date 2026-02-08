// import 'package:flutter/material.dart';
// import '../../../auth/data/model/ngo_model.dart';
//
// class NGOCard extends StatelessWidget {
//   final NGOModel ngo;
//   final VoidCallback? onViewDetails;
//   final VoidCallback? onDonate;
//
//   const NGOCard({
//     super.key,
//     required this.ngo,
//     this.onViewDetails,
//     this.onDonate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 3,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(
//               ngo.image,
//               height: 150,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Details
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // NGO Name
//                 Text(
//                   ngo.name,
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 // Location, Food Requirement, Distance
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           ngo.location,
//                           style: const TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.people_outline, size: 18, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           ngo.foodRequirement,
//                           style: const TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.pin_drop_outlined, size: 18, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           ngo.distance,
//                           style: const TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 const Divider(),
//                 const SizedBox(height: 8),
//                 // Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: onViewDetails,
//                       child: const Text("View Details"),
//                     ),
//                     const SizedBox(width: 8),
//                     ElevatedButton(
//                       onPressed: onDonate,
//                       style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                       child: const Text("Donate"),
//                     ),
//                   ],
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
import '../../../auth/data/model/ngo_model.dart';


class NGOCard extends StatelessWidget {
  final NGOModel ngo;
  final VoidCallback? onViewDetails;
  final VoidCallback? onDonate;

  const NGOCard({
    super.key,
    required this.ngo,
    this.onViewDetails,
    this.onDonate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Safe Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: ngo.imageUrl.isNotEmpty
                ? Image.asset(
              ngo.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            )
                : Container(
              height: 150,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image_not_supported,
                size: 50,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ngo.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          ngo.location,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people_outline, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          ngo.foodRequirement,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.pin_drop_outlined, size: 18, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          ngo.pickupTime,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: onViewDetails,
                      child:  Text("View Details", style: TextStyle(color: AppColor.black),),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: onDonate,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      )),
                      child:  Text("Donate", style: TextStyle(color: AppColor.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
