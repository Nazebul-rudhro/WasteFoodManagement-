// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../provider/volunteer_provider.dart';
//
// class VolunteerTabSection extends StatelessWidget {
//   final TabController tabController;
//   const VolunteerTabSection({super.key, required this.tabController});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TabBar(
//           tabAlignment: TabAlignment.start,
//           isScrollable: true,
//           controller: tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: AppColor.black,
//           indicatorColor: AppColor.lightGreen,
//           tabs: const [
//             Tab(text: "Delivery Request"),
//             Tab(text: "Completed Delivery"),
//           ],
//         ),
//         SizedBox(
//           height: 450,
//           child: TabBarView(
//             controller: tabController,
//             children: [
//               _buildAvailableRequestsTab(context),
//               _buildCompletedDeliveriesTab(context),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAvailableRequestsTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context, listen: false);
//     // জেনেরিক প্রোভাইডার থেকে ইউজার আইডি নেওয়া
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getAvailableRequests(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           // যদি ইনডেক্স এরর থাকে তবে এখানে লিঙ্ক দেখাবে
//           return Center(child: Text("Error: ${snapshot.error}"));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         var docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return const Center(
//             child: Text("No new requests found.\nMake sure Firestore has status='approved' and volunteerId=''"),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             var data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               elevation: 2,
//               child: ListTile(
//                 title: Text("Food: ${data['postId'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text("Delivery Type: ${data['deliveryType'] ?? 'N/A'}"),
//                 trailing: ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
//                   onPressed: () => vProvider.acceptDelivery(docs[index].id, userUid),
//                   child: const Text("Accept", style: TextStyle(color: Colors.white)),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildCompletedDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context, listen: false);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getMyDeliveries(userUid, 'completed'),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//         var docs = snapshot.data!.docs;
//         if (docs.isEmpty) return const Center(child: Text("No completed deliveries yet."));
//
//         return ListView.builder(
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             var data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               child: ListTile(
//                 leading: const Icon(Icons.verified, color: Colors.green),
//                 title: Text("Post ID: ${data['postId']}"),
//                 subtitle: const Text("Successfully Delivered"),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../provider/volunteer_provider.dart';

class VolunteerTabSection extends StatelessWidget {
  final TabController tabController;
  const VolunteerTabSection({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: AppColor.black,
          indicatorColor: AppColor.lightGreen,
          tabs: const [
            Tab(text: "Available Requests"),
            Tab(text: "My Deliveries"),
          ],
        ),
        SizedBox(
          height: 500, // Tomar screen onujayi adjust koro
          child: TabBarView(
            controller: tabController,
            children: [
              _buildAvailableRequestsTab(context),
              _buildCompletedDeliveriesTab(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableRequestsTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getAvailableRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text("No delivery requests available right now."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final String requestId = docs[index].id;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text("Food: ${data['postId'] ?? 'Unnamed Post'}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                subtitle: const Text("Need delivery for this order"),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () async {
                    try {
                      await vProvider.acceptDelivery(requestId, userUid);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Pickup Successful! Moving to 'My Deliveries'")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to accept: $e")),
                      );
                    }
                  },
                  child: const Text("Accept Pickup"),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCompletedDeliveriesTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getMyDeliveries(userUid, 'on_the_way'), // Ekhon status update hoye on_the_way
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("You haven't accepted any deliveries yet."));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              color: Colors.green.shade50,
              child: ListTile(
                leading: const Icon(Icons.delivery_dining, color: Colors.green),
                title: Text("Pickup: ${data['postId']}"),
                subtitle: const Text("Status: On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
              ),
            );
          },
        );
      },
    );
  }
}