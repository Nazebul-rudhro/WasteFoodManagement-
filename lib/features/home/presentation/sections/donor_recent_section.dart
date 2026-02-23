// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../auth/data/model/post_model.dart';
//
// class DonorRecentSection extends StatelessWidget {
//   final VoidCallback onActionTap;
//   const DonorRecentSection({super.key, required this.onActionTap});
//
//   // 🔹 টাইম ফিল্টারিং লজিক
//   bool isPostStillValid(PostModel post) {
//     try {
//       final now = DateTime.now();
//       if (post.expiryDate != null) return now.isBefore(post.expiryDate!);
//
//       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
//       final parts = post.pickupTime.split(' (');
//       if (parts.length < 2) return true;
//
//       final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
//       final match = timeRegex.firstMatch(parts[0].trim());
//
//       if (match != null) {
//         int hour = int.parse(match.group(1)!);
//         int minute = int.parse(match.group(2)!);
//         if (match.group(3) == "PM" && hour < 12) hour += 12;
//         if (match.group(3) == "AM" && hour == 12) hour = 0;
//
//         DateTime pickupDateTime = DateTime(createdDate.year, createdDate.month, createdDate.day, hour, minute);
//         if (parts[1].toLowerCase().contains("tomorrow")) pickupDateTime = pickupDateTime.add(const Duration(days: 1));
//         return now.isBefore(pickupDateTime);
//       }
//       return true;
//     } catch (e) { return true; }
//   }
//
//   Stream<List<PostModel>> getRecentPosts() {
//     return FirebaseFirestore.instance
//         .collection('posts')
//         .where('status', isEqualTo: 'available')
//         .orderBy('createdAt', descending: true)
//         .limit(4)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => PostModel.fromSnapshot(doc))
//         .where((post) => isPostStillValid(post))
//         .take(4).toList());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Recent Donations",
//                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
//               GestureDetector(
//                 onTap: onActionTap,
//                 child: const Text("See All",
//                     style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
//               ),
//             ],
//           ),
//         ),
//         StreamBuilder<List<PostModel>>(
//           stream: getRecentPosts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
//             final posts = snapshot.data ?? [];
//             if (posts.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No donations found")));
//
//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: posts.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 14,
//                 crossAxisSpacing: 14,
//                 childAspectRatio: 0.68, // 🔹 সব ইনফো দেখানোর জন্য পারফেক্ট রেশিও
//               ),
//               itemBuilder: (context, index) => _buildCustomCard(posts[index]),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCustomCard(PostModel post) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 1. ইমেজ সেকশন
//           Expanded(
//             flex: 12,
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderIcon())
//                         : _placeholderIcon(),
//                   ),
//                 ),
//                 Positioned(
//                   top: 10, left: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: AppColor.green.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(post.foodCondition,
//                         style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // 2. ইনফরমেশন সেকশন
//           Expanded(
//             flex: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(post.foodName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2D3142))),
//                   const SizedBox(height: 6),
//
//                   // কোয়ান্টিটি এবং কতজনের খাবার (একই রো-তে সুন্দর করে সাজানো)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _miniInfoItem(Icons.inventory_2_outlined, post.quantity),
//                       _miniInfoItem(Icons.people_outline, "${post.estimatePersons} prs"),
//                     ],
//                   ),
//                   const SizedBox(height: 5),
//                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
//                   const SizedBox(height: 5),
//                   _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _miniInfoItem(IconData icon, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 12, color: AppColor.green.withOpacity(0.8)),
//         const SizedBox(width: 4),
//         Flexible(
//           child: Text(text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w500)),
//         ),
//       ],
//     );
//   }
//
//   Widget _placeholderIcon() => Container(color: Colors.grey[100], child: const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 30)));
//
//   Widget _buildShimmerLoading() {
//     return GridView.builder(
//       shrinkWrap: true, itemCount: 4,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 0.68),
//       itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16))),
//     );
//   }
// }

//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../auth/data/model/post_model.dart';
//
// class DonorRecentSection extends StatelessWidget {
//   final VoidCallback onActionTap;
//   const DonorRecentSection({super.key, required this.onActionTap});
//
//   // 🔹 টাইম ফিল্টারিং লজিক (Error-safe parsing)
//   bool isPostStillValid(PostModel post) {
//     try {
//       final now = DateTime.now();
//       if (post.expiryDate != null) return now.isBefore(post.expiryDate!);
//
//       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
//       final String timeString = post.pickupTime;
//       if (timeString.isEmpty) return true;
//
//       final parts = timeString.split(' (');
//       final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
//       final match = timeRegex.firstMatch(parts[0].trim());
//
//       if (match != null) {
//         int hour = int.parse(match.group(1)!);
//         int minute = int.parse(match.group(2)!);
//         String period = match.group(3)!;
//         if (period == "PM" && hour < 12) hour += 12;
//         if (period == "AM" && hour == 12) hour = 0;
//
//         DateTime pickupDateTime = DateTime(createdDate.year, createdDate.month, createdDate.day, hour, minute);
//         if (parts.length > 1 && parts[1].toLowerCase().contains("tomorrow")) {
//           pickupDateTime = pickupDateTime.add(const Duration(days: 1));
//         }
//         return now.isBefore(pickupDateTime);
//       }
//       return true;
//     } catch (e) {
//       return true;
//     }
//   }
//
//   Stream<List<PostModel>> getRecentPosts() {
//     return FirebaseFirestore.instance
//         .collection('posts')
//         .where('status', isEqualTo: 'available')
//         .orderBy('createdAt', descending: true)
//         .limit(4)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => PostModel.fromSnapshot(doc))
//         .where((post) => isPostStillValid(post))
//         .take(4)
//         .toList());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 🔹 অরিয়েন্টেশন চেক করা
//     final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("Recent Donations",
//                   style: AppData.heading2.copyWith(
//                       fontSize: 19,
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: -0.5)),
//               GestureDetector(
//                 onTap: onActionTap,
//                 child: const Text("See All",
//                     style: TextStyle(
//                         color: AppColor.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14)),
//               ),
//             ],
//           ),
//         ),
//         StreamBuilder<List<PostModel>>(
//           stream: getRecentPosts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading(isLandscape);
//             final posts = snapshot.data ?? [];
//             if (posts.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No active donations")));
//
//             return GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: posts.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 // 🔹 ল্যান্ডস্কেপ হলে ৩টি কলাম, পোর্টেট হলে ২টি
//                 crossAxisCount: isLandscape ? 3 : 2,
//                 mainAxisSpacing: 14,
//                 crossAxisSpacing: 14,
//                 // 🔹 ল্যান্ডস্কেপ মোডে কার্ড যাতে খুব লম্বা না হয় তাই রেশিও অ্যাডজাস্ট
//                 childAspectRatio: isLandscape ? 0.85 : 0.63,
//               ),
//               itemBuilder: (context, index) => _buildCustomCard(posts[index], isLandscape),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCustomCard(PostModel post, bool isLandscape) {
//     final String foodType = post.foodType.isEmpty ? "Other" : post.foodType;
//     final bool isVeg = foodType.toLowerCase().contains("veg");
//     final Color typeColor = isVeg ? Colors.green : Colors.redAccent;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ইমেজ অংশ
//           Expanded(
//             flex: isLandscape ? 8 : 11, // ল্যান্ডস্কেপে ইমেজ ছোট করা হয়েছে
//             child: Stack(
//               children: [
//                 Positioned.fill(
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderIcon())
//                         : _placeholderIcon(),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8, left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
//                     decoration: BoxDecoration(color: Colors.black.withOpacity(0.6), borderRadius: BorderRadius.circular(6)),
//                     child: Text(post.foodCondition, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // টেক্সট ইনফরমেশন অংশ
//           Expanded(
//             flex: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly, // কন্টেন্ট সমানভাবে ভাগ করে দেবে
//                 children: [
//                   Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Color(0xFF2D3142))),
//
//                   Text(foodType, style: TextStyle(color: typeColor, fontSize: 10, fontWeight: FontWeight.w700)),
//
//                   const Divider(height: 8, thickness: 0.5),
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _miniInfoItem(Icons.inventory_2_outlined, post.quantity),
//                       _miniInfoItem(Icons.people_outline, "${post.estimatePersons} prs"),
//                     ],
//                   ),
//                   _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
//                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _miniInfoItem(IconData icon, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 10, color: AppColor.green),
//         const SizedBox(width: 3),
//         Flexible(
//           child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 9, color: Colors.black54, fontWeight: FontWeight.w500)),
//         ),
//       ],
//     );
//   }
//
//   Widget _placeholderIcon() => Container(color: Colors.grey[100], child: const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 25)));
//
//   Widget _buildShimmerLoading(bool isLandscape) {
//     return GridView.builder(
//       shrinkWrap: true, itemCount: isLandscape ? 3 : 4,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: isLandscape ? 3 : 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: isLandscape ? 0.85 : 0.63),
//       itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16))),
//     );
//   }
// }





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../auth/data/model/post_model.dart';

class DonorRecentSection extends StatelessWidget {
  final VoidCallback onActionTap;
  const DonorRecentSection({super.key, required this.onActionTap});

  // 🔹 পোস্ট এখনো ভ্যালিড কিনা চেক
  bool isPostStillValid(PostModel post) {
    try {
      final now = DateTime.now();

      if (post.expiryDate != null) {
        return now.isBefore(post.expiryDate!);
      }

      DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
      final String timeString = post.pickupTime;
      if (timeString.isEmpty) return true;

      final parts = timeString.split(' (');
      final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
      final match = timeRegex.firstMatch(parts[0].trim());

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        String period = match.group(3)!;

        if (period == "PM" && hour < 12) hour += 12;
        if (period == "AM" && hour == 12) hour = 0;

        DateTime pickupDateTime = DateTime(
          createdDate.year,
          createdDate.month,
          createdDate.day,
          hour,
          minute,
        );

        if (parts.length > 1 &&
            parts[1].toLowerCase().contains("tomorrow")) {
          pickupDateTime =
              pickupDateTime.add(const Duration(days: 1));
        }

        return now.isBefore(pickupDateTime);
      }

      return true;
    } catch (e) {
      return true;
    }
  }

  Stream<List<PostModel>> getRecentPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('status', isEqualTo: 'available')
        .orderBy('createdAt', descending: true)
        .limit(6)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => PostModel.fromSnapshot(doc))
        .where((post) => isPostStillValid(post))
        .take(4)
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Donations",
                style: AppData.heading2.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: onActionTap,
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: AppColor.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 🔹 Post Grid
        StreamBuilder<List<PostModel>>(
          stream: getRecentPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return _buildShimmerLoading();
            }

            final posts = snapshot.data ?? [];

            if (posts.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("No active donations"),
                ),
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;

                // 🔥 Dynamic responsive ratio
                double aspectRatio = width < 350
                    ? 0.60
                    : width < 600
                    ? 0.68
                    : 0.75;

                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: posts.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // সবসময় ২টা
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: aspectRatio,
                  ),
                  itemBuilder: (context, index) =>
                      _buildCustomCard(posts[index]),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomCard(PostModel post) {
    final String foodType =
    post.foodType.isEmpty ? "Other" : post.foodType;

    final bool isVeg =
    foodType.toLowerCase().contains("veg");

    final Color typeColor =
    isVeg ? Colors.green : Colors.redAccent;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          // 🔹 Image
          Expanded(
            flex: 11,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(
                        top:
                        Radius.circular(16)),
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(
                      post.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) =>
                          _placeholder(),
                    )
                        : _placeholder(),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.6),
                      borderRadius:
                      BorderRadius.circular(
                          6),
                    ),
                    child: Text(
                      post.foodCondition,
                      style:
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Info Section
          Expanded(
            flex: 10,
            child: Padding(
              padding:
              const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceEvenly,
                children: [
                  Text(
                    post.foodName,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style:
                    const TextStyle(
                      fontWeight:
                      FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    foodType,
                    style: TextStyle(
                      color: typeColor,
                      fontSize: 10,
                      fontWeight:
                      FontWeight.w700,
                    ),
                  ),
                  const Divider(
                      height: 8,
                      thickness: 0.5),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      _miniInfo(
                          Icons
                              .inventory_2_outlined,
                          post.quantity),
                      _miniInfo(
                          Icons
                              .people_outline,
                          "${post.estimatePersons} prs"),
                    ],
                  ),
                  _miniInfo(
                      Icons
                          .location_on_outlined,
                      post.pickupAddress),
                  _miniInfo(
                      Icons
                          .schedule_outlined,
                      post.pickupTime),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniInfo(
      IconData icon, String text) {
    return Row(
      mainAxisSize:
      MainAxisSize.min,
      children: [
        Icon(icon,
            size: 10,
            color:
            AppColor.green),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow:
            TextOverflow.ellipsis,
            style:
            const TextStyle(
              fontSize: 9,
              color: Colors.black54,
              fontWeight:
              FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey[100],
      child: const Center(
        child: Icon(
          Icons.fastfood_outlined,
          color: Colors.grey,
          size: 25,
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 4,
      physics:
      const NeverScrollableScrollPhysics(),
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) =>
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius:
              BorderRadius.circular(16),
            ),
          ),
    );
  }
}