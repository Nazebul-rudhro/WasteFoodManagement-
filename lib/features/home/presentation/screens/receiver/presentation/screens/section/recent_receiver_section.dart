//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_all_post.dart';
// import '../../../../../../../../app/app_theme.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/post_model.dart';
// import '../../provider/receiver_provider.dart';
//
// class ReceiverRecentSection extends StatelessWidget {
//   const ReceiverRecentSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<ReceiverProvider>();
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final now = DateTime.now();
//
//     final recentPosts = provider.availablePostsForMe.where((post) {
//       if (post.expiryDate != null) {
//         return post.expiryDate!.isAfter(now);
//       }
//       return true;
//     }).take(4).toList();
//
//     if (recentPosts.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//                 "Recent Donations",
//                 style: AppData.heading2.copyWith(
//                     color: isDark ? AppColor.white : AppColor.black
//                 )
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
//               },
//               child: Text(
//                   "See All",
//                   style: AppData.heading2.copyWith(
//                       color: AppColor.green,
//                       fontSize: 14
//                   )
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: recentPosts.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             childAspectRatio: 0.68,
//           ),
//           itemBuilder: (context, index) {
//             final post = recentPosts[index];
//             final isLoading = provider.isRequesting[post.postId] ?? false;
//             return _buildPostCard(context, post, isLoading);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPostCard(BuildContext context, PostModel post, bool isLoading) {
//     final provider = context.read<ReceiverProvider>();
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       decoration: BoxDecoration(
//         // Adaptive background color
//         color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//         borderRadius: BorderRadius.circular(15),
//         border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
//         boxShadow: isDark ? [] : [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 10,
//               offset: const Offset(0, 4)
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image Section
//           Expanded(
//             flex: 4,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Container(
//                     width: double.infinity,
//                     color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(
//                         post.imageUrls.first,
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => Icon(
//                             Icons.fastfood,
//                             color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray
//                         )
//                     )
//                         : Icon(
//                         Icons.fastfood,
//                         color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray,
//                         size: 30
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8, left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                         color: AppColor.green.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(8)
//                     ),
//                     child: const Text(
//                         "New",
//                         style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Details Section
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                       post.foodName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                         color: isDark ? AppColor.white : AppColor.black,
//                       )
//                   ),
//                   const SizedBox(height: 6),
//
//                   _infoItem(context, Icons.group_outlined, "For: ${post.quantity} Person"),
//                   _infoItem(context, Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
//                   _infoItem(context, Icons.location_on_outlined, post.pickupAddress),
//
//                   const Spacer(),
//
//                   SizedBox(
//                     width: double.infinity,
//                     height: 32,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                       onPressed: isLoading ? null : () async {
//                         await provider.sendRequest(post.postId, post.donorId);
//                       },
//                       child: isLoading
//                           ? const SizedBox(
//                           width: 16, height: 16,
//                           child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
//                       )
//                           : const Text(
//                           "Request Now",
//                           style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoItem(BuildContext context, IconData icon, String text) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 12, color: AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Text(
//                 text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                     fontSize: 10,
//                     color: isDark ? AppColor.white.withOpacity(0.6) : Colors.black87
//                 )
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_all_post.dart';
import '../../../../../../../../app/app_theme.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';

class ReceiverRecentSection extends StatelessWidget {
  const ReceiverRecentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final now = DateTime.now();

    // এক্সপায়ার হয়নি এমন লেটেস্ট ৪টি পোস্ট নেওয়া হচ্ছে
    final recentPosts = provider.availablePostsForMe.where((post) {
      if (post.expiryDate != null) {
        return post.expiryDate!.isAfter(now);
      }
      return true;
    }).take(4).toList();

    if (recentPosts.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "Recent Donations",
                style: AppData.heading2.copyWith(
                    color: isDark ? AppColor.white : AppColor.black,
                    fontSize: 18
                )
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
              },
              child: Text(
                  "See All",
                  style: AppData.heading2.copyWith(
                      color: AppColor.green,
                      fontSize: 14
                  )
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentPosts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.60, // কন্ডিশন ফিল্ডের জন্য রেশিও কিছুটা কমানো হয়েছে
          ),
          itemBuilder: (context, index) {
            final post = recentPosts[index];
            final isLoading = provider.isRequesting[post.postId] ?? false;
            return _buildPostCard(context, post, isLoading);
          },
        ),
      ],
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post, bool isLoading) {
    final provider = context.read<ReceiverProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
            width: 1
        ),
        boxShadow: isDark ? [] : [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 4)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- ইমেজ সেকশন ---
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                    width: double.infinity,
                    color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(
                        post.imageUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.fastfood, size: 30))
                    )
                        : const Center(child: Icon(Icons.fastfood, size: 30)),
                  ),
                ),
                // Food Type Badge
                Positioned(
                  top: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                        color: post.foodType?.toLowerCase() == "vegetarian" ? Colors.green : Colors.redAccent,
                        borderRadius: BorderRadius.circular(6)
                    ),
                    child: Text(
                        post.foodType ?? "Food",
                        style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- ডিটেইলস সেকশন ---
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Food Name
                  Text(
                      post.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? AppColor.white : AppColor.black,
                      )
                  ),

                  // 2. Food Condition (Freshly Cooked)
                  Text(
                    post.foodCondition ?? "Freshly Cooked",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColor.green,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 3. Info Items
                  _infoItem(context, Icons.inventory_2_outlined, "Quantity: ${post.quantity}"),
                  _infoItem(context, Icons.group_outlined, "For: ${post.estimatePersons} Person"),
                  _infoItem(context, Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
                  _infoItem(context, Icons.location_on_outlined, post.pickupAddress),

                  const Spacer(),

                  // 4. Request Button
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: isLoading ? null : () async {
                        await provider.sendRequest(post.postId, post.donorId);
                      },
                      child: isLoading
                          ? const SizedBox(
                          width: 16, height: 16,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                          : const Text(
                          "Request Now",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)
                      ),
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

  Widget _infoItem(BuildContext context, IconData icon, String text) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColor.green.withOpacity(0.8)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 10,
                    color: isDark ? AppColor.white.withOpacity(0.6) : Colors.black87
                )
            ),
          ),
        ],
      ),
    );
  }
}