// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // import '../../../../../../../../core/constants/app_colors.dart';
// // import '../../../../../../../auth/data/model/post_model.dart';
// // import '../../provider/receiver_provider.dart';
// //
// // class ReceiverAllPost extends StatefulWidget {
// //   const ReceiverAllPost({super.key});
// //
// //   @override
// //   State<ReceiverAllPost> createState() => _ReceiverAllPostState();
// // }
// //
// // class _ReceiverAllPostState extends State<ReceiverAllPost> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
// //   }
// //
// //   bool isPostValid(PostModel post) {
// //     final now = DateTime.now();
// //     if (post.status != 'available') return false;
// //     if (post.expiryDate != null) {
// //       return post.expiryDate!.isAfter(now);
// //     }
// //     return true;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<ReceiverProvider>();
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Scaffold(
// //       // Adaptive Background
// //       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColor.green, // Using primary green
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: AppColor.white),
// //         title: const Text(
// //           "Available Food Near You",
// //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.white),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: BaseScreen(
// //         child: StreamBuilder<QuerySnapshot>(
// //           stream: FirebaseFirestore.instance
// //               .collection('posts')
// //               .where('status', isEqualTo: 'available')
// //               .orderBy('createdAt', descending: true)
// //               .snapshots(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //             }
// //
// //             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //               return _emptyView(context, "No food posts available");
// //             }
// //
// //             final posts = snapshot.data!.docs
// //                 .map((doc) => PostModel.fromSnapshot(doc))
// //                 .where((post) {
// //               final bool notRequested = !provider.myRequestIds.contains(post.postId);
// //               final bool valid = isPostValid(post);
// //               return notRequested && valid;
// //             }).toList();
// //
// //             if (posts.isEmpty) {
// //               return _emptyView(context, "All items are either requested or expired");
// //             }
// //
// //             return GridView.builder(
// //               padding: const EdgeInsets.all(10),
// //               itemCount: posts.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 10,
// //                 crossAxisSpacing: 10,
// //                 childAspectRatio: 0.68,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final post = posts[index];
// //                 final isLoading = provider.isRequesting[post.postId] ?? false;
// //                 return _buildModernPostCard(context, post, isLoading, provider);
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildModernPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Container(
// //       decoration: BoxDecoration(
// //         // Adaptive card color
// //         color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
// //         borderRadius: BorderRadius.circular(15),
// //         border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
// //         boxShadow: isDark ? [] : [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.04),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Expanded(
// //             flex: 4,
// //             child: ClipRRect(
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
// //               child: Stack(
// //                 children: [
// //                   Container(
// //                     width: double.infinity,
// //                     color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
// //                     child: post.imageUrls.isNotEmpty
// //                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
// //                         errorBuilder: (_, __, ___) => Icon(Icons.fastfood_outlined,
// //                             color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray))
// //                         : Icon(Icons.fastfood_outlined,
// //                         color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray, size: 40),
// //                   ),
// //                   Positioned(
// //                     top: 8,
// //                     left: 8,
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                       decoration: BoxDecoration(
// //                         color: isDark ? AppColor.green.withOpacity(0.8) : AppColor.white.withOpacity(0.9),
// //                         borderRadius: BorderRadius.circular(5),
// //                       ),
// //                       child: Text(
// //                         "Fresh",
// //                         style: TextStyle(
// //                             color: isDark ? AppColor.white : AppColor.green,
// //                             fontSize: 10,
// //                             fontWeight: FontWeight.bold
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 6,
// //             child: Padding(
// //               padding: const EdgeInsets.all(10),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     post.foodName,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 14,
// //                         color: isDark ? AppColor.white : AppColor.black
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   _infoRow(context, Icons.group_outlined, "For: ${post.quantity} Person"),
// //                   _infoRow(context, Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
// //                   _infoRow(context, Icons.location_on_outlined, post.pickupAddress),
// //                   const Spacer(),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 36,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: AppColor.green,
// //                         foregroundColor: AppColor.white,
// //                         elevation: 0,
// //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //                       ),
// //                       onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
// //                       child: isLoading
// //                           ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: AppColor.white, strokeWidth: 2))
// //                           : const Text("Request Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _infoRow(BuildContext context, IconData icon, String text) {
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 5),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 14, color: AppColor.green.withOpacity(0.8)),
// //           const SizedBox(width: 6),
// //           Expanded(
// //             child: Text(
// //               text,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(
// //                   fontSize: 11,
// //                   color: isDark ? AppColor.white.withOpacity(0.6) : AppColor.gray
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _emptyView(BuildContext context, String message) {
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(
// //               Icons.layers_clear_outlined,
// //               size: 50,
// //               color: isDark ? AppColor.gray.withOpacity(0.5) : AppColor.gray.withOpacity(0.2)
// //           ),
// //           const SizedBox(height: 10),
// //           Text(message, style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.4) : AppColor.gray)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/post_model.dart';
// import '../../provider/receiver_provider.dart';
//
// class ReceiverAllPost extends StatefulWidget {
//   const ReceiverAllPost({super.key});
//
//   @override
//   State<ReceiverAllPost> createState() => _ReceiverAllPostState();
// }
//
// class _ReceiverAllPostState extends State<ReceiverAllPost> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
//   }
//
//   bool isPostValid(PostModel post) {
//     final now = DateTime.now();
//     if (post.status != 'available') return false;
//     if (post.expiryDate != null) return post.expiryDate!.isAfter(now);
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<ReceiverProvider>();
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColor.green,
//         title: const Text("Available Food", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('posts').where('status', isEqualTo: 'available').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return _emptyView("No food available");
//
//             final posts = snapshot.data!.docs.map((doc) => PostModel.fromSnapshot(doc)).where((post) {
//               return !provider.myRequestIds.contains(post.postId) && isPostValid(post);
//             }).toList();
//
//             // ✅ SAFE SORTING (Timestamp to DateTime)
//             posts.sort((a, b) {
//               final DateTime dateA = a.createdAt?.toDate() ?? DateTime(2000);
//               final DateTime dateB = b.createdAt?.toDate() ?? DateTime(2000);
//               return dateB.compareTo(dateA);
//             });
//
//             if (posts.isEmpty) return _emptyView("No valid items found");
//
//             return ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: posts.length,
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 final isLoading = provider.isRequesting[post.postId] ?? false;
//                 return _buildFullCard(context, post, isLoading, provider);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFullCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: isDark ? Colors.white10 : Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//             child: post.imageUrls.isNotEmpty
//                 ? Image.network(post.imageUrls.first, height: 180, width: double.infinity, fit: BoxFit.cover)
//                 : Container(height: 100, color: Colors.grey, child: const Icon(Icons.fastfood)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(post.foodName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     _badge(post.foodType, post.foodType.toLowerCase() == "vegetarian" ? Colors.green : Colors.red),
//                   ],
//                 ),
//                 Text(post.foodCondition, style: const TextStyle(color: AppColor.green, fontStyle: FontStyle.italic)),
//                 const Divider(height: 20),
//                 _infoLarge(Icons.inventory_2_outlined, "Quantity: ${post.quantity}"),
//                 _infoLarge(Icons.people_outline, "For: ${post.estimatePersons} Persons"),
//                 _infoLarge(Icons.location_on_outlined, post.pickupAddress),
//                 const SizedBox(height: 15),
//                 SizedBox(
//                   width: double.infinity, height: 45,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                     onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
//                     child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Request Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _badge(String text, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)), child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10)));
//   Widget _infoLarge(IconData icon, String text) => Padding(padding: const EdgeInsets.only(bottom: 5), child: Row(children: [Icon(icon, size: 16, color: AppColor.green), const SizedBox(width: 8), Expanded(child: Text(text, style: const TextStyle(fontSize: 13)))]));
//   Widget _emptyView(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// }





import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';

class ReceiverAllPost extends StatefulWidget {
  const ReceiverAllPost({super.key});

  @override
  State<ReceiverAllPost> createState() => _ReceiverAllPostState();
}

class _ReceiverAllPostState extends State<ReceiverAllPost> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
  }

  bool isPostValid(PostModel post) {
    final now = DateTime.now();
    if (post.status != 'available') return false;
    if (post.expiryDate != null) return post.expiryDate!.isAfter(now);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.green,
        title: const Text("Available Food Near You",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('status', isEqualTo: 'available')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColor.green));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return _emptyView("No food available right now");
            }

            // মডেল এ রূপান্তর এবং ফিল্টারিং
            final posts = snapshot.data!.docs.map((doc) => PostModel.fromSnapshot(doc)).where((post) {
              return !provider.myRequestIds.contains(post.postId) && isPostValid(post);
            }).toList();

            // সর্টিং (টাইমস্ট্যাম্প টু ডেটটাইম)
            posts.sort((a, b) {
              final DateTime dateA = a.createdAt?.toDate() ?? DateTime(2000);
              final DateTime dateB = b.createdAt?.toDate() ?? DateTime(2000);
              return dateB.compareTo(dateA);
            });

            if (posts.isEmpty) return _emptyView("All items are already requested");

            // ✅ এখানে ListView ব্যবহার করা হয়েছে যা ১টি করে শো করবে
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final post = posts[index];
                final isLoading = provider.isRequesting[post.postId] ?? false;

                // ১টি করে আইটেম নিশ্চিত করতে উইডথ double.infinity করা হয়েছে
                return _buildFullCard(context, post, isLoading, provider);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildFullCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width, // স্ক্রিনের পুরো প্রস্থ নিবে
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: isDark ? [] : [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ইমেজ সেকশন
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: post.imageUrls.isNotEmpty
                ? Image.network(
              post.imageUrls.first,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image)
              ),
            )
                : Container(height: 200, color: Colors.grey[200], child: const Icon(Icons.fastfood, size: 50)),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // নাম এবং ব্যাজ
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(post.foodName,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    _badge(post.foodType, post.foodType.toLowerCase() == "vegetarian" ? Colors.green : Colors.red),
                  ],
                ),
                const SizedBox(height: 4),
                // কন্ডিশন
                Text(post.foodCondition,
                    style: const TextStyle(color: AppColor.green, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500)),

                const Divider(height: 24),

                // ইনফরমেশন রো
                _infoLarge(Icons.inventory_2_outlined, "Quantity: ${post.quantity}"),
                _infoLarge(Icons.people_alt_outlined, "Estimate: For ${post.estimatePersons} People"),
                _infoLarge(Icons.location_on_outlined, post.pickupAddress),
                _infoLarge(Icons.access_time, "Pickup: ${post.pickupTime}"),

                const SizedBox(height: 20),

                // বাটন
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
                    child: isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text("Request Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _badge(String text, Color color) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)));

  Widget _infoLarge(IconData icon, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(children: [Icon(icon, size: 18, color: AppColor.green), const SizedBox(width: 10), Expanded(child: Text(text, style: const TextStyle(fontSize: 14)))]));

  Widget _emptyView(String msg) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.no_food, size: 64, color: Colors.grey[400]),
        const SizedBox(height: 16),
        Text(msg, style: const TextStyle(color: Colors.grey, fontSize: 16)),
      ],
    ),
  );
}