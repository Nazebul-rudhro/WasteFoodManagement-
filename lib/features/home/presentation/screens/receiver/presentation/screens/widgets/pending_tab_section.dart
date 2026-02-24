// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class PendingTab extends StatelessWidget {
//   const PendingTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final posts = provider.pendingPosts;
//
//         if (posts.isEmpty) {
//           return _buildEmptyState("No pending requests found");
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
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildLeadingImage(post.imageUrls),
//                     const SizedBox(width: 15),
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
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                     color: Color(0xFF2D2D2D),
//                                   ),
//                                 ),
//                               ),
//                               _buildStatusBadge("PENDING", Colors.orange),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           _infoRow(Icons.group_outlined, "For: ${post.quantity} Persons"),
//                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
//                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
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
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 12, color: Colors.grey.shade600, letterSpacing: 0.2),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeadingImage(List<String> urls) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 85,
//         height: 85,
//         color: Colors.grey.shade100,
//         child: urls.isNotEmpty
//             ? Image.network(
//           urls.first,
//           fit: BoxFit.cover,
//           errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
//         )
//             : const Icon(Icons.fastfood, color: Colors.grey, size: 30),
//       ),
//     );
//   }
//
//   Widget _buildStatusBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String msg) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.hourglass_empty_rounded, size: 60, color: Colors.grey.shade300),
//           const SizedBox(height: 12),
//           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class PendingTab extends StatelessWidget {
//   const PendingTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Detect Dark Mode
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.primary));
//         }
//
//         final posts = provider.pendingPosts;
//
//         if (posts.isEmpty) {
//           return _buildEmptyState(context, "No pending requests found");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           physics: const BouncingScrollPhysics(),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 // Adaptive Background: Dark Gray for Night, White for Light
//                 color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
//                 boxShadow: isDark ? [] : [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildLeadingImage(post.imageUrls, isDark),
//                     const SizedBox(width: 15),
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
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                     color: isDark ? AppColor.white : AppColor.black,
//                                   ),
//                                 ),
//                               ),
//                               // Using Orange for Pending Status
//                               _buildStatusBadge("PENDING", Colors.orange),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           _infoRow(context, Icons.group_outlined, "For: ${post.quantity} Persons"),
//                           _infoRow(context, Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
//                           _infoRow(context, Icons.location_on_outlined, post.pickupAddress),
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
//   Widget _infoRow(BuildContext context, IconData icon, String text) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: AppColor.primary.withOpacity(0.8)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                   fontSize: 12,
//                   color: isDark ? AppColor.white.withOpacity(0.6) : Colors.grey.shade600,
//                   letterSpacing: 0.2
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeadingImage(List<String> urls, bool isDark) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         width: 85,
//         height: 85,
//         color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
//         child: urls.isNotEmpty
//             ? Image.network(
//           urls.first,
//           fit: BoxFit.cover,
//           errorBuilder: (_, __, ___) => Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.3) : Colors.grey),
//         )
//             : Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.3) : Colors.grey, size: 30),
//       ),
//     );
//   }
//
//   Widget _buildStatusBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context, String msg) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.hourglass_empty_rounded,
//               size: 60,
//               color: isDark ? AppColor.gray.withOpacity(0.5) : Colors.grey.shade300
//           ),
//           const SizedBox(height: 12),
//           Text(
//               msg,
//               style: TextStyle(
//                   color: isDark ? AppColor.white.withOpacity(0.5) : Colors.grey.shade500,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../provider/receiver_provider.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.primary));
        }

        final posts = provider.pendingPosts;

        if (posts.isEmpty) {
          return _buildEmptyState(context, "No pending requests found");
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
                color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
                borderRadius: BorderRadius.circular(16),
                border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
                boxShadow: isDark ? [] : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeadingImage(post.imageUrls, isDark),
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
                                  post.foodName ?? "Unknown Food", // ✅ Null check
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: isDark ? AppColor.white : AppColor.black,
                                  ),
                                ),
                              ),
                              _buildStatusBadge("PENDING", Colors.orange),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // ✅ ডাটাগুলো নাল হতে পারে তাই ডিফল্ট ভ্যালু দেওয়া নিরাপদ
                          _infoRow(context, Icons.group_outlined, "For: ${post.quantity ?? 0} Persons"),
                          _infoRow(context, Icons.access_time_rounded, "Pickup: ${post.pickupTime ?? 'N/A'}"),
                          _infoRow(context, Icons.location_on_outlined, post.pickupAddress ?? "No Address Provided"),
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

  // ... (আপনার বাকি সব মেথড যেমন আছে তেমনই থাকবে, কোনো পরিবর্তন দরকার নেই)

  Widget _infoRow(BuildContext context, IconData icon, String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColor.primary.withOpacity(0.8)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  color: isDark ? AppColor.white.withOpacity(0.6) : Colors.grey.shade600,
                  letterSpacing: 0.2
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingImage(List<String>? urls, bool isDark) { // ✅ Nullable list handling
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 85,
        height: 85,
        color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
        child: (urls != null && urls.isNotEmpty)
            ? Image.network(
          urls.first,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.3) : Colors.grey),
        )
            : Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.3) : Colors.grey, size: 30),
      ),
    );
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9, letterSpacing: 0.5),
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
              Icons.hourglass_empty_rounded,
              size: 60,
              color: isDark ? AppColor.gray.withOpacity(0.5) : Colors.grey.shade300
          ),
          const SizedBox(height: 12),
          Text(
              msg,
              style: TextStyle(
                  color: isDark ? AppColor.white.withOpacity(0.5) : Colors.grey.shade500,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              )
          ),
        ],
      ),
    );
  }
}