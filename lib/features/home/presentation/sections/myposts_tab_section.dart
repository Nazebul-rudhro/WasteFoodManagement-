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
//         if (list.isEmpty) return const Center(child: Text("No data found"));
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
//
//             // ✅ ভলান্টিয়ার বিডিং লিস্ট: যখন স্ট্যাটাস 'approved' কিন্তু কেউ অ্যাসাইন হয়নি
//             if (status == 'approved' && (request['volunteerId'] == null || request['volunteerId'] == "")) ...[
//               const Divider(height: 20),
//               _buildVolunteerBiddingList(context, request['requestId']),
//             ],
//
//             const Divider(height: 24),
//             _buildFooterActions(context, status, dStatus),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildVolunteerBiddingList(BuildContext context, String requestId) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('requests').doc(requestId).collection('pickup_requests').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const LinearProgressIndicator();
//         final bids = snapshot.data!.docs;
//         if (bids.isEmpty) return const Text("Waiting for volunteer interest...", style: TextStyle(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic));
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Interested Volunteers:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue)),
//             const SizedBox(height: 8),
//             ...bids.map((bid) {
//               final bData = bid.data() as Map<String, dynamic>;
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 5),
//                 decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(8)),
//                 child: ListTile(
//                   dense: true,
//                   leading: const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 14)),
//                   title: Text(bData['volunteerName'] ?? "Volunteer", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
//                   trailing: ElevatedButton(
//                     onPressed: () => context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']),
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 12)),
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
//                 width: 65, height: 65, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 65),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post['foodName'] ?? "N/A", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                   const SizedBox(height: 4),
//                   _buildReceiverNameTag(request['receiverId']),
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
//     Color color = Colors.grey;
//     String text = status;
//
//     if (status == 'pending') { color = Colors.orange; text = "Pending"; }
//     else if (status == 'approved') { color = Colors.blue; text = "Approved"; }
//     else if (status == 'delivered') {
//       if (dStatus == 'pending') { color = Colors.indigo; text = "To Pickup"; }
//       else if (dStatus == 'ongoing') { color = Colors.purple; text = "Ongoing"; }
//       else if (dStatus == 'completed') { color = AppColor.green; text = "Finished"; }
//     }
//
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
//       child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
//     );
//   }
//
//   Widget _buildReceiverNameTag(String receiverId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//         String name = userData?['profile']?['contactPerson'] ?? "Receiver";
//         return Text("For: $name", style: const TextStyle(color: Colors.grey, fontSize: 12));
//       },
//     );
//   }
//
//   Widget _buildFooterActions(BuildContext context, String status, String dStatus) {
//     String msg = "Action Needed:";
//     if (status == 'approved') msg = "Waiting for Volunteer...";
//     if (status == 'delivered' && dStatus == 'pending') msg = "Assigned: ${request['volunteerName']}";
//     if (dStatus == 'ongoing') msg = "Volunteer is picking up...";
//     if (dStatus == 'completed') msg = "Delivery Successful ✅";
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(child: Text(msg, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54))),
//         if (status == 'pending')
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
//                 child: const Text("Reject", style: TextStyle(color: Colors.red, fontSize: 13)),
//               ),
//               ElevatedButton(
//                 onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
//                 style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, elevation: 0),
//                 child: const Text("Approve", style: TextStyle(color: Colors.white, fontSize: 13)),
//               ),
//             ],
//           ),
//       ],
//     );
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          tabAlignment: TabAlignment.start,
          labelColor: AppColor.green, // Updated to AppColor.green
          unselectedLabelColor: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray,
          indicatorColor: AppColor.green, // Updated to AppColor.green
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
          Icon(
              Icons.post_add_rounded,
              size: 80,
              color: isDark ? AppColor.white.withOpacity(0.1) : AppColor.gray.withOpacity(0.2)
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => showDialog(context: context, builder: (_) => const CreateDonationDialog()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.green, // Updated to AppColor.green
              foregroundColor: AppColor.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text("Create New Donation", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestList({required bool isApproved, required bool isDark}) {
    return Consumer<DonorProvider>(
      builder: (context, provider, _) {
        final list = isApproved ? provider.approvedRequests : provider.receiverRequests;
        if (list.isEmpty) {
          return Center(
            child: Text(
              "No data found",
              style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          physics: const BouncingScrollPhysics(),
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
    String status = request['status'] ?? 'pending';
    String dStatus = request['deliverystatus'] ?? 'none';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildHeaderInfo(context, status, isDark),
            if (status == 'approved' && (request['volunteerId'] == null || request['volunteerId'] == "")) ...[
              const SizedBox(height: 15),
              _buildVolunteerBiddingList(context, request['requestId'], isDark),
            ],
            Divider(
                height: 30,
                color: isDark ? AppColor.white.withOpacity(0.05) : AppColor.gray.withOpacity(0.05)
            ),
            _buildFooterActions(context, status, dStatus, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildVolunteerBiddingList(BuildContext context, String requestId, bool isDark) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').doc(requestId).collection('pickup_requests').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        final bids = snapshot.data!.docs;
        if (bids.isEmpty) return Text("Waiting for volunteer interest...", style: TextStyle(fontSize: 12, color: AppColor.gray, fontStyle: FontStyle.italic));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Interested Volunteers:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: isDark ? AppColor.white : AppColor.black)),
            const SizedBox(height: 10),
            ...bids.map((bid) {
              final bData = bid.data() as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isDark ? AppColor.white.withOpacity(0.03) : AppColor.gray.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  dense: true,
                  leading: CircleAvatar(
                      radius: 14,
                      backgroundColor: AppColor.green.withOpacity(0.1),
                      child: Icon(Icons.person, size: 16, color: AppColor.green)
                  ),
                  title: Text(bData['volunteerName'] ?? "Volunteer", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? AppColor.white : AppColor.black)),
                  trailing: ElevatedButton(
                    onPressed: () => context.read<DonorProvider>().assignVolunteer(requestId, bData['volunteerId'], bData['volunteerName']),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green, // Handover button is Green
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                    ),
                    child: const Text("Handover", style: TextStyle(color: AppColor.white, fontSize: 11)),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }

  Widget _buildHeaderInfo(BuildContext context, String status, bool isDark) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(request['postId']).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox(height: 50, child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppColor.green)));
        final post = snapshot.data!.data() as Map<String, dynamic>?;
        if (post == null) return const Text("Data missing");

        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                post['imageUrls'][0],
                width: 60, height: 60, fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColor.gray.withOpacity(0.1), child: const Icon(Icons.fastfood)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['foodName'] ?? "N/A",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? AppColor.white : AppColor.black),
                  ),
                  const SizedBox(height: 4),
                  _buildReceiverNameTag(request['receiverId'], isDark),
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
    Color color = AppColor.gray;
    String text = status;

    if (status == 'pending') { color = Colors.orange; text = "Pending"; }
    else if (status == 'approved') { color = AppColor.green; text = "Approved"; } // Approved is now Green
    else if (status == 'delivered') {
      if (dStatus == 'pending') { color = AppColor.green; text = "To Pickup"; }
      else if (dStatus == 'ongoing') { color = AppColor.green; text = "Ongoing"; }
      else if (dStatus == 'completed') { color = AppColor.green; text = "Finished"; }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)),
    );
  }

  Widget _buildReceiverNameTag(String receiverId, bool isDark) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("...", style: TextStyle(fontSize: 12));
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        String name = userData?['profile']?['contactPerson'] ?? "Receiver";
        return Text("For: $name", style: TextStyle(color: isDark ? AppColor.white.withOpacity(0.5) : AppColor.gray, fontSize: 12));
      },
    );
  }

  Widget _buildFooterActions(BuildContext context, String status, String dStatus, bool isDark) {
    String msg = "Activity Status:";
    if (status == 'approved') msg = "Waiting for Volunteer...";
    if (status == 'delivered' && dStatus == 'pending') msg = "Assigned: ${request['volunteerName']}";
    if (dStatus == 'ongoing') msg = "Handing over process...";
    if (dStatus == 'completed') msg = "Delivery Successful ✅";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            msg,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColor.white.withOpacity(0.3) : AppColor.gray,
            ),
          ),
        ),
        if (status == 'pending')
          Row(
            children: [
              TextButton(
                onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'rejected'),
                child: Text("Reject", style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => context.read<DonorProvider>().handleRequest(request['requestId'], request['postId'], 'approved'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green, // Approve button is Green
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                ),
                child: const Text("Approve", style: TextStyle(color: AppColor.white, fontSize: 13, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
      ],
    );
  }
}