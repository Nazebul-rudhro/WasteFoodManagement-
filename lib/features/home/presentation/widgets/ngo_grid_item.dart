// // import 'package:flutter/material.dart';
// //
// // import '../../../../app/app_theme.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../../../auth/data/model/ngo_model.dart';
// //
// // class NgoGridItem extends StatelessWidget {
// //   final NGOModel data;
// //
// //   const NgoGridItem({
// //     super.key,
// //     required this.data,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       // color: AppColor.soft_green,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       // child: Padding(
// //       //   padding: const EdgeInsets.all(10),
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(8),
// //                 child: Image.asset(
// //                   data.image,
// //                   fit: BoxFit.cover,
// //                   width: double.infinity,
// //                   // height: 250,
// //                 ),
// //               ),
// //             ),
// //             Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                       data.name,
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: AppData.heading3.copyWith(color: AppColor.black, fontSize: 12)),
// //                   Text(data.pickupTime, style: AppData.heading3.copyWith(color: AppColor.black)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         // ),
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// //
// // import 'package:flutter/material.dart';
// //
// // import '../../../auth/data/model/ngo_model.dart';
// // class NgoGridItem extends StatelessWidget {
// //   final NGOModel data;
// //
// //   const NgoGridItem({super.key, required this.data});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //       elevation: 3,
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Expanded(
// //             child: ClipRRect(
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //               child: Image.network(
// //                 data.image,
// //                 width: double.infinity,
// //                 fit: BoxFit.cover,
// //                 errorBuilder: (_, __, ___) =>
// //                 const Icon(Icons.image_not_supported),
// //               ),
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(8),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(data.name,
// //                     style: const TextStyle(
// //                         fontWeight: FontWeight.bold, fontSize: 14)),
// //                 const SizedBox(height: 4),
// //                 Text("Pickup: ${data.pickupTime}",
// //                     style: const TextStyle(fontSize: 12)),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
//
//
// import 'package:flutter/material.dart';
// import '../../../auth/data/model/ngo_model.dart';
// class NgoGridItem extends StatelessWidget {
//   final NGOModel data;
//   const NgoGridItem({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // NGO Image (Cloudinary theke asha URL)
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//               child: Image.network(
//                 data.imageUrl ?? 'https://via.placeholder.com/150',
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) =>
//                 const Icon(Icons.business, size: 50, color: Colors.grey),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   data.name,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 12, color: Colors.green),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         data.imageUrl ?? "Nearby",
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.grey[600], fontSize: 11),
//                       ),
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
import '../../../auth/data/model/ngo_model.dart';

class NgoGridItem extends StatelessWidget {
  final NGOModel data;
  const NgoGridItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: data.imageUrl.isNotEmpty
                  ? Image.network(
                data.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey)),
              )
                  : Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  "Qty: ${data.foodRequirement}",
                  style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 10, color: Colors.grey),
                    Expanded(
                      child: Text(
                        data.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
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