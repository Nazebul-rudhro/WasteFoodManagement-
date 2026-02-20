// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // // import '../../../../../../../../core/constants/app_colors.dart';
// // // import '../../../../../../../auth/data/model/post_model.dart';
// // // import '../../provider/receiver_provider.dart';
// // //
// // // class ReceiverAllPost extends StatefulWidget {
// // //   const ReceiverAllPost({super.key});
// // //
// // //   @override
// // //   State<ReceiverAllPost> createState() => _ReceiverAllPostState();
// // // }
// // //
// // // class _ReceiverAllPostState extends State<ReceiverAllPost> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
// // //   }
// // //
// // //   bool isPostStillValid(PostModel post) {
// // //     try {
// // //       final now = DateTime.now();
// // //
// // //       // 🔹 expiryDate সরাসরি থাকলে সেটা চেক করা সবচেয়ে নিরাপদ
// // //       if (post.expiryDate != null) {
// // //         return now.isBefore(post.expiryDate!);
// // //       }
// // //
// // //       // যদি expiryDate না থাকে তবে আপনার string parsing লজিক:
// // //       DateTime createdDate = post.createdAt?.toDate() ?? DateTime.now();
// // //       final parts = post.pickupTime.split(' (');
// // //       if (parts.length < 2) return true;
// // //
// // //       final timePart = parts[0].trim();
// // //       final dayPart = parts[1].trim();
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
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final provider = context.watch<ReceiverProvider>();
// // //
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey.shade50,
// // //       appBar: AppBar(
// // //         backgroundColor: AppColor.green,
// // //         elevation: 0,
// // //         iconTheme: const IconThemeData(color: Colors.white),
// // //         title: const Text("All Available Food",
// // //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
// // //         centerTitle: true,
// // //       ),
// // //       body: BaseScreen(
// // //         child: StreamBuilder<QuerySnapshot>(
// // //           // 🔹 ইনডেক্স এরর দিলে ব্রাউজারের লিঙ্কে ক্লিক করে ইনডেক্স সেভ করবেন
// // //           stream: FirebaseFirestore.instance
// // //               .collection('posts')
// // //               .where('status', isEqualTo: 'available')
// // //               .orderBy('createdAt', descending: true)
// // //               .snapshots(),
// // //           builder: (context, snapshot) {
// // //             if (snapshot.connectionState == ConnectionState.waiting) {
// // //               return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // //             }
// // //
// // //             if (snapshot.hasError) {
// // //               debugPrint("Stream Error: ${snapshot.error}");
// // //               return const Center(child: Text("Something went wrong. Check Indexing."));
// // //             }
// // //
// // //             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // //               return const Center(child: Text("No food posts available"));
// // //             }
// // //
// // //             final posts = snapshot.data!.docs
// // //                 .map((doc) => PostModel.fromSnapshot(doc))
// // //                 .where((post) {
// // //               final bool notRequested = !provider.myRequests.contains(post.postId);
// // //               final bool timeValid = isPostStillValid(post);
// // //               return notRequested && timeValid;
// // //             }).toList();
// // //
// // //             if (posts.isEmpty) {
// // //               return const Center(child: Text("No valid food items available"));
// // //             }
// // //
// // //             return GridView.builder(
// // //               padding: const EdgeInsets.all(12),
// // //               itemCount: posts.length,
// // //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //                 crossAxisCount: 2,
// // //                 mainAxisSpacing: 12,
// // //                 crossAxisSpacing: 12,
// // //                 childAspectRatio: 0.68,
// // //               ),
// // //               itemBuilder: (context, index) {
// // //                 final post = posts[index];
// // //                 final isLoading = provider.isRequesting[post.postId] ?? false;
// // //                 return _buildProfessionalPostCard(context, post, isLoading, provider);
// // //               },
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildProfessionalPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white,
// // //         borderRadius: BorderRadius.circular(12),
// // //         boxShadow: [
// // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Expanded(
// // //             flex: 5,
// // //             child: ClipRRect(
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// // //               child: Container(
// // //                 width: double.infinity,
// // //                 color: Colors.grey[100],
// // //                 child: post.imageUrls.isNotEmpty
// // //                     ? Image.network(post.imageUrls.first, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholderIcon())
// // //                     : _placeholderIcon(),
// // //               ),
// // //             ),
// // //           ),
// // //           Expanded(
// // //             flex: 6,
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(10.0),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: [
// // //                   Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// // //                   _miniInfoItem(Icons.inventory_2_outlined, post.quantity),
// // //                   _miniInfoItem(Icons.schedule_outlined, post.pickupTime),
// // //                   _miniInfoItem(Icons.location_on_outlined, post.pickupAddress),
// // //                   const SizedBox(height: 4),
// // //                   SizedBox(
// // //                     width: double.infinity,
// // //                     height: 35,
// // //                     child: ElevatedButton(
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: AppColor.green,
// // //                         elevation: 0,
// // //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                       ),
// // //                       onPressed: isLoading ? null : () async {
// // //                         await provider.sendRequest(post.postId, post.donorId);
// // //                       },
// // //                       child: isLoading
// // //                           ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// // //                           : const Text("Request Now", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
// // //                     ),
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
// // //   Widget _miniInfoItem(IconData icon, String text) {
// // //     return Row(
// // //       children: [
// // //         Icon(icon, size: 13, color: Colors.grey),
// // //         const SizedBox(width: 5),
// // //         Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: Colors.black54))),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _placeholderIcon() {
// // //     return const Center(child: Icon(Icons.fastfood_outlined, color: Colors.grey, size: 35));
// // //   }
// // // }
// //
// //
// //
// //
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
// //   bool isPostStillValid(PostModel post) {
// //     if (post.expiryDate != null) {
// //       return DateTime.now().isBefore(post.expiryDate!);
// //     }
// //     return true;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = context.watch<ReceiverProvider>();
// //
// //     return Scaffold(
// //       backgroundColor: Colors.grey.shade50,
// //       appBar: AppBar(
// //         backgroundColor: AppColor.green,
// //         elevation: 0,
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         title: const Text("All Available Food",
// //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
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
// //               return const Center(child: Text("No food posts available"));
// //             }
// //
// //             // 🔹 এরর ফিক্সড ফিল্টারিং
// //             final posts = snapshot.data!.docs.map((doc) => PostModel.fromSnapshot(doc)).where((post) {
// //               final bool notRequested = !provider.myRequestIds.contains(post.postId);
// //               return notRequested && isPostStillValid(post);
// //             }).toList();
// //
// //             if (posts.isEmpty) {
// //               return const Center(child: Text("No valid food items available"));
// //             }
// //
// //             return GridView.builder(
// //               padding: const EdgeInsets.all(12),
// //               itemCount: posts.length,
// //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: 2,
// //                 mainAxisSpacing: 12,
// //                 crossAxisSpacing: 12,
// //                 childAspectRatio: 0.68,
// //               ),
// //               itemBuilder: (context, index) {
// //                 final post = posts[index];
// //                 final isLoading = provider.isRequesting[post.postId] ?? false;
// //                 return _buildProfessionalPostCard(context, post, isLoading, provider);
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildProfessionalPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 4))
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Expanded(
// //             flex: 5,
// //             child: ClipRRect(
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //               child: Container(
// //                 width: double.infinity,
// //                 color: Colors.grey[100],
// //                 child: post.imageUrls.isNotEmpty
// //                     ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
// //                     : const Icon(Icons.fastfood, color: Colors.grey),
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             flex: 6,
// //             child: Padding(
// //               padding: const EdgeInsets.all(10.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Text(post.foodName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// //                   _miniInfo(Icons.inventory_2_outlined, post.quantity),
// //                   _miniInfo(Icons.location_on_outlined, post.pickupAddress),
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 35,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
// //                       onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
// //                       child: isLoading
// //                           ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //                           : const Text("Request Now", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
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
// //   Widget _miniInfo(IconData icon, String text) {
// //     return Row(
// //       children: [
// //         Icon(icon, size: 13, color: Colors.grey),
// //         const SizedBox(width: 5),
// //         Expanded(child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10))),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/post_model.dart';
// import '../../provider/receiver_provider.dart';
// import 'package:intl/intl.dart'; // সময় ফরম্যাট করার জন্য
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
//   // প্রফেশনাল এক্সপায়ারি চেক লজিক
//   bool isPostStillValid(PostModel post) {
//     if (post.expiryDate != null) {
//       return DateTime.now().isBefore(post.expiryDate!);
//     }
//     return true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<ReceiverProvider>();
//
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       appBar: AppBar(
//         backgroundColor: AppColor.green,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text("Available Food Near You",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('posts')
//               .where('status', isEqualTo: 'available')
//               .orderBy('createdAt', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return _emptyState("No food posts found.");
//             }
//
//             final posts = snapshot.data!.docs
//                 .map((doc) => PostModel.fromSnapshot(doc))
//                 .where((post) {
//               final bool notRequested = !provider.myRequestIds.contains(post.postId);
//               return notRequested && isPostStillValid(post);
//             }).toList();
//
//             if (posts.isEmpty) {
//               return _emptyState("All items are requested or expired.");
//             }
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: posts.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 0.62, // সব ইনফরমেশন দেখানোর জন্য রেশিও একটু কমানো হয়েছে
//               ),
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 final isLoading = provider.isRequesting[post.postId] ?? false;
//                 return _buildProfessionalPostCard(context, post, isLoading, provider);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfessionalPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
//     // এক্সপায়ারি টাইম ফরম্যাট
//     String expiryStr = post.expiryDate != null
//         ? DateFormat('hh:mm a').format(post.expiryDate!)
//         : "N/A";
//
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ইমেজ এবং এক্সপায়ারি ব্যাজ
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
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
//                         : const Icon(Icons.fastfood, color: Colors.grey, size: 40),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.redAccent.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text("Expires: $expiryStr",
//                         style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // ইনফরমেশন সেকশন
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.foodName,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//
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
//                   const Spacer(),
//
//                   // রিকোয়েস্ট বাটন
//                   SizedBox(
//                     width: double.infinity,
//                     height: 38,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
//                       child: isLoading
//                           ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                           : const Text("Request Food", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
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
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 11, color: Colors.grey.shade700)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _emptyState(String msg) {
//     return Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
//   }
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

  /// 🔹 প্রফেশনাল ভ্যালিডেশন লজিক: খাবার কি এখনো ভালো আছে?
  bool isPostValid(PostModel post) {
    final now = DateTime.now();

    // ১. স্ট্যাটাস যদি এভেইলএবল না থাকে তবে দেখাবে না
    if (post.status != 'available') return false;

    // ২. এক্সপায়ারি ডেট চেক (যদি আপনার মডেল-এ DateTime থাকে)
    if (post.expiryDate != null) {
      return post.expiryDate!.isAfter(now);
    }

    // ৩. ব্যাকআপ লজিক: যদি expiryDate না থাকে, তাহলে pickupTime দিয়ে চেক করা যায়
    // তবে সবচেয়ে প্রফেশনাল উপায় হলো ফায়ারস্টোরে 'expiryDate' ফিল্ড রাখা।
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: AppColor.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Available Food Near You",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        centerTitle: true,
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('status', isEqualTo: 'available')
          // 🔹 সার্ভার সাইড ফিল্টারিং: শুধু ফিউচার এক্সপায়ারি ডেট এর পোস্ট আনা ভালো
          // .where('expiryDate', isGreaterThan: DateTime.now()) // ইনডেক্স প্রয়োজন হতে পারে
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColor.green));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return _emptyView("No food posts available");
            }

            // 🔹 প্রফেশনাল ফিল্টারিং (Requested + Expired Check)
            final posts = snapshot.data!.docs
                .map((doc) => PostModel.fromSnapshot(doc))
                .where((post) {
              final bool notRequested = !provider.myRequestIds.contains(post.postId);
              final bool valid = isPostValid(post);
              return notRequested && valid;
            }).toList();

            if (posts.isEmpty) {
              return _emptyView("All items are either requested or expired");
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10), // স্পেস কমানো হয়েছে
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.68, // কার্ডের হাইট পারফেক্ট রাখার জন্য
              ),
              itemBuilder: (context, index) {
                final post = posts[index];
                final isLoading = provider.isRequesting[post.postId] ?? false;
                return _buildModernPostCard(context, post, isLoading, provider);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildModernPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // আরও রাউন্ডেড এবং মডার্ন
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ইমেজ সেকশন
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
                        : const Icon(Icons.fastfood_outlined, color: Colors.grey, size: 40),
                  ),
                  // ছোট স্ট্যাটাস ব্যাজ (অপশনাল)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Fresh",
                        style: TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ইনফরমেশন সেকশন
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.foodName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),

                  _infoRow(Icons.group_outlined, "For: ${post.quantity} Person"),
                  _infoRow(Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
                  _infoRow(Icons.location_on_outlined, post.pickupAddress),

                  const Spacer(),

                  // প্রিমিয়াম রিকোয়েস্ট বাটন
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
                      child: isLoading
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("Request Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColor.green),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyView(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_clear_outlined, size: 50, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text(message, style: TextStyle(color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}