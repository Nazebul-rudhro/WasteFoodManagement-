// // // import 'package:flutter/material.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // //
// // // class PostCard extends StatelessWidget {
// // //   final PostModel post;
// // //
// // //   const PostCard({
// // //     super.key,
// // //     required this.post,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Card(
// // //       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       elevation: 3,
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           // 🔹 Image Section
// // //           ClipRRect(
// // //             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //             child: post.imageUrls.isNotEmpty
// // //                 ? Image.network(
// // //               post.imageUrls.first,
// // //               height: 160,
// // //               width: double.infinity,
// // //               fit: BoxFit.cover,
// // //               errorBuilder: (_, __, ___) => _imagePlaceholder(),
// // //             )
// // //                 : _imagePlaceholder(),
// // //           ),
// // //
// // //           // 🔹 Details Section
// // //           Padding(
// // //             padding: const EdgeInsets.all(12),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 // Food name
// // //                 Text(
// // //                   post.foodName,
// // //                   style: const TextStyle(
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 10),
// // //
// // //                 // Info row
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     _infoItem(
// // //                       icon: Icons.inventory_2_outlined,
// // //                       text: post.quantity,
// // //                     ),
// // //                     _infoItem(
// // //                       icon: Icons.schedule_outlined,
// // //                       text: post.pickupTime,
// // //                     ),
// // //
// // //                   ],
// // //                 ),
// // //
// // //                 const SizedBox(height: 10),
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     _infoItem(
// // //                       icon: Icons.location_on_outlined,
// // //                       text: post.pickupAddress,
// // //                     ),
// // //                     Row(children: [
// // //                       Icon(Icons.description, color: AppColor.lightGray,),
// // //                       Text(
// // //                         post.description,
// // //                         maxLines: 3,
// // //                         overflow: TextOverflow.ellipsis,
// // //                         style: const TextStyle(color: Colors.grey),
// // //                       ),
// // //                     ],)
// // //                   ],
// // //                 ),
// // //
// // //                 // Description
// // //
// // //
// // //                 const SizedBox(height: 12),
// // //
// // //                 // Status chip
// // //                 Align(
// // //                   alignment: Alignment.centerRight,
// // //                   child: Chip(
// // //                     label: Text(
// // //                       post.status.toUpperCase(),
// // //                       style: const TextStyle(fontSize: 12),
// // //                     ),
// // //                     backgroundColor: post.status == 'available'
// // //                         ? Colors.green.shade100
// // //                         : Colors.orange.shade100,
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // 🔹 Reusable info widget
// // //   Widget _infoItem({
// // //     required IconData icon,
// // //     required String text,
// // //   }) {
// // //     return Row(
// // //       children: [
// // //         Icon(icon, size: 18, color: Colors.grey),
// // //         const SizedBox(width: 4),
// // //         Text(
// // //           text,
// // //           style: const TextStyle(fontSize: 14, color: Colors.grey),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // 🔹 Image placeholder
// // //   Widget _imagePlaceholder() {
// // //     return Container(
// // //       height: 160,
// // //       width: double.infinity,
// // //       color: Colors.grey[300],
// // //       child: const Icon(
// // //         Icons.image_not_supported,
// // //         size: 50,
// // //         color: Colors.grey,
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import '../../../auth/data/model/post_model.dart';
// //
// // class PostCard extends StatelessWidget {
// //   final PostModel post;
// //
// //   const PostCard({super.key, required this.post});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 20,
// //             offset: const Offset(0, 10),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           // 🔹 Image & Status Badge Section
// //           Stack(
// //             children: [
// //               ClipRRect(
// //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// //                 child: post.imageUrls.isNotEmpty
// //                     ? Image.network(
// //                   post.imageUrls.first,
// //                   height: 180,
// //                   width: double.infinity,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (_, __, ___) => _imagePlaceholder(),
// //                 )
// //                     : _imagePlaceholder(),
// //               ),
// //
// //               // 🔹 Status Badge (Floating on Image)
// //               Positioned(
// //                 top: 15,
// //                 right: 15,
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(30),
// //                     boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       CircleAvatar(
// //                         radius: 4,
// //                         backgroundColor: post.status == 'available' ? Colors.green : Colors.orange,
// //                       ),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         post.status.toUpperCase(),
// //                         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.black87),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //
// //           // 🔹 Details Section
// //           Padding(
// //             padding: const EdgeInsets.all(16),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Food Name & Quantity
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Expanded(
// //                       child: Text(
// //                         post.foodName,
// //                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF2D3142)),
// //                       ),
// //                     ),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                       decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
// //                       child: Text(post.quantity,
// //                           style: const TextStyle(color: AppColor.green, fontWeight: FontWeight.bold, fontSize: 12)),
// //                     ),
// //                   ],
// //                 ),
// //
// //                 const SizedBox(height: 12),
// //
// //                 // Pickup Time & Person Count
// //                 Row(
// //                   children: [
// //                     _iconInfo(Icons.access_time_filled_rounded, post.pickupTime, Colors.blue.shade400),
// //                     const SizedBox(width: 16),
// //                     _iconInfo(Icons.people_alt_rounded, "For ${post.estimatePersons}", Colors.orange.shade400),
// //                   ],
// //                 ),
// //
// //                 const Padding(
// //                   padding: EdgeInsets.symmetric(vertical: 12),
// //                   child: Divider(height: 1, thickness: 0.5, color: Color(0xFFEDF1F7)),
// //                 ),
// //
// //                 // Address & Description
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Icon(Icons.location_on_rounded, size: 18, color: AppColor.green),
// //                     const SizedBox(width: 8),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Text(post.pickupAddress,
// //                               maxLines: 1, overflow: TextOverflow.ellipsis,
// //                               style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
// //                           const SizedBox(height: 4),
// //                           Text(post.description,
// //                               maxLines: 2, overflow: TextOverflow.ellipsis,
// //                               style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4)),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // 🔹 Reusable Icon Info Row
// //   Widget _iconInfo(IconData icon, String text, Color iconColor) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 16, color: iconColor),
// //         const SizedBox(width: 6),
// //         Text(text, style: TextStyle(fontSize: 13, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
// //       ],
// //     );
// //   }
// //
// //   Widget _imagePlaceholder() {
// //     return Container(
// //       height: 180, width: double.infinity,
// //       color: Colors.grey.shade100,
// //       child: Icon(Icons.fastfood_rounded, size: 40, color: Colors.grey.shade300),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../auth/data/model/post_model.dart';
//
// class PostCard extends StatelessWidget {
//   final PostModel post;
//
//   const PostCard({super.key, required this.post});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // --- ইমেজ এবং স্ট্যাটাস ব্যাজ ---
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 child: post.imageUrls.isNotEmpty
//                     ? Image.network(
//                   post.imageUrls.first,
//                   height: 190,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => _imagePlaceholder(),
//                 )
//                     : _imagePlaceholder(),
//               ),
//
//               // ছবির ওপরে ভাসমান স্ট্যাটাস
//               Positioned(
//                 top: 15,
//                 right: 15,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4)],
//                   ),
//                   child: Row(
//                     children: [
//                       CircleAvatar(radius: 4, backgroundColor: post.status == 'available' ? Colors.green : Colors.orange),
//                       const SizedBox(width: 6),
//                       Text(post.status.toUpperCase(),
//                           style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // --- ডিটেইলস সেকশন ---
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ১. খাবারের নাম এবং পরিমাণ
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(post.foodName,
//                           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF2D3142))),
//                     ),
//                     _badgeInfo(Icons.inventory_2, post.quantity, AppColor.green),
//                   ],
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // ২. পিকআপ সময় এবং মানুষের সংখ্যা
//                 Row(
//                   children: [
//                     _iconWithLabel(Icons.access_time_filled, "টাইম: ", post.pickupTime, Colors.blue),
//                     const SizedBox(width: 15),
//                     _iconWithLabel(Icons.people_alt_rounded, "খাবে: ", "${post.estimatePersons} জন", Colors.orange),
//                   ],
//                 ),
//
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12),
//                   child: Divider(height: 1, thickness: 0.5, color: Color(0xFFF1F3F6)),
//                 ),
//
//                 // ৩. লোকেশন/ঠিকানা
//                 _sectionHeading(Icons.location_on_rounded, "ঠিকানা:", Colors.redAccent),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 26, top: 2),
//                   child: Text(post.pickupAddress,
//                       style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
//                 ),
//
//                 const SizedBox(height: 10),
//
//                 // ৪. খাবারের বর্ণনা
//                 _sectionHeading(Icons.description_rounded, "বিস্তারিত:", Colors.blueGrey),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 26, top: 2),
//                   child: Text(post.description,
//                       maxLines: 2, overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.4)),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- ছোট হেল্পার উইজেটস ---
//
//   // আইকন সহ লেবেল (যেমন: টাইম, জন)
//   Widget _iconWithLabel(IconData icon, String label, String value, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: color),
//         const SizedBox(width: 4),
//         Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
//         Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
//       ],
//     );
//   }
//
//   // সেকশন হেডিং (যেমন: ঠিকানা, বিস্তারিত)
//   Widget _sectionHeading(IconData icon, String title, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: color),
//         const SizedBox(width: 8),
//         Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black54)),
//       ],
//     );
//   }
//
//   // ছোট ব্যাজ (যেমন: ৫ কেজি)
//   Widget _badgeInfo(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 4),
//           Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
//         ],
//       ),
//     );
//   }
//
//   Widget _imagePlaceholder() {
//     return Container(height: 190, width: double.infinity, color: Colors.grey.shade100,
//         child: Icon(Icons.fastfood_rounded, size: 40, color: Colors.grey.shade300));
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../auth/data/model/post_model.dart';
//
// class PostCard extends StatelessWidget {
//   final PostModel post;
//
//   const PostCard({super.key, required this.post});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔹 Header: Image & Status Badge
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//                 child: post.imageUrls.isNotEmpty
//                     ? Image.network(
//                   post.imageUrls.first,
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => _imagePlaceholder(),
//                 )
//                     : _imagePlaceholder(),
//               ),
//
//               // Floating Status Badge on Top Right
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 8)],
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircleAvatar(
//                           radius: 4,
//                           backgroundColor: post.status == 'available' ? Colors.green : Colors.orange
//                       ),
//                       const SizedBox(width: 8),
//                       Text(
//                           post.status.toUpperCase(),
//                           style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.8)
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // 🔹 Body: Labels and Details
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Food Name & Qty Label
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                           post.foodName,
//                           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1A1D1E))
//                       ),
//                     ),
//                     _badgeInfo(Icons.inventory_2_outlined, "Qty: ${post.quantity}", AppColor.green),
//                   ],
//                 ),
//
//                 const SizedBox(height: 5),
//
//                 // Primary Info Row (Time & Servings)
//                 Row(
//                   children: [
//                     _iconWithLabel(Icons.access_time_filled_rounded, "Time:", post.pickupTime, Colors.blue),
//                     const SizedBox(width: 20),
//                     _iconWithLabel(Icons.people_alt_rounded, "Serves:", "${post.estimatePersons} persons", Colors.orange),
//                   ],
//                 ),
//
//                 const Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   child: Divider(height: 1, thickness: 1, color: Color(0xFFEDF1F7)),
//                 ),
//
//                 // Location Section
//                 _sectionHeading(Icons.location_on_rounded, "Location:", Colors.redAccent),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 28, top: 4),
//                   child: Text(
//                       post.pickupAddress,
//                       style: const TextStyle(fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)
//                   ),
//                 ),
//
//                 const SizedBox(height: 12),
//
//                 // Description Section
//                 _sectionHeading(Icons.notes_rounded, "Description:", Colors.blueGrey),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 28, top: 4),
//                   child: Text(
//                       post.description,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(fontSize: 13, color: Colors.grey.shade600, height: 1.5)
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- UI Component Helpers ---
//
//   // Helper for Row-based info (Time, Persons)
//   Widget _iconWithLabel(IconData icon, String label, String value, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 16, color: color),
//         const SizedBox(width: 6),
//         Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
//         const SizedBox(width: 4),
//         Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87)),
//       ],
//     );
//   }
//
//   // Helper for Section Headings (Location, Description)
//   Widget _sectionHeading(IconData icon, String title, Color color) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: color),
//         const SizedBox(width: 8),
//         Text(
//             title,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black54)
//         ),
//       ],
//     );
//   }
//
//   // Helper for Quantity Badge
//   Widget _badgeInfo(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: color),
//           const SizedBox(width: 6),
//           Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12)),
//         ],
//       ),
//     );
//   }
//
//   Widget _imagePlaceholder() {
//     return Container(
//         height: 200, width: double.infinity, color: Colors.grey.shade100,
//         child: Icon(Icons.fastfood_outlined, size: 50, color: Colors.grey.shade300)
//     );
//   }
// }



import 'package:flutter/material.dart';

import '../../../auth/data/model/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  String _calculateTimeLeft(DateTime? expiry) {
    if (expiry == null) return "N/A";
    final diff = expiry.difference(DateTime.now());
    if (diff.isNegative) return "Expired";
    if (diff.inDays > 0) return "${diff.inDays}d left";
    if (diff.inHours > 0) return "${diff.inHours}h left";
    return "${diff.inMinutes}m left";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ইমেজ এবং স্ট্যাটাস ব্যাজ
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: post.imageUrls.isNotEmpty
                    ? Image.network(post.imageUrls.first, height: 180, width: double.infinity, fit: BoxFit.cover)
                    : Container(height: 180, color: Colors.grey[200], child: const Icon(Icons.fastfood, size: 50)),
              ),
              Positioned(
                top: 10, left: 10,
                child: _buildBadge("⚡ ${_calculateTimeLeft(post.expiryDate)}", Colors.redAccent),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.foodName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _infoRow(Icons.scale_outlined, "Quantity: ${post.quantity}"),
                _infoRow(Icons.people_outline, "Serves: ${post.estimatePersons} people"),
                _infoRow(Icons.location_on_outlined, "Location: ${post.pickupAddress}"),
                const Divider(),
                Text("Note: ${post.description}", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}