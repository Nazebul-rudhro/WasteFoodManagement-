// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   /// 🔹 Firestore stream for recent posts
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .orderBy('createdAt', descending: true)
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) =>
// // //         snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList());
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         /// 🔹 Header
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text(
// // //               "Recent Donations",
// // //               style: AppData.heading2,
// // //             ),
// // //             GestureDetector(
// // //               onTap: onActionTap,
// // //               child: Text(
// // //                 "See All",
// // //                 style: AppData.heading2.copyWith(color: AppColor.green),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //
// // //         /// 🔹 Donation Grid
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Padding(
// // //                 padding: EdgeInsets.all(20),
// // //                 child: Center(
// // //                   child: CircularProgressIndicator(color: Colors.green),
// // //                 ),
// // //               );
// // //             }
// // //
// // //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //               return const Padding(
// // //                 padding: EdgeInsets.all(20),
// // //                 child: Center(
// // //                   child: Text(
// // //                     "No recent donations",
// // //                     style: TextStyle(color: Colors.grey),
// // //                   ),
// // //                 ),
// // //               );
// // //             }
// // //
// // //             final posts = snapshot.data!;
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 10,
// // //                 crossAxisSpacing: 10,
// // //                 childAspectRatio: 0.82,
// // //               ),
// // //               itemBuilder: (context, index) {
// // //                 return _buildPostCard(posts[index]);
// // //               },
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   /// 🔹 Post Card UI
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.05),
// // //             blurRadius: 8,
// // //             offset: const Offset(0, 4),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           /// Image
// // //           Expanded(
// // //             child: ClipRRect(
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //               child: post.imageUrls.isNotEmpty
// // //                   ? Image.network(
// // //                 post.imageUrls.first,
// // //                 width: double.infinity,
// // //                 fit: BoxFit.cover,
// // //                 errorBuilder: (_, __, ___) => _imagePlaceholder(),
// // //               )
// // //                   : _imagePlaceholder(),
// // //             ),
// // //           ),
// // //
// // //           /// Info
// // //           Padding(
// // //             padding: const EdgeInsets.all(8),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Text(
// // //                       post.foodName,
// // //                       maxLines: 1,
// // //                       overflow: TextOverflow.ellipsis,
// // //                       style: const TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 13,
// // //                       ),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       "Qty: ${post.quantity}",
// // //                       style: const TextStyle(
// // //                         color: Colors.green,
// // //                         fontSize: 11,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 const SizedBox(height: 4),
// // //
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     /// 📍 Address (Left)
// // //                     Expanded(
// // //                       child: Row(
// // //                         children: [
// // //                           const Icon(
// // //                             Icons.location_on,
// // //                             size: 12,
// // //                             color: Colors.grey,
// // //                           ),
// // //                           const SizedBox(width: 4),
// // //                           Expanded(
// // //                             child: Text(
// // //                               post.pickupAddress,
// // //                               maxLines: 1,
// // //                               overflow: TextOverflow.ellipsis,
// // //                               style: const TextStyle(
// // //                                 fontSize: 10,
// // //                                 color: Colors.grey,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //
// // //                     const SizedBox(width: 6),
// // //
// // //                     /// ⏰ Pickup Time (Right)
// // //                     Row(
// // //                       children: [
// // //                         const Icon(
// // //                           Icons.access_time,
// // //                           size: 12,
// // //                           color: Colors.grey,
// // //                         ),
// // //                         const SizedBox(width: 3),
// // //                         Text(
// // //                           post.pickupTime.isNotEmpty ? post.pickupTime : 'N/A',
// // //                           style: const TextStyle(
// // //                             fontSize: 10,
// // //                             color: Colors.grey,
// // //                             fontWeight: FontWeight.w500,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() {
// // //     return Container(
// // //       color: Colors.grey[100],
// // //       child: const Center(
// // //         child: Icon(Icons.fastfood, color: Colors.grey),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available') // লজিক: অনুমোদিত পোস্ট এখানে আসবে না
// // //         .orderBy('createdAt', descending: true)
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) =>
// // //         snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList());
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text("Recent Donations", style: AppData.heading2),
// // //             GestureDetector(
// // //               onTap: onActionTap,
// // //               child: Text("See All", style: AppData.heading2.copyWith(color: AppColor.green)),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Center(child: CircularProgressIndicator(color: Colors.green));
// // //             }
// // //             if (snapshot.hasError) {
// // //               return Center(child: Text("Error: Check Firestore Indexing"));
// // //             }
// // //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //               return const Center(child: Padding(
// // //                 padding: EdgeInsets.all(20.0),
// // //                 child: Text("No available donations", style: TextStyle(color: Colors.grey)),
// // //               ));
// // //             }
// // //             final posts = snapshot.data!;
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 10,
// // //                 crossAxisSpacing: 10,
// // //                 childAspectRatio: 0.82,
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index]),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             child: ClipRRect(
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //               child: post.imageUrls.isNotEmpty
// // //                   ? Image.network(post.imageUrls.first, width: double.infinity, fit: BoxFit.cover,
// // //                   errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                   : _imagePlaceholder(),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
// // //                 Text("Qty: ${post.quantity}", style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
// // //                 const SizedBox(height: 4),
// // //                 Row(
// // //                   children: [
// // //                     const Icon(Icons.location_on, size: 12, color: Colors.grey),
// // //                     const SizedBox(width: 4),
// // //                     Expanded(child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Colors.grey))),
// // //                   ],
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: Colors.grey[100], child: const Center(child: Icon(Icons.fastfood, color: Colors.grey)));
// // // }
// //
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available') // Only shows available
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error for doc ${doc.id}: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text("Recent Donations", style: AppData.heading2),
// // //             GestureDetector(
// // //               onTap: onActionTap,
// // //               child: Text("See All", style: AppData.heading2.copyWith(color: AppColor.green)),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Center(child: CircularProgressIndicator(color: Colors.green));
// // //             }
// // //
// // //             if (snapshot.hasError) {
// // //               return Center(child: Text("Error: ${snapshot.error}"));
// // //             }
// // //
// // //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //               return const Center(
// // //                 child: Padding(
// // //                   padding: EdgeInsets.all(20.0),
// // //                   child: Text("No available donations found in Database",
// // //                       style: TextStyle(color: Colors.grey)),
// // //                 ),
// // //               );
// // //             }
// // //
// // //             final posts = snapshot.data!;
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 10,
// // //                 crossAxisSpacing: 10,
// // //                 childAspectRatio: 0.82,
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index]),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             child: ClipRRect(
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //               child: post.imageUrls.isNotEmpty
// // //                   ? Image.network(post.imageUrls.first, width: double.infinity, fit: BoxFit.cover,
// // //                   errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                   : _imagePlaceholder(),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
// // //                 Text("Qty: ${post.quantity}",
// // //                     style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: Colors.grey[100],
// // //       child: const Center(child: Icon(Icons.fastfood, color: Colors.grey)));
// // // }
// //
// //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .limit(4) // এখানে ৪টি পোস্টের লিমিট যোগ করা হয়েছে
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error for doc ${doc.id}: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text("Recent Donations", style: AppData.heading2),
// // //             GestureDetector(
// // //               onTap: onActionTap,
// // //               child: Text("See All", style: AppData.heading2.copyWith(color: AppColor.green)),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Center(child: CircularProgressIndicator(color: Colors.green));
// // //             }
// // //
// // //             if (snapshot.hasError) {
// // //               return Center(child: Text("Error: ${snapshot.error}"));
// // //             }
// // //
// // //             if (!snapshot.hasData || snapshot.data!.isEmpty) {
// // //               return const Center(
// // //                 child: Padding(
// // //                   padding: EdgeInsets.all(20.0),
// // //                   child: Text("No available donations found in Database",
// // //                       style: TextStyle(color: Colors.grey)),
// // //                 ),
// // //               );
// // //             }
// // //
// // //             final posts = snapshot.data!;
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               // এখানে নিশ্চিত করা হয়েছে যেন ৪টির বেশি পোস্ট না দেখায়
// // //               itemCount: posts.length > 4 ? 4 : posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 10,
// // //                 crossAxisSpacing: 10,
// // //                 childAspectRatio: 0.82,
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index]),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             child: ClipRRect(
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //               child: post.imageUrls.isNotEmpty
// // //                   ? Image.network(post.imageUrls.first, width: double.infinity, fit: BoxFit.cover,
// // //                   errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                   : _imagePlaceholder(),
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(8),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
// // //                 Text("Qty: ${post.quantity}",
// // //                     style: const TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: Colors.grey[100],
// // //       child: const Center(child: Icon(Icons.fastfood, color: Colors.grey)));
// // // }
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   // 🔹 Firestore থেকে ডাটা আনার স্ট্রিম (শুধুমাত্র ৪টি এভেইলঅ্যাবল পোস্ট)
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .orderBy('createdAt', descending: true) // নতুন পোস্ট আগে দেখাবে
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error parsing post: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // --- Header ---
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text("Recent Donations", style: AppData.heading2.copyWith(fontSize: 18)),
// // //             TextButton(
// // //               onPressed: onActionTap,
// // //               style: TextButton.styleFrom(foregroundColor: AppColor.green),
// // //               child: const Text("See All", style: TextStyle(fontWeight: FontWeight.bold)),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 12),
// // //
// // //         // --- Post Grid ---
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return _buildShimmerLoading(); // আধুনিক লোডিং
// // //             }
// // //
// // //             if (snapshot.hasError) {
// // //               return _buildErrorState("Failed to load data");
// // //             }
// // //
// // //             final posts = snapshot.data ?? [];
// // //
// // //             if (posts.isEmpty) {
// // //               return _buildEmptyState();
// // //             }
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 15,
// // //                 crossAxisSpacing: 15,
// // //                 childAspectRatio: 0.78, // কার্ডের উচ্চতা কিছুটা বাড়ানো হয়েছে
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index]),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // 🔹 প্রফেশনাল পোস্ট কার্ড ডিজাইন
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.06),
// // //             blurRadius: 10,
// // //             offset: const Offset(0, 4),
// // //           )
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // ইমেজ এবং কন্ডিশন ট্যাগ
// // //           Expanded(
// // //             flex: 6,
// // //             child: Stack(
// // //               children: [
// // //                 ClipRRect(
// // //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
// // //                   child: post.imageUrls.isNotEmpty
// // //                       ? Image.network(
// // //                     post.imageUrls.first,
// // //                     width: double.infinity,
// // //                     height: double.infinity,
// // //                     fit: BoxFit.cover,
// // //                     errorBuilder: (_, __, ___) => _imagePlaceholder(),
// // //                   )
// // //                       : _imagePlaceholder(),
// // //                 ),
// // //                 // 🔹 কন্ডিশন ট্যাগ (যেমন: Fresh)
// // //                 Positioned(
// // //                   top: 8,
// // //                   left: 8,
// // //                   child: Container(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white.withOpacity(0.9),
// // //                       borderRadius: BorderRadius.circular(20),
// // //                     ),
// // //                     child: Text(
// // //                       post.foodCondition, // মডেল এ এটি থাকলে
// // //                       style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColor.green),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //           // ইনফরমেশন সেকশন
// // //           Expanded(
// // //             flex: 4,
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(10),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Text(
// // //                     post.foodName,
// // //                     maxLines: 1,
// // //                     overflow: TextOverflow.ellipsis,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on, size: 12, color: Colors.grey),
// // //                       const SizedBox(width: 4),
// // //                       Expanded(
// // //                         child: Text(
// // //                           post.pickupAddress,
// // //                           maxLines: 1,
// // //                           overflow: TextOverflow.ellipsis,
// // //                           style: const TextStyle(color: Colors.grey, fontSize: 11),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   const Divider(),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Text(
// // //                         "Qty: ${post.quantity}",
// // //                         style: const TextStyle(color: AppColor.green, fontSize: 11, fontWeight: FontWeight.bold),
// // //                       ),
// // //                       Text(
// // //                         "For: ${post.estimatePersons}",
// // //                         style: const TextStyle(color: Colors.grey, fontSize: 10),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- 🔹 হেল্পার উইজেটস ---
// // //
// // //   Widget _imagePlaceholder() => Container(
// // //     width: double.infinity,
// // //     color: Colors.grey[100],
// // //     child: const Center(child: Icon(Icons.fastfood, color: Colors.grey, size: 30)),
// // //   );
// // //
// // //   Widget _buildEmptyState() => Center(
// // //     child: Column(
// // //       children: const [
// // //         SizedBox(height: 20),
// // //         Icon(Icons.layers_clear_outlined, size: 50, color: Colors.grey),
// // //         SizedBox(height: 10),
// // //         Text("No available donations", style: TextStyle(color: Colors.grey)),
// // //       ],
// // //     ),
// // //   );
// // //
// // //   Widget _buildErrorState(String error) => Center(
// // //     child: Text(error, style: const TextStyle(color: Colors.red)),
// // //   );
// // //
// // //   // 🔹 শিমার লোডিং ইফেক্ট (আধুনিক অ্যাপের মতো)
// // //   Widget _buildShimmerLoading() {
// // //     return GridView.builder(
// // //       shrinkWrap: true,
// // //       physics: const NeverScrollableScrollPhysics(),
// // //       itemCount: 4,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //         crossAxisCount: 2,
// // //         mainAxisSpacing: 15,
// // //         crossAxisSpacing: 15,
// // //         childAspectRatio: 0.78,
// // //       ),
// // //       itemBuilder: (context, index) => Container(
// // //         decoration: BoxDecoration(
// // //           color: Colors.grey[200],
// // //           borderRadius: BorderRadius.circular(16),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   // 🔹 Firestore থেকে রিয়েল-টাইম ডাটা আনার স্ট্রিম
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .orderBy('createdAt', descending: true) // নতুন পোস্ট সবার আগে
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error parsing post: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   // 🔹 সময় ফরম্যাট করার ফাংশন (e.g., 2h ago)
// // //   String _formatTimeAgo(Timestamp? timestamp) {
// // //     if (timestamp == null) return "Just now";
// // //     final DateTime postDate = timestamp.toDate();
// // //     final Duration diff = DateTime.now().difference(postDate);
// // //
// // //     if (diff.inDays > 0) return "${diff.inDays}d ago";
// // //     if (diff.inHours > 0) return "${diff.inHours}h ago";
// // //     if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
// // //     return "Just now";
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // --- Header Section ---
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Text("Recent Donations", style: AppData.heading2.copyWith(fontSize: 18)),
// // //             TextButton(
// // //               onPressed: onActionTap,
// // //               style: TextButton.styleFrom(foregroundColor: AppColor.green),
// // //               child: const Text("See All", style: TextStyle(fontWeight: FontWeight.bold)),
// // //             ),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 12),
// // //
// // //         // --- StreamBuilder for Real-time Updates ---
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return _buildShimmerLoading();
// // //             }
// // //
// // //             if (snapshot.hasError) {
// // //               return _buildErrorState("Something went wrong!");
// // //             }
// // //
// // //             final posts = snapshot.data ?? [];
// // //
// // //             if (posts.isEmpty) {
// // //               return _buildEmptyState();
// // //             }
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 15,
// // //                 crossAxisSpacing: 15,
// // //                 childAspectRatio: 0.75, // কার্ডের হাইট কিছুটা বাড়ানো হয়েছে
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index]),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // 🔹 প্রফেশনাল কার্ড ডিজাইন
// // //   Widget _buildPostCard(PostModel post) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(16),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.05),
// // //             blurRadius: 10,
// // //             offset: const Offset(0, 4),
// // //           )
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // ইমেজ এবং ব্যাজ সেকশন
// // //           Expanded(
// // //             flex: 6,
// // //             child: Stack(
// // //               children: [
// // //                 ClipRRect(
// // //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
// // //                   child: post.imageUrls.isNotEmpty
// // //                       ? Image.network(
// // //                     post.imageUrls.first,
// // //                     width: double.infinity,
// // //                     height: double.infinity,
// // //                     fit: BoxFit.cover,
// // //                     errorBuilder: (_, __, ___) => _imagePlaceholder(),
// // //                   )
// // //                       : _imagePlaceholder(),
// // //                 ),
// // //
// // //                 // ১. Condition Badge (বাম দিকে)
// // //                 Positioned(
// // //                   top: 8,
// // //                   left: 8,
// // //                   child: Container(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //                     decoration: BoxDecoration(
// // //                       color: AppColor.green.withOpacity(0.9),
// // //                       borderRadius: BorderRadius.circular(20),
// // //                     ),
// // //                     child: Text(
// // //                       post.foodCondition,
// // //                       style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
// // //                     ),
// // //                   ),
// // //                 ),
// // //
// // //                 // ২. Time Ago Badge (ডান দিকে)
// // //                 Positioned(
// // //                   top: 8,
// // //                   right: 8,
// // //                   child: Container(
// // //                     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.black.withOpacity(0.6),
// // //                       borderRadius: BorderRadius.circular(8),
// // //                     ),
// // //                     child: Row(
// // //                       mainAxisSize: MainAxisSize.min,
// // //                       children: [
// // //                         const Icon(Icons.access_time, size: 10, color: Colors.white),
// // //                         const SizedBox(width: 4),
// // //                         Text(
// // //                           _formatTimeAgo(post.createdAt),
// // //                           style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w500),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //
// // //           // টেক্সট ইনফরমেশন সেকশন
// // //           Expanded(
// // //             flex: 5,
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(10),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(
// // //                     post.foodName,
// // //                     maxLines: 1,
// // //                     overflow: TextOverflow.ellipsis,
// // //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on, size: 12, color: Colors.grey),
// // //                       const SizedBox(width: 3),
// // //                       Expanded(
// // //                         child: Text(
// // //                           post.pickupAddress,
// // //                           maxLines: 1,
// // //                           overflow: TextOverflow.ellipsis,
// // //                           style: const TextStyle(color: Colors.grey, fontSize: 11),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   const Spacer(),
// // //                   const Divider(height: 10),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Text(
// // //                         "Qty: ${post.quantity}",
// // //                         style: const TextStyle(color: AppColor.green, fontSize: 11, fontWeight: FontWeight.bold),
// // //                       ),
// // //                       Container(
// // //                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //                         decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
// // //                         child: Text(
// // //                           "For ${post.estimatePersons}",
// // //                           style: const TextStyle(color: Colors.black54, fontSize: 9, fontWeight: FontWeight.w600),
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- হেল্পার উইজেটস ---
// // //
// // //   Widget _imagePlaceholder() => Container(
// // //     width: double.infinity,
// // //     color: Colors.grey[100],
// // //     child: const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 30)),
// // //   );
// // //
// // //   Widget _buildEmptyState() => const Center(
// // //     child: Padding(
// // //       padding: EdgeInsets.symmetric(vertical: 20),
// // //       child: Text("No donations available at the moment", style: TextStyle(color: Colors.grey)),
// // //     ),
// // //   );
// // //
// // //   Widget _buildErrorState(String msg) => Center(
// // //     child: Text(msg, style: const TextStyle(color: Colors.red)),
// // //   );
// // //
// // //   Widget _buildShimmerLoading() {
// // //     return GridView.builder(
// // //       shrinkWrap: true,
// // //       itemCount: 4,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //         crossAxisCount: 2,
// // //         mainAxisSpacing: 15,
// // //         crossAxisSpacing: 15,
// // //         childAspectRatio: 0.75,
// // //       ),
// // //       itemBuilder: (context, index) => Container(
// // //         decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   // 🔹 Firestore Stream
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .orderBy('createdAt', descending: true)
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error parsing post: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   // 🔹 Pro Time Ago Formatter
// // //   String _formatTimeAgo(Timestamp? timestamp) {
// // //     if (timestamp == null) return "Just now";
// // //     final diff = DateTime.now().difference(timestamp.toDate());
// // //     if (diff.inDays > 0) return "${diff.inDays}d ago";
// // //     if (diff.inHours > 0) return "${diff.inHours}h ago";
// // //     if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
// // //     return "Just now";
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // --- Header Section ---
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //           child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               Text("Recent Donations",
// // //                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
// // //               InkWell(
// // //                 onTap: onActionTap,
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// // //                   child: Text("See All",
// // //                       style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //
// // //         const SizedBox(height: 8),
// // //
// // //         // --- Grid View ---
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
// // //             if (snapshot.hasError) return _buildErrorState();
// // //
// // //             final posts = snapshot.data ?? [];
// // //             if (posts.isEmpty) return _buildEmptyState();
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 16,
// // //                 crossAxisSpacing: 16,
// // //                 childAspectRatio: 0.68, // কার্ডের ইনফরমেশন অনুযায়ী পারফেক্ট রেশিও
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index], context),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildPostCard(PostModel post, BuildContext context) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.04),
// // //             blurRadius: 15,
// // //             offset: const Offset(0, 8),
// // //           )
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // 1. Image & Condition Badge
// // //           Expanded(
// // //             flex: 11,
// // //             child: Stack(
// // //               children: [
// // //                 Container(
// // //                   width: double.infinity,
// // //                   margin: const EdgeInsets.all(6),
// // //                   child: ClipRRect(
// // //                     borderRadius: BorderRadius.circular(14),
// // //                     child: post.imageUrls.isNotEmpty
// // //                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
// // //                         errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                         : _imagePlaceholder(),
// // //                   ),
// // //                 ),
// // //                 Positioned(
// // //                   top: 12,
// // //                   left: 12,
// // //                   child: _buildBadge(post.foodCondition),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //
// // //           // 2. Info Section
// // //           Expanded(
// // //             flex: 10,
// // //             child: Padding(
// // //               padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post.foodName,
// // //                       maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF2D3142))),
// // //
// // //                   // const Spacer(),
// // //                   SizedBox(height: 5,),
// // //
// // //                   // Address with Icon
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on_rounded, size: 14, color: AppColor.green),
// // //                       const SizedBox(width: 4),
// // //                       Expanded(
// // //                         child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                             style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w500)),
// // //                       ),
// // //                     ],
// // //                   ),
// // //
// // //                   const SizedBox(height: 4),
// // //
// // //                   // Time Ago with Icon
// // //                   Row(
// // //                     children: [
// // //                       Icon(Icons.access_time_filled_rounded, size: 13, color: Colors.orange.shade300),
// // //                       const SizedBox(width: 4),
// // //                       Text(_formatTimeAgo(post.createdAt),
// // //                           style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.w600)),
// // //                     ],
// // //                   ),
// // //
// // //                   const Padding(
// // //                     padding: EdgeInsets.symmetric(vertical: 8.0),
// // //                     child: Divider(height: 1, thickness: 0.6, color: Color(0xFFF1F3F6)),
// // //                   ),
// // //
// // //                   // Bottom Info (Qty & Persons)
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Text("Qty: ${post.quantity}",
// // //                           style: const TextStyle(color: AppColor.green, fontSize: 11, fontWeight: FontWeight.w800)),
// // //                       Text("👤 ${post.estimatePersons}",
// // //                           style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- UI Components ---
// // //
// // //   Widget _buildBadge(String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white.withOpacity(0.9),
// // //         borderRadius: BorderRadius.circular(10),
// // //         boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
// // //       ),
// // //       child: Text(text,
// // //           style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppColor.green, letterSpacing: 0.5)),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: const Color(0xFFF8F9FA),
// // //       child: const Center(child: Icon(Icons.fastfood_rounded, color: Colors.grey, size: 28)));
// // //
// // //   Widget _buildEmptyState() => const Center(
// // //       child: Text("No active donations found", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)));
// // //
// // //   Widget _buildErrorState() => const Center(child: Icon(Icons.error_outline, color: Colors.red));
// // //
// // //   Widget _buildShimmerLoading() {
// // //     return GridView.builder(
// // //       shrinkWrap: true, itemCount: 4,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //           crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.68),
// // //       itemBuilder: (context, index) => Container(
// // //           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18))),
// // //     );
// // //   }
// // // }
// //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   // 🔹 Firestore Stream: স্ট্যাটাস 'available' এবং নতুন পোস্ট আগে দেখাবে
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .orderBy('createdAt', descending: true)
// // //         .limit(4)
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs.map((doc) {
// // //         try {
// // //           return PostModel.fromSnapshot(doc);
// // //         } catch (e) {
// // //           debugPrint("Error parsing post: $e");
// // //           return null;
// // //         }
// // //       }).whereType<PostModel>().toList();
// // //     });
// // //   }
// // //
// // //   // 🔹 প্রোফেশনাল টাইম এগো ফরমেটার
// // //   String _formatTimeAgo(Timestamp? timestamp) {
// // //     if (timestamp == null) return "Just now";
// // //     final diff = DateTime.now().difference(timestamp.toDate());
// // //     if (diff.inDays > 0) return "${diff.inDays}d ago";
// // //     if (diff.inHours > 0) return "${diff.inHours}h ago";
// // //     if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
// // //     return "Just now";
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         // --- Header Section ---
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //           child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               Text("Recent Donations",
// // //                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
// // //               InkWell(
// // //                 onTap: onActionTap,
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 child: const Padding(
// // //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// // //                   child: Text("See All",
// // //                       style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //
// // //         const SizedBox(height: 8),
// // //
// // //         // --- Grid View Logic ---
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
// // //
// // //             if (snapshot.hasError) {
// // //               debugPrint("Firestore Stream Error: ${snapshot.error}");
// // //               return _buildErrorState();
// // //             }
// // //
// // //             final posts = snapshot.data ?? [];
// // //             if (posts.isEmpty) return _buildEmptyState();
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 16,
// // //                 crossAxisSpacing: 16,
// // //                 childAspectRatio: 0.68,
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index], context),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildPostCard(PostModel post, BuildContext context) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.04),
// // //             blurRadius: 15,
// // //             offset: const Offset(0, 8),
// // //           )
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // 1. ইমেজ এবং কন্ডিশন ব্যাজ (যেমন: Fresh, Cooked)
// // //           Expanded(
// // //             flex: 11,
// // //             child: Stack(
// // //               children: [
// // //                 Container(
// // //                   width: double.infinity,
// // //                   margin: const EdgeInsets.all(6),
// // //                   child: ClipRRect(
// // //                     borderRadius: BorderRadius.circular(14),
// // //                     child: post.imageUrls.isNotEmpty
// // //                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
// // //                         errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                         : _imagePlaceholder(),
// // //                   ),
// // //                 ),
// // //                 Positioned(
// // //                   top: 12,
// // //                   left: 12,
// // //                   child: _buildBadge(post.foodCondition), // 🔹 এখন এরর দিবে না
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //
// // //           // 2. ইনফরমেশন সেকশন
// // //           Expanded(
// // //             flex: 10,
// // //             child: Padding(
// // //               padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post.foodName,
// // //                       maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF2D3142))),
// // //
// // //                   const SizedBox(height: 5),
// // //
// // //                   // লোকেশন
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on_rounded, size: 14, color: AppColor.green),
// // //                       const SizedBox(width: 4),
// // //                       Expanded(
// // //                         child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                             style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w500)),
// // //                       ),
// // //                     ],
// // //                   ),
// // //
// // //                   const SizedBox(height: 4),
// // //
// // //                   // সময়
// // //                   Row(
// // //                     children: [
// // //                       Icon(Icons.access_time_filled_rounded, size: 13, color: Colors.orange.shade300),
// // //                       const SizedBox(width: 4),
// // //                       Text(_formatTimeAgo(post.createdAt),
// // //                           style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.w600)),
// // //                     ],
// // //                   ),
// // //
// // //                   const Padding(
// // //                     padding: EdgeInsets.symmetric(vertical: 8.0),
// // //                     child: Divider(height: 1, thickness: 0.6, color: Color(0xFFF1F3F6)),
// // //                   ),
// // //
// // //                   // নিচের ইনফো (পরিমাণ এবং মানুষ)
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Text("Qty: ${post.quantity}",
// // //                           style: const TextStyle(color: AppColor.green, fontSize: 11, fontWeight: FontWeight.w800)),
// // //                       Text("👤 ${post.estimatePersons}",
// // //                           style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- ছোট ইউআই কম্পোনেন্টস ---
// // //
// // //   Widget _buildBadge(String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white.withOpacity(0.9),
// // //         borderRadius: BorderRadius.circular(10),
// // //         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
// // //       ),
// // //       child: Text(text,
// // //           style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppColor.green, letterSpacing: 0.5)),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: const Color(0xFFF8F9FA),
// // //       child: const Center(child: Icon(Icons.fastfood_rounded, color: Colors.grey, size: 28)));
// // //
// // //   Widget _buildEmptyState() => const Center(
// // //       child: Padding(
// // //         padding: EdgeInsets.all(20.0),
// // //         child: Text("No active donations found", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
// // //       ));
// // //
// // //   Widget _buildErrorState() => const Center(child: Icon(Icons.error_outline, color: Colors.red));
// // //
// // //   Widget _buildShimmerLoading() {
// // //     return GridView.builder(
// // //       shrinkWrap: true, itemCount: 4,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //           crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.68),
// // //       itemBuilder: (context, index) => Container(
// // //           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18))),
// // //     );
// // //   }
// // // }
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class DonorRecentSection extends StatelessWidget {
// // //   final VoidCallback onActionTap;
// // //   const DonorRecentSection({super.key, required this.onActionTap});
// // //
// // //   // 🔹 টাইম ফিল্টারিং লজিক (যা আপনি চেয়েছিলেন)
// // //   bool isPostStillValid(PostModel post) {
// // //     try {
// // //       final now = DateTime.now();
// // //
// // //       // যদি মডেলে সরাসরি expiryDate থাকে তবে সেটি চেক করা সবচেয়ে সহজ
// // //       if (post.expiryDate != null) {
// // //         return now.isBefore(post.expiryDate!);
// // //       }
// // //
// // //       // অন্যথায় pickupTime string থেকে ক্যালকুলেশন
// // //       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
// // //       final parts = post.pickupTime.split(' (');
// // //       if (parts.length < 2) return true;
// // //
// // //       final timePart = parts[0].trim(); // "11:00 PM"
// // //       final dayPart = parts[1].trim();  // "Today)"
// // //
// // //       final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
// // //       final match = timeRegex.firstMatch(timePart);
// // //
// // //       if (match != null) {
// // //         int hour = int.parse(match.group(1)!);
// // //         int minute = int.parse(match.group(2)!);
// // //         String period = match.group(3)!;
// // //
// // //         if (period == "PM" && hour < 12) hour += 12;
// // //         if (period == "AM" && hour == 12) hour = 0;
// // //
// // //         DateTime pickupDateTime = DateTime(
// // //           createdDate.year, createdDate.month, createdDate.day, hour, minute,
// // //         );
// // //
// // //         if (dayPart.toLowerCase().contains("tomorrow")) {
// // //           pickupDateTime = pickupDateTime.add(const Duration(days: 1));
// // //         }
// // //         return now.isBefore(pickupDateTime);
// // //       }
// // //       return true;
// // //     } catch (e) {
// // //       return true;
// // //     }
// // //   }
// // //
// // //   Stream<List<PostModel>> getRecentPosts() {
// // //     return FirebaseFirestore.instance
// // //         .collection('posts')
// // //         .where('status', isEqualTo: 'available')
// // //         .orderBy('createdAt', descending: true)
// // //         .limit(10) // কিছু বেশি ডাটা আনা হচ্ছে ফিল্টার করার জন্য
// // //         .snapshots()
// // //         .map((snapshot) {
// // //       return snapshot.docs
// // //           .map((doc) => PostModel.fromSnapshot(doc))
// // //           .where((post) => isPostStillValid(post)) // 🔹 এখানে টাইম ফিল্টার অ্যাপ্লাই হলো
// // //           .take(4) // ফিল্টার করার পর মাত্র ৪টি দেখানো হবে
// // //           .toList();
// // //     });
// // //   }
// // //
// // //   String _formatTimeAgo(Timestamp? timestamp) {
// // //     if (timestamp == null) return "Just now";
// // //     final diff = DateTime.now().difference(timestamp.toDate());
// // //     if (diff.inDays > 0) return "${diff.inDays}d ago";
// // //     if (diff.inHours > 0) return "${diff.inHours}h ago";
// // //     if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
// // //     return "Just now";
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// // //           child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               Text("Recent Donations",
// // //                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
// // //               InkWell(
// // //                 onTap: onActionTap,
// // //                 borderRadius: BorderRadius.circular(20),
// // //                 child: const Padding(
// // //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// // //                   child: Text("See All",
// // //                       style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //         const SizedBox(height: 8),
// // //         StreamBuilder<List<PostModel>>(
// // //           stream: getRecentPosts(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
// // //             if (snapshot.hasError) return _buildErrorState();
// // //
// // //             final posts = snapshot.data ?? [];
// // //             if (posts.isEmpty) return _buildEmptyState();
// // //
// // //             return GridView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 16,
// // //                 crossAxisSpacing: 16,
// // //                 childAspectRatio: 0.68,
// // //               ),
// // //               itemBuilder: (context, index) => _buildPostCard(posts[index], context),
// // //             );
// // //           },
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // --- কার্ড ডিজাইন ---
// // //   Widget _buildPostCard(PostModel post, BuildContext context) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8))
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             flex: 11,
// // //             child: Stack(
// // //               children: [
// // //                 Container(
// // //                   width: double.infinity,
// // //                   margin: const EdgeInsets.all(6),
// // //                   child: ClipRRect(
// // //                     borderRadius: BorderRadius.circular(14),
// // //                     child: post.imageUrls.isNotEmpty
// // //                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
// // //                         errorBuilder: (_, __, ___) => _imagePlaceholder())
// // //                         : _imagePlaceholder(),
// // //                   ),
// // //                 ),
// // //                 Positioned(top: 12, left: 12, child: _buildBadge(post.foodCondition)),
// // //               ],
// // //             ),
// // //           ),
// // //           Expanded(
// // //             flex: 10,
// // //             child: Padding(
// // //               padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF2D3142))),
// // //                   const SizedBox(height: 5),
// // //                   Row(
// // //                     children: [
// // //                       const Icon(Icons.location_on_rounded, size: 14, color: AppColor.green),
// // //                       const SizedBox(width: 4),
// // //                       Expanded(
// // //                         child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis,
// // //                             style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.w500)),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       Icon(Icons.access_time_filled_rounded, size: 13, color: Colors.orange.shade300),
// // //                       const SizedBox(width: 4),
// // //                       Text(_formatTimeAgo(post.createdAt),
// // //                           style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.w600)),
// // //                     ],
// // //                   ),
// // //                   const Padding(
// // //                     padding: EdgeInsets.symmetric(vertical: 8.0),
// // //                     child: Divider(height: 1, thickness: 0.6, color: Color(0xFFF1F3F6)),
// // //                   ),
// // //                   Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Text("Qty: ${post.quantity}",
// // //                           style: const TextStyle(color: AppColor.green, fontSize: 11, fontWeight: FontWeight.w800)),
// // //                       Text("👤 ${post.estimatePersons}",
// // //                           style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildBadge(String text) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
// // //       decoration: BoxDecoration(
// // //         color: Colors.white.withOpacity(0.9),
// // //         borderRadius: BorderRadius.circular(10),
// // //         boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
// // //       ),
// // //       child: Text(text,
// // //           style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppColor.green, letterSpacing: 0.5)),
// // //     );
// // //   }
// // //
// // //   Widget _imagePlaceholder() => Container(color: const Color(0xFFF8F9FA),
// // //       child: const Center(child: Icon(Icons.fastfood_rounded, color: Colors.grey, size: 28)));
// // //
// // //   Widget _buildEmptyState() => const Center(
// // //       child: Padding(padding: EdgeInsets.all(20.0),
// // //           child: Text("No active donations found", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500))));
// // //
// // //   Widget _buildErrorState() => const Center(child: Icon(Icons.error_outline, color: Colors.red));
// // //
// // //   Widget _buildShimmerLoading() {
// // //     return GridView.builder(
// // //       shrinkWrap: true, itemCount: 4,
// // //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //           crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 0.68),
// // //       itemBuilder: (context, index) => Container(
// // //           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18))),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:waste_food_management/app/app_theme.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import '../../../auth/data/model/post_model.dart';
// //
// // class DonorRecentSection extends StatelessWidget {
// //   final VoidCallback onActionTap;
// //   const DonorRecentSection({super.key, required this.onActionTap});
// //
// //   // 🔹 টাইম ফিল্টারিং লজিক
// //   bool isPostStillValid(PostModel post) {
// //     try {
// //       final now = DateTime.now();
// //       if (post.expiryDate != null) {
// //         return now.isBefore(post.expiryDate!);
// //       }
// //       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
// //       final parts = post.pickupTime.split(' (');
// //       if (parts.length < 2) return true;
// //
// //       final timePart = parts[0].trim();
// //       final dayPart = parts[1].trim();
// //
// //       final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
// //       final match = timeRegex.firstMatch(timePart);
// //
// //       if (match != null) {
// //         int hour = int.parse(match.group(1)!);
// //         int minute = int.parse(match.group(2)!);
// //         String period = match.group(3)!;
// //
// //         if (period == "PM" && hour < 12) hour += 12;
// //         if (period == "AM" && hour == 12) hour = 0;
// //
// //         DateTime pickupDateTime = DateTime(
// //           createdDate.year, createdDate.month, createdDate.day, hour, minute,
// //         );
// //
// //         if (dayPart.toLowerCase().contains("tomorrow")) {
// //           pickupDateTime = pickupDateTime.add(const Duration(days: 1));
// //         }
// //         return now.isBefore(pickupDateTime);
// //       }
// //       return true;
// //     } catch (e) {
// //       return true;
// //     }
// //   }
// //
// //   Stream<List<PostModel>> getRecentPosts() {
// //     return FirebaseFirestore.instance
// //         .collection('posts')
// //         .where('status', isEqualTo: 'available')
// //         .orderBy('createdAt', descending: true)
// //         .limit(10)
// //         .snapshots()
// //         .map((snapshot) {
// //       return snapshot.docs
// //           .map((doc) => PostModel.fromSnapshot(doc))
// //           .where((post) => isPostStillValid(post))
// //           .take(4)
// //           .toList();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text("Recent Donations",
// //                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
// //               InkWell(
// //                 onTap: onActionTap,
// //                 borderRadius: BorderRadius.circular(20),
// //                 child: const Padding(
// //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //                   child: Text("See All",
// //                       style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         StreamBuilder<List<PostModel>>(
// //           stream: getRecentPosts(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
// //             if (snapshot.hasError) return const Center(child: Icon(Icons.error_outline, color: Colors.red));
// //
// //             final posts = snapshot.data ?? [];
// //             if (posts.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No active donations")));
// //
// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: posts.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 12,
// //                 crossAxisSpacing: 12,
// //                 childAspectRatio: 0.68, // আপনার Receiver কার্ডের রেশিও
// //               ),
// //               itemBuilder: (context, index) => _buildReceiverStyleCard(context, posts[index]),
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // 🔹 আপনার আগের (Receiver) কার্ডের স্টাইলে ডিজাইন
// //   Widget _buildReceiverStyleCard(BuildContext context, PostModel post) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 8,
// //             offset: const Offset(0, 4),
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // ইমেজ অংশ
// //           Expanded(
// //             flex: 5,
// //             child: ClipRRect(
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //               child: Container(
// //                 width: double.infinity,
// //                 color: Colors.grey[100],
// //                 child: post.imageUrls.isNotEmpty
// //                     ? Image.network(
// //                   post.imageUrls.first,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (_, __, ___) => _placeholderIcon(),
// //                 )
// //                     : _placeholderIcon(),
// //               ),
// //             ),
// //           ),
// //           // টেক্সট ইনফরমেশন অংশ
// //           Expanded(
// //             flex: 6,
// //             child: Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     post.foodName,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //                   ),
// //                   _miniInfoItem(Icons.inventory_2_outlined, post.quantity),
// //                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
// //                   _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
// //                   const SizedBox(height: 4),
// //                   // ডোনার সাইডে সাধারণত বাটন থাকে না, তবে আপনি চাইলে "View Details" বাটন দিতে পারেন
// //                   Container(
// //                     width: double.infinity,
// //                     height: 30,
// //                     alignment: Alignment.center,
// //                     decoration: BoxDecoration(
// //                       color: AppColor.green.withOpacity(0.1),
// //                       borderRadius: BorderRadius.circular(6),
// //                     ),
// //                     child: Text(
// //                       post.foodCondition,
// //                       style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColor.green),
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
// //   Widget _miniInfoItem(IconData icon, String text) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 13, color: Colors.grey),
// //         const SizedBox(width: 5),
// //         Expanded(
// //           child: Text(
// //             text,
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis,
// //             style: const TextStyle(fontSize: 10, color: Colors.black54),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _placeholderIcon() {
// //     return const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 35));
// //   }
// //
// //   Widget _buildShimmerLoading() {
// //     return GridView.builder(
// //       shrinkWrap: true, itemCount: 4,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.68),
// //       itemBuilder: (context, index) => Container(
// //           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12))),
// //     );
// //   }
// // }
//
//
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:waste_food_management/app/app_theme.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import '../../../auth/data/model/post_model.dart';
// //
// // class DonorRecentSection extends StatelessWidget {
// //   final VoidCallback onActionTap;
// //   const DonorRecentSection({super.key, required this.onActionTap});
// //
// //   // 🔹 টাইম ফিল্টারিং লজিক (ভ্যালিডেশন)
// //   bool isPostStillValid(PostModel post) {
// //     try {
// //       final now = DateTime.now();
// //       if (post.expiryDate != null) {
// //         return now.isBefore(post.expiryDate!);
// //       }
// //       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
// //       final parts = post.pickupTime.split(' (');
// //       if (parts.length < 2) return true;
// //
// //       final timePart = parts[0].trim();
// //       final dayPart = parts[1].trim();
// //
// //       final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
// //       final match = timeRegex.firstMatch(timePart);
// //
// //       if (match != null) {
// //         int hour = int.parse(match.group(1)!);
// //         int minute = int.parse(match.group(2)!);
// //         String period = match.group(3)!;
// //
// //         if (period == "PM" && hour < 12) hour += 12;
// //         if (period == "AM" && hour == 12) hour = 0;
// //
// //         DateTime pickupDateTime = DateTime(
// //           createdDate.year, createdDate.month, createdDate.day, hour, minute,
// //         );
// //
// //         if (dayPart.toLowerCase().contains("tomorrow")) {
// //           pickupDateTime = pickupDateTime.add(const Duration(days: 1));
// //         }
// //         return now.isBefore(pickupDateTime);
// //       }
// //       return true;
// //     } catch (e) {
// //       return true;
// //     }
// //   }
// //
// //   Stream<List<PostModel>> getRecentPosts() {
// //     return FirebaseFirestore.instance
// //         .collection('posts')
// //         .where('status', isEqualTo: 'available')
// //         .orderBy('createdAt', descending: true)
// //         .limit(10)
// //         .snapshots()
// //         .map((snapshot) {
// //       return snapshot.docs
// //           .map((doc) => PostModel.fromSnapshot(doc))
// //           .where((post) => isPostStillValid(post))
// //           .take(4)
// //           .toList();
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(vertical: 8.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text("Recent Donations",
// //                   style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
// //               InkWell(
// //                 onTap: onActionTap,
// //                 borderRadius: BorderRadius.circular(20),
// //                 child: const Padding(
// //                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
// //                   child: Text("See All",
// //                       style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 8),
// //         StreamBuilder<List<PostModel>>(
// //           stream: getRecentPosts(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
// //             if (snapshot.hasError) return const Center(child: Icon(Icons.error_outline, color: Colors.red));
// //
// //             final posts = snapshot.data ?? [];
// //             if (posts.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No active donations")));
// //
// //             return GridView.builder(
// //               shrinkWrap: true,
// //               physics: const NeverScrollableScrollPhysics(),
// //               itemCount: posts.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 12,
// //                 crossAxisSpacing: 12,
// //                 childAspectRatio: 0.65, // কার্ডের হাইট কিছুটা বাড়ানো হয়েছে সব তথ্য দেখানোর জন্য
// //               ),
// //               itemBuilder: (context, index) => _buildCustomCard(context, posts[index]),
// //             );
// //           },
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // 🔹 আপনার চাহিদামতো ইমেজ এবং ইমেজের ওপর ব্যাজ ডিজাইন
// //   Widget _buildCustomCard(BuildContext context, PostModel post) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           )
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // 1. ইমেজ সেকশন + কন্ডিশন ব্যাজ (Stack ব্যবহার করা হয়েছে)
// //           Expanded(
// //             flex: 6, // ইমেজের জায়গা বাড়ানো হলো
// //             child: Stack(
// //               children: [
// //                 ClipRRect(
// //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                   child: Container(
// //                     width: double.infinity,
// //                     color: Colors.grey[100],
// //                     child: post.imageUrls.isNotEmpty
// //                         ? Image.network(
// //                       post.imageUrls.first,
// //                       fit: BoxFit.cover,
// //                       errorBuilder: (_, __, ___) => _placeholderIcon(),
// //                     )
// //                         : _placeholderIcon(),
// //                   ),
// //                 ),
// //                 // --- ইমেজের ওপর Condition Badge ---
// //                 Positioned(
// //                   top: 8,
// //                   left: 8,
// //                   child: Container(
// //                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                     decoration: BoxDecoration(
// //                       color: AppColor.green.withOpacity(0.9),
// //                       borderRadius: BorderRadius.circular(6),
// //                     ),
// //                     child: Text(
// //                       post.foodCondition,
// //                       style: const TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 9,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //
// //           // 2. ইনফরমেশন সেকশন (description, quantity, etc.)
// //           Expanded(
// //             flex: 4,
// //             child: Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(
// //                     post.foodName,
// //                     maxLines: 1,
// //                     overflow: TextOverflow.ellipsis,
// //                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2D3142)),
// //                   ),
// //                   _miniInfoItem(Icons.inventory_2_outlined, "Qty: ${post.quantity}"),
// //                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
// //                   _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
// //
// //                   // const Divider(height: 12, thickness: 0.5),
// //                   //
// //                   // // Description সেকশন
// //                   // Text(
// //                   //   post.description,
// //                   //   maxLines: 2,
// //                   //   overflow: TextOverflow.ellipsis,
// //                   //   style: TextStyle(fontSize: 10, color: Colors.grey.shade600, height: 1.2),
// //                   // ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _miniInfoItem(IconData icon, String text) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 12, color: AppColor.green),
// //         const SizedBox(width: 5),
// //         Expanded(
// //           child: Text(
// //             text,
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis,
// //             style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w500),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _placeholderIcon() {
// //     return const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 35));
// //   }
// //
// //   Widget _buildShimmerLoading() {
// //     return GridView.builder(
// //       shrinkWrap: true, itemCount: 4,
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.65),
// //       itemBuilder: (context, index) => Container(
// //           decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12))),
// //     );
// //   }
// // }
//
//
//
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
//         .limit(10)
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
//                 childAspectRatio: 0.72, // 🔹 হাইট অ্যাডজাস্ট করা হয়েছে গ্যাপ কমানোর জন্য
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
//         borderRadius: BorderRadius.circular(16), // 🔹 আরো প্রফেশনাল কার্ভ
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 1. ইমেজ সেকশন
//           Expanded(
//             flex: 12, // 🔹 ইমেজ বেশি জায়গা নিবে (গ্যাপ কমাবে)
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
//                         style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // 2. ইনফরমেশন সেকশন
//           Expanded(
//             flex: 8, // 🔹 টেক্সট সেকশন টাইট করা হয়েছে
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start, // 🔹 গ্যাপ কমানোর জন্য স্টার্ট ব্যবহার করা হয়েছে
//                 children: [
//                   Text(post.foodName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2D3142))),
//                   const SizedBox(height: 6), // 🔹 টাইট স্পেসিং
//                   _miniInfoItem(Icons.inventory_2_outlined, "Qty: ${post.quantity}"),
//                   const SizedBox(height: 4),
//                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
//                   const SizedBox(height: 4),
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
//       children: [
//         Icon(icon, size: 13, color: AppColor.green.withOpacity(0.8)),
//         const SizedBox(width: 6),
//         Expanded(
//           child: Text(text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: const TextStyle(fontSize: 10.5, color: Colors.black54, fontWeight: FontWeight.w500)),
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
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 0.72),
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

  // 🔹 টাইম ফিল্টারিং লজিক
  bool isPostStillValid(PostModel post) {
    try {
      final now = DateTime.now();
      if (post.expiryDate != null) return now.isBefore(post.expiryDate!);

      DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
      final parts = post.pickupTime.split(' (');
      if (parts.length < 2) return true;

      final timeRegex = RegExp(r'(\d+):(\d+)\s+(AM|PM)');
      final match = timeRegex.firstMatch(parts[0].trim());

      if (match != null) {
        int hour = int.parse(match.group(1)!);
        int minute = int.parse(match.group(2)!);
        if (match.group(3) == "PM" && hour < 12) hour += 12;
        if (match.group(3) == "AM" && hour == 12) hour = 0;

        DateTime pickupDateTime = DateTime(createdDate.year, createdDate.month, createdDate.day, hour, minute);
        if (parts[1].toLowerCase().contains("tomorrow")) pickupDateTime = pickupDateTime.add(const Duration(days: 1));
        return now.isBefore(pickupDateTime);
      }
      return true;
    } catch (e) { return true; }
  }

  Stream<List<PostModel>> getRecentPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('status', isEqualTo: 'available')
        .orderBy('createdAt', descending: true)
        .limit(4)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => PostModel.fromSnapshot(doc))
        .where((post) => isPostStillValid(post))
        .take(4).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Donations",
                  style: AppData.heading2.copyWith(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
              GestureDetector(
                onTap: onActionTap,
                child: const Text("See All",
                    style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
        ),
        StreamBuilder<List<PostModel>>(
          stream: getRecentPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return _buildShimmerLoading();
            final posts = snapshot.data ?? [];
            if (posts.isEmpty) return const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No donations found")));

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.68, // 🔹 সব ইনফো দেখানোর জন্য পারফেক্ট রেশিও
              ),
              itemBuilder: (context, index) => _buildCustomCard(posts[index]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCustomCard(PostModel post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. ইমেজ সেকশন
          Expanded(
            flex: 12,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(post.imageUrls.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderIcon())
                        : _placeholderIcon(),
                  ),
                ),
                Positioned(
                  top: 10, left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColor.green.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(post.foodCondition,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          // 2. ইনফরমেশন সেকশন
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(post.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2D3142))),
                  const SizedBox(height: 6),

                  // কোয়ান্টিটি এবং কতজনের খাবার (একই রো-তে সুন্দর করে সাজানো)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniInfoItem(Icons.inventory_2_outlined, post.quantity),
                      _miniInfoItem(Icons.people_outline, "${post.estimatePersons} prs"),
                    ],
                  ),
                  const SizedBox(height: 5),
                  _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
                  const SizedBox(height: 5),
                  _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: AppColor.green.withOpacity(0.8)),
        const SizedBox(width: 4),
        Flexible(
          child: Text(text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  Widget _placeholderIcon() => Container(color: Colors.grey[100], child: const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 30)));

  Widget _buildShimmerLoading() {
    return GridView.builder(
      shrinkWrap: true, itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 0.68),
      itemBuilder: (context, index) => Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16))),
    );
  }
}