// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// //
// // import '../../../../app/app_theme.dart';
// // import '../../../../core/constants/app_colors.dart';
// // import '../screens/donor/presentation/provider/donor_provider.dart';
// // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // class MyPostsTabSection extends StatelessWidget {
// //   final TabController tabController;
// //
// //   const MyPostsTabSection({super.key, required this.tabController});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         TabBar(
// //           tabAlignment: TabAlignment.start,
// //           isScrollable: true,
// //           controller: tabController,
// //           labelColor: AppColor.green,
// //           unselectedLabelColor: AppColor.black,
// //           indicatorColor: AppColor.lightGreen,
// //           tabs: const [
// //             Tab(text: "My Post"),
// //             Tab(text: "Receivers Requests"),
// //           ],
// //         ),
// //         SizedBox(
// //           height: 200,
// //           child: TabBarView(
// //             controller: tabController,
// //             children: [
// //               SingleChildScrollView(
// //                 child: Card(
// //                   // color: AppColor.soft_green,
// //                   child: Padding(
// //                     padding: const EdgeInsets.all(16.0),
// //                     child: Column(
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         Text(
// //                           "Nothing till now",
// //                           style: AppData.heading2.copyWith(
// //                             color: AppColor.black.withOpacity(0.6),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 15),
// //                         Divider(
// //                           thickness: 1,
// //                           color: AppColor.black.withOpacity(0.5),
// //                         ),
// //                         const SizedBox(height: 15),
// //                         Text(
// //                           "Do You Have Some food to donate?",
// //                           style: AppData.heading2,
// //                         ),
// //                         const SizedBox(height: 15),
// //                         ElevatedButton.icon(
// //                           onPressed: () {
// //                             showDialog(context: context, builder: (BuildContext context) {
// //                               return CreateDonationDialog();
// //                             });
// //                           },
// //                           icon: Icon(Icons.add, color: AppColor.white,),
// //                           label: Text(
// //                             "Create Donation Post",
// //                             style: AppData.heading2.copyWith(
// //                               color: AppColor.white,
// //                             ),
// //                           ),
// //
// //
// //
// //
// //
// //
// //
// //                           style: ElevatedButton.styleFrom(
// //                             backgroundColor: AppColor.green,
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(8),
// //                             ),
// //                           ),
// //                         ),
// //
// //
// //
// //                     // ElevatedButton.icon(
// //                     //   onPressed: () {
// //                     //     showDialog(
// //                     //       context: context,
// //                     //       isScrollControlled: true,
// //                     //       builder: (_) =>
// //                     //       const CreateDonationDialog(),
// //                     //     );
// //                     //   }, label: null,
// //
// //
// //
// //
// //
// //
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //
// //
// //
// //
// //
// //               // ListView(
// //               //   padding: const EdgeInsets.all(16),
// //               //   children: [
// //               //     Text(
// //               //       "Receivers Requests Content Here",
// //               //       style: AppData.heading3,
// //               //     ),
// //               //   ],
// //               // ),
// //
// //
// //               ListView(
// //                 padding: const EdgeInsets.all(16),
// //                 children: [
// //                   // প্রোভাইডার থেকে রিকোয়েস্টগুলো চেক করা হচ্ছে
// //                   Consumer<DonorProvider>(
// //                     builder: (context, donorPro, _) {
// //                       // যদি এখনও ডেটা লোড না হয়ে থাকে
// //                       if (donorPro.receiverRequests.isEmpty) {
// //                         return Center(
// //                           child: Padding(
// //                             padding: const EdgeInsets.only(top: 50),
// //                             child: Text(
// //                               "No requests received yet",
// //                               style: AppData.heading3.copyWith(color: Colors.grey),
// //                             ),
// //                           ),
// //                         );
// //                       }
// //
// //                       // রিকোয়েস্ট লিস্ট তৈরি
// //                       return Column(
// //                         children: donorPro.receiverRequests.map((request) {
// //                           return FutureBuilder<DocumentSnapshot>(
// //                             future: FirebaseFirestore.instance
// //                                 .collection('posts')
// //                                 .doc(request['postId'])
// //                                 .get(),
// //                             builder: (context, snapshot) {
// //                               if (!snapshot.hasData) return const SizedBox();
// //
// //                               final postData = snapshot.data!.data() as Map<String, dynamic>;
// //
// //                               return Card(
// //                                 margin: const EdgeInsets.only(bottom: 16),
// //                                 shape: RoundedRectangleBorder(
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 elevation: 3,
// //                                 child: Column(
// //                                   children: [
// //                                     ListTile(
// //                                       contentPadding: const EdgeInsets.all(10),
// //                                       leading: ClipRRect(
// //                                         borderRadius: BorderRadius.circular(8),
// //                                         child: Container(
// //                                           width: 60,
// //                                           height: 60,
// //                                           color: Colors.grey[200],
// //                                           child: postData['imageUrls'] != null && postData['imageUrls'].isNotEmpty
// //                                               ? Image.network(
// //                                             postData['imageUrls'][0],
// //                                             fit: BoxFit.cover,
// //                                             errorBuilder: (_, __, ___) => const Icon(Icons.fastfood),
// //                                           )
// //                                               : const Icon(Icons.fastfood),
// //                                         ),
// //                                       ),
// //                                       title: Text(
// //                                         postData['foodName'] ?? "Unknown Food",
// //                                         style: AppData.heading3.copyWith(fontWeight: FontWeight.bold),
// //                                       ),
// //                                       subtitle: Text(
// //                                         "Qty: ${postData['quantity']}\nReceiver ID: ${request['receiverId'].toString().substring(0, 5)}...",
// //                                         style: const TextStyle(fontSize: 12),
// //                                       ),
// //                                     ),
// //                                     const Divider(height: 1),
// //                                     Padding(
// //                                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //                                       child: Row(
// //                                         mainAxisAlignment: MainAxisAlignment.end,
// //                                         children: [
// //                                           // Reject Button
// //                                           TextButton.icon(
// //                                             onPressed: () => donorPro.handleRequest(
// //                                                 request['requestId'], request['postId'], 'rejected'),
// //                                             icon: const Icon(Icons.close, color: Colors.red, size: 18),
// //                                             label: const Text("Reject", style: TextStyle(color: Colors.red)),
// //                                           ),
// //                                           const SizedBox(width: 8),
// //                                           // Approve Button
// //                                           ElevatedButton.icon(
// //                                             onPressed: () => donorPro.handleRequest(
// //                                                 request['requestId'], request['postId'], 'approved'),
// //                                             style: ElevatedButton.styleFrom(
// //                                               backgroundColor: AppColor.green,
// //                                               foregroundColor: Colors.white,
// //                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
// //                                             ),
// //                                             icon: const Icon(Icons.check, size: 18),
// //                                             label: const Text("Approve"),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           );
// //                         }).toList(),
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               )
// //
// //
// //
// //
// //
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../app/app_theme.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../screens/donor/presentation/provider/donor_provider.dart';
// import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
//
// class MyPostsTabSection extends StatefulWidget {
//   final TabController tabController;
//
//   const MyPostsTabSection({super.key, required this.tabController});
//
//   @override
//   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// }
//
// class _MyPostsTabSectionState extends State<MyPostsTabSection> {
//   @override
//   void initState() {
//     super.initState();
//     // স্ক্রিন লোড হওয়ার সময় ডেটা ফেচ করা নিশ্চিত করা
//     Future.microtask(() => context.read<DonorProvider>().fetchRequests());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           tabAlignment: TabAlignment.start,
//           isScrollable: true,
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: AppColor.black,
//           indicatorColor: AppColor.lightGreen,
//           tabs: const [
//             Tab(text: "My Post"),
//             Tab(text: "Receivers Requests"),
//           ],
//         ),
//
//         // সমাধান ১: SizedBox(height: 200) সরিয়ে Expanded ব্যবহার করা হয়েছে
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [
//               // --- ১ম ট্যাব: My Post ---
//               _buildMyPostsTab(context),
//
//               // --- ২য় ট্যাব: Receivers Requests ---
//               _buildReceiversRequestsTab(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMyPostsTab(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 40,),
//               Text("Nothing till now", style: AppData.heading2.copyWith(color: AppColor.black.withOpacity(0.6))),
//               const SizedBox(height: 15),
//               Divider(thickness: 1, color: AppColor.black.withOpacity(0.5)),
//               const SizedBox(height: 15),
//               Text("Do You Have Some food to donate?", style: AppData.heading2),
//               const SizedBox(height: 15),
//               ElevatedButton.icon(
//                 onPressed: () => showDialog(context: context, builder: (_) => CreateDonationDialog()),
//                 icon: const Icon(Icons.add, color: AppColor.white),
//                 label: Text("Create Donation Post", style: AppData.heading2.copyWith(color: AppColor.white)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColor.green,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                 ),
//               ),
//               SizedBox(height: 40,)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReceiversRequestsTab() {
//     return Consumer<DonorProvider>(
//       builder: (context, donorPro, _) {
//         if (donorPro.receiverRequests.isEmpty) {
//           return const Center(child: Text("No requests received yet"));
//         }
//
//         // সমাধান ২: ListView এর বদলে SingleChildScrollView ব্যবহার করা হয়েছে যাতে এরর না আসে
//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: donorPro.receiverRequests.map((request) {
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox();
//                   if (!snapshot.hasData || snapshot.data?.data() == null) return const SizedBox();
//
//                   final postData = snapshot.data!.data() as Map<String, dynamic>;
//
//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     elevation: 3,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           contentPadding: const EdgeInsets.all(10),
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
//                                 ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)
//                                 : const Icon(Icons.fastfood, size: 40),
//                           ),
//                           title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
//                           subtitle: Text("Receiver: ${request['receiverId'].toString().substring(0, 6)}..."),
//                         ),
//                         const Divider(height: 1),
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                 onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'rejected'),
//                                 child: const Text("Reject", style: TextStyle(color: Colors.red)),
//                               ),
//                               const SizedBox(width: 8),
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
//                                 onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'approved'),
//                                 child: const Text("Approve", style: TextStyle(color: Colors.white)),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../screens/donor/presentation/provider/donor_provider.dart';
import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';

class MyPostsTabSection extends StatefulWidget {
  final TabController tabController;

  const MyPostsTabSection({super.key, required this.tabController});

  @override
  State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
}

class _MyPostsTabSectionState extends State<MyPostsTabSection> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DonorProvider>().fetchRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: widget.tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: AppColor.black,
          indicatorColor: AppColor.lightGreen,
          tabs: const [
            Tab(text: "My Post"),
            Tab(text: "Receivers Requests"),
          ],
        ),
        SizedBox(
          height: 350, // আপনার চাওয়া অনুযায়ী হাইট ৩৫০
          child: TabBarView(
            controller: widget.tabController,
            children: [
              _buildMyPostsTab(context),
              _buildReceiversRequestsTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMyPostsTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text("Nothing till now", style: AppData.heading2.copyWith(color: AppColor.black.withOpacity(0.6))),
              const SizedBox(height: 15),
              Divider(thickness: 1, color: AppColor.black.withOpacity(0.5)),
              const SizedBox(height: 15),
              Text("Do You Have Some food to donate?", style: AppData.heading2, textAlign: TextAlign.center),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () => showDialog(context: context, builder: (_) => CreateDonationDialog()),
                icon: const Icon(Icons.add, color: AppColor.white),
                label: Text("Create Donation Post", style: AppData.heading2.copyWith(color: AppColor.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiversRequestsTab() {
    return Consumer<DonorProvider>(
      builder: (context, donorPro, _) {
        if (donorPro.receiverRequests.isEmpty) {
          return const Center(child: Text("No requests received yet"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: donorPro.receiverRequests.length,
          itemBuilder: (context, index) {
            final request = donorPro.receiverRequests[index];
            final receiverId = request['receiverId'];

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
              builder: (context, postSnapshot) {
                if (!postSnapshot.hasData) return const SizedBox();
                final postData = postSnapshot.data!.data() as Map<String, dynamic>;

                return FutureBuilder<DocumentSnapshot>(
                  // accounts কালেকশন থেকে ডাটা ফেচ করা
                  future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
                  builder: (context, accSnapshot) {
                    String contactPerson = "Loading...";
                    if (accSnapshot.hasData && accSnapshot.data!.exists) {
                      final accData = accSnapshot.data!.data() as Map<String, dynamic>;
                      // আপনার ডাটা স্ট্রাকচার: profile -> contactPerson
                      contactPerson = accData['profile']?['contactPerson'] ?? "No Name";
                    }

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
                                  ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)
                                  : const Icon(Icons.fastfood, size: 40),
                            ),
                            title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Quantity: ${postData['quantity']}"),
                                Text("By: $contactPerson", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'rejected'),
                                  child: const Text("Reject", style: TextStyle(color: Colors.red)),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
                                  onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'approved'),
                                  child: const Text("Approve", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}