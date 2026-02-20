// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/post_model.dart';
// import '../../provider/receiver_provider.dart';
//
// class ReceiverPostCard extends StatelessWidget {
//   final PostModel post;
//
//   const ReceiverPostCard({
//     super.key,
//     required this.post,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // এখানে watch ব্যবহার করছি যাতে রিকোয়েস্ট পাঠানোর সাথে সাথে বাটনের স্টেট চেঞ্জ হয়
//     final provider = context.watch<ReceiverProvider>();
//     final bool alreadyRequested = provider.myRequests.contains(post.postId);
//     final bool isThisPostRequesting = provider.isRequesting[post.postId] ?? false;
//
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ইমেজ সেকশন
//           Expanded(
//             flex: 5,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               child: (post.imageUrls != null && post.imageUrls!.isNotEmpty)
//                   ? Image.network(
//                 post.imageUrls!.first,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => _buildPlaceholder(),
//               )
//                   : _buildPlaceholder(),
//             ),
//           ),
//           // ইনফরমেশন সেকশন
//           Expanded(
//             flex: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.foodName ?? "No Name",
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                   const SizedBox(height: 4),
//                   Text("Qty: ${post.quantity ?? '0'}",
//                       style: const TextStyle(color: AppColor.green, fontSize: 12, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 4),
//                   _buildIconText(Icons.location_on, post.pickupAddress ?? "No Address"),
//                   const SizedBox(height: 2),
//                   _buildIconText(Icons.access_time, post.pickupTime ?? "Not specified"),
//                 ],
//               ),
//             ),
//           ),
//           // বাটন সেকশন
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: double.infinity,
//               height: 35,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: alreadyRequested || isThisPostRequesting ? Colors.grey : AppColor.green,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 ),
//                 onPressed: (alreadyRequested || isThisPostRequesting)
//                     ? null
//                     : () => provider.sendRequest(post.postId!, post.donorId!),
//                 child: isThisPostRequesting
//                     ? const SizedBox(width: 15, height: 15,
//                     child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                     : Text(
//                   alreadyRequested ? "Requested" : "Request Now",
//                   style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlaceholder() {
//     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey));
//   }
//
//   Widget _buildIconText(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 12, color: Colors.grey),
//         const SizedBox(width: 4),
//         Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis,
//             style: const TextStyle(color: Colors.grey, fontSize: 11))),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';

class ReceiverPostCard extends StatelessWidget {
  final PostModel post;
  const ReceiverPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();
    final isThisPostRequesting = provider.isRequesting[post.postId] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ইমেজ সেকশন (Gradient Overlay সহ)
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Hero(
                    tag: post.postId ?? '',
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: post.imageUrls.isNotEmpty
                          ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
                          : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
                    ),
                  ),
                ),
                // ছোট ব্যাজ (Quantity)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColor.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(post.quantity,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
          // টেক্সট ইনফরমেশন
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2D2D2D))),
                  const SizedBox(height: 6),
                  _infoRow(Icons.access_time_rounded, post.pickupTime),
                  const SizedBox(height: 4),
                  _infoRow(Icons.location_on_outlined, post.pickupAddress),
                  const Spacer(),
                  // প্রিমিয়াম বাটন ডিজাইন
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: isThisPostRequesting
                          ? null
                          : () => provider.sendRequest(post.postId, post.donorId),
                      child: isThisPostRequesting
                          ? const SizedBox(width: 18, height: 18,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("Request Now",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade500),
        const SizedBox(width: 5),
        Expanded(
          child: Text(text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600, height: 1.2)),
        ),
      ],
    );
  }
}