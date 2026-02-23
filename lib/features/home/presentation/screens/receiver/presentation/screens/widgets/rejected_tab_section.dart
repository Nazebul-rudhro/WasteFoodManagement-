// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class RejectedTab extends StatelessWidget {
//   const RejectedTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         // Provider theke sorted rejected list niye asha
//         final posts = provider.rejectedPosts;
//
//         if (posts.isEmpty) {
//           return _buildEmptyState("No rejected requests found");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.red.withOpacity(0.1)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.03),
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   children: [
//                     // Image Section
//                     _buildImage(post.imageUrls),
//                     const SizedBox(width: 15),
//
//                     // Content Section
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   post.foodName,
//                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               _badge("REJECTED", Colors.red),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           _rowInfo(Icons.group_outlined, "Quantity: ${post.quantity}"),
//                           _rowInfo(Icons.access_time, "Pickup: ${post.pickupTime}"),
//                           _rowInfo(Icons.location_on_outlined, post.pickupAddress),
//
//                           const Divider(height: 20, thickness: 0.5),
//                           const Text(
//                             "Donation request was not accepted.",
//                             style: TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _rowInfo(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.grey),
//           const SizedBox(width: 6),
//           Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87))),
//         ],
//       ),
//     );
//   }
//
//   Widget _badge(String txt, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(txt, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9)),
//     );
//   }
//
//   Widget _buildImage(List<String> urls) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 80, height: 80, color: Colors.grey.shade100,
//         child: urls.isNotEmpty
//             ? Image.network(urls.first, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.fastfood))
//             : const Icon(Icons.fastfood, color: Colors.grey),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String msg) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.cancel_schedule_send, size: 50, color: Colors.grey.shade300),
//           const SizedBox(height: 10),
//           Text(msg, style: TextStyle(color: Colors.grey.shade500)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../provider/receiver_provider.dart';

class RejectedTab extends StatelessWidget {
  const RejectedTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Detect Theme Mode
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.primary));
        }

        final posts = provider.rejectedPosts;

        if (posts.isEmpty) {
          return _buildEmptyState(context, "No rejected requests found");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                // Adaptive background
                color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
                borderRadius: BorderRadius.circular(16),
                // Subtle red border to indicate rejection status
                border: Border.all(color: AppColor.red.withOpacity(0.2)),
                boxShadow: isDark ? [] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    _buildImage(post.imageUrls, isDark),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  post.foodName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isDark ? AppColor.white : AppColor.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _badge("REJECTED", AppColor.red),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _rowInfo(context, Icons.group_outlined, "Quantity: ${post.quantity}"),
                          _rowInfo(context, Icons.access_time, "Pickup: ${post.pickupTime}"),
                          _rowInfo(context, Icons.location_on_outlined, post.pickupAddress),

                          const Divider(height: 20, thickness: 0.5),
                          Text(
                            "Donation request was not accepted.",
                            style: TextStyle(
                                fontSize: 10,
                                color: isDark ? AppColor.red.withOpacity(0.8) : AppColor.red,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _rowInfo(BuildContext context, IconData icon, String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray),
          const SizedBox(width: 6),
          Expanded(
              child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColor.white.withOpacity(0.7) : Colors.black87
                  )
              )
          ),
        ],
      ),
    );
  }

  Widget _badge(String txt, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6)
      ),
      child: Text(
          txt,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9)
      ),
    );
  }

  Widget _buildImage(List<String> urls, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        height: 80,
        color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
        child: urls.isNotEmpty
            ? Image.network(
            urls.first,
            fit: BoxFit.cover,
            errorBuilder: (_,__,___) => Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : AppColor.gray)
        )
            : Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : AppColor.gray),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String msg) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.cancel_schedule_send,
              size: 50,
              color: isDark ? AppColor.gray.withOpacity(0.4) : Colors.grey.shade300
          ),
          const SizedBox(height: 10),
          Text(
              msg,
              style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.5) : Colors.grey.shade500)
          ),
        ],
      ),
    );
  }
}