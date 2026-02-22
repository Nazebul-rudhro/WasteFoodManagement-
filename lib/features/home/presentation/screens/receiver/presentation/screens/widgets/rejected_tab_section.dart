// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // নিশ্চিত করুন এই ইমপোর্টটি আছে
// import '../../provider/receiver_provider.dart';
//
// class RejectedTab extends StatefulWidget {
//   const RejectedTab({super.key});
//
//   @override
//   State<RejectedTab> createState() => _RejectedTabState();
// }
//
// class _RejectedTabState extends State<RejectedTab> {
//   @override
//   void initState() {
//     super.initState();
//     // স্ক্রিন লোড হওয়ার সময় ডাটা রিফ্রেশ করার জন্য
//     Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, child) {
//         final posts = provider.rejectedPosts;
//
//         if (posts.isEmpty) {
//           return const Center(
//             child: Text(
//               "No rejected requests found",
//               style: TextStyle(color: Colors.grey, fontSize: 16),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//             return Card(
//               color: Colors.red.shade50, // রিজেক্টেড এর জন্য হালকা লাল ব্যাকগ্রাউন্ড
//               elevation: 2,
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 side: BorderSide(color: Colors.red.shade100),
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(12),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     color: Colors.white,
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(
//                       post.imageUrls.first,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, color: Colors.red),
//                     )
//                         : const Icon(Icons.cancel, color: Colors.red, size: 30),
//                   ),
//                 ),
//                 title: Text(
//                   post.foodName,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 subtitle: const Padding(
//                   padding: EdgeInsets.only(top: 4),
//                   child: Text(
//                     "This request was declined by the donor.",
//                     style: TextStyle(color: Colors.redAccent, fontSize: 12),
//                   ),
//                 ),
//                 trailing: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: const Text(
//                     "REJECTED",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../provider/receiver_provider.dart';
//
// class RejectedTab extends StatefulWidget {
//   const RejectedTab({super.key});
//
//   @override
//   State<RejectedTab> createState() => _RejectedTabState();
// }
//
// class _RejectedTabState extends State<RejectedTab> {
//   @override
//   void initState() {
//     super.initState();
//     // স্ক্রিন লোড হওয়ার সময় ডাটা রিফ্রেশ করা
//     Future.microtask(() {
//       if (mounted) {
//         context.read<ReceiverProvider>().fetchAllPosts();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, child) {
//         // রিসিভার প্রোভাইডার থেকে রিজেক্টেড পোস্টগুলো নেওয়া
//         final posts = provider.rejectedPosts;
//
//         // ১. লোডিং স্টেট চেক (যদি প্রোভাইডারে isLoading থাকে)
//         if (provider.isLoading && posts.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         // ২. ডাটা খালি থাকলে মেসেজ
//         if (posts.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.info_outline, size: 50, color: Colors.grey[400]),
//                 const SizedBox(height: 10),
//                 const Text(
//                   "No rejected requests found",
//                   style: TextStyle(color: Colors.grey, fontSize: 16),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         // ৩. রিজেক্টেড লিস্ট রেন্ডার করা
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           physics: const BouncingScrollPhysics(),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//
//             return Card(
//               color: Colors.red.shade50,
//               elevation: 0, // রিজেক্টেড এর জন্য ফ্ল্যাট ডিজাইন ভালো লাগে
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 side: BorderSide(color: Colors.red.shade100, width: 1),
//               ),
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(12),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     color: Colors.white,
//                     child: (post.imageUrls != null && post.imageUrls!.isNotEmpty)
//                         ? Image.network(
//                       post.imageUrls!.first,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, color: Colors.red),
//                     )
//                         : const Icon(Icons.no_photography, color: Colors.red, size: 24),
//                   ),
//                 ),
//                 title: Text(
//                   post.foodName ?? "Unknown Food",
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 4),
//                     Text(
//                       "Reason: This request was declined.",
//                       style: TextStyle(color: Colors.red.shade700, fontSize: 12),
//                     ),
//                     Text(
//                       "Qty: ${post.quantity ?? 'N/A'}",
//                       style: const TextStyle(color: Colors.black54, fontSize: 11),
//                     ),
//                   ],
//                 ),
//                 trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: const Text(
//                         "REJECTED",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 9,
//                         ),
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
// }




//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class RejectedTab extends StatefulWidget {
//   const RejectedTab({super.key});
//
//   @override
//   State<RejectedTab> createState() => _RejectedTabState();
// }
//
// class _RejectedTabState extends State<RejectedTab> {
//   @override
//   void initState() {
//     super.initState();
//     // স্ক্রিন লোড হওয়ার সাথে সাথে ডাটা রিফ্রেশ করা
//     Future.microtask(() {
//       if (mounted) {
//         context.read<ReceiverProvider>().fetchAllPosts();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final posts = provider.rejectedPosts;
//
//         if (posts.isEmpty) {
//           return _buildEmptyState("No rejected requests found");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           physics: const BouncingScrollPhysics(),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: Border.all(color: Colors.red.shade50),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.red.withOpacity(0.02),
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
//                     // --- ইমেজ সেকশন ---
//                     _buildLeadingImage(post.imageUrls),
//                     const SizedBox(width: 15),
//
//                     // --- ডিটেইলস সেকশন ---
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
//                               _buildStatusBadge("REJECTED", Colors.red),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//
//                           // ১. কত জনের খাবার
//                           _infoRow(Icons.group_outlined, "For: ${post.quantity} Persons"),
//
//                           // ২. পিকআপ টাইম
//                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
//
//                           // ৩. লোকেশন
//                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
//
//                           const SizedBox(height: 4),
//                           const Divider(height: 10, thickness: 0.5),
//
//                           // রিজেক্টেড হওয়ার ছোট মেসেজ
//                           Row(
//                             children: [
//                               Icon(Icons.info_outline, size: 12, color: Colors.red.shade300),
//                               const SizedBox(width: 4),
//                               const Text(
//                                 "Request declined by donor.",
//                                 style: TextStyle(fontSize: 10, color: Colors.red, fontWeight: FontWeight.w500),
//                               ),
//                             ],
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
//   // --- হেল্পার উইজেটস ---
//
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: Colors.red.withOpacity(0.5)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//               ),
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
//           errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.red),
//         )
//             : const Icon(Icons.no_photography_outlined, color: Colors.red, size: 30),
//       ),
//     );
//   }
//
//   Widget _buildStatusBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 9,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String msg) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.cancel_presentation_outlined, size: 60, color: Colors.grey.shade300),
//           const SizedBox(height: 12),
//           Text(
//             msg,
//             style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
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

class RejectedTab extends StatelessWidget {
  const RejectedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        // Provider theke sorted rejected list niye asha
        final posts = provider.rejectedPosts;

        if (posts.isEmpty) {
          return _buildEmptyState("No rejected requests found");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withOpacity(0.1)),
                boxShadow: [
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
                    // Image Section
                    _buildImage(post.imageUrls),
                    const SizedBox(width: 15),

                    // Content Section
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
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _badge("REJECTED", Colors.red),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _rowInfo(Icons.group_outlined, "Quantity: ${post.quantity}"),
                          _rowInfo(Icons.access_time, "Pickup: ${post.pickupTime}"),
                          _rowInfo(Icons.location_on_outlined, post.pickupAddress),

                          const Divider(height: 20, thickness: 0.5),
                          const Text(
                            "Donation request was not accepted.",
                            style: TextStyle(fontSize: 10, color: Colors.redAccent, fontWeight: FontWeight.w500),
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

  Widget _rowInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _badge(String txt, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(txt, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9)),
    );
  }

  Widget _buildImage(List<String> urls) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80, height: 80, color: Colors.grey.shade100,
        child: urls.isNotEmpty
            ? Image.network(urls.first, fit: BoxFit.cover, errorBuilder: (_,__,___) => const Icon(Icons.fastfood))
            : const Icon(Icons.fastfood, color: Colors.grey),
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cancel_schedule_send, size: 50, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text(msg, style: TextStyle(color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}