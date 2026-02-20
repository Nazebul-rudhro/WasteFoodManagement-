// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:provider/provider.dart'; // এই ইমপোর্টটি মিসিং ছিল
// // // // // import '../../provider/receiver_provider.dart';
// // // // //
// // // // // class ApprovedTab extends StatelessWidget {
// // // // //   const ApprovedTab({super.key});
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     // Consumer এর আগে অবশ্যই provider প্যাকেজ ইমপোর্ট থাকতে হবে
// // // // //     return Consumer<ReceiverProvider>(
// // // // //       builder: (context, provider, child) {
// // // // //         final posts = provider.approvedPosts;
// // // // //
// // // // //         if (posts.isEmpty) {
// // // // //           return const Center(
// // // // //             child: Text(
// // // // //               "No approved food found",
// // // // //               style: TextStyle(color: Colors.grey, fontSize: 16),
// // // // //             ),
// // // // //           );
// // // // //         }
// // // // //
// // // // //         return ListView.builder(
// // // // //           padding: const EdgeInsets.all(12),
// // // // //           itemCount: posts.length,
// // // // //           itemBuilder: (context, index) {
// // // // //             final post = posts[index];
// // // // //             return Card(
// // // // //               color: Colors.green.shade50,
// // // // //               elevation: 2,
// // // // //               margin: const EdgeInsets.only(bottom: 12),
// // // // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // // // //               child: ListTile(
// // // // //                 contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // // // //                 leading: ClipRRect(
// // // // //                   borderRadius: BorderRadius.circular(8),
// // // // //                   child: Container(
// // // // //                     width: 55,
// // // // //                     height: 55,
// // // // //                     color: Colors.white,
// // // // //                     child: post.imageUrls.isNotEmpty
// // // // //                         ? Image.network(
// // // // //                       post.imageUrls.first,
// // // // //                       fit: BoxFit.cover,
// // // // //                       // ইমেজ লোড হতে সমস্যা হলে এরর হ্যান্ডলিং
// // // // //                       errorBuilder: (context, error, stackTrace) =>
// // // // //                       const Icon(Icons.fastfood, color: Colors.green),
// // // // //                     )
// // // // //                         : const Icon(Icons.check_circle, color: Colors.green, size: 30),
// // // // //                   ),
// // // // //                 ),
// // // // //                 title: Text(
// // // // //                   post.foodName,
// // // // //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // //                 ),
// // // // //                 subtitle: Padding(
// // // // //                   padding: const EdgeInsets.only(top: 4),
// // // // //                   child: Column(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Text("Qty: ${post.quantity}"),
// // // // //                       Text("Pickup: ${post.pickupTime}", style: const TextStyle(fontSize: 12)),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ),
// // // // //                 trailing: Container(
// // // // //                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // // //                   decoration: BoxDecoration(
// // // // //                     color: Colors.green,
// // // // //                     borderRadius: BorderRadius.circular(5),
// // // // //                   ),
// // // // //                   child: const Text(
// // // // //                     "APPROVED",
// // // // //                     style: TextStyle(
// // // // //                         color: Colors.white,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         fontSize: 10
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import '../../../../../../../../core/constants/app_colors.dart';
// // // // // import '../../provider/receiver_provider.dart';
// // // // //
// // // // // class ApprovedTab extends StatelessWidget {
// // // // //   const ApprovedTab({super.key});
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Consumer<ReceiverProvider>(
// // // // //       builder: (context, provider, _) {
// // // // //         if (provider.isLoading) {
// // // // //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // //         }
// // // // //
// // // // //         final posts = provider.approvedPosts;
// // // // //
// // // // //         if (posts.isEmpty) {
// // // // //           return _buildEmptyState("No approved donations yet");
// // // // //         }
// // // // //
// // // // //         return ListView.builder(
// // // // //           padding: const EdgeInsets.all(12),
// // // // //           itemCount: posts.length,
// // // // //           itemBuilder: (context, index) {
// // // // //             final post = posts[index];
// // // // //             return Container(
// // // // //               margin: const EdgeInsets.only(bottom: 15),
// // // // //               decoration: BoxDecoration(
// // // // //                 color: Colors.white,
// // // // //                 borderRadius: BorderRadius.circular(16),
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.black.withOpacity(0.04),
// // // // //                     blurRadius: 10,
// // // // //                     offset: const Offset(0, 4),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Padding(
// // // // //                 padding: const EdgeInsets.all(12),
// // // // //                 child: Row(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     // --- ইমেজ সেকশন ---
// // // // //                     _buildLeadingImage(post.imageUrls),
// // // // //                     const SizedBox(width: 15),
// // // // //
// // // // //                     // --- ডিটেইলস সেকশন ---
// // // // //                     Expanded(
// // // // //                       child: Column(
// // // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                         children: [
// // // // //                           Row(
// // // // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                             children: [
// // // // //                               Expanded(
// // // // //                                 child: Text(
// // // // //                                   post.foodName,
// // // // //                                   maxLines: 1,
// // // // //                                   overflow: TextOverflow.ellipsis,
// // // // //                                   style: const TextStyle(
// // // // //                                     fontWeight: FontWeight.bold,
// // // // //                                     fontSize: 15,
// // // // //                                     color: Color(0xFF2D2D2D),
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ),
// // // // //                               _buildStatusBadge("APPROVED", Colors.green),
// // // // //                             ],
// // // // //                           ),
// // // // //                           const SizedBox(height: 8),
// // // // //
// // // // //                           // ১. কত জনের খাবার (Icon + Text)
// // // // //                           _infoRow(Icons.group_outlined, "For: ${post.quantity} Persons"),
// // // // //
// // // // //                           // ২. পিকআপ টাইম (Icon + Text)
// // // // //                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
// // // // //
// // // // //                           // ৩. পিকআপ অ্যাড্রেস (Icon + Text)
// // // // //                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
// // // // //
// // // // //                           const SizedBox(height: 4),
// // // // //                           const Divider(height: 10, thickness: 0.5),
// // // // //
// // // // //                           // ডোনারের সাথে যোগাযোগের জন্য একটি ছোট টেক্সট বা হিন্ট
// // // // //                           const Text(
// // // // //                             "Please contact the donor for collection.",
// // // // //                             style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.w500),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             );
// // // // //           },
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // --- হেল্পার উইজেটস ---
// // // // //
// // // // //   Widget _infoRow(IconData icon, String text) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.only(bottom: 5),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           Icon(icon, size: 14, color: Colors.green.withOpacity(0.7)),
// // // // //           const SizedBox(width: 6),
// // // // //           Expanded(
// // // // //             child: Text(
// // // // //               text,
// // // // //               maxLines: 1,
// // // // //               overflow: TextOverflow.ellipsis,
// // // // //               style: TextStyle(
// // // // //                 fontSize: 12,
// // // // //                 color: Colors.grey.shade600,
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildLeadingImage(List<String> urls) {
// // // // //     return ClipRRect(
// // // // //       borderRadius: BorderRadius.circular(12),
// // // // //       child: Container(
// // // // //         width: 90,
// // // // //         height: 90,
// // // // //         color: Colors.grey.shade100,
// // // // //         child: urls.isNotEmpty
// // // // //             ? Image.network(
// // // // //           urls.first,
// // // // //           fit: BoxFit.cover,
// // // // //           errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
// // // // //         )
// // // // //             : const Icon(Icons.check_circle_outline, color: Colors.green, size: 35),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildStatusBadge(String text, Color color) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // // //       decoration: BoxDecoration(
// // // // //         color: color.withOpacity(0.12),
// // // // //         borderRadius: BorderRadius.circular(6),
// // // // //       ),
// // // // //       child: Text(
// // // // //         text,
// // // // //         style: TextStyle(
// // // // //           color: color,
// // // // //           fontWeight: FontWeight.bold,
// // // // //           fontSize: 9,
// // // // //           letterSpacing: 0.5,
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildEmptyState(String msg) {
// // // // //     return Center(
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         children: [
// // // // //           Icon(Icons.assignment_turned_in_outlined, size: 60, color: Colors.grey.shade300),
// // // // //           const SizedBox(height: 12),
// // // // //           Text(
// // // // //             msg,
// // // // //             style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import '../../../../../../../../core/constants/app_colors.dart';
// // // // import '../../provider/receiver_provider.dart';
// // // //
// // // // class ApprovedTab extends StatelessWidget {
// // // //   const ApprovedTab({super.key});
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Consumer<ReceiverProvider>(
// // // //       builder: (context, provider, _) {
// // // //         if (provider.isLoading) {
// // // //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // //         }
// // // //
// // // //         final posts = provider.approvedPosts;
// // // //
// // // //         if (posts.isEmpty) {
// // // //           return _buildEmptyState("No approved donations yet");
// // // //         }
// // // //
// // // //         return ListView.builder(
// // // //           padding: const EdgeInsets.all(12),
// // // //           itemCount: posts.length,
// // // //           itemBuilder: (context, index) {
// // // //             final post = posts[index];
// // // //             return Container(
// // // //               margin: const EdgeInsets.only(bottom: 15),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.white,
// // // //                 borderRadius: BorderRadius.circular(16),
// // // //                 boxShadow: [
// // // //                   BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
// // // //                 ],
// // // //               ),
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.all(12),
// // // //                 child: Row(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     _buildLeadingImage(post.imageUrls),
// // // //                     const SizedBox(width: 15),
// // // //                     Expanded(
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Row(
// // // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                             children: [
// // // //                               Expanded(
// // // //                                 child: Text(post.foodName,
// // // //                                     maxLines: 1,
// // // //                                     overflow: TextOverflow.ellipsis,
// // // //                                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
// // // //                               ),
// // // //                               _buildStatusBadge("RECEIVED", Colors.green),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 8),
// // // //                           _infoRow(Icons.group_outlined, "For: ${post.quantity} Person"),
// // // //                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
// // // //                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   Widget _infoRow(IconData icon, String text) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(bottom: 5),
// // // //       child: Row(
// // // //         children: [
// // // //           Icon(icon, size: 14, color: AppColor.green.withOpacity(0.7)),
// // // //           const SizedBox(width: 6),
// // // //           Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey.shade600))),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildLeadingImage(List<String> urls) {
// // // //     return ClipRRect(
// // // //       borderRadius: BorderRadius.circular(12),
// // // //       child: Container(
// // // //         width: 85, height: 85, color: Colors.grey.shade100,
// // // //         child: urls.isNotEmpty
// // // //             ? Image.network(urls.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey))
// // // //             : const Icon(Icons.check_circle_outline, color: Colors.green, size: 30),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildStatusBadge(String text, Color color) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // //       decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
// // // //       child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9)),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildEmptyState(String msg) {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
// // // //           const SizedBox(height: 10),
// // // //           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import '../../../../../../../../core/constants/app_colors.dart';
// // // // import '../../provider/receiver_provider.dart';
// // // //
// // // // class ApprovedTab extends StatelessWidget {
// // // //   const ApprovedTab({super.key});
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Consumer<ReceiverProvider>(
// // // //       builder: (context, provider, _) {
// // // //         if (provider.isLoading) {
// // // //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // //         }
// // // //
// // // //         final requests = provider.approvedPosts;
// // // //
// // // //         if (requests.isEmpty) {
// // // //           return _buildEmptyState("No approved donations yet");
// // // //         }
// // // //
// // // //         return ListView.builder(
// // // //           padding: const EdgeInsets.all(12),
// // // //           itemCount: requests.length,
// // // //           itemBuilder: (context, index) {
// // // //             final post = requests[index];
// // // //
// // // //             // 🔹 Database field values
// // // //             final String dStatus = post.deliveryStatus.toLowerCase();
// // // //             final String donorStatus = post.status.toUpperCase(); // APPROVED / RECEIVED
// // // //
// // // //             return Container(
// // // //               margin: const EdgeInsets.only(bottom: 15),
// // // //               decoration: BoxDecoration(
// // // //                 color: Colors.white,
// // // //                 borderRadius: BorderRadius.circular(16),
// // // //                 boxShadow: [
// // // //                   BoxShadow(
// // // //                     color: Colors.black.withOpacity(0.04),
// // // //                     blurRadius: 10,
// // // //                     offset: const Offset(0, 4),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.all(12),
// // // //                 child: Row(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     _buildLeadingImage(post.imageUrls, dStatus),
// // // //                     const SizedBox(width: 15),
// // // //                     Expanded(
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Row(
// // // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                             children: [
// // // //                               Expanded(
// // // //                                 child: Text(
// // // //                                   post.foodName,
// // // //                                   maxLines: 1,
// // // //                                   overflow: TextOverflow.ellipsis,
// // // //                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
// // // //                                 ),
// // // //                               ),
// // // //                               // 🔹 Eikhane Donor er status (APPROVED/RECEIVED) show korbe
// // // //                               _buildBadge(donorStatus, Colors.green),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 10),
// // // //
// // // //                           // 🔹 Donor Info
// // // //                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),
// // // //
// // // //                           // 🔹 Delivery Status (Volunteer status onujayi update hobe)
// // // //                           _infoRow(
// // // //                             _getStatusIcon(dStatus),
// // // //                             "Delivery: ${dStatus.toUpperCase()}",
// // // //                             color: _getStatusColor(dStatus),
// // // //                             isBold: true,
// // // //                           ),
// // // //
// // // //                           const SizedBox(height: 5),
// // // //                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
// // // //                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   // --- Helpers ---
// // // //
// // // //   Color _getStatusColor(String status) {
// // // //     if (status == "completed") return Colors.green;
// // // //     if (status == "ongoing") return Colors.orange;
// // // //     return Colors.blue;
// // // //   }
// // // //
// // // //   IconData _getStatusIcon(String status) {
// // // //     if (status == "completed") return Icons.check_circle_outline;
// // // //     if (status == "ongoing") return Icons.motorcycle;
// // // //     return Icons.timer_outlined;
// // // //   }
// // // //
// // // //   // 🔹 Custom Badge Widget
// // // //   Widget _buildBadge(String text, Color color) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // // //       decoration: BoxDecoration(
// // // //         color: color.withOpacity(0.12),
// // // //         borderRadius: BorderRadius.circular(6),
// // // //       ),
// // // //       child: Text(
// // // //         text,
// // // //         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(bottom: 5),
// // // //       child: Row(
// // // //         children: [
// // // //           Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
// // // //           const SizedBox(width: 6),
// // // //           Expanded(
// // // //             child: Text(
// // // //               text,
// // // //               maxLines: 1,
// // // //               overflow: TextOverflow.ellipsis,
// // // //               style: TextStyle(
// // // //                 fontSize: 12,
// // // //                 color: color ?? Colors.grey.shade600,
// // // //                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildLeadingImage(List<String> urls, String status) {
// // // //     return ClipRRect(
// // // //       borderRadius: BorderRadius.circular(12),
// // // //       child: Stack(
// // // //         children: [
// // // //           Container(
// // // //             width: 85, height: 85, color: Colors.grey.shade100,
// // // //             child: urls.isNotEmpty
// // // //                 ? Image.network(
// // // //               urls.first,
// // // //               fit: BoxFit.cover,
// // // //               errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
// // // //             )
// // // //                 : const Icon(Icons.fastfood, color: Colors.grey),
// // // //           ),
// // // //           if (status == "ongoing")
// // // //             Positioned.fill(
// // // //               child: Container(
// // // //                 color: Colors.black.withOpacity(0.2),
// // // //                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 30),
// // // //               ),
// // // //             ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildEmptyState(String msg) {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
// // // //           const SizedBox(height: 10),
// // // //           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../../../../../../../../core/constants/app_colors.dart';
// // // import '../../provider/receiver_provider.dart';
// // //
// // // class ApprovedTab extends StatelessWidget {
// // //   const ApprovedTab({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Consumer<ReceiverProvider>(
// // //       builder: (context, provider, _) {
// // //         if (provider.isLoading) {
// // //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // //         }
// // //
// // //         final requests = provider.approvedPosts;
// // //
// // //         if (requests.isEmpty) {
// // //           return _buildEmptyState("No approved donations yet");
// // //         }
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: requests.length,
// // //           itemBuilder: (context, index) {
// // //             final post = requests[index];
// // //
// // //             // 🔹 Database field values
// // //             final String dStatus = post.deliveryStatus.toLowerCase(); // requests collection -> deliverystatus
// // //             // 🔹 Eikhane posts collection er status ta use kora hocche
// // //             final String postStatus = post.status.toUpperCase();
// // //
// // //             return Container(
// // //               margin: const EdgeInsets.only(bottom: 15),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(16),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.black.withOpacity(0.04),
// // //                     blurRadius: 10,
// // //                     offset: const Offset(0, 4),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(12),
// // //                 child: Row(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     _buildLeadingImage(post.imageUrls, dStatus),
// // //                     const SizedBox(width: 15),
// // //                     Expanded(
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               Expanded(
// // //                                 child: Text(
// // //                                   post.foodName,
// // //                                   maxLines: 1,
// // //                                   overflow: TextOverflow.ellipsis,
// // //                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
// // //                                 ),
// // //                               ),
// // //                               // 🔹 এখানি সরাসরি পোস্টের স্ট্যাটাস (CLAIMED/COMPLETED) দেখাবে
// // //                               _buildBadge(postStatus, _getPostStatusColor(postStatus)),
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 10),
// // //
// // //                           // 🔹 Donor Info
// // //                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),
// // //
// // //                           // 🔹 Delivery Status Row
// // //                           _infoRow(
// // //                             _getStatusIcon(dStatus),
// // //                             "Delivery: ${dStatus.toUpperCase()}",
// // //                             color: _getStatusColor(dStatus),
// // //                             isBold: true,
// // //                           ),
// // //
// // //                           const SizedBox(height: 5),
// // //                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
// // //                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- Helpers ---
// // //
// // //   // 🔹 পোস্টের স্ট্যাটাস অনুযায়ী কালার কোড
// // //   Color _getPostStatusColor(String status) {
// // //     if (status == "COMPLETED") return Colors.grey;
// // //     if (status == "CLAIMED") return Colors.green;
// // //     return AppColor.green;
// // //   }
// // //
// // //   Color _getStatusColor(String status) {
// // //     if (status == "completed") return Colors.green;
// // //     if (status == "ongoing") return Colors.orange;
// // //     return Colors.blue;
// // //   }
// // //
// // //   IconData _getStatusIcon(String status) {
// // //     if (status == "completed") return Icons.check_circle_outline;
// // //     if (status == "ongoing") return Icons.motorcycle;
// // //     return Icons.timer_outlined;
// // //   }
// // //
// // //   Widget _buildBadge(String text, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         color: color.withOpacity(0.12),
// // //         borderRadius: BorderRadius.circular(6),
// // //       ),
// // //       child: Text(
// // //         text,
// // //         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(bottom: 5),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
// // //           const SizedBox(width: 6),
// // //           Expanded(
// // //             child: Text(
// // //               text,
// // //               maxLines: 1,
// // //               overflow: TextOverflow.ellipsis,
// // //               style: TextStyle(
// // //                 fontSize: 12,
// // //                 color: color ?? Colors.grey.shade600,
// // //                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildLeadingImage(List<String> urls, String status) {
// // //     return ClipRRect(
// // //       borderRadius: BorderRadius.circular(12),
// // //       child: Stack(
// // //         children: [
// // //           Container(
// // //             width: 85, height: 85, color: Colors.grey.shade100,
// // //             child: urls.isNotEmpty
// // //                 ? Image.network(
// // //               urls.first,
// // //               fit: BoxFit.cover,
// // //               errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
// // //             )
// // //                 : const Icon(Icons.fastfood, color: Colors.grey),
// // //           ),
// // //           if (status == "ongoing")
// // //             Positioned.fill(
// // //               child: Container(
// // //                 color: Colors.black.withOpacity(0.2),
// // //                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 30),
// // //               ),
// // //             ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildEmptyState(String msg) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
// // //           const SizedBox(height: 10),
// // //           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../../../../../../core/constants/app_colors.dart';
// // import '../../provider/receiver_provider.dart';
// //
// // class ApprovedTab extends StatelessWidget {
// //   const ApprovedTab({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<ReceiverProvider>(
// //       builder: (context, provider, _) {
// //         if (provider.isLoading) {
// //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //         }
// //
// //         final requests = provider.approvedPosts;
// //
// //         if (requests.isEmpty) {
// //           return _buildEmptyState("No approved donations yet");
// //         }
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: requests.length,
// //           itemBuilder: (context, index) {
// //             final post = requests[index];
// //
// //             // 🔹 ডাটাবেস থেকে সরাসরি ভ্যালু নেওয়া হচ্ছে
// //             // ১. status ফিল্ড (সরাসরি যা আসবে তাই)
// //             final String donorStatusText = post.status.toString();
// //             // ২. deliverystatus ফিল্ড (সরাসরি যা আসবে তাই)
// //             final String deliveryStatusText = post.deliveryStatus.toString();
// //
// //             return Container(
// //               margin: const EdgeInsets.only(bottom: 15),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.04),
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(12),
// //                 child: Row(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _buildLeadingImage(post.imageUrls, deliveryStatusText.toLowerCase()),
// //                     const SizedBox(width: 15),
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Expanded(
// //                                 child: Text(
// //                                   post.foodName,
// //                                   maxLines: 1,
// //                                   overflow: TextOverflow.ellipsis,
// //                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //                                 ),
// //                               ),
// //                               // ✅ এখানে সরাসরি ডাটাবেসের status ফিল্ডের টেক্সট শো করবে
// //                               Row(
// //                                 children: [
// //                                   const Text(
// //                                     "Donor Status: ",
// //                                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
// //                                   ),
// //                                   _buildBadge(donorStatusText.toUpperCase(), _getStatusColor(donorStatusText.toLowerCase())),
// //                                 ],
// //                               ),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 10),
// //
// //                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),
// //
// //                           // ✅ এখানে সরাসরি ডাটাবেসের deliverystatus ফিল্ডের টেক্সট শো করবে
// //                           _infoRow(
// //                             _getDeliveryIcon(deliveryStatusText.toLowerCase()),
// //                             "Delivery: ${deliveryStatusText.toUpperCase()}",
// //                             color: _getStatusColor(deliveryStatusText.toLowerCase()),
// //                             isBold: true,
// //                           ),
// //
// //                           const SizedBox(height: 5),
// //                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
// //                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // --- Helpers ---
// //
// //   Color _getStatusColor(String status) {
// //     if (status == 'delivered' || status == 'completed') return Colors.green;
// //     if (status == 'approved') return Colors.blue;
// //     if (status == 'ongoing') return Colors.orange;
// //     if (status == 'pending') return Colors.blueGrey;
// //     return Colors.grey; // Default color
// //   }
// //
// //   IconData _getDeliveryIcon(String status) {
// //     if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
// //     if (status == "ongoing") return Icons.motorcycle;
// //     return Icons.timer_outlined;
// //   }
// //
// //   Widget _buildBadge(String text, Color color) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //       decoration: BoxDecoration(
// //         color: color.withOpacity(0.12),
// //         borderRadius: BorderRadius.circular(4),
// //       ),
// //       child: Text(
// //         text,
// //         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
// //       ),
// //     );
// //   }
// //
// //   Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 5),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
// //           const SizedBox(width: 6),
// //           Expanded(
// //             child: Text(
// //               text,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(
// //                 fontSize: 11,
// //                 color: color ?? Colors.grey.shade600,
// //                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildLeadingImage(List<String> urls, String status) {
// //     return ClipRRect(
// //       borderRadius: BorderRadius.circular(12),
// //       child: Stack(
// //         children: [
// //           Container(
// //             width: 80, height: 80, color: Colors.grey.shade100,
// //             child: urls.isNotEmpty
// //                 ? Image.network(
// //               urls.first,
// //               fit: BoxFit.cover,
// //               errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
// //             )
// //                 : const Icon(Icons.fastfood, color: Colors.grey),
// //           ),
// //           if (status == "ongoing")
// //             Positioned.fill(
// //               child: Container(
// //                 color: Colors.black.withOpacity(0.2),
// //                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildEmptyState(String msg) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
// //           const SizedBox(height: 10),
// //           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class ApprovedTab extends StatelessWidget {
//   const ApprovedTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final requests = provider.approvedPosts;
//
//         if (requests.isEmpty) {
//           return _buildEmptyState("No approved donations yet");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final post = requests[index];
//
//             // 🔹 সরাসরি requests কালেকশনের ডাটা (যা আমরা প্রোভাইডারে ইনজেক্ট করেছি)
//             final String donorStatus = post.status.toLowerCase();
//             final String dStatus = post.deliveryStatus.toLowerCase();
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
//                     _buildLeadingImage(post.imageUrls, dStatus),
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
//                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                                 ),
//                               ),
//                               // ✅ Donor Status ব্যাজ (সরাসরি status ফিল্ডের ডাটা)
//                               Row(
//                                 children: [
//                                   const Text(
//                                     "Donor Status: ",
//                                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
//                                   ),
//                                   _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//
//                           // 🔹 Donor Info
//                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),
//
//                           // 🔹 Delivery Status Row
//                           _infoRow(
//                             _getStatusIcon(dStatus),
//                             "Delivery: ${dStatus.toUpperCase()}",
//                             color: _getStatusColor(dStatus),
//                             isBold: true,
//                           ),
//
//                           const SizedBox(height: 5),
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
//   // --- Helpers (অ্যাগের সেই ডিজাইন অনুযায়ী) ---
//
//   Color _getStatusColor(String status) {
//     if (status == 'delivered' || status == 'completed') return Colors.green;
//     if (status == 'approved') return Colors.blue;
//     if (status == 'ongoing') return Colors.orange;
//     return AppColor.green;
//   }
//
//   IconData _getStatusIcon(String status) {
//     if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
//     if (status == "ongoing") return Icons.motorcycle;
//     return Icons.timer_outlined;
//   }
//
//   Widget _buildBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: color ?? Colors.grey.shade600,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeadingImage(List<String> urls, String status) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Stack(
//         children: [
//           Container(
//             width: 80, height: 80, color: Colors.grey.shade100,
//             child: urls.isNotEmpty
//                 ? Image.network(
//               urls.first,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
//             )
//                 : const Icon(Icons.fastfood, color: Colors.grey),
//           ),
//           if (status == "ongoing")
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.2),
//                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String msg) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
//           const SizedBox(height: 10),
//           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../provider/receiver_provider.dart';

class ApprovedTab extends StatelessWidget {
  const ApprovedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        final requests = provider.approvedPosts;

        if (requests.isEmpty) {
          return _buildEmptyState("No approved donations yet");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final post = requests[index];

            // 🔹 সরাসরি requests কালেকশনের ডাটা
            final String donorStatus = post.status.toLowerCase(); // delivered, approved
            final String dStatus = post.deliveryStatus.toLowerCase(); // pending, ongoing, completed

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  Shadows.softShadow, // আপনার কাস্টম শ্যাডো থাকলে সেটি দিন বা নিচেরটা রাখুন
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
                    _buildLeadingImage(post.imageUrls, dStatus),
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ),
                              // ✅ Donor Status ব্যাজ (সরাসরি status ফিল্ডের ডাটা)
                              Row(
                                children: [
                                  const Text(
                                    "Donor Status: ",
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
                                  ),
                                  _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // 🔹 Donor Info
                          _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),

                          // 🔹 Delivery Status Row (Pending এবং Delivered কালার হ্যান্ডেল করা হয়েছে)
                          _infoRow(
                            _getStatusIcon(dStatus),
                            "Delivery: ${dStatus.toUpperCase()}",
                            color: _getStatusColor(dStatus),
                            isBold: true,
                          ),

                          const SizedBox(height: 5),
                          _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
                          _infoRow(Icons.location_on_outlined, post.pickupAddress),
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

  // --- Helpers ---

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
      case 'completed':
        return Colors.green; // ডেলিভারি হলে সবুজ
      case 'ongoing':
        return Colors.orange; // রাস্তায় থাকলে কমলা
      case 'pending':
        return Colors.blueGrey; // পেন্ডিং থাকলে নীলচে ধূসর (যাতে আলাদা বোঝা যায়)
      case 'approved':
        return Colors.blue;
      default:
        return AppColor.green;
    }
  }

  IconData _getStatusIcon(String status) {
    if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
    if (status == "ongoing") return Icons.motorcycle;
    return Icons.timer_outlined; // Pending এর জন্য টাইমার আইকন
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: color ?? Colors.grey.shade600,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingImage(List<String> urls, String status) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: 80, height: 80, color: Colors.grey.shade100,
            child: urls.isNotEmpty
                ? Image.network(
              urls.first,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
            )
                : const Icon(Icons.fastfood, color: Colors.grey),
          ),
          if (status == "ongoing")
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        ],
      ),
    );
  }
}

// শ্যাডো এর জন্য একটি সিম্পল ক্লাস (যদি না থাকে)
class Shadows {
  static BoxShadow softShadow = BoxShadow(
    color: Colors.black.withOpacity(0.04),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
}