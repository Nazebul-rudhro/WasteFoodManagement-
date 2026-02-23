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
//   /// 🔹 প্রফেশনাল ভ্যালিডেশন লজিক: খাবার কি এখনো ভালো আছে?
//   bool isPostValid(PostModel post) {
//     final now = DateTime.now();
//
//     // ১. স্ট্যাটাস যদি এভেইলএবল না থাকে তবে দেখাবে না
//     if (post.status != 'available') return false;
//
//     // ২. এক্সপায়ারি ডেট চেক (যদি আপনার মডেল-এ DateTime থাকে)
//     if (post.expiryDate != null) {
//       return post.expiryDate!.isAfter(now);
//     }
//
//     // ৩. ব্যাকআপ লজিক: যদি expiryDate না থাকে, তাহলে pickupTime দিয়ে চেক করা যায়
//     // তবে সবচেয়ে প্রফেশনাল উপায় হলো ফায়ারস্টোরে 'expiryDate' ফিল্ড রাখা।
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
//           // 🔹 সার্ভার সাইড ফিল্টারিং: শুধু ফিউচার এক্সপায়ারি ডেট এর পোস্ট আনা ভালো
//           // .where('expiryDate', isGreaterThan: DateTime.now()) // ইনডেক্স প্রয়োজন হতে পারে
//               .orderBy('createdAt', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             }
//
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return _emptyView("No food posts available");
//             }
//
//             // 🔹 প্রফেশনাল ফিল্টারিং (Requested + Expired Check)
//             final posts = snapshot.data!.docs
//                 .map((doc) => PostModel.fromSnapshot(doc))
//                 .where((post) {
//               final bool notRequested = !provider.myRequestIds.contains(post.postId);
//               final bool valid = isPostValid(post);
//               return notRequested && valid;
//             }).toList();
//
//             if (posts.isEmpty) {
//               return _emptyView("All items are either requested or expired");
//             }
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(10), // স্পেস কমানো হয়েছে
//               itemCount: posts.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 10,
//                 crossAxisSpacing: 10,
//                 childAspectRatio: 0.68, // কার্ডের হাইট পারফেক্ট রাখার জন্য
//               ),
//               itemBuilder: (context, index) {
//                 final post = posts[index];
//                 final isLoading = provider.isRequesting[post.postId] ?? false;
//                 return _buildModernPostCard(context, post, isLoading, provider);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildModernPostCard(BuildContext context, PostModel post, bool isLoading, ReceiverProvider provider) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(15), // আরও রাউন্ডেড এবং মডার্ন
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ইমেজ সেকশন
//           Expanded(
//             flex: 4,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//               child: Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[100],
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
//                         : const Icon(Icons.fastfood_outlined, color: Colors.grey, size: 40),
//                   ),
//                   // ছোট স্ট্যাটাস ব্যাজ (অপশনাল)
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.9),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(
//                         "Fresh",
//                         style: TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // ইনফরমেশন সেকশন
//           Expanded(
//             flex: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post.foodName,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
//                   ),
//                   const SizedBox(height: 8),
//
//                   _infoRow(Icons.group_outlined, "For: ${post.quantity} Person"),
//                   _infoRow(Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
//                   _infoRow(Icons.location_on_outlined, post.pickupAddress),
//
//                   const Spacer(),
//
//                   // প্রিমিয়াম রিকোয়েস্ট বাটন
//                   SizedBox(
//                     width: double.infinity,
//                     height: 36,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         foregroundColor: Colors.white,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
//                       child: isLoading
//                           ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                           : const Text("Request Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
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
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: AppColor.green),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _emptyView(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.layers_clear_outlined, size: 50, color: Colors.grey.shade300),
//           const SizedBox(height: 10),
//           Text(message, style: TextStyle(color: Colors.grey.shade400)),
//         ],
//       ),
//     );
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

  bool isPostValid(PostModel post) {
    final now = DateTime.now();
    if (post.status != 'available') return false;
    if (post.expiryDate != null) {
      return post.expiryDate!.isAfter(now);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Adaptive Background
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.primary, // Using primary green
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.white),
        title: const Text(
          "Available Food Near You",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.white),
        ),
        centerTitle: true,
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('status', isEqualTo: 'available')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColor.primary));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return _emptyView(context, "No food posts available");
            }

            final posts = snapshot.data!.docs
                .map((doc) => PostModel.fromSnapshot(doc))
                .where((post) {
              final bool notRequested = !provider.myRequestIds.contains(post.postId);
              final bool valid = isPostValid(post);
              return notRequested && valid;
            }).toList();

            if (posts.isEmpty) {
              return _emptyView(context, "All items are either requested or expired");
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.68,
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        // Adaptive card color
        color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
        borderRadius: BorderRadius.circular(15),
        border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
        boxShadow: isDark ? [] : [
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
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.fastfood_outlined,
                            color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray))
                        : Icon(Icons.fastfood_outlined,
                        color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray, size: 40),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: isDark ? AppColor.primary.withOpacity(0.8) : AppColor.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Fresh",
                        style: TextStyle(
                            color: isDark ? AppColor.white : AppColor.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isDark ? AppColor.white : AppColor.black
                    ),
                  ),
                  const SizedBox(height: 8),
                  _infoRow(context, Icons.group_outlined, "For: ${post.quantity} Person"),
                  _infoRow(context, Icons.timer_outlined, "Pickup: ${post.pickupTime}"),
                  _infoRow(context, Icons.location_on_outlined, post.pickupAddress),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        foregroundColor: AppColor.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isLoading ? null : () => provider.sendRequest(post.postId, post.donorId),
                      child: isLoading
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: AppColor.white, strokeWidth: 2))
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
                  fontSize: 11,
                  color: isDark ? AppColor.white.withOpacity(0.6) : AppColor.gray
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyView(BuildContext context, String message) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.layers_clear_outlined,
              size: 50,
              color: isDark ? AppColor.gray.withOpacity(0.5) : AppColor.gray.withOpacity(0.2)
          ),
          const SizedBox(height: 10),
          Text(message, style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.4) : AppColor.gray)),
        ],
      ),
    );
  }
}