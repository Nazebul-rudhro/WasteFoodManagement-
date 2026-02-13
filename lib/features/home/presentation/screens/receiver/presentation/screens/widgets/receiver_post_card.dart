// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../../../../../auth/data/model/post_model.dart';
// // import '../../provider/receiver_provider.dart';
// //
// // class ReceiverPostCard extends StatelessWidget {
// //   final PostModel post;
// //
// //   const ReceiverPostCard({super.key, required this.post});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = Provider.of<ReceiverProvider>(context);
// //     final isRequested = provider.myRequests.contains(post.postId);
// //
// //     return Card(
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //       elevation: 4,
// //       child: Padding(
// //         padding: const EdgeInsets.all(12),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             /// Food Name
// //             Text(
// //               post.foodName,
// //               style: const TextStyle(
// //                   fontSize: 16, fontWeight: FontWeight.bold),
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //             const SizedBox(height: 6),
// //
// //             /// Description
// //             Text(
// //               post.description,
// //               maxLines: 2,
// //               overflow: TextOverflow.ellipsis,
// //               style: const TextStyle(fontSize: 14, color: Colors.black54),
// //             ),
// //             const SizedBox(height: 8),
// //
// //             /// Pickup Time & Address
// //             Text(
// //               "Pickup: ${post.pickupTime}, ${post.pickupAddress}",
// //               style: const TextStyle(fontSize: 12, color: Colors.grey),
// //             ),
// //             const Spacer(),
// //
// //             /// Request Button
// //             ElevatedButton(
// //               style: ElevatedButton.styleFrom(
// //                 minimumSize: const Size.fromHeight(36),
// //                 backgroundColor: isRequested ? Colors.grey : Colors.blue,
// //               ),
// //               onPressed: isRequested
// //                   ? null
// //                   : () async {
// //                 await provider.sendRequest(post.postId, post.donorId);
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   const SnackBar(content: Text("Request Sent / Pending")),
// //                 );
// //               },
// //               child: Text(isRequested ? "Pending" : "Request"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // File: lib/features/home/presentation/screens/receiver/widgets/receiver_post_card.dart
// import 'package:flutter/material.dart';
// import '../../../../../auth/data/model/post_model.dart';
// import 'package:provider/provider.dart';
// import '../provider/receiver_provider.dart';
// import '../../../../../../core/constants/app_colors.dart';
//
// class ReceiverPostCard extends StatelessWidget {
//   final PostModel post;
//   final bool alreadyRequested;
//   final bool isLoading;
//
//   const ReceiverPostCard({
//     super.key,
//     required this.post,
//     required this.alreadyRequested,
//     required this.isLoading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.read<ReceiverProvider>();
//
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 5,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               child: post.imageUrls.isNotEmpty
//                   ? Image.network(
//                 post.imageUrls.first,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   color: Colors.grey[200],
//                   child: const Icon(Icons.fastfood, color: Colors.grey),
//                 ),
//               )
//                   : Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey)),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                   const SizedBox(height: 2),
//                   Text("Qty: ${post.quantity}", style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 2),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on, size: 12, color: Colors.grey),
//                       const SizedBox(width: 2),
//                       Expanded(child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 11))),
//                     ],
//                   ),
//                   const SizedBox(height: 2),
//                   Row(
//                     children: [
//                       const Icon(Icons.access_time, size: 12, color: Colors.grey),
//                       const SizedBox(width: 2),
//                       Text(post.pickupTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//             child: SizedBox(
//               width: double.infinity,
//               height: 32,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: alreadyRequested || isLoading ? Colors.grey : AppColor.green,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 ),
//                 onPressed: alreadyRequested || isLoading
//                     ? null
//                     : () async {
//                   provider.setRequesting(post.postId, true);
//                   try {
//                     await provider.sendRequest(post.postId, post.donorId);
//                   } finally {
//                     provider.setRequesting(post.postId, false);
//                   }
//                 },
//                 child: isLoading
//                     ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                     : Text(alreadyRequested ? "Pending" : "Available", style: const TextStyle(fontSize: 13)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//



// File: lib/features/home/presentation/screens/receiver/widgets/receiver_post_card.dart
import 'package:flutter/material.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';
class ReceiverPostCard extends StatelessWidget {
  final PostModel post;
  final bool alreadyRequested;
  final bool isLoading;

  const ReceiverPostCard({
    super.key,
    required this.post,
    required this.alreadyRequested,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ReceiverProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: post.imageUrls.isNotEmpty
                  ? Image.network(
                post.imageUrls.first,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.fastfood, color: Colors.grey),
                ),
              )
                  : Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text("Qty: ${post.quantity}", style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(post.pickupAddress, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(post.pickupTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: SizedBox(
              width: double.infinity,
              // height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alreadyRequested || isLoading ? Colors.grey : AppColor.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: alreadyRequested || isLoading
                    ? null
                    : () async {
                  provider.setRequesting(post.postId, true);
                  try {
                    await provider.sendRequest(post.postId, post.donorId);
                  } finally {
                    provider.setRequesting(post.postId, false);
                  }
                },
                child: isLoading
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text(alreadyRequested ? "Pending" : "Available", style: const TextStyle(fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

