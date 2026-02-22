// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // //
// // // // // import '../../../../app/app_theme.dart';
// // // // // import '../../../../core/constants/app_colors.dart';
// // // // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // // // // class MyPostsTabSection extends StatelessWidget {
// // // // //   final TabController tabController;
// // // // //
// // // // //   const MyPostsTabSection({super.key, required this.tabController});
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Column(
// // // // //       children: [
// // // // //         TabBar(
// // // // //           tabAlignment: TabAlignment.start,
// // // // //           isScrollable: true,
// // // // //           controller: tabController,
// // // // //           labelColor: AppColor.green,
// // // // //           unselectedLabelColor: AppColor.black,
// // // // //           indicatorColor: AppColor.lightGreen,
// // // // //           tabs: const [
// // // // //             Tab(text: "My Post"),
// // // // //             Tab(text: "Receivers Requests"),
// // // // //           ],
// // // // //         ),
// // // // //         SizedBox(
// // // // //           height: 200,
// // // // //           child: TabBarView(
// // // // //             controller: tabController,
// // // // //             children: [
// // // // //               SingleChildScrollView(
// // // // //                 child: Card(
// // // // //                   // color: AppColor.soft_green,
// // // // //                   child: Padding(
// // // // //                     padding: const EdgeInsets.all(16.0),
// // // // //                     child: Column(
// // // // //                       mainAxisSize: MainAxisSize.min,
// // // // //                       children: [
// // // // //                         Text(
// // // // //                           "Nothing till now",
// // // // //                           style: AppData.heading2.copyWith(
// // // // //                             color: AppColor.black.withOpacity(0.6),
// // // // //                           ),
// // // // //                         ),
// // // // //                         const SizedBox(height: 15),
// // // // //                         Divider(
// // // // //                           thickness: 1,
// // // // //                           color: AppColor.black.withOpacity(0.5),
// // // // //                         ),
// // // // //                         const SizedBox(height: 15),
// // // // //                         Text(
// // // // //                           "Do You Have Some food to donate?",
// // // // //                           style: AppData.heading2,
// // // // //                         ),
// // // // //                         const SizedBox(height: 15),
// // // // //                         ElevatedButton.icon(
// // // // //                           onPressed: () {
// // // // //                             showDialog(context: context, builder: (BuildContext context) {
// // // // //                               return CreateDonationDialog();
// // // // //                             });
// // // // //                           },
// // // // //                           icon: Icon(Icons.add, color: AppColor.white,),
// // // // //                           label: Text(
// // // // //                             "Create Donation Post",
// // // // //                             style: AppData.heading2.copyWith(
// // // // //                               color: AppColor.white,
// // // // //                             ),
// // // // //                           ),
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //                           style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: AppColor.green,
// // // // //                             shape: RoundedRectangleBorder(
// // // // //                               borderRadius: BorderRadius.circular(8),
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //
// // // // //
// // // // //
// // // // //                     // ElevatedButton.icon(
// // // // //                     //   onPressed: () {
// // // // //                     //     showDialog(
// // // // //                     //       context: context,
// // // // //                     //       isScrollControlled: true,
// // // // //                     //       builder: (_) =>
// // // // //                     //       const CreateDonationDialog(),
// // // // //                     //     );
// // // // //                     //   }, label: null,
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //               // ListView(
// // // // //               //   padding: const EdgeInsets.all(16),
// // // // //               //   children: [
// // // // //               //     Text(
// // // // //               //       "Receivers Requests Content Here",
// // // // //               //       style: AppData.heading3,
// // // // //               //     ),
// // // // //               //   ],
// // // // //               // ),
// // // // //
// // // // //
// // // // //               ListView(
// // // // //                 padding: const EdgeInsets.all(16),
// // // // //                 children: [
// // // // //                   // প্রোভাইডার থেকে রিকোয়েস্টগুলো চেক করা হচ্ছে
// // // // //                   Consumer<DonorProvider>(
// // // // //                     builder: (context, donorPro, _) {
// // // // //                       // যদি এখনও ডেটা লোড না হয়ে থাকে
// // // // //                       if (donorPro.receiverRequests.isEmpty) {
// // // // //                         return Center(
// // // // //                           child: Padding(
// // // // //                             padding: const EdgeInsets.only(top: 50),
// // // // //                             child: Text(
// // // // //                               "No requests received yet",
// // // // //                               style: AppData.heading3.copyWith(color: Colors.grey),
// // // // //                             ),
// // // // //                           ),
// // // // //                         );
// // // // //                       }
// // // // //
// // // // //                       // রিকোয়েস্ট লিস্ট তৈরি
// // // // //                       return Column(
// // // // //                         children: donorPro.receiverRequests.map((request) {
// // // // //                           return FutureBuilder<DocumentSnapshot>(
// // // // //                             future: FirebaseFirestore.instance
// // // // //                                 .collection('posts')
// // // // //                                 .doc(request['postId'])
// // // // //                                 .get(),
// // // // //                             builder: (context, snapshot) {
// // // // //                               if (!snapshot.hasData) return const SizedBox();
// // // // //
// // // // //                               final postData = snapshot.data!.data() as Map<String, dynamic>;
// // // // //
// // // // //                               return Card(
// // // // //                                 margin: const EdgeInsets.only(bottom: 16),
// // // // //                                 shape: RoundedRectangleBorder(
// // // // //                                   borderRadius: BorderRadius.circular(12),
// // // // //                                 ),
// // // // //                                 elevation: 3,
// // // // //                                 child: Column(
// // // // //                                   children: [
// // // // //                                     ListTile(
// // // // //                                       contentPadding: const EdgeInsets.all(10),
// // // // //                                       leading: ClipRRect(
// // // // //                                         borderRadius: BorderRadius.circular(8),
// // // // //                                         child: Container(
// // // // //                                           width: 60,
// // // // //                                           height: 60,
// // // // //                                           color: Colors.grey[200],
// // // // //                                           child: postData['imageUrls'] != null && postData['imageUrls'].isNotEmpty
// // // // //                                               ? Image.network(
// // // // //                                             postData['imageUrls'][0],
// // // // //                                             fit: BoxFit.cover,
// // // // //                                             errorBuilder: (_, __, ___) => const Icon(Icons.fastfood),
// // // // //                                           )
// // // // //                                               : const Icon(Icons.fastfood),
// // // // //                                         ),
// // // // //                                       ),
// // // // //                                       title: Text(
// // // // //                                         postData['foodName'] ?? "Unknown Food",
// // // // //                                         style: AppData.heading3.copyWith(fontWeight: FontWeight.bold),
// // // // //                                       ),
// // // // //                                       subtitle: Text(
// // // // //                                         "Qty: ${postData['quantity']}\nReceiver ID: ${request['receiverId'].toString().substring(0, 5)}...",
// // // // //                                         style: const TextStyle(fontSize: 12),
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                     const Divider(height: 1),
// // // // //                                     Padding(
// // // // //                                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// // // // //                                       child: Row(
// // // // //                                         mainAxisAlignment: MainAxisAlignment.end,
// // // // //                                         children: [
// // // // //                                           // Reject Button
// // // // //                                           TextButton.icon(
// // // // //                                             onPressed: () => donorPro.handleRequest(
// // // // //                                                 request['requestId'], request['postId'], 'rejected'),
// // // // //                                             icon: const Icon(Icons.close, color: Colors.red, size: 18),
// // // // //                                             label: const Text("Reject", style: TextStyle(color: Colors.red)),
// // // // //                                           ),
// // // // //                                           const SizedBox(width: 8),
// // // // //                                           // Approve Button
// // // // //                                           ElevatedButton.icon(
// // // // //                                             onPressed: () => donorPro.handleRequest(
// // // // //                                                 request['requestId'], request['postId'], 'approved'),
// // // // //                                             style: ElevatedButton.styleFrom(
// // // // //                                               backgroundColor: AppColor.green,
// // // // //                                               foregroundColor: Colors.white,
// // // // //                                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
// // // // //                                             ),
// // // // //                                             icon: const Icon(Icons.check, size: 18),
// // // // //                                             label: const Text("Approve"),
// // // // //                                           ),
// // // // //                                         ],
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ],
// // // // //                                 ),
// // // // //                               );
// // // // //                             },
// // // // //                           );
// // // // //                         }).toList(),
// // // // //                       );
// // // // //                     },
// // // // //                   ),
// // // // //                 ],
// // // // //               )
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import '../../../../app/app_theme.dart';
// // // // import '../../../../core/constants/app_colors.dart';
// // // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // // //
// // // // class MyPostsTabSection extends StatefulWidget {
// // // //   final TabController tabController;
// // // //
// // // //   const MyPostsTabSection({super.key, required this.tabController});
// // // //
// // // //   @override
// // // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // // }
// // // //
// // // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     // স্ক্রিন লোড হওয়ার সময় ডেটা ফেচ করা নিশ্চিত করা
// // // //     Future.microtask(() => context.read<DonorProvider>().fetchRequests());
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Column(
// // // //       children: [
// // // //         TabBar(
// // // //           tabAlignment: TabAlignment.start,
// // // //           isScrollable: true,
// // // //           controller: widget.tabController,
// // // //           labelColor: AppColor.green,
// // // //           unselectedLabelColor: AppColor.black,
// // // //           indicatorColor: AppColor.lightGreen,
// // // //           tabs: const [
// // // //             Tab(text: "My Post"),
// // // //             Tab(text: "Receivers Requests"),
// // // //           ],
// // // //         ),
// // // //
// // // //         // সমাধান ১: SizedBox(height: 200) সরিয়ে Expanded ব্যবহার করা হয়েছে
// // // //         Expanded(
// // // //           child: TabBarView(
// // // //             controller: widget.tabController,
// // // //             children: [
// // // //               // --- ১ম ট্যাব: My Post ---
// // // //               _buildMyPostsTab(context),
// // // //
// // // //               // --- ২য় ট্যাব: Receivers Requests ---
// // // //               _buildReceiversRequestsTab(),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildMyPostsTab(BuildContext context) {
// // // //     return SingleChildScrollView(
// // // //       padding: const EdgeInsets.all(16),
// // // //       child: Card(
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             children: [
// // // //               SizedBox(height: 40,),
// // // //               Text("Nothing till now", style: AppData.heading2.copyWith(color: AppColor.black.withOpacity(0.6))),
// // // //               const SizedBox(height: 15),
// // // //               Divider(thickness: 1, color: AppColor.black.withOpacity(0.5)),
// // // //               const SizedBox(height: 15),
// // // //               Text("Do You Have Some food to donate?", style: AppData.heading2),
// // // //               const SizedBox(height: 15),
// // // //               ElevatedButton.icon(
// // // //                 onPressed: () => showDialog(context: context, builder: (_) => CreateDonationDialog()),
// // // //                 icon: const Icon(Icons.add, color: AppColor.white),
// // // //                 label: Text("Create Donation Post", style: AppData.heading2.copyWith(color: AppColor.white)),
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: AppColor.green,
// // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // // //                 ),
// // // //               ),
// // // //               SizedBox(height: 40,)
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildReceiversRequestsTab() {
// // // //     return Consumer<DonorProvider>(
// // // //       builder: (context, donorPro, _) {
// // // //         if (donorPro.receiverRequests.isEmpty) {
// // // //           return const Center(child: Text("No requests received yet"));
// // // //         }
// // // //
// // // //         // সমাধান ২: ListView এর বদলে SingleChildScrollView ব্যবহার করা হয়েছে যাতে এরর না আসে
// // // //         return SingleChildScrollView(
// // // //           padding: const EdgeInsets.all(16),
// // // //           child: Column(
// // // //             children: donorPro.receiverRequests.map((request) {
// // // //               return FutureBuilder<DocumentSnapshot>(
// // // //                 future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // // //                 builder: (context, snapshot) {
// // // //                   if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox();
// // // //                   if (!snapshot.hasData || snapshot.data?.data() == null) return const SizedBox();
// // // //
// // // //                   final postData = snapshot.data!.data() as Map<String, dynamic>;
// // // //
// // // //                   return Card(
// // // //                     margin: const EdgeInsets.only(bottom: 16),
// // // //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // //                     elevation: 3,
// // // //                     child: Column(
// // // //                       children: [
// // // //                         ListTile(
// // // //                           contentPadding: const EdgeInsets.all(10),
// // // //                           leading: ClipRRect(
// // // //                             borderRadius: BorderRadius.circular(8),
// // // //                             child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
// // // //                                 ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)
// // // //                                 : const Icon(Icons.fastfood, size: 40),
// // // //                           ),
// // // //                           title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
// // // //                           subtitle: Text("Receiver: ${request['receiverId'].toString().substring(0, 6)}..."),
// // // //                         ),
// // // //                         const Divider(height: 1),
// // // //                         Padding(
// // // //                           padding: const EdgeInsets.all(8),
// // // //                           child: Row(
// // // //                             mainAxisAlignment: MainAxisAlignment.end,
// // // //                             children: [
// // // //                               TextButton(
// // // //                                 onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'rejected'),
// // // //                                 child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // // //                               ),
// // // //                               const SizedBox(width: 8),
// // // //                               ElevatedButton(
// // // //                                 style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
// // // //                                 onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'approved'),
// // // //                                 child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   );
// // // //                 },
// // // //               );
// // // //             }).toList(),
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // // import '../../../../app/app_theme.dart';
// // // // import '../../../../core/constants/app_colors.dart';
// // // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // // //
// // // // class MyPostsTabSection extends StatefulWidget {
// // // //   final TabController tabController;
// // // //
// // // //   const MyPostsTabSection({super.key, required this.tabController});
// // // //
// // // //   @override
// // // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // // }
// // // //
// // // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     Future.microtask(() => context.read<DonorProvider>().fetchRequests());
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Column(
// // // //       children: [
// // // //         TabBar(
// // // //           tabAlignment: TabAlignment.start,
// // // //           isScrollable: true,
// // // //           controller: widget.tabController,
// // // //           labelColor: AppColor.green,
// // // //           unselectedLabelColor: AppColor.black,
// // // //           indicatorColor: AppColor.lightGreen,
// // // //           tabs: const [
// // // //             Tab(text: "My Post"),
// // // //             Tab(text: "Receivers Requests"),
// // // //           ],
// // // //         ),
// // // //         SizedBox(
// // // //           height: 350, // আপনার চাওয়া অনুযায়ী হাইট ৩৫০
// // // //           child: TabBarView(
// // // //             controller: widget.tabController,
// // // //             children: [
// // // //               _buildMyPostsTab(context),
// // // //               _buildReceiversRequestsTab(),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildMyPostsTab(BuildContext context) {
// // // //     return SingleChildScrollView(
// // // //       padding: const EdgeInsets.all(16),
// // // //       child: Card(
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16.0),
// // // //           child: Column(
// // // //             children: [
// // // //               const SizedBox(height: 40),
// // // //               Text("Nothing till now", style: AppData.heading2.copyWith(color: AppColor.black.withOpacity(0.6))),
// // // //               const SizedBox(height: 15),
// // // //               Divider(thickness: 1, color: AppColor.black.withOpacity(0.5)),
// // // //               const SizedBox(height: 15),
// // // //               Text("Do You Have Some food to donate?", style: AppData.heading2, textAlign: TextAlign.center),
// // // //               const SizedBox(height: 15),
// // // //               ElevatedButton.icon(
// // // //                 onPressed: () => showDialog(context: context, builder: (_) => CreateDonationDialog()),
// // // //                 icon: const Icon(Icons.add, color: AppColor.white),
// // // //                 label: Text("Create Donation Post", style: AppData.heading2.copyWith(color: AppColor.white)),
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: AppColor.green,
// // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 40),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildReceiversRequestsTab() {
// // // //     return Consumer<DonorProvider>(
// // // //       builder: (context, donorPro, _) {
// // // //         if (donorPro.receiverRequests.isEmpty) {
// // // //           return const Center(child: Text("No requests received yet"));
// // // //         }
// // // //
// // // //         return ListView.builder(
// // // //           padding: const EdgeInsets.all(16),
// // // //           itemCount: donorPro.receiverRequests.length,
// // // //           itemBuilder: (context, index) {
// // // //             final request = donorPro.receiverRequests[index];
// // // //             final receiverId = request['receiverId'];
// // // //
// // // //             return FutureBuilder<DocumentSnapshot>(
// // // //               future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // // //               builder: (context, postSnapshot) {
// // // //                 if (!postSnapshot.hasData) return const SizedBox();
// // // //                 final postData = postSnapshot.data!.data() as Map<String, dynamic>;
// // // //
// // // //                 return FutureBuilder<DocumentSnapshot>(
// // // //                   // accounts কালেকশন থেকে ডাটা ফেচ করা
// // // //                   future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// // // //                   builder: (context, accSnapshot) {
// // // //                     String contactPerson = "Loading...";
// // // //                     if (accSnapshot.hasData && accSnapshot.data!.exists) {
// // // //                       final accData = accSnapshot.data!.data() as Map<String, dynamic>;
// // // //                       // আপনার ডাটা স্ট্রাকচার: profile -> contactPerson
// // // //                       contactPerson = accData['profile']?['contactPerson'] ?? "No Name";
// // // //                     }
// // // //
// // // //                     return Card(
// // // //                       margin: const EdgeInsets.only(bottom: 16),
// // // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // // //                       elevation: 3,
// // // //                       child: Column(
// // // //                         children: [
// // // //                           ListTile(
// // // //                             contentPadding: const EdgeInsets.all(10),
// // // //                             leading: ClipRRect(
// // // //                               borderRadius: BorderRadius.circular(8),
// // // //                               child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
// // // //                                   ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)
// // // //                                   : const Icon(Icons.fastfood, size: 40),
// // // //                             ),
// // // //                             title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
// // // //                             subtitle: Column(
// // // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // // //                               children: [
// // // //                                 Text("Quantity: ${postData['quantity']}"),
// // // //                                 Text("By: $contactPerson", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                           const Divider(height: 1),
// // // //                           Padding(
// // // //                             padding: const EdgeInsets.all(8),
// // // //                             child: Row(
// // // //                               mainAxisAlignment: MainAxisAlignment.end,
// // // //                               children: [
// // // //                                 TextButton(
// // // //                                   onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'rejected'),
// // // //                                   child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // // //                                 ),
// // // //                                 const SizedBox(width: 8),
// // // //                                 ElevatedButton(
// // // //                                   style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
// // // //                                   onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'approved'),
// // // //                                   child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     );
// // // //                   },
// // // //                 );
// // // //               },
// // // //             );
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../../../../app/app_theme.dart';
// // // import '../../../../core/constants/app_colors.dart';
// // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // //
// // // class MyPostsTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //
// // //   const MyPostsTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // }
// // //
// // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     Future.microtask(() => context.read<DonorProvider>().fetchRequests());
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           tabAlignment: TabAlignment.start,
// // //           isScrollable: true,
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: AppColor.black,
// // //           indicatorColor: AppColor.lightGreen,
// // //           tabs: const [
// // //             Tab(text: "My Post"),
// // //             Tab(text: "Receivers Requests"),
// // //             Tab(text: "Approved Requests"),
// // //
// // //           ],
// // //         ),
// // //         SizedBox(
// // //           height: 350,
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildMyPostsTab(context),
// // //               _buildReceiversRequestsTab(),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildMyPostsTab(BuildContext context) {
// // //     return SingleChildScrollView(
// // //       padding: const EdgeInsets.all(16),
// // //       child: Card(
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16.0),
// // //           child: Column(
// // //             children: [
// // //               const SizedBox(height: 40),
// // //               Text("Nothing till now", style: AppData.heading2.copyWith(color: AppColor.black.withOpacity(0.6))),
// // //               const SizedBox(height: 15),
// // //               Divider(thickness: 1, color: AppColor.black.withOpacity(0.5)),
// // //               const SizedBox(height: 15),
// // //               Text("Do You Have Some food to donate?", style: AppData.heading2, textAlign: TextAlign.center),
// // //               const SizedBox(height: 15),
// // //               ElevatedButton.icon(
// // //                 onPressed: () => showDialog(context: context, builder: (_) => CreateDonationDialog()),
// // //                 icon: const Icon(Icons.add, color: AppColor.white),
// // //                 label: Text("Create Donation Post", style: AppData.heading2.copyWith(color: AppColor.white)),
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: AppColor.green,
// // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 40),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildReceiversRequestsTab() {
// // //     return Consumer<DonorProvider>(
// // //       builder: (context, donorPro, _) {
// // //         if (donorPro.receiverRequests.isEmpty) {
// // //           return const Center(child: Text("All caught up! No new pending requests to process.", style: TextStyle(color: Colors.grey),));
// // //         }
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(16),
// // //           itemCount: donorPro.receiverRequests.length,
// // //           itemBuilder: (context, index) {
// // //             final request = donorPro.receiverRequests[index];
// // //             final receiverId = request['receiverId'];
// // //
// // //             return FutureBuilder<DocumentSnapshot>(
// // //               future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // //               builder: (context, postSnapshot) {
// // //                 if (!postSnapshot.hasData) return const SizedBox();
// // //                 final postData = postSnapshot.data!.data() as Map<String, dynamic>;
// // //
// // //                 return FutureBuilder<DocumentSnapshot>(
// // //                   future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// // //                   builder: (context, accSnapshot) {
// // //                     String contactPerson = "Loading...";
// // //                     if (accSnapshot.hasData && accSnapshot.data!.exists) {
// // //                       final accData = accSnapshot.data!.data() as Map<String, dynamic>;
// // //                       contactPerson = accData['profile']?['contactPerson'] ?? "No Name";
// // //                     }
// // //
// // //                     return Card(
// // //                       margin: const EdgeInsets.only(bottom: 16),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //                       elevation: 3,
// // //                       child: Column(
// // //                         children: [
// // //                           ListTile(
// // //                             contentPadding: const EdgeInsets.all(10),
// // //                             leading: ClipRRect(
// // //                               borderRadius: BorderRadius.circular(8),
// // //                               child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
// // //                                   ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)
// // //                                   : const Icon(Icons.fastfood, size: 40),
// // //                             ),
// // //                             title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
// // //                             subtitle: Column(
// // //                               crossAxisAlignment: CrossAxisAlignment.start,
// // //                               children: [
// // //                                 Text("Quantity: ${postData['quantity']}"),
// // //                                 Text("By: $contactPerson", style: TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           const Divider(height: 1),
// // //                           Padding(
// // //                             padding: const EdgeInsets.all(8),
// // //                             child: Row(
// // //                               mainAxisAlignment: MainAxisAlignment.end,
// // //                               children: [
// // //                                 TextButton(
// // //                                   style: ElevatedButton.styleFrom(
// // //                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
// // //                                   ),
// // //                                   onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'rejected'),
// // //                                   child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // //                                 ),
// // //                                 const SizedBox(width: 8),
// // //                                 ElevatedButton(
// // //                                   style: ElevatedButton.styleFrom(
// // //                                       backgroundColor: AppColor.green,
// // //                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
// // //                                   ),
// // //                                   onPressed: () => donorPro.handleRequest(request['requestId'], request['postId'], 'approved'),
// // //                                   child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     );
// // //                   },
// // //                 );
// // //               },
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// //
// //
// //
// //
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // //
// // // class MyPostsTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //
// // //   const MyPostsTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // }
// // //
// // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // ডাটা ফেচিং নিশ্চিত করা
// // //     Future.microtask(() {
// // //       if (mounted) {
// // //         final donorProvider = context.read<DonorProvider>();
// // //         donorProvider.fetchRequests();
// // //         donorProvider.fetchApprovedRequests();
// // //       }
// // //     });
// // //
// // //     widget.tabController.addListener(() {
// // //       if (mounted) setState(() {});
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // স্ক্রিনের হাইট অনুযায়ী ডাইনামিক করা
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           tabAlignment: TabAlignment.start,
// // //           isScrollable: true,
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: AppColor.black,
// // //           indicatorColor: AppColor.lightGreen,
// // //           tabs: const [
// // //             Tab(text: "My Post"),
// // //             Tab(text: "Receivers Requests"),
// // //             Tab(text: "Approved Requests"),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //         // Expanded ব্যবহার করা হয়েছে যাতে Overflow না হয়
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildMyPostsTab(context),
// // //               _buildRequestListTab(context, isApproved: false),
// // //               _buildRequestListTab(context, isApproved: true),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ১: My Posts ---
// // //   Widget _buildMyPostsTab(BuildContext context) {
// // //     return SingleChildScrollView(
// // //       physics: const BouncingScrollPhysics(),
// // //       padding: const EdgeInsets.all(16),
// // //       child: Card(
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //         elevation: 2,
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(20.0),
// // //           child: Column(
// // //             children: [
// // //               const Icon(Icons.post_add, size: 50, color: AppColor.green),
// // //               const SizedBox(height: 15),
// // //               Text("Do You Have Some food to donate?",
// // //                   style: AppData.heading2, textAlign: TextAlign.center),
// // //               const SizedBox(height: 10),
// // //               const Text("Your contribution can save a life.",
// // //                   style: TextStyle(color: Colors.grey)),
// // //               const SizedBox(height: 20),
// // //               ElevatedButton.icon(
// // //                 onPressed: () => showDialog(
// // //                     context: context,
// // //                     builder: (_) => CreateDonationDialog()
// // //                 ),
// // //                 icon: const Icon(Icons.add, color: AppColor.white),
// // //                 label: const Text("Create Donation Post",
// // //                     style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold)),
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: AppColor.green,
// // //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ২ ও ৩: রিকোয়েস্ট লিস্ট ---
// // //   Widget _buildRequestListTab(BuildContext context, {required bool isApproved}) {
// // //     return Consumer<DonorProvider>(
// // //       builder: (context, donorPro, _) {
// // //         final list = isApproved ? donorPro.approvedRequests : donorPro.receiverRequests;
// // //
// // //         if (list.isEmpty) {
// // //           return Center(
// // //             child: SingleChildScrollView( // এম্পটি স্টেটেও সেফটি রাখা
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   Icon(Icons.inbox_outlined, size: 50, color: Colors.grey.shade400),
// // //                   const SizedBox(height: 10),
// // //                   Text(
// // //                     isApproved
// // //                         ? "No approved requests yet."
// // //                         : "All caught up! No pending requests.",
// // //                     style: const TextStyle(color: Colors.grey, fontSize: 14),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         }
// // //
// // //         return ListView.builder(
// // //           physics: const BouncingScrollPhysics(),
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: list.length,
// // //           itemBuilder: (context, index) {
// // //             final request = list[index];
// // //             return _buildRequestCard(context, request, isApproved);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- রিকোয়েস্ট কার্ড ডিজাইন ---
// // //   Widget _buildRequestCard(BuildContext context, Map<String, dynamic> request, bool isApproved) {
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       elevation: 3,
// // //       child: Column(
// // //         children: [
// // //           // FutureBuilder গুলো কার্ডের ভেতরে ডাটা লোড করবে
// // //           FutureBuilder<DocumentSnapshot>(
// // //             future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // //             builder: (context, postSnapshot) {
// // //               if (!postSnapshot.hasData) return const LinearProgressIndicator();
// // //               final postData = postSnapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //
// // //               return FutureBuilder<DocumentSnapshot>(
// // //                 future: FirebaseFirestore.instance.collection('accounts').doc(request['receiverId']).get(),
// // //                 builder: (context, accSnapshot) {
// // //                   String contactPerson = "Loading...";
// // //                   if (accSnapshot.hasData && accSnapshot.data!.exists) {
// // //                     final accData = accSnapshot.data!.data() as Map<String, dynamic>;
// // //                     contactPerson = accData['profile']?['contactPerson'] ?? "No Name";
// // //                   }
// // //
// // //                   return ListTile(
// // //                     contentPadding: const EdgeInsets.all(12),
// // //                     leading: ClipRRect(
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
// // //                           ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image))
// // //                           : Container(width: 60, height: 60, color: Colors.grey.shade200, child: const Icon(Icons.fastfood)),
// // //                     ),
// // //                     title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
// // //                     subtitle: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         const SizedBox(height: 4),
// // //                         Text("Requested by: $contactPerson", style: const TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
// // //                         Text("Qty: ${postData['quantity'] ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
// // //                       ],
// // //                     ),
// // //                   );
// // //                 },
// // //               );
// // //             },
// // //           ),
// // //           const Divider(height: 1),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //             child: isApproved
// // //                 ? const Align(
// // //               alignment: Alignment.centerRight,
// // //               child: Chip(
// // //                 backgroundColor: AppColor.green,
// // //                 label: Text("Approved", style: TextStyle(color: Colors.white, fontSize: 12)),
// // //               ),
// // //             )
// // //                 : Row(
// // //               mainAxisAlignment: MainAxisAlignment.end,
// // //               children: [
// // //                 TextButton(
// // //                   onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
// // //                   child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 ElevatedButton(
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: AppColor.green,
// // //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                   ),
// // //                   onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
// // //                   child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // //
// // // class MyPostsTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //
// // //   const MyPostsTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // }
// // //
// // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // পেজ লোড হওয়ার সাথে সাথে ডোনারের রিকোয়েস্টগুলো ফেচ করা
// // //     Future.microtask(() {
// // //       if (mounted) {
// // //         final donorProvider = context.read<DonorProvider>();
// // //         donorProvider.fetchRequests();
// // //         donorProvider.fetchApprovedRequests();
// // //       }
// // //     });
// // //
// // //     widget.tabController.addListener(() {
// // //       if (mounted) setState(() {});
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           tabAlignment: TabAlignment.start,
// // //           isScrollable: true,
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: AppColor.black,
// // //           indicatorColor: AppColor.lightGreen,
// // //           tabs: const [
// // //             Tab(text: "My Post"),
// // //             Tab(text: "Receivers Requests"),
// // //             Tab(text: "Approved Requests"),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildMyPostsTab(context),
// // //               _buildRequestListTab(context, isApproved: false),
// // //               _buildRequestListTab(context, isApproved: true),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ১: My Posts (ক্রিয়েট ডোনেশন বাটন) ---
// // //   Widget _buildMyPostsTab(BuildContext context) {
// // //     return SingleChildScrollView(
// // //       physics: const BouncingScrollPhysics(),
// // //       padding: const EdgeInsets.all(16),
// // //       child: Card(
// // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //         elevation: 2,
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(20.0),
// // //           child: Column(
// // //             children: [
// // //               const Icon(Icons.post_add, size: 50, color: AppColor.green),
// // //               const SizedBox(height: 15),
// // //               Text("Do You Have Some food to donate?",
// // //                   style: AppData.heading2, textAlign: TextAlign.center),
// // //               const SizedBox(height: 10),
// // //               const Text("Your contribution can save a life.",
// // //                   style: TextStyle(color: Colors.grey)),
// // //               const SizedBox(height: 20),
// // //               ElevatedButton.icon(
// // //                 onPressed: () => showDialog(
// // //                     context: context,
// // //                     builder: (_) => CreateDonationDialog()
// // //                 ),
// // //                 icon: const Icon(Icons.add, color: AppColor.white),
// // //                 label: const Text("Create Donation Post",
// // //                     style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold)),
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: AppColor.green,
// // //                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ২ ও ৩: রিকোয়েস্ট লিস্ট (লজিক ফিক্স করা হয়েছে) ---
// // //   Widget _buildRequestListTab(BuildContext context, {required bool isApproved}) {
// // //     return Consumer<DonorProvider>(
// // //       builder: (context, donorPro, _) {
// // //         // প্রোভাইডার থেকে সঠিক লিস্টটি নেওয়া
// // //         final list = isApproved ? donorPro.approvedRequests : donorPro.receiverRequests;
// // //
// // //         if (list.isEmpty) {
// // //           return Center(
// // //             child: Column(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               children: [
// // //                 Icon(Icons.inbox_outlined, size: 50, color: Colors.grey.shade400),
// // //                 const SizedBox(height: 10),
// // //                 Text(
// // //                   isApproved
// // //                       ? "No approved requests yet."
// // //                       : "All caught up! No pending requests.",
// // //                   style: const TextStyle(color: Colors.grey, fontSize: 14),
// // //                 ),
// // //               ],
// // //             ),
// // //           );
// // //         }
// // //
// // //         return ListView.builder(
// // //           physics: const BouncingScrollPhysics(),
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: list.length,
// // //           itemBuilder: (context, index) {
// // //             final request = list[index];
// // //             return _buildRequestCard(context, request, isApproved);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- রিকোয়েস্ট কার্ড ডিজাইন (FutureBuilder হ্যান্ডেল করা হয়েছে) ---
// // //   Widget _buildRequestCard(BuildContext context, Map<String, dynamic> request, bool isApproved) {
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       elevation: 3,
// // //       child: Column(
// // //         children: [
// // //           // পোস্টের ডাটা নিয়ে আসা
// // //           FutureBuilder<DocumentSnapshot>(
// // //             future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // //             builder: (context, postSnapshot) {
// // //               if (postSnapshot.connectionState == ConnectionState.waiting) {
// // //                 return const LinearProgressIndicator(color: AppColor.green);
// // //               }
// // //
// // //               if (!postSnapshot.hasData || !postSnapshot.data!.exists) {
// // //                 return const ListTile(title: Text("Post not found"));
// // //               }
// // //
// // //               final postData = postSnapshot.data!.data() as Map<String, dynamic>;
// // //
// // //               // রিসিভারের নাম নিয়ে আসা
// // //               return FutureBuilder<DocumentSnapshot>(
// // //                 future: FirebaseFirestore.instance.collection('accounts').doc(request['receiverId']).get(),
// // //                 builder: (context, accSnapshot) {
// // //                   String contactPerson = "User";
// // //                   if (accSnapshot.hasData && accSnapshot.data!.exists) {
// // //                     final accData = accSnapshot.data!.data() as Map<String, dynamic>;
// // //                     contactPerson = accData['profile']?['contactPerson'] ??
// // //                         accData['businessOrFullName'] ?? "Receiver";
// // //                   }
// // //
// // //                   return ListTile(
// // //                     contentPadding: const EdgeInsets.all(12),
// // //                     leading: ClipRRect(
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       child: (postData['imageUrls'] != null && (postData['imageUrls'] as List).isNotEmpty)
// // //                           ? Image.network(postData['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover,
// // //                           errorBuilder: (c, e, s) => const Icon(Icons.fastfood, size: 40))
// // //                           : Container(width: 60, height: 60, color: Colors.grey.shade200, child: const Icon(Icons.fastfood)),
// // //                     ),
// // //                     title: Text(postData['foodName'] ?? "Food", style: const TextStyle(fontWeight: FontWeight.bold)),
// // //                     subtitle: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         const SizedBox(height: 4),
// // //                         Text("Requested by: $contactPerson",
// // //                             style: const TextStyle(color: AppColor.green, fontWeight: FontWeight.bold)),
// // //                         Text("Qty: ${postData['quantity'] ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
// // //                       ],
// // //                     ),
// // //                   );
// // //                 },
// // //               );
// // //             },
// // //           ),
// // //           const Divider(height: 1),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //             child: isApproved
// // //                 ? const Align(
// // //               alignment: Alignment.centerRight,
// // //               child: Chip(
// // //                 backgroundColor: AppColor.green,
// // //                 label: Text("Approved", style: TextStyle(color: Colors.white, fontSize: 12)),
// // //               ),
// // //             )
// // //                 : Row(
// // //               mainAxisAlignment: MainAxisAlignment.end,
// // //               children: [
// // //                 TextButton(
// // //                   onPressed: () {
// // //                     context.read<DonorProvider>().handleRequest(
// // //                         request['requestId'],
// // //                         request['postId'],
// // //                         'rejected'
// // //                     );
// // //                   },
// // //                   child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // //                 ),
// // //                 const SizedBox(width: 8),
// // //                 ElevatedButton(
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: AppColor.green,
// // //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// // //                   ),
// // //                   onPressed: () {
// // //                     context.read<DonorProvider>().handleRequest(
// // //                         request['requestId'],
// // //                         request['postId'],
// // //                         'approved'
// // //                     );
// // //                   },
// // //                   child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // //
// // // class MyPostsTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //   const MyPostsTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // }
// // //
// // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           controller: widget.tabController,
// // //           tabAlignment: TabAlignment.start,
// // //           labelColor: AppColor.green,
// // //           indicatorColor: AppColor.green,
// // //           isScrollable: true,
// // //           tabs: const [
// // //             Tab(text: "Create Post"),
// // //             Tab(text: "Pending Requests"),
// // //             Tab(text: "Delivery/Approved"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildHomeTab(),
// // //               _buildRequestList(isApproved: false),
// // //               _buildRequestList(isApproved: true),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildHomeTab() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           const Icon(Icons.post_add, size: 80, color: AppColor.green),
// // //           const SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
// // //             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
// // //             child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildRequestList({required bool isApproved}) {
// // //     return Consumer<DonorProvider>(
// // //       builder: (context, provider, _) {
// // //         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
// // //         if (list.isEmpty) return const Center(child: Text("No data found"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: list.length,
// // //           itemBuilder: (context, index) => _RequestCard(request: list[index], isApproved: isApproved),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// // //
// // // class _RequestCard extends StatelessWidget {
// // //   final Map<String, dynamic> request;
// // //   final bool isApproved;
// // //   const _RequestCard({required this.request, required this.isApproved});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Card(
// // //       elevation: 4,
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: Column(
// // //         children: [
// // //           _buildPostInfo(),
// // //           const Divider(height: 1),
// // //           _buildActionRow(context),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildPostInfo() {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const LinearProgressIndicator();
// // //         final post = snapshot.data!.data() as Map<String, dynamic>;
// // //         return ListTile(
// // //           leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(post['imageUrls'][0], width: 60, height: 60, fit: BoxFit.cover)),
// // //           title: Text(post['foodName'], style: const TextStyle(fontWeight: FontWeight.bold)),
// // //           subtitle: Text("Status: ${request['status'].toString().toUpperCase()}", style: const TextStyle(color: AppColor.green, fontSize: 12)),
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildActionRow(BuildContext context) {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(10),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //         children: [
// // //           _buildReceiverTag(),
// // //           if (!isApproved)
// // //             Row(
// // //               children: [
// // //                 TextButton(onPressed: () => _handle(context, 'rejected'), child: const Text("Reject", style: TextStyle(color: Colors.red))),
// // //                 ElevatedButton(onPressed: () => _handle(context, 'approved'), style: ElevatedButton.styleFrom(backgroundColor: AppColor.green), child: const Text("Approve")),
// // //               ],
// // //             )
// // //           else if (request['status'] == 'approved')
// // //             ElevatedButton.icon(
// // //               onPressed: () => context.read<DonorProvider>().markAsDelivered(request['requestId'], request['postId']),
// // //               icon: const Icon(Icons.delivery_dining),
// // //               label: const Text("Confirm Delivery"),
// // //               style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
// // //             )
// // //           else
// // //             const Chip(label: Text("Delivered ✅"), backgroundColor: Colors.grey),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildReceiverTag() {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('requests').doc(request['receiverId']).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("...");
// // //         final data = snapshot.data!.data() as Map<String, dynamic>;
// // //         return Text("By: ${data['businessOrFullName'] ?? 'User'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12));
// // //       },
// // //     );
// // //   }
// // //
// // //   void _handle(BuildContext context, String action) {
// // //     context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], action);
// // //   }
// // // }
// //
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // import '../screens/donor/presentation/provider/donor_provider.dart';
// // // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// // //
// // // class MyPostsTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //   const MyPostsTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // // }
// // //
// // // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           controller: widget.tabController,
// // //           tabAlignment: TabAlignment.start,
// // //           labelColor: AppColor.green,
// // //           indicatorColor: AppColor.green,
// // //           isScrollable: true,
// // //           tabs: const [
// // //             Tab(text: "My Post"),
// // //             Tab(text: "Pending Requests"),
// // //             Tab(text: "Delivery/Approved"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildHomeTab(),
// // //               _buildRequestList(isApproved: false),
// // //               _buildRequestList(isApproved: true),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildHomeTab() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           const Icon(Icons.post_add, size: 80, color: AppColor.green),
// // //           const SizedBox(height: 20),
// // //           ElevatedButton(
// // //             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
// // //             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
// // //             child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildRequestList({required bool isApproved}) {
// // //     return Consumer<DonorProvider>(
// // //       builder: (context, provider, _) {
// // //         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
// // //         if (list.isEmpty) return const Center(child: Text("No requests available"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: list.length,
// // //           itemBuilder: (context, index) => _RequestCard(request: list[index]),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// // //
// // // class _RequestCard extends StatelessWidget {
// // //   final Map<String, dynamic> request;
// // //   const _RequestCard({required this.request});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     String status = request['status'] ?? 'pending';
// // //
// // //     return Card(
// // //       elevation: 3,
// // //       margin: const EdgeInsets.only(bottom: 16),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //       child: Padding(
// // //         padding: const EdgeInsets.all(12.0),
// // //         child: Column(
// // //           children: [
// // //             _buildHeaderInfo(),
// // //             const Divider(height: 24),
// // //             _buildFooterActions(context, status),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildHeaderInfo() {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const LinearProgressIndicator();
// // //         final post = snapshot.data!.data() as Map<String, dynamic>?;
// // //         if (post == null) return const Text("Post data missing");
// // //
// // //         return Row(
// // //           children: [
// // //             ClipRRect(
// // //               borderRadius: BorderRadius.circular(8),
// // //               child: Image.network(
// // //                 post['imageUrls'][0],
// // //                 width: 70, height: 70, fit: BoxFit.cover,
// // //                 errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 70),
// // //               ),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post['foodName'] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
// // //                   const SizedBox(height: 4),
// // //                   _buildReceiverNameTag(request['receiverId']),
// // //                 ],
// // //               ),
// // //             ),
// // //             _buildStatusBadge(request['status']),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildStatusBadge(String status) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         color: AppColor.green.withOpacity(0.1),
// // //         borderRadius: BorderRadius.circular(6),
// // //       ),
// // //       child: Text(status.toUpperCase(), style: const TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold)),
// // //     );
// // //   }
// // //
// // //   Widget _buildReceiverNameTag(String receiverId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("By: ...", style: TextStyle(fontSize: 12));
// // //         final userData = snapshot.data!.data() as Map<String, dynamic>?;
// // //         String name = userData?['businessOrFullName'] ??
// // //             userData?['profile']?['contactPerson'] ?? "Someone";
// // //         return Text("By: $name", style: const TextStyle(color: Colors.grey, fontSize: 13));
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildFooterActions(BuildContext context, String status) {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //       children: [
// // //         const Text("Action Needed:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
// // //         _buildActionButtons(context, status),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildActionButtons(BuildContext context, String status) {
// // //     if (status == 'pending') {
// // //       return Row(
// // //         children: [
// // //           TextButton(
// // //             onPressed: () => _process(context, 'rejected'),
// // //             child: const Text("Reject", style: TextStyle(color: Colors.red)),
// // //           ),
// // //           const SizedBox(width: 8),
// // //           ElevatedButton(
// // //             onPressed: () => _process(context, 'approved'),
// // //             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
// // //             child: const Text("Approve", style: TextStyle(color: Colors.white)),
// // //           ),
// // //         ],
// // //       );
// // //     } else if (status == 'approved') {
// // //       return ElevatedButton.icon(
// // //         onPressed: () => context.read<DonorProvider>().markAsDelivered(request['requestId'], request['postId']),
// // //         icon: const Icon(Icons.delivery_dining, size: 18, color: Colors.white),
// // //         label: const Text("Confirm Delivery", style: TextStyle(color: Colors.white)),
// // //         style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, elevation: 0),
// // //       );
// // //     } else {
// // //       return const Chip(
// // //         label: Text("Completed ✅", style: TextStyle(fontSize: 11, color: Colors.white)),
// // //         backgroundColor: Colors.grey,
// // //         padding: EdgeInsets.zero,
// // //       );
// // //     }
// // //   }
// // //
// // //   void _process(BuildContext context, String action) {
// // //     context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], action);
// // //   }
// // // }
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import '../screens/donor/presentation/provider/donor_provider.dart';
// // import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
// //
// // class MyPostsTabSection extends StatefulWidget {
// //   final TabController tabController;
// //   const MyPostsTabSection({super.key, required this.tabController});
// //
// //   @override
// //   State<MyPostsTabSection> createState() => _MyPostsTabSectionState();
// // }
// //
// // class _MyPostsTabSectionState extends State<MyPostsTabSection> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         TabBar(
// //           controller: widget.tabController,
// //           tabAlignment: TabAlignment.start,
// //           labelColor: AppColor.green,
// //           indicatorColor: AppColor.green,
// //           isScrollable: true,
// //           tabs: const [
// //             Tab(text: "My Post"),
// //             Tab(text: "Pending Requests"),
// //             Tab(text: "Delivery/Approved"),
// //           ],
// //         ),
// //         Expanded(
// //           child: TabBarView(
// //             controller: widget.tabController,
// //             children: [
// //               _buildHomeTab(),
// //               _buildRequestList(isApproved: false),
// //               _buildRequestList(isApproved: true),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildHomeTab() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           const Icon(Icons.post_add, size: 80, color: AppColor.green),
// //           const SizedBox(height: 20),
// //           ElevatedButton(
// //             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
// //             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
// //             child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildRequestList({required bool isApproved}) {
// //     return Consumer<DonorProvider>(
// //       builder: (context, provider, _) {
// //         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
// //         if (list.isEmpty) return const Center(child: Text("No requests available"));
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: list.length,
// //           itemBuilder: (context, index) => _RequestCard(request: list[index]),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // class _RequestCard extends StatelessWidget {
// //   final Map<String, dynamic> request;
// //   const _RequestCard({required this.request});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     String status = request['status'] ?? 'pending';
// //     String dStatus = request['deliverystatus'] ?? 'none';
// //
// //     return Card(
// //       elevation: 3,
// //       margin: const EdgeInsets.only(bottom: 16),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //       child: Padding(
// //         padding: const EdgeInsets.all(12.0),
// //         child: Column(
// //           children: [
// //             _buildHeaderInfo(),
// //             const Divider(height: 24),
// //             _buildFooterActions(context, status, dStatus),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildHeaderInfo() {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const SizedBox(height: 70, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
// //         final post = snapshot.data!.data() as Map<String, dynamic>?;
// //         if (post == null) return const Text("Post data missing");
// //
// //         return Row(
// //           children: [
// //             ClipRRect(
// //               borderRadius: BorderRadius.circular(8),
// //               child: Image.network(
// //                 post['imageUrls'][0],
// //                 width: 70, height: 70, fit: BoxFit.cover,
// //                 errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 70),
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(post['foodName'] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
// //                   const SizedBox(height: 4),
// //                   _buildReceiverNameTag(request['receiverId']),
// //                 ],
// //               ),
// //             ),
// //             _buildStatusBadge(request['status']),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildStatusBadge(String status) {
// //     Color color = (status == 'delivered' || status == 'completed') ? Colors.grey : AppColor.green;
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
// //       child: Text(status.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
// //     );
// //   }
// //
// //   Widget _buildReceiverNameTag(String receiverId) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const Text("By: ...", style: TextStyle(fontSize: 12));
// //         final userData = snapshot.data!.data() as Map<String, dynamic>?;
// //         String name = userData?['businessOrFullName'] ?? "Receiver";
// //         return Text("By: $name", style: const TextStyle(color: Colors.grey, fontSize: 13));
// //       },
// //     );
// //   }
// //
// //   Widget _buildFooterActions(BuildContext context, String status, String dStatus) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Text(
// //           dStatus == 'ongoing' ? "Volunteer is on the way" : "Action Needed:",
// //           style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: dStatus == 'ongoing' ? Colors.orange : Colors.black54),
// //         ),
// //         _buildActionButtons(context, status, dStatus),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildActionButtons(BuildContext context, String status, String dStatus) {
// //     if (status == 'pending') {
// //       return Row(
// //         children: [
// //           TextButton(
// //             onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
// //             child: const Text("Reject", style: TextStyle(color: Colors.red)),
// //           ),
// //           const SizedBox(width: 8),
// //           ElevatedButton(
// //             onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
// //             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
// //             child: const Text("Approve", style: TextStyle(color: Colors.white)),
// //           ),
// //         ],
// //       );
// //     } else if (status == 'approved' || status == 'ongoing') {
// //       return ElevatedButton.icon(
// //         onPressed: () => context.read<DonorProvider>().markAsDelivered(request['requestId'], request['postId']),
// //         icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white),
// //         label: const Text("Confirm Delivery", style: TextStyle(color: Colors.white)),
// //         style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, elevation: 0),
// //       );
// //     } else {
// //       return const Chip(
// //         label: Text("Completed ✅", style: TextStyle(fontSize: 11, color: Colors.white)),
// //         backgroundColor: Colors.grey,
// //         padding: EdgeInsets.zero,
// //       );
// //     }
// //   }
// // }
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../screens/donor/presentation/provider/donor_provider.dart';
// import '../screens/donor/presentation/screens/section/create_donation_dialog.dart';
//
// class MyPostsTabSection extends StatefulWidget {
//   final TabController tabController;
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
//     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColor.green,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           tabs: const [
//             Tab(text: "My Post"),
//             Tab(text: "Pending Requests"),
//             Tab(text: "Delivery/Approved"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [
//               _buildHomeTab(),
//               _buildRequestList(isApproved: false),
//               _buildRequestList(isApproved: true),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHomeTab() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.post_add, size: 80, color: AppColor.green),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
//             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
//             child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequestList({required bool isApproved}) {
//     return Consumer<DonorProvider>(
//       builder: (context, provider, _) {
//         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
//         if (list.isEmpty) return const Center(child: Text("No requests available"));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: list.length,
//           itemBuilder: (context, index) => _RequestCard(request: list[index]),
//         );
//       },
//     );
//   }
// }
//
// class _RequestCard extends StatelessWidget {
//   final Map<String, dynamic> request;
//   const _RequestCard({required this.request});
//
//   @override
//   Widget build(BuildContext context) {
//     String status = request['status'] ?? 'pending';
//     String dStatus = request['deliverystatus'] ?? 'none';
//
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             _buildHeaderInfo(status),
//             const Divider(height: 24),
//             _buildFooterActions(context, status, dStatus),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeaderInfo(String status) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const SizedBox(height: 70, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
//         final post = snapshot.data!.data() as Map<String, dynamic>?;
//         if (post == null) return const Text("Post data missing");
//
//         return Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 post['imageUrls'][0],
//                 width: 70, height: 70, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 70),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post['foodName'] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId']),
//                 ],
//               ),
//             ),
//             _buildStatusBadge(status),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildStatusBadge(String status) {
//     Color color;
//     if (status == 'pending') color = Colors.orange;
//     else if (status == 'approved') color = Colors.blue; // ✅ Approved হলে নীল দেখাবে
//     else if (status == 'delivered') color = Colors.grey;
//     else color = AppColor.green;
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(status.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
//     );
//   }
//
//   Widget _buildReceiverNameTag(String receiverId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("By: ...", style: TextStyle(fontSize: 12));
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//         String name = userData?['businessOrFullName'] ?? "Receiver";
//         return Text("By: $name", style: const TextStyle(color: Colors.grey, fontSize: 13));
//       },
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           dStatus == 'ongoing' ? "Volunteer is on the way" : "Action Needed:",
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: dStatus == 'ongoing' ? Colors.orange : Colors.black54),
//         ),
//         _buildActionButtons(context, status, dStatus),
//       ],
//     );
//   }
//
//   Widget _buildActionButtons(BuildContext context, String status, String dStatus) {
//     if (status == 'pending') {
//       return Row(
//         children: [
//           TextButton(
//             onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
//             child: const Text("Reject", style: TextStyle(color: Colors.red)),
//           ),
//           const SizedBox(width: 8),
//           ElevatedButton(
//             onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
//             style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
//             child: const Text("Approve", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       );
//     } else if (status == 'approved' || status == 'ongoing') {
//       // ✅ এখানে কার্ডটি আসার পর ডোনরকে "Confirm" বাটনে ক্লিক করতে হবে
//       return ElevatedButton.icon(
//         onPressed: () => context.read<DonorProvider>().markAsDelivered(request['requestId'], request['postId']),
//         icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white),
//         label: const Text("Confirm Delivery", style: TextStyle(color: Colors.white)),
//         style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent, elevation: 0),
//       );
//     } else {
//       return const Chip(
//         label: Text("Completed ✅", style: TextStyle(fontSize: 11, color: Colors.white)),
//         backgroundColor: Colors.grey,
//         padding: EdgeInsets.zero,
//       );
//     }
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
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
    Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          tabAlignment: TabAlignment.start,
          labelColor: AppColor.green,
          indicatorColor: AppColor.green,
          isScrollable: true,
          tabs: const [
            Tab(text: "My Post"),
            Tab(text: "Pending Requests"),
            Tab(text: "Delivery/Approved"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [
              _buildHomeTab(),
              _buildRequestList(isApproved: false),
              _buildRequestList(isApproved: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHomeTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.post_add, size: 80, color: AppColor.green),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
            child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList({required bool isApproved}) {
    return Consumer<DonorProvider>(
      builder: (context, provider, _) {
        final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
        if (list.isEmpty) return const Center(child: Text("No data found"));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          itemBuilder: (context, index) => _RequestCard(request: list[index]),
        );
      },
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Map<String, dynamic> request;
  const _RequestCard({required this.request});

  @override
  Widget build(BuildContext context) {
    String status = request['status'] ?? 'pending';
    String dStatus = request['deliverystatus'] ?? 'none';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildHeaderInfo(status),

            // ✅ ভলান্টিয়ার বিডিং লিস্ট: যখন স্ট্যাটাস 'approved' কিন্তু কেউ অ্যাসাইন হয়নি
            if (status == 'approved' && (request['volunteerId'] == null || request['volunteerId'] == "")) ...[
              const Divider(height: 20),
              _buildVolunteerBiddingList(context, request['requestId']),
            ],

            const Divider(height: 24),
            _buildFooterActions(context, status, dStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerBiddingList(BuildContext context, String requestId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(requestId).collection('pickup_requests').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        final bids = snapshot.data!.docs;
        if (bids.isEmpty) return const Text("Waiting for volunteer interest...", style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Interested Volunteers:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue)),
            const SizedBox(height: 8),
            ...bids.map((bid) {
              final bData = bid.data() as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  dense: true,
                  leading: const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 14)),
                  title: Text(bData['volunteerName'] ?? "Volunteer", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                  trailing: ElevatedButton(
                    onPressed: () => context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 12)),
                    child: const Text("Handover", style: TextStyle(color: Colors.white, fontSize: 11)),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildHeaderInfo(String status) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 70, child: Center(child: CircularProgressIndicator(strokeWidth: 2)));
        final post = snapshot.data!.data() as Map<String, dynamic>?;
        if (post == null) return const Text("Post data missing");

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post['imageUrls'][0],
                width: 65, height: 65, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 65),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post['foodName'] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  _buildReceiverNameTag(request['receiverId']),
                ],
              ),
            ),
            _buildStatusBadge(status, request['deliverystatus']),
          ],
        );
      },
    );
  }

  Widget _buildStatusBadge(String status, String? dStatus) {
    Color color = Colors.grey;
    String text = status;

    if (status == 'pending') { color = Colors.orange; text = "Pending"; }
    else if (status == 'approved') { color = Colors.blue; text = "Approved"; }
    else if (status == 'delivered') {
      if (dStatus == 'pending') { color = Colors.indigo; text = "To Pickup"; }
      else if (dStatus == 'ongoing') { color = Colors.purple; text = "Ongoing"; }
      else if (dStatus == 'completed') { color = AppColor.green; text = "Finished"; }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildReceiverNameTag(String receiverId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        String name = userData?['profile']?['contactPerson'] ?? "Receiver";
        return Text("For: $name", style: const TextStyle(color: Colors.grey, fontSize: 12));
      },
    );
  }

  Widget _buildFooterActions(BuildContext context, String status, String dStatus) {
    String msg = "Action Needed:";
    if (status == 'approved') msg = "Waiting for Volunteer...";
    if (status == 'delivered' && dStatus == 'pending') msg = "Assigned: ${request['volunteerName']}";
    if (dStatus == 'ongoing') msg = "Volunteer is picking up...";
    if (dStatus == 'completed') msg = "Delivery Successful ✅";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(msg, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54))),
        if (status == 'pending')
          Row(
            children: [
              TextButton(
                onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
                child: const Text("Reject", style: TextStyle(color: Colors.red, fontSize: 13)),
              ),
              ElevatedButton(
                onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
                child: const Text("Approve", style: TextStyle(color: Colors.white, fontSize: 13)),
              ),
            ],
          ),
      ],
    );
  }
}