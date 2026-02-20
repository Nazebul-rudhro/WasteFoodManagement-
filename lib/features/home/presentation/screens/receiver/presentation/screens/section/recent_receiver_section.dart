// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_all_post.dart';
// import '../../../../../../../../app/app_theme.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/post_model.dart';
// import '../../../../donor/presentation/screens/food_donation_list_screen.dart';
// import '../../provider/receiver_provider.dart';
//
// class ReceiverRecentSection extends StatelessWidget {
//   const ReceiverRecentSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<ReceiverProvider>();
//     final recentPosts = provider.allPosts.take(4).toList();
//
//     if (recentPosts.isEmpty) {
//       return const Padding(
//         padding: EdgeInsets.all(20),
//         child: Center(
//           child: Text("No recent donations", style: TextStyle(color: Colors.grey)),
//         ),
//       );
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Header
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Recent Donations", style: AppData.heading2),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context, AppRoutes.smooth(ReceiverAllPost()));
//               },
//               child: Text(
//                 "See All",
//                 style: AppData.heading2.copyWith(color: AppColor.green),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//
//         /// 2x2 Grid
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: recentPosts.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 10,
//             crossAxisSpacing: 10,
//             childAspectRatio: 0.72,
//           ),
//           itemBuilder: (context, index) {
//             final post = recentPosts[index];
//             final alreadyRequested = provider.myRequests.contains(post.postId);
//             final isLoading = provider.isRequesting[post.postId] ?? false;
//
//             return _buildPostCard(context, post, alreadyRequested, isLoading);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPostCard(BuildContext context, PostModel post, bool alreadyRequested, bool isLoading) {
//     final provider = context.read<ReceiverProvider>();
//
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Image
//           Container(
//             height: 100,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//               image: post.imageUrls.isNotEmpty
//                   ? DecorationImage(
//                 image: NetworkImage(post.imageUrls.first),
//                 fit: BoxFit.cover,
//               )
//                   : null,
//               color: Colors.grey[200],
//             ),
//             child: post.imageUrls.isEmpty
//                 ? const Center(child: Icon(Icons.fastfood, color: Colors.grey))
//                 : null,
//           ),
//
//           /// Text Info
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post.foodName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   "Qty: ${post.quantity}",
//                   style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, size: 12, color: Colors.grey),
//                     const SizedBox(width: 2),
//                     Expanded(
//                       child: Text(
//                         post.pickupAddress,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(color: Colors.grey, fontSize: 11),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//                 Row(
//                   children: [
//                     const Icon(Icons.access_time, size: 12, color: Colors.grey),
//                     const SizedBox(width: 2),
//                     Text(post.pickupTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//
//           /// Available Button
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
//             child: SizedBox(
//               width: double.infinity,
//               height: 32,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: alreadyRequested || isLoading ? Colors.grey : AppColor.green,
//                   foregroundColor:  alreadyRequested || isLoading ? Colors.black : AppColor.white,
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
//                     ?  SizedBox(
//                   width: 16,
//                   height: 16,
//                   child: CircularProgressIndicator(
//                     color: AppColor.green,
//                     strokeWidth: 2,
//                   ),
//                 )
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
//     // watch ব্যবহার করা হয়েছে যাতে প্রোভাইডারে চেঞ্জ হলে UI আপডেট হয়
//     final provider = context.watch<ReceiverProvider>();
//
//     // প্রোভাইডারে অলরেডি ফিল্টার করা ডাটা থাকবে
//     final recentPosts = provider.allPosts.take(4).toList();
//
//     if (recentPosts.isEmpty) {
//       return const SizedBox.shrink(); // ডাটা না থাকলে সেকশনটি দেখাবে না
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Header Section
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Recent Donations", style: AppData.heading2),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
//               },
//               child: Text(
//                 "See All",
//                 style: AppData.heading2.copyWith(color: AppColor.green),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//
//         /// Grid View
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: recentPosts.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 0.78, // প্রফেশনাল লুকের জন্য একটু বাড়ানো হয়েছে
//           ),
//           itemBuilder: (context, index) {
//             final post = recentPosts[index];
//             final isLoading = provider.isRequesting[post.postId] ?? false;
//
//             return _buildPostCard(context, post, isLoading);
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPostCard(BuildContext context, PostModel post, bool isLoading) {
//     final provider = context.read<ReceiverProvider>();
//
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
//           /// Food Image Section
//           Expanded(
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Container(
//                     width: double.infinity,
//                     color: Colors.grey[100],
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(
//                       post.imageUrls.first,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, color: Colors.grey),
//                     )
//                         : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
//                   ),
//                 ),
//                 // ছোট ব্যাজ (প্রফেশনাল লুক)
//                 Positioned(
//                   top: 8,
//                   left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: AppColor.green.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Text(
//                       "New",
//                       style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// Content Section
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post.foodName,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                 ),
//                 const SizedBox(height: 4),
//
//                 Row(
//                   children: [
//                     Icon(Icons.shopping_basket_outlined, size: 14, color: AppColor.green),
//                     const SizedBox(width: 4),
//                     Text(
//                       "Qty: ${post.quantity}",
//                       style: TextStyle(color: AppColor.green, fontSize: 12, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 4),
//
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         post.pickupAddress,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(color: Colors.grey, fontSize: 11),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 /// Professional Request Button
//                 SizedBox(
//                   width: double.infinity,
//                   height: 35,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColor.green,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                     ),
//                     onPressed: isLoading
//                         ? null
//                         : () async {
//                       await provider.sendRequest(post.postId, post.donorId);
//                     },
//                     child: isLoading
//                         ? const SizedBox(
//                       width: 18,
//                       height: 18,
//                       child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//                     )
//                         : const Text(
//                       "Available",
//                       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


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
//
//     // শুধু সেই পোস্টগুলো নিবে যেগুলোতে রিকোয়েস্ট দেওয়া হয়নি
//     final recentPosts = provider.availablePostsForMe.take(4).toList();
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
//             Text("Recent Donations", style: AppData.heading2),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
//               },
//               child: Text("See All", style: AppData.heading2.copyWith(color: AppColor.green)),
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
//             mainAxisSpacing: 12,
//             crossAxisSpacing: 12,
//             childAspectRatio: 0.78,
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
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Container(
//                     width: double.infinity,
//                     color: Colors.grey[100],
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image))
//                         : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8, left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(color: AppColor.green.withOpacity(0.9), borderRadius: BorderRadius.circular(20)),
//                     child: const Text("New", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.shopping_basket_outlined, size: 14, color: AppColor.green),
//                     const SizedBox(width: 4),
//                     Text("Qty: ${post.quantity}", style: TextStyle(color: AppColor.green, fontSize: 12, fontWeight: FontWeight.w600)),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Expanded(child: Text(post.pickupAddress, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 11))),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 35,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                     onPressed: isLoading ? null : () async {
//                       await provider.sendRequest(post.postId, post.donorId);
//                     },
//                     child: isLoading
//                         ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                         : const Text("Available", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
//     // 🔹 watch ব্যবহার করা হয়েছে যাতে প্রোভাইডার আপডেট হলে লিস্ট সাথে সাথে রিফ্রেশ হয়
//     final provider = context.watch<ReceiverProvider>();
//
//     // 🔹 সর্বোচ্চ ৪টি নতুন পোস্ট নিবে যেগুলোতে রিকোয়েস্ট করা হয়নি
//     final recentPosts = provider.availablePostsForMe.take(4).toList();
//
//     // ডাটা না থাকলে সেকশনটি দেখানোর দরকার নেই
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
//             Text("Recent Donations", style: AppData.heading2),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
//               },
//               child: Text("See All",
//                   style: AppData.heading2.copyWith(color: AppColor.green, fontSize: 14)),
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
//             childAspectRatio: 0.70, // 🔹 সব ডাটা ঠিকমতো দেখানোর জন্য রেশিও অ্যাডজাস্ট করা হয়েছে
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
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
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
//           // ইমেজ সেকশন
//           Expanded(
//             flex: 4,
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Container(
//                     width: double.infinity,
//                     color: Colors.grey[100],
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey))
//                         : const Icon(Icons.fastfood, color: Colors.grey, size: 30),
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
//                     child: const Text("New",
//                         style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // ডিটেইলস সেকশন
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.foodName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
//                   const SizedBox(height: 6),
//
//                   // ১. কত জনের খাবার
//                   _infoItem(Icons.group_outlined, "For: ${post.quantity} Person"),
//
//                   // ২. পিকআপ টাইম
//                   _infoItem(Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
//
//                   // ৩. লোকেশন
//                   _infoItem(Icons.location_on_outlined, post.pickupAddress),
//
//                   // const Spacer(),
//
//                   SizedBox(height: 10,),
//                   // রিকোয়েস্ট বাটন
//                   SizedBox(
//                     width: double.infinity,
//                     height: 32,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         padding: EdgeInsets.zero,
//                       ),
//                       onPressed: isLoading ? null : () async {
//                         await provider.sendRequest(post.postId, post.donorId);
//                       },
//                       child: isLoading
//                           ? const SizedBox(width: 16, height: 16,
//                           child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                           : const Text("Request Now",
//                           style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
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
//   Widget _infoItem(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 3),
//       child: Row(
//         children: [
//           Icon(icon, size: 12, color: AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 5),
//           Expanded(
//             child: Text(text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 10, color: Colors.black87)),
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

    // 🔹 এক্সপায়ারি টাইম ফিল্টারিং লজিক
    final now = DateTime.now();

    final recentPosts = provider.availablePostsForMe.where((post) {
      // ১. যদি পোস্টে expiryDate থাকে, তবে চেক করবে সেটা বর্তমান সময়ের পরের কি না
      if (post.expiryDate != null) {
        return post.expiryDate!.isAfter(now);
      }
      // ২. যদি expiryDate না থাকে, তবে বাই-ডিফল্ট শো করবে (অথবা আপনার লজিক অনুযায়ী ফলস দিতে পারেন)
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
            Text("Recent Donations", style: AppData.heading2),
            TextButton(
              onPressed: () {
                Navigator.push(context, AppRoutes.smooth(const ReceiverAllPost()));
              },
              child: Text("See All",
                  style: AppData.heading2.copyWith(color: AppColor.green, fontSize: 14)),
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
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.68, // 🔹 হাইট একটু বাড়ানো হয়েছে যাতে সব টেক্সট ধরে
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey))
                        : const Icon(Icons.fastfood, color: Colors.grey, size: 30),
                  ),
                ),
                Positioned(
                  top: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppColor.green.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Text("New",
                        style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 6),

                  _infoItem(Icons.group_outlined, "For: ${post.quantity} Person"),
                  _infoItem(Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
                  _infoItem(Icons.location_on_outlined, post.pickupAddress),

                  const Spacer(), // বাটনকে একদম নিচে পুশ করবে

                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: isLoading ? null : () async {
                        await provider.sendRequest(post.postId, post.donorId);
                      },
                      child: isLoading
                          ? const SizedBox(width: 16, height: 16,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("Request Now",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
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

  Widget _infoItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColor.green.withOpacity(0.7)),
          const SizedBox(width: 5),
          Expanded(
            child: Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10, color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}


