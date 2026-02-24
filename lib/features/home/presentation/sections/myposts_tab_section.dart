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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColor.green, // Updated to AppColor.green
//           unselectedLabelColor: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray,
//           indicatorColor: AppColor.green, // Updated to AppColor.green
//           isScrollable: true,
//           dividerColor: Colors.transparent,
//           indicatorSize: TabBarIndicatorSize.label,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
//               _buildHomeTab(isDark),
//               _buildRequestList(isApproved: false, isDark: isDark),
//               _buildRequestList(isApproved: true, isDark: isDark),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHomeTab(bool isDark) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.post_add_rounded,
//               size: 80,
//               color: isDark ? AppColor.white.withOpacity(0.1) : AppColor.gray.withOpacity(0.2)
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.green, // Updated to AppColor.green
//               foregroundColor: AppColor.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 0,
//             ),
//             child: const Text("Create New Donation", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequestList({required bool isApproved, required bool isDark}) {
//     return Consumer<DonorProvider>(
//       builder: (context, provider, _) {
//         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
//         if (list.isEmpty) {
//           return Center(
//             child: Text(
//               "No data found",
//               style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: list.length,
//           physics: const BouncingScrollPhysics(),
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     String status = request['status'] ?? 'pending';
//     String dStatus = request['deliverystatus'] ?? 'none';
//
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.only(bottom: 16),
//       color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
//           width: 1,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             _buildHeaderInfo(context, status, isDark),
//             if (status == 'approved' && (request['volunteerId'] == null || request['volunteerId'] == "")) ...[
//               const SizedBox(height: 15),
//               _buildVolunteerBiddingList(context, request['requestId'], isDark),
//             ],
//             Divider(
//                 height: 30,
//                 color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.05)
//             ),
//             _buildFooterActions(context, status, dStatus, isDark),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVolunteerBiddingList(BuildContext context, String requestId, bool isDark) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('requests').doc(requestId).collection('pickup_requests').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const LinearProgressIndicator();
//         final bids = snapshot.data!.docs;
//         if (bids.isEmpty) return Text("Waiting for volunteer interest...", style: TextStyle(fontSize: 12, color: AppColor.gray, fontStyle: FontStyle.italic));
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Interested Volunteers:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? AppColor.white : AppColor.black)),
//             const SizedBox(height: 10),
//             ...bids.map((bid) {
//               final bData = bid.data() as Map<String, dynamic>;
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: isDark ? AppColor.white.withOpacity(0.03) : AppColor.gray.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   leading: CircleAvatar(
//                       radius: 14,
//                       backgroundColor: AppColor.green.withOpacity(0.1),
//                       child: Icon(Icons.person, size: 16, color: AppColor.green)
//                   ),
//                   title: Text(bData['volunteerName'] ?? "Volunteer", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColor.white : AppColor.black)),
//                   trailing: ElevatedButton(
//                     onPressed: () => context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green, // Handover button is Green
//                         elevation: 0,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                     ),
//                     child: const Text("Handover", style: TextStyle(color: AppColor.white, fontSize: 11)),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildHeaderInfo(BuildContext context, String status, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.green)));
//         final post = snapshot.data!.data() as Map<String, dynamic>?;
//         if (post == null) return const Text("Data missing");
//
//         return Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 post['imageUrls'][0],
//                 width: 60, height: 60, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(color: AppColor.gray.withOpacity(0.1), child: const Icon(Icons.fastfood)),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post['foodName'] ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? AppColor.white : AppColor.black),
//                   ),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId'], isDark),
//                 ],
//               ),
//             ),
//             _buildStatusBadge(status, request['deliverystatus']),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildStatusBadge(String status, String? dStatus) {
//     Color color = AppColor.gray;
//     String text = status;
//
//     if (status == 'pending') { color = Colors.orange; text = "Pending"; }
//     else if (status == 'approved') { color = AppColor.green; text = "Approved"; } // Approved is now Green
//     else if (status == 'delivered') {
//       if (dStatus == 'pending') { color = AppColor.green; text = "To Pickup"; }
//       else if (dStatus == 'ongoing') { color = AppColor.green; text = "Ongoing"; }
//       else if (dStatus == 'completed') { color = AppColor.green; text = "Finished"; }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
//     );
//   }
//
//   Widget _buildReceiverNameTag(String receiverId, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//         String name = userData?['profile']?['contactPerson'] ?? "Receiver";
//         return Text("For: $name", style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray, fontSize: 12));
//       },
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus, bool isDark) {
//     String msg = "Activity Status:";
//     if (status == 'approved') msg = "Waiting for Volunteer...";
//     if (status == 'delivered' && dStatus == 'pending') msg = "Assigned: ${request['volunteerName']}";
//     if (dStatus == 'ongoing') msg = "Handing over process...";
//     if (dStatus == 'completed') msg = "Delivery Successful ✅";
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             msg,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray,
//             ),
//           ),
//         ),
//         if (status == 'pending')
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
//                 child: Text("Reject", style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.green, // Approve button is Green
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                 ),
//                 child: const Text("Approve", style: TextStyle(color: AppColor.white, fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }
//
//
//
//
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
//     // মাইক্রোটাস্ক ব্যবহার করা হয়েছে যাতে ফ্রেম রেন্ডার হওয়ার পর ডাটা ফেচ শুরু হয়
//     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColor.green,
//           unselectedLabelColor: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           dividerColor: Colors.transparent,
//           // indicatorSize: TabBarSize.label,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           tabs: const [
//             Tab(text: "My Post"),
//             Tab(text: "Pending Requests"),
//             Tab(text: "History/Approved"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [
//               _buildHomeTab(isDark),
//               _buildRequestList(isApproved: false, isDark: isDark),
//               _buildRequestList(isApproved: true, isDark: isDark),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHomeTab(bool isDark) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.post_add_rounded,
//               size: 80,
//               color: isDark ? AppColor.white.withOpacity(0.1) : AppColor.gray.withOpacity(0.2)
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.green,
//               foregroundColor: AppColor.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 0,
//             ),
//             child: const Text("Create New Donation", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequestList({required bool isApproved, required bool isDark}) {
//     return Consumer<DonorProvider>(
//       builder: (context, provider, _) {
//         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
//
//         if (list.isEmpty) {
//           return Center(
//             child: Text(
//               "No data found",
//               style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: list.length,
//           physics: const BouncingScrollPhysics(),
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     final String status = request['status'] ?? 'pending';
//     final String dStatus = request['deliverystatus'] ?? 'none';
//     final String? volunteerId = request['volunteerId'];
//
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.only(bottom: 16),
//       color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             _buildHeaderInfo(context, status, dStatus, isDark),
//
//             // ✅ যদি এক্সেপ্ট হয় কিন্তু ভলান্টিয়ার অ্যাসাইন না হয়, তবে বিডিং লিস্ট দেখাও
//             if (status == 'approved' && (volunteerId == null || volunteerId.isEmpty)) ...[
//               const SizedBox(height: 15),
//               _buildVolunteerBiddingList(context, request['requestId'], isDark),
//             ],
//
//             Divider(
//                 height: 30,
//                 color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.05)
//             ),
//             _buildFooterActions(context, status, dStatus, isDark),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVolunteerBiddingList(BuildContext context, String requestId, bool isDark) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('requests')
//           .doc(requestId)
//           .collection('pickup_requests')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const LinearProgressIndicator();
//
//         final bids = snapshot.data?.docs ?? [];
//         if (bids.isEmpty) {
//           return Text(
//               "Waiting for volunteer interest...",
//               style: TextStyle(fontSize: 12, color: AppColor.gray, fontStyle: FontStyle.italic)
//           );
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//                 "Interested Volunteers:",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? AppColor.white : AppColor.black)
//             ),
//             const SizedBox(height: 10),
//             ...bids.map((bid) {
//               final bData = bid.data() as Map<String, dynamic>;
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: isDark ? AppColor.white.withOpacity(0.03) : AppColor.gray.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   leading: CircleAvatar(
//                       radius: 14,
//                       backgroundColor: AppColor.green.withOpacity(0.1),
//                       child: Icon(Icons.person, size: 16, color: AppColor.green)
//                   ),
//                   title: Text(bData['volunteerName'] ?? "Volunteer",
//                       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColor.white : AppColor.black)),
//                   trailing: ElevatedButton(
//                     onPressed: () => context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         elevation: 0,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                     ),
//                     child: const Text("Handover", style: TextStyle(color: AppColor.white, fontSize: 11)),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildHeaderInfo(BuildContext context, String status, String dStatus, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.green)));
//         final post = snapshot.data!.data() as Map<String, dynamic>?;
//         if (post == null) return const Text("Food Data missing");
//
//         return Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 post['imageUrls'][0],
//                 width: 60, height: 60, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(color: AppColor.gray.withOpacity(0.1), child: const Icon(Icons.fastfood)),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post['foodName'] ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? AppColor.white : AppColor.black),
//                   ),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId'], isDark),
//                 ],
//               ),
//             ),
//             _buildStatusBadge(status, dStatus),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildStatusBadge(String status, String dStatus) {
//     Color color = AppColor.gray;
//     String text = status;
//
//     if (status == 'pending') {
//       color = Colors.orange;
//       text = "Reviewing";
//     } else if (status == 'approved') {
//       color = Colors.blue;
//       text = "Finding Volunteer";
//     } else if (status == 'delivered') {
//       if (dStatus == 'pending') { color = AppColor.green; text = "Awaiting Pickup"; }
//       else if (dStatus == 'ongoing') { color = Colors.indigo; text = "Out for Delivery"; }
//       else if (dStatus == 'completed') { color = AppColor.green; text = "Completed"; }
//     } else if (status == 'rejected') {
//       color = Colors.red;
//       text = "Rejected";
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
//     );
//   }
//
//   Widget _buildReceiverNameTag(String receiverId, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//         String name = userData?['profile']?['contactPerson'] ?? "Receiver";
//         return Text("Requester: $name", style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray, fontSize: 12));
//       },
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus, bool isDark) {
//     String msg = "Activity:";
//     if (status == 'pending') msg = "Verify details and Respond";
//     if (status == 'approved') msg = "Waiting for volunteer interaction...";
//     if (status == 'delivered' && dStatus == 'pending') msg = "Volunteer: ${request['volunteerName']} (Coming)";
//     if (dStatus == 'ongoing') msg = "Delivery is in progress...";
//     if (dStatus == 'completed') msg = "Delivered to requester ✅";
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             msg,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: isDark ? AppColor.white.withOpacity(0.4) : AppColor.gray,
//             ),
//           ),
//         ),
//         if (status == 'pending')
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
//                 child: const Text("Reject", style: TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.green,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                 ),
//                 child: const Text("Approve", style: TextStyle(color: AppColor.white, fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../../services/notification_service.dart';
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColor.green,
//           unselectedLabelColor: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           dividerColor: Colors.transparent,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           tabs: const [
//             Tab(text: "My Post"),
//             Tab(text: "Pending Requests"),
//             Tab(text: "History/Approved"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [
//               _buildHomeTab(isDark),
//               _buildRequestList(isApproved: false, isDark: isDark),
//               _buildRequestList(isApproved: true, isDark: isDark),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHomeTab(bool isDark) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.post_add_rounded,
//               size: 80,
//               color: isDark ? AppColor.white.withOpacity(0.1) : AppColor.gray.withOpacity(0.2)
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.green,
//               foregroundColor: AppColor.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 0,
//             ),
//             child: const Text("Create New Donation", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequestList({required bool isApproved, required bool isDark}) {
//     return Consumer<DonorProvider>(
//       builder: (context, provider, _) {
//         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
//
//         if (list.isEmpty) {
//           return Center(
//             child: Text(
//               "No data found",
//               style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: list.length,
//           physics: const BouncingScrollPhysics(),
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     final String status = request['status'] ?? 'pending';
//     final String dStatus = request['deliverystatus'] ?? 'none';
//     final String? volunteerId = request['volunteerId'];
//
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.only(bottom: 16),
//       color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             _buildHeaderInfo(context, status, dStatus, isDark),
//
//             if (status == 'approved' && (volunteerId == null || volunteerId.isEmpty)) ...[
//               const SizedBox(height: 15),
//               _buildVolunteerBiddingList(context, request['requestId'], isDark),
//             ],
//
//             Divider(
//                 height: 30,
//                 color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.05)
//             ),
//             _buildFooterActions(context, status, dStatus, isDark),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVolunteerBiddingList(BuildContext context, String requestId, bool isDark) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('requests')
//           .doc(requestId)
//           .collection('pickup_requests')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const LinearProgressIndicator();
//
//         final bids = snapshot.data?.docs ?? [];
//         if (bids.isEmpty) {
//           return Text(
//               "Waiting for volunteer interest...",
//               style: TextStyle(fontSize: 12, color: AppColor.gray, fontStyle: FontStyle.italic)
//           );
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//                 "Interested Volunteers:",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? AppColor.white : AppColor.black)
//             ),
//             const SizedBox(height: 10),
//             ...bids.map((bid) {
//               final bData = bid.data() as Map<String, dynamic>;
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: isDark ? AppColor.white.withOpacity(0.03) : AppColor.gray.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   leading: CircleAvatar(
//                       radius: 14,
//                       backgroundColor: AppColor.green.withOpacity(0.1),
//                       child: Icon(Icons.person, size: 16, color: AppColor.green)
//                   ),
//                   title: Text(bData['volunteerName'] ?? "Volunteer",
//                       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColor.white : AppColor.black)),
//                   trailing: ElevatedButton(
//                     onPressed: () async {
//                       // ✅ ভলান্টিয়ার অ্যাসাইন করা এবং নোটিফিকেশন পাঠানো
//                       await context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']);
//
//                       // রিসিভারকে জানানো যে খাবারটি ডেলিভারির জন্য ভলান্টিয়ারের কাছে দেওয়া হয়েছে
//                       NotificationService.sendApprovalNotification(
//                           requesterId: request['receiverId'],
//                           foodName: "Your requested food",
//                           postId: request['postId']
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         elevation: 0,
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                     ),
//                     child: const Text("Handover", style: TextStyle(color: AppColor.white, fontSize: 11)),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildHeaderInfo(BuildContext context, String status, String dStatus, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.green)));
//         final post = snapshot.data!.data() as Map<String, dynamic>?;
//         if (post == null) return const Text("Food Data missing");
//
//         return Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.network(
//                 post['imageUrls'][0],
//                 width: 60, height: 60, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(color: AppColor.gray.withOpacity(0.1), child: const Icon(Icons.fastfood)),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     post['foodName'] ?? "N/A",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? AppColor.white : AppColor.black),
//                   ),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId'], isDark),
//                 ],
//               ),
//             ),
//             _buildStatusBadge(status, dStatus),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildStatusBadge(String status, String dStatus) {
//     Color color = AppColor.gray;
//     String text = status;
//
//     if (status == 'pending') { color = Colors.orange; text = "Reviewing"; }
//     else if (status == 'approved') { color = Colors.blue; text = "Finding Volunteer"; }
//     else if (status == 'delivered') {
//       if (dStatus == 'pending') { color = AppColor.green; text = "Awaiting Pickup"; }
//       else if (dStatus == 'ongoing') { color = Colors.indigo; text = "Out for Delivery"; }
//       else if (dStatus == 'completed') { color = AppColor.green; text = "Completed"; }
//     } else if (status == 'rejected') { color = Colors.red; text = "Rejected"; }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
//     );
//   }
//
//   Widget _buildReceiverNameTag(String receiverId, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//         String name = userData?['profile']?['contactPerson'] ?? "Receiver";
//         return Text("Requester: $name", style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray, fontSize: 12));
//       },
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus, bool isDark) {
//     String msg = "Activity:";
//     if (status == 'pending') msg = "Verify details and Respond";
//     if (status == 'approved') msg = "Waiting for volunteer interaction...";
//     if (status == 'delivered' && dStatus == 'pending') msg = "Volunteer: ${request['volunteerName']} (Coming)";
//     if (dStatus == 'ongoing') msg = "Delivery is in progress...";
//     if (dStatus == 'completed') msg = "Delivered to requester ✅";
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(
//             msg,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isDark ? AppColor.white.withOpacity(0.4) : AppColor.gray),
//           ),
//         ),
//         if (status == 'pending')
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () async {
//                   // ✅ Reject নোটিফিকেশন
//                   await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected');
//                   NotificationService.sendRejectionNotification(
//                       requesterId: request['receiverId'],
//                       foodName: "Requested Item",
//                       postId: request['postId']
//                   );
//                 },
//                 child: const Text("Reject", style: TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: () async {
//                   // ✅ Approve নোটিফিকেশন
//                   await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved');
//                   NotificationService.sendApprovalNotification(
//                       requesterId: request['receiverId'],
//                       foodName: "Requested Item",
//                       postId: request['postId']
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.green,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//                 ),
//                 child: const Text("Approve", style: TextStyle(color: AppColor.white, fontSize: 13, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import '../../../../services/notification_service.dart';
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
//     // স্ক্রিন লোড হওয়ার সময় সব রিকোয়েস্ট ফেচ করা
//     Future.microtask(() => context.read<DonorProvider>().fetchAllRequests());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           tabAlignment: TabAlignment.start,
//           labelColor: AppColor.green,
//           unselectedLabelColor: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           dividerColor: Colors.transparent,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           tabs: const [
//             Tab(text: "My Post"),
//             Tab(text: "Pending Requests"),
//             Tab(text: "History/Approved"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [
//               _buildHomeTab(isDark),
//               _buildRequestList(isApproved: false, isDark: isDark),
//               _buildRequestList(isApproved: true, isDark: isDark),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHomeTab(bool isDark) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.post_add_rounded,
//               size: 80,
//               color: isDark ? AppColor.white.withOpacity(0.1) : AppColor.gray.withOpacity(0.2)
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton(
//             onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.green,
//               foregroundColor: AppColor.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               elevation: 0,
//             ),
//             child: const Text("Create New Donation", style: TextStyle(fontWeight: FontWeight.bold)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequestList({required bool isApproved, required bool isDark}) {
//     return Consumer<DonorProvider>(
//       builder: (context, provider, _) {
//         final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
//
//         if (list.isEmpty) {
//           return Center(
//             child: Text(
//               isApproved ? "No approved history" : "No pending requests",
//               style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: list.length,
//           physics: const BouncingScrollPhysics(),
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     final String status = request['status'] ?? 'pending';
//     final String dStatus = request['deliverystatus'] ?? 'none';
//     final String? volunteerId = request['volunteerId'];
//
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.only(bottom: 16),
//       color: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children: [
//             _buildHeaderInfo(context, status, dStatus, isDark),
//
//             // ভলান্টিয়ার বিডিং সেকশন (যদি রিকোয়েস্ট অ্যাপ্রুভড হয় কিন্তু ভলান্টিয়ার এসাইন না হয়)
//             if (status == 'approved' && (volunteerId == null || volunteerId.isEmpty)) ...[
//               const SizedBox(height: 15),
//               _buildVolunteerBiddingList(context, request['requestId'], isDark),
//             ],
//
//             Divider(
//                 height: 30,
//                 color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.05)
//             ),
//             _buildFooterActions(context, status, dStatus, isDark),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- ভলান্টিয়ার যারা আগ্রহ দেখিয়েছে তাদের লিস্ট ---
//   Widget _buildVolunteerBiddingList(BuildContext context, String requestId, bool isDark) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('requests')
//           .doc(requestId)
//           .collection('pickup_requests')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const LinearProgressIndicator();
//
//         final bids = snapshot.data?.docs ?? [];
//         if (bids.isEmpty) {
//           return Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(color: Colors.orange.withOpacity(0.05), borderRadius: BorderRadius.circular(10)),
//             child: Row(
//               children: [
//                 const Icon(Icons.hourglass_empty, size: 14, color: Colors.orange),
//                 const SizedBox(width: 8),
//                 Text("Waiting for volunteer interest...", style: TextStyle(fontSize: 12, color: Colors.orange[700], fontStyle: FontStyle.italic)),
//               ],
//             ),
//           );
//         }
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Available Volunteers:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? Colors.white70 : Colors.black87)),
//             const SizedBox(height: 10),
//             ...bids.map((bid) {
//               final bData = bid.data() as Map<String, dynamic>;
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 8),
//                 decoration: BoxDecoration(
//                   color: isDark ? AppColor.white.withOpacity(0.03) : AppColor.gray.withOpacity(0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   leading: const CircleAvatar(radius: 14, backgroundColor: AppColor.green, child: Icon(Icons.delivery_dining, size: 16, color: Colors.white)),
//                   title: Text(bData['volunteerName'] ?? "Volunteer", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//                   trailing: ElevatedButton(
//                     onPressed: () async {
//                       // ভলান্টিয়ার অ্যাসাইন করা
//                       await context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']);
//
//                       // ভলান্টিয়ারকে পপ-আপ পাঠানো
//                       NotificationService.sendApprovalNotification(
//                           requesterId: bData['volunteerId'],
//                           foodName: "Task Assigned: Delivery for ${request['foodName']}",
//                           postId: request['postId']
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                     child: const Text("Handover", style: TextStyle(color: Colors.white, fontSize: 11)),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildHeaderInfo(BuildContext context, String status, String dStatus, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.green)));
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//
//         return Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: _buildPostImage(post['imageUrls']),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post['foodName'] ?? "N/A", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? AppColor.white : AppColor.black)),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId'], isDark),
//                 ],
//               ),
//             ),
//             _buildStatusBadge(status, dStatus),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildStatusBadge(String status, String dStatus) {
//     Color color = AppColor.gray;
//     String text = status;
//
//     if (status == 'pending') { color = Colors.orange; text = "New Request"; }
//     else if (status == 'approved') { color = Colors.blue; text = "Wait for Volunteer"; }
//     else if (status == 'delivered') {
//       if (dStatus == 'pending') { color = Colors.teal; text = "Picked Up"; }
//       else if (dStatus == 'ongoing') { color = Colors.indigo; text = "On Way"; }
//       else if (dStatus == 'completed') { color = AppColor.green; text = "Received"; }
//     } else if (status == 'rejected') { color = Colors.red; text = "Declined"; }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.w900)),
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus, bool isDark) {
//     String activityMsg = "Status: Monitoring delivery...";
//     if (status == 'pending') activityMsg = "Verify details and Respond";
//     if (status == 'approved') activityMsg = "Volunteer bidding active...";
//     if (dStatus == 'completed') activityMsg = "Donation successful! ✅";
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Text(activityMsg, style: TextStyle(fontSize: 12, color: isDark ? Colors.white38 : Colors.grey[600])),
//         ),
//         if (status == 'pending')
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () async {
//                   await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected');
//                   NotificationService.sendRejectionNotification(
//                       requesterId: request['receiverId'],
//                       foodName: request['foodName'] ?? "Food Item",
//                       postId: request['postId']
//                   );
//                 },
//                 child: const Text("Reject", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: () async {
//                   await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved');
//                   // রিসিভারকে পপ-আপ পাঠানো
//                   NotificationService.sendApprovalNotification(
//                       requesterId: request['receiverId'],
//                       foodName: request['foodName'] ?? "Food Item",
//                       postId: request['postId']
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
//                 child: const Text("Approve", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//               ),
//             ],
//           ),
//       ],
//     );
//   }
//
//   // ইমেজ হ্যান্ডলার
//   Widget _buildPostImage(dynamic urls) {
//     if (urls != null && urls is List && urls.isNotEmpty) {
//       return Image.network(urls[0], width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _errorIcon());
//     }
//     return _errorIcon();
//   }
//
//   Widget _errorIcon() => Container(width: 60, height: 60, color: AppColor.gray.withOpacity(0.1), child: const Icon(Icons.fastfood, size: 20));
//
//   Widget _buildReceiverNameTag(String receiverId, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//         String name = userData['profile']?['contactPerson'] ?? "Loading...";
//         return Text("For: $name", style: TextStyle(color: isDark ? Colors.white54 : AppColor.gray, fontSize: 12));
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../../services/notification_service.dart';
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          tabAlignment: TabAlignment.start,
          labelColor: AppColor.green,
          unselectedLabelColor: isDark ? Colors.white54 : Colors.grey,
          indicatorColor: AppColor.green,
          isScrollable: true,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          tabs: const [
            Tab(text: "My Post"),
            Tab(text: "Pending Requests"),
            Tab(text: "History/Approved"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [
              _buildHomeTab(isDark),
              _buildRequestList(isApproved: false, isDark: isDark),
              _buildRequestList(isApproved: true, isDark: isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHomeTab(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.post_add_rounded, size: 80, color: isDark ? Colors.white10 : Colors.grey[200]),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Create New Donation", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList({required bool isApproved, required bool isDark}) {
    return Consumer<DonorProvider>(
      builder: (context, provider, _) {
        final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
        if (list.isEmpty) return Center(child: Text("No data found", style: TextStyle(color: isDark ? Colors.white30 : Colors.grey)));

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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String status = request['status'] ?? 'pending';
    final String dStatus = request['deliverystatus'] ?? 'none';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: isDark ? Colors.white10 : Colors.grey[200]!)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildCardHeader(context, isDark, status, dStatus),
            if (status == 'approved' && (request['volunteerId'] == null))
              _buildVolunteerSection(context, request['requestId'], isDark),
            const Divider(height: 30),
            _buildActions(context, status, dStatus, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerSection(BuildContext context, String reqId, bool isDark) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(reqId).collection('pickup_requests').snapshots(),
      builder: (context, snap) {
        final bids = snap.data?.docs ?? [];
        if (bids.isEmpty) return const Padding(padding: EdgeInsets.only(top: 10), child: Text("Waiting for volunteers...", style: TextStyle(fontSize: 12, color: Colors.orange)));

        return Column(
          children: bids.map((bid) {
            final bData = bid.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(bData['volunteerName'] ?? "Volunteer", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                onPressed: () async {
                  await context.read<DonorProvider>().assignVolunteer(reqId, bData['volunteerId'], bData['volunteerName']);
                  NotificationService.showLocalNotification("Task Assigned!", "Handed over ${request['foodName']} to volunteer.");
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
                child: const Text("Handover", style: TextStyle(color: Colors.white, fontSize: 11)),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCardHeader(BuildContext context, bool isDark, String status, String dStatus) {
    return Row(
      children: [
        const CircleAvatar(backgroundColor: AppColor.green, child: Icon(Icons.fastfood, color: Colors.white, size: 20)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(request['foodName'] ?? "Food Item", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Requester ID: ${request['receiverId'].toString().substring(0, 5)}...", style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ]),
        ),
        _buildBadge(status, dStatus),
      ],
    );
  }

  Widget _buildBadge(String s, String ds) {
    Color c = Colors.orange;
    if (s == 'approved') c = Colors.blue;
    if (ds == 'completed') c = AppColor.green;
    if (s == 'rejected') c = Colors.red;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(s.toUpperCase(), style: TextStyle(color: c, fontSize: 8, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActions(BuildContext context, String status, String dStatus, bool isDark) {
    if (status == 'pending') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () async {
              await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected');
              NotificationService.sendRejectionNotification(requesterId: request['receiverId'], foodName: request['foodName'] ?? "Food", postId: request['postId']);
            },
            child: const Text("Reject", style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async {
              await context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved');
              NotificationService.sendApprovalNotification(requesterId: request['receiverId'], foodName: request['foodName'] ?? "Food", postId: request['postId']);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
            child: const Text("Approve", style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    }
    return Row(
      children: [
        Icon(Icons.info_outline, size: 14, color: isDark ? Colors.white38 : Colors.grey),
        const SizedBox(width: 5),
        Text(dStatus == 'completed' ? "Donation Completed ✅" : "Current Status: ${status.toUpperCase()}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}