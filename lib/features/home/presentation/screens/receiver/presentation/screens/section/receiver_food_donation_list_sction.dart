// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_generic_donor_section.dart';
// // import '../../../../../sections/generic_donation_list.dart';
// // import '../../provider/receiver_provider.dart';
// //
// // class ReceiverFoodDonationListScreen extends StatelessWidget {
// //   const ReceiverFoodDonationListScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ChangeNotifierProvider(
// //       create: (_) => ReceiverProvider()..fetchAllPosts(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Food Donation List"),
// //         ),
// //         body: const SafeArea(child: ReceiverGenericDonorSection()),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class ReceiverFoodDonationListScreen extends StatefulWidget {
//   static String routeName = "receiver-food-list";
//
//   const ReceiverFoodDonationListScreen({super.key});
//
//   @override
//   State<ReceiverFoodDonationListScreen> createState() =>
//       _ReceiverFoodDonationListScreenState();
// }
//
// class _ReceiverFoodDonationListScreenState
//     extends State<ReceiverFoodDonationListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     final provider =
//     Provider.of<ReceiverProvider>(context, listen: false);
//     provider.fetchAllPosts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("All Available Donations"),
//         backgroundColor: AppColor.green,
//       ),
//       body: Consumer<ReceiverProvider>(
//         builder: (context, provider, _) {
//           if (provider.isLoading) {
//             return const Center(
//                 child: CircularProgressIndicator(color: Colors.green));
//           }
//
//           final posts = provider.availablePosts;
//           if (posts.isEmpty) {
//             return const Center(
//                 child: Text("No donations available",
//                     style: TextStyle(color: Colors.grey)));
//           }
//
//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: posts.length,
//             itemBuilder: (context, index) {
//               final post = posts[index];
//               final alreadyRequested =
//               provider.myRequests.contains(post.postId);
//               final isLoading = provider.isRequesting[post.postId] ?? false;
//
//               return Card(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: post.imageUrls.isNotEmpty
//                             ? Image.network(
//                           post.imageUrls.first,
//                           width: double.infinity,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         )
//                             : Container(
//                           height: 150,
//                           color: Colors.grey[200],
//                           child: const Icon(Icons.fastfood,
//                               size: 40, color: Colors.grey),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(post.foodName,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16)),
//                       const SizedBox(height: 4),
//                       Text("Quantity: ${post.quantity}",
//                           style: const TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.location_on, size: 14, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Expanded(
//                               child: Text(post.pickupAddress,
//                                   style: const TextStyle(fontSize: 12))),
//                           const Icon(Icons.access_time,
//                               size: 14, color: Colors.grey),
//                           const SizedBox(width: 3),
//                           Text(post.pickupTime,
//                               style: const TextStyle(fontSize: 12)),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//
//                       /// Request Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 36,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: alreadyRequested || isLoading
//                                   ? Colors.grey
//                                   : AppColor.green,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: (alreadyRequested || isLoading)
//                               ? null
//                               : () async {
//                             provider.setRequesting(post.postId, true);
//                             try {
//                               await provider.sendRequest(
//                                   post.postId, post.donorId);
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Request Sent")));
//                             } catch (e) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       content: Text("Request Failed")));
//                             } finally {
//                               provider.setRequesting(post.postId, false);
//                             }
//                           },
//                           child: isLoading
//                               ? const SizedBox(
//                             width: 16,
//                             height: 16,
//                             child: CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2,
//                             ),
//                           )
//                               : Text(
//                             alreadyRequested ? "Pending" : "Request",
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// File: lib/features/home/presentation/screens/receiver/screens/receiver_food_donation_list_sction.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';
import '../widgets/receiver_post_card.dart';

class ReceiverFoodDonationListScreen extends StatelessWidget {
  const ReceiverFoodDonationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Donations"),
        backgroundColor: Colors.green.shade400,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No donations found"));
          }

          final posts = snapshot.data!.docs.map((doc) => PostModel.fromSnapshot(doc)).toList();

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              final alreadyRequested = provider.myRequests.contains(post.postId);
              final isLoading = provider.isRequesting[post.postId] ?? false;

              return ReceiverPostCard(
                post: post,
                alreadyRequested: alreadyRequested,
                isLoading: isLoading,
              );
            },
          );
        },
      ),
    );
  }
}
