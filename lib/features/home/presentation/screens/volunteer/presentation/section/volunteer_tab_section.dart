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
//
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
//             Tab(text: "Available Requests"),
//             Tab(text: "My Deliveries"),
//           ],
//         ),
//         SizedBox(
//           height: 500, // Tomar screen onujayi adjust koro
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
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getAvailableRequests(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return const Center(child: Text("No delivery requests available right now."));
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             final String requestId = docs[index].id;
//
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               elevation: 3,
//               child: ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 title: Text("Food: ${data['postId'] ?? 'Unnamed Post'}",
//                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 subtitle: const Text("Need delivery for this order"),
//                 trailing: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.green,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: () async {
//                     try {
//                       await vProvider.acceptDelivery(requestId, userUid);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Pickup Successful! Moving to 'My Deliveries'")),
//                       );
//                     } catch (e) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text("Failed to accept: $e")),
//                       );
//                     }
//                   },
//                   child: const Text("Accept Pickup"),
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
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'), // Ekhon status update hoye on_the_way
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("You haven't accepted any deliveries yet."));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               color: Colors.green.shade50,
//               child: ListTile(
//                 leading: const Icon(Icons.delivery_dining, color: Colors.green),
//                 title: Text("Pickup: ${data['postId']}"),
//                 subtitle: const Text("Status: On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../provider/volunteer_provider.dart';
//
// class VolunteerTabSection extends StatefulWidget {
//   final TabController tabController;
//   const VolunteerTabSection({super.key, required this.tabController});
//
//   @override
//   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// }
//
// class _VolunteerTabSectionState extends State<VolunteerTabSection> {
//   @override
//   void initState() {
//     super.initState();
//     // ট্যাব পরিবর্তন হলে যাতে ইউআই রিফ্রেশ হয়
//     widget.tabController.addListener(() {
//       if (mounted) setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: Colors.black,
//           indicatorColor: AppColor.green,
//           tabs: const [
//             Tab(text: "Available Requests"),
//             Tab(text: "My Deliveries"),
//           ],
//         ),
//         const SizedBox(height: 10),
//         // TabBarView এর বদলে সরাসরি কন্ডিশন ব্যবহার করা হয়েছে লেআউট এরর এড়াতে
//         widget.tabController.index == 0
//             ? _buildAvailableRequestsTab(context)
//             : _buildMyDeliveriesTab(context),
//       ],
//     );
//   }
//
//   Widget _buildAvailableRequestsTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getAvailableRequests(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return const Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Text("No new requests available."),
//           );
//         }
//
//         return ListView.builder(
//           shrinkWrap: true, // এটি লিস্টকে কন্টেন্ট অনুযায়ী হাইট নিতে দেয়
//           physics: const NeverScrollableScrollPhysics(), // হোম স্ক্রিনে স্ক্রলবার থাকায় এটি বন্ধ
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final requestData = docs[index].data() as Map<String, dynamic>;
//             final String requestId = docs[index].id;
//             final String postId = requestData['postId'] ?? "";
//             final String donorId = requestData['donorId'] ?? "";
//             final String receiverId = requestData['receiverId'] ?? "";
//
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               elevation: 3,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ডোনর এবং পোস্টের ডিটেইলস (Food Name, Pickup Time, Location)
//                     _fetchPostAndDonorInfo(postId, donorId),
//                     const Divider(height: 20),
//                     // রিসিভারের ডিটেইলস (Name, Phone, Address)
//                     _fetchReceiverInfo(receiverId),
//                     const SizedBox(height: 15),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.green,
//                         minimumSize: const Size(double.infinity, 45),
//                       ),
//                       onPressed: () => vProvider.acceptDelivery(requestId, userUid),
//                       child: const Text("Accept Pickup", style: TextStyle(color: Colors.white)),
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
//   // ডোনর এবং পোস্ট কালেকশন থেকে ডাটা ফেচিং
//   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading post...");
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Food: ${post['foodName'] ?? 'N/A'}",
//                 style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
//             Text("Pickup Time: ${post['pickupTime'] ?? 'N/A'}"),
//             Text("Pickup Location: ${post['location'] ?? 'Manual Address'}",
//                 style: const TextStyle(color: Colors.redAccent)),
//
//             FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
//               builder: (context, accSnap) {
//                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
//                 return Text("Donor: ${donor?['profile']?['name'] ?? '...'}",
//                     style: const TextStyle(fontWeight: FontWeight.w600));
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   // রিসিভারের একাউন্ট থেকে ডাটা ফেচিং
//   Widget _fetchReceiverInfo(String receiverId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading receiver...");
//         final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         final profile = user['profile'] ?? {};
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Deliver To (Receiver):", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//             Text("Name: ${profile['name'] ?? 'N/A'}"),
//             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
//             Text("Address: ${profile['location'] ?? 'N/A'}"),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildMyDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
//         final docs = snapshot.data!.docs;
//         if (docs.isEmpty) return const Padding(padding: EdgeInsets.all(20), child: Text("No ongoing deliveries."));
//
//         return ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               child: ListTile(
//                 leading: const Icon(Icons.delivery_dining, color: Colors.green),
//                 title: Text("Food Post: ${data['postId']}"),
//                 subtitle: const Text("Status: On the Way", style: TextStyle(color: Colors.orange)),
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

class VolunteerTabSection extends StatefulWidget {
  final TabController tabController;

  const VolunteerTabSection({super.key, required this.tabController});

  @override
  State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
}

class _VolunteerTabSectionState extends State<VolunteerTabSection> {
  bool _isAccepting = false; // লোডিং স্টেট ট্র্যাকিং এর জন্য

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: widget.tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: Colors.black,
          indicatorColor: AppColor.green,
          tabs: const [
            Tab(text: "Available Requests"),
            Tab(text: "My Deliveries"),
          ],
        ),
        const SizedBox(height: 10),

        // এখানে একটি নির্দিষ্ট হাইট দেওয়া হয়েছে যাতে লিস্টটি এর ভেতরে স্ক্রল করে
        Container(
          height: 400, // আপনি আপনার প্রয়োজন মতো হাইট কমাতে বা বাড়াতে পারেন
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.tabController.index == 0
              ? _buildAvailableRequestsTab(context)
              : _buildMyDeliveriesTab(context),
        ),
      ],
    );
  }

  Widget _buildAvailableRequestsTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid =
        Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ??
        "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getAvailableRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text("No new requests available."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final requestData = docs[index].data() as Map<String, dynamic>;
            final String requestId = docs[index].id;
            final String postId = requestData['postId'] ?? "";
            final String donorId = requestData['donorId'] ?? "";
            final String receiverId = requestData['receiverId'] ?? "";

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fetchPostAndDonorInfo(postId, donorId),
                    const Divider(height: 20),
                    _fetchReceiverInfo(receiverId),
                    const SizedBox(height: 15),

                    // একসেপ্ট বাটন লোডিং লজিকসহ
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isAccepting
                            ? null // লোড হওয়ার সময় বাটন ডিজেবল থাকবে
                            : () async {
                                setState(
                                  () => _isAccepting = true,
                                ); // লোডিং শুরু
                                try {
                                  await vProvider.acceptDelivery(
                                    requestId,
                                    userUid,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Delivery Accepted Successfully!",
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  debugPrint(e.toString());
                                } finally {
                                  if (mounted)
                                    setState(
                                      () => _isAccepting = false,
                                    ); // লোডিং শেষ
                                }
                              },
                        child: _isAccepting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Accept Pickup",
                                style: TextStyle(color: Colors.white),
                              ),
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

  // পোস্ট ও ডোনর তথ্য আগের মতোই
  Widget _fetchPostAndDonorInfo(String postId, String donorId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading post...");
        final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Food: ${post['foodName'] ?? 'N/A'}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            Text("pickupTime: ${post['pickupTime'] ?? 'N/A'}"),
            Text(
              "Location: ${post['pickupAddress'] ?? 'Manual Address'}",
              style: const TextStyle(color: Colors.redAccent),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('accounts')
                  .doc(donorId)
                  .get(),
              builder: (context, accSnap) {
                final donor = accSnap.data?.data() as Map<String, dynamic>?;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Donor: ${donor?['profile']?['contactPerson'] ?? '...'}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Phone: ${donor?['profile']?['phone'] ?? '...'}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _fetchReceiverInfo(String receiverId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('accounts')
          .doc(receiverId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading receiver...");
        final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final profile = user['profile'] ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Deliver To:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text("Name: ${profile['contactPerson'] ?? 'N/A'}"),
            Text("Phone: ${profile['phone'] ?? 'N/A'}"),
            Text("Address: ${profile['address'] ?? 'N/A'}"),
          ],
        );
      },
    );
  }

  Widget _buildMyDeliveriesTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid =
        Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ??
        "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs ?? [];
        if (docs.isEmpty)
          return const Center(child: Text("No ongoing deliveries."));

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              child: ListTile(
                leading: const Icon(Icons.delivery_dining, color: Colors.green),
                title: Text("Post ID: ${data['postId']}"),
                subtitle: const Text(
                  "Status: On the Way",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
