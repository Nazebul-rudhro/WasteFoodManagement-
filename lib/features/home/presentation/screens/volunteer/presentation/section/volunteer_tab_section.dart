// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../../../../../../../core/constants/app_colors.dart';
// // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // import '../provider/volunteer_provider.dart';
// // //
// // // class VolunteerTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //
// // //   const VolunteerTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// // // }
// // //
// // // class _VolunteerTabSectionState extends State<VolunteerTabSection> {
// // //   bool _isAccepting = false; // লোডিং স্টেট ট্র্যাকিং এর জন্য
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     widget.tabController.addListener(() {
// // //       if (mounted) setState(() {});
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       mainAxisSize: MainAxisSize.min,
// // //       children: [
// // //         TabBar(
// // //           tabAlignment: TabAlignment.start,
// // //           isScrollable: true,
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: Colors.black,
// // //           indicatorColor: AppColor.green,
// // //           tabs: const [
// // //             Tab(text: "Available Requests"),
// // //             Tab(text: "My Deliveries"),
// // //             Tab(text: "Completed Deliveries"),
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //
// // //         // এখানে একটি নির্দিষ্ট হাইট দেওয়া হয়েছে যাতে লিস্টটি এর ভেতরে স্ক্রল করে
// // //         Container(
// // //           height: 400, // আপনি আপনার প্রয়োজন মতো হাইট কমাতে বা বাড়াতে পারেন
// // //           decoration: BoxDecoration(
// // //             color: Colors.grey.shade50,
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //           child: widget.tabController.index == 0
// // //               ? _buildAvailableRequestsTab(context)
// // //               : _buildMyDeliveriesTab(context),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildAvailableRequestsTab(BuildContext context) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid =
// // //         Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ??
// // //         "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: vProvider.getAvailableRequests(),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) {
// // //           return const Center(child: Text("No new requests available."));
// // //         }
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final requestData = docs[index].data() as Map<String, dynamic>;
// // //             final String requestId = docs[index].id;
// // //             final String postId = requestData['postId'] ?? "";
// // //             final String donorId = requestData['donorId'] ?? "";
// // //             final String receiverId = requestData['receiverId'] ?? "";
// // //
// // //             return Card(
// // //               margin: const EdgeInsets.only(bottom: 12),
// // //               elevation: 3,
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(12),
// // //               ),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(15),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     _fetchPostAndDonorInfo(postId, donorId),
// // //                     const Divider(height: 20),
// // //                     _fetchReceiverInfo(receiverId),
// // //                     const SizedBox(height: 15),
// // //
// // //                     // একসেপ্ট বাটন লোডিং লজিকসহ
// // //                     SizedBox(
// // //                       width: double.infinity,
// // //                       height: 45,
// // //                       child: ElevatedButton(
// // //                         style: ElevatedButton.styleFrom(
// // //                           backgroundColor: AppColor.green,
// // //                           shape: RoundedRectangleBorder(
// // //                             borderRadius: BorderRadius.circular(8),
// // //                           ),
// // //                         ),
// // //                         onPressed: _isAccepting
// // //                             ? null // লোড হওয়ার সময় বাটন ডিজেবল থাকবে
// // //                             : () async {
// // //                                 setState(
// // //                                   () => _isAccepting = true,
// // //                                 ); // লোডিং শুরু
// // //                                 try {
// // //                                   await vProvider.acceptDelivery(
// // //                                     requestId,
// // //                                     userUid,
// // //                                   );
// // //                                   ScaffoldMessenger.of(context).showSnackBar(
// // //                                     const SnackBar(
// // //                                       content: Text(
// // //                                         "Delivery Accepted Successfully!",
// // //                                       ),
// // //                                     ),
// // //                                   );
// // //                                 } catch (e) {
// // //                                   debugPrint(e.toString());
// // //                                 } finally {
// // //                                   if (mounted)
// // //                                     setState(
// // //                                       () => _isAccepting = false,
// // //                                     ); // লোডিং শেষ
// // //                                 }
// // //                               },
// // //                         child: _isAccepting
// // //                             ? const SizedBox(
// // //                                 height: 20,
// // //                                 width: 20,
// // //                                 child: CircularProgressIndicator(
// // //                                   color: Colors.white,
// // //                                   strokeWidth: 2,
// // //                                 ),
// // //                               )
// // //                             : const Text(
// // //                                 "Accept Pickup",
// // //                                 style: TextStyle(color: Colors.white),
// // //                               ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // পোস্ট ও ডোনর তথ্য আগের মতোই
// // //   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading post...");
// // //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text(
// // //               "Food: ${post['foodName'] ?? 'N/A'}",
// // //               style: const TextStyle(
// // //                 fontWeight: FontWeight.bold,
// // //                 fontSize: 16,
// // //                 color: Colors.green,
// // //               ),
// // //             ),
// // //             Text("pickupTime: ${post['pickupTime'] ?? 'N/A'}"),
// // //             Text(
// // //               "Location: ${post['pickupAddress'] ?? 'Manual Address'}",
// // //               style: const TextStyle(color: Colors.redAccent),
// // //             ),
// // //             FutureBuilder<DocumentSnapshot>(
// // //               future: FirebaseFirestore.instance
// // //                   .collection('accounts')
// // //                   .doc(donorId)
// // //                   .get(),
// // //               builder: (context, accSnap) {
// // //                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
// // //                 return Column(
// // //                   mainAxisAlignment: MainAxisAlignment.start,
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       "Donor: ${donor?['profile']?['contactPerson'] ?? '...'}",
// // //                       style: const TextStyle(fontWeight: FontWeight.w600),
// // //                     ),
// // //                     Text(
// // //                       "Phone: ${donor?['profile']?['phone'] ?? '...'}",
// // //                       style: const TextStyle(fontWeight: FontWeight.w600),
// // //                     ),
// // //                   ],
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _fetchReceiverInfo(String receiverId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance
// // //           .collection('accounts')
// // //           .doc(receiverId)
// // //           .get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading receiver...");
// // //         final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         final profile = user['profile'] ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const Text(
// // //               "Deliver To:",
// // //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
// // //             ),
// // //             Text("Name: ${profile['contactPerson'] ?? 'N/A'}"),
// // //             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
// // //             Text("Address: ${profile['address'] ?? 'N/A'}"),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // Widget _buildMyDeliveriesTab(BuildContext context) {
// // //   //   final vProvider = Provider.of<VolunteerProvider>(context);
// // //   //   final userUid =
// // //   //       Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ??
// // //   //       "";
// // //   //
// // //   //   return StreamBuilder<QuerySnapshot>(
// // //   //     stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
// // //   //     builder: (context, snapshot) {
// // //   //       if (snapshot.connectionState == ConnectionState.waiting)
// // //   //         return const Center(child: CircularProgressIndicator());
// // //   //       final docs = snapshot.data!.docs ?? [];
// // //   //       if (docs.isEmpty)
// // //   //         return const Center(child: Text("No ongoing deliveries."));
// // //   //
// // //   //       return ListView.builder(
// // //   //         padding: const EdgeInsets.all(10),
// // //   //         itemCount: docs.length,
// // //   //         itemBuilder: (context, index) {
// // //   //           final data = docs[index].data() as Map<String, dynamic>;
// // //   //           return Card(
// // //   //             child: ListTile(
// // //   //               leading: const Icon(Icons.delivery_dining, color: Colors.green),
// // //   //               title: Text("Post ID: ${data['postId']}"),
// // //   //               subtitle: const Text(
// // //   //                 "Status: On the Way",
// // //   //                 style: TextStyle(color: Colors.orange),
// // //   //               ),
// // //   //             ),
// // //   //           );
// // //   //         },
// // //   //       );
// // //   //     },
// // //   //   );
// // //   // }
// // //
// // //
// // //   Widget _buildMyDeliveriesTab(BuildContext context) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return const Center(child: CircularProgressIndicator());
// // //         }
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) {
// // //           return const Center(child: Text("No ongoing deliveries."));
// // //         }
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             final String requestId = docs[index].id;
// // //             final String receiverId = data['receiverId'] ?? "";
// // //
// // //             return Card(
// // //               elevation: 3,
// // //               margin: const EdgeInsets.only(bottom: 10),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(12.0),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Row(
// // //                       children: [
// // //                         const Icon(Icons.delivery_dining, color: Colors.green),
// // //                         const SizedBox(width: 10),
// // //                         Expanded(
// // //                           child: Text(
// // //                             "Post ID: ${data['postId']}",
// // //                             style: const TextStyle(fontWeight: FontWeight.bold),
// // //                           ),
// // //                         ),
// // //                         const Text(
// // //                           "On the Way",
// // //                           style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     const Divider(),
// // //
// // //                     // রিসিভারের নাম দেখানোর জন্য FutureBuilder
// // //                     FutureBuilder<DocumentSnapshot>(
// // //                       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// // //                       builder: (context, accSnap) {
// // //                         if (!accSnap.hasData) return const Text("Loading Receiver Name...");
// // //                         final userData = accSnap.data!.data() as Map<String, dynamic>?;
// // //                         final String receiverName = userData?['profile']?['name'] ?? "Unknown";
// // //
// // //                         return Text(
// // //                           "Receiver: $receiverName",
// // //                           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
// // //                         );
// // //                       },
// // //                     ),
// // //
// // //                     const SizedBox(height: 15),
// // //
// // //                     // Complete Delivery Button
// // //                     SizedBox(
// // //                       width: double.infinity,
// // //                       child: ElevatedButton.icon(
// // //                         style: ElevatedButton.styleFrom(
// // //                           backgroundColor: Colors.blue, // কমপ্লিট বাটন নীল বা সবুজ দিতে পারেন
// // //                           foregroundColor: Colors.white,
// // //                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
// // //                         ),
// // //                         onPressed: () async {
// // //                           // কনফার্মেশন ডায়ালগ চাইলে দিতে পারেন
// // //                           await vProvider.completeDelivery(requestId);
// // //                           ScaffoldMessenger.of(context).showSnackBar(
// // //                             const SnackBar(content: Text("Delivery Completed!")),
// // //                           );
// // //                         },
// // //                         icon: const Icon(Icons.check_circle_outline),
// // //                         label: const Text("Complete Delivery"),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //
// // //
// // //
// // // }
// //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import '../../../../../../../core/constants/app_colors.dart';
// // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // import '../provider/volunteer_provider.dart';
// // //
// // // class VolunteerTabSection extends StatefulWidget {
// // //   final TabController tabController;
// // //   const VolunteerTabSection({super.key, required this.tabController});
// // //
// // //   @override
// // //   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// // // }
// // //
// // // class _VolunteerTabSectionState extends State<VolunteerTabSection> {
// // //   bool _isAccepting = false;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     widget.tabController.addListener(() {
// // //       if (mounted) setState(() {});
// // //     });
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       mainAxisSize: MainAxisSize.min,
// // //       children: [
// // //         TabBar(
// // //           tabAlignment: TabAlignment.start,
// // //           isScrollable: true,
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: Colors.black,
// // //           indicatorColor: AppColor.green,
// // //           tabs: const [
// // //             Tab(text: "Available Requests"),
// // //             Tab(text: "My Deliveries"),
// // //             Tab(text: "Completed"), // ৩য় ট্যাব যোগ করা হয়েছে
// // //           ],
// // //         ),
// // //         const SizedBox(height: 10),
// // //
// // //         Container(
// // //           height: 400,
// // //           decoration: BoxDecoration(
// // //             color: Colors.grey.shade50,
// // //             borderRadius: BorderRadius.circular(10),
// // //           ),
// // //           child: widget.tabController.index == 0
// // //               ? _buildAvailableRequestsTab(context)
// // //               : widget.tabController.index == 1
// // //               ? _buildMyDeliveriesTab(context)
// // //               : _buildCompletedDeliveriesTab(context), // ৩য় ট্যাবের জন্য কল
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ১: এভেইলেবল রিকোয়েস্ট ---
// // //   Widget _buildAvailableRequestsTab(BuildContext context) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: vProvider.getAvailableRequests(),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No new requests available."));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             return Card(
// // //               margin: const EdgeInsets.only(bottom: 12),
// // //               elevation: 3,
// // //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(15),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
// // //                     const Divider(height: 20),
// // //                     _fetchReceiverInfo(data['receiverId'] ?? ""),
// // //                     const SizedBox(height: 15),
// // //                     SizedBox(
// // //                       width: double.infinity,
// // //                       height: 45,
// // //                       child: ElevatedButton(
// // //                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
// // //                         onPressed: _isAccepting ? null : () async {
// // //                           setState(() => _isAccepting = true);
// // //                           try {
// // //                             await vProvider.acceptDelivery(docs[index].id, userUid);
// // //                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
// // //                           } catch (e) {
// // //                             debugPrint(e.toString());
// // //                           } finally {
// // //                             if (mounted) setState(() => _isAccepting = false);
// // //                           }
// // //                         },
// // //                         child: _isAccepting
// // //                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// // //                             : const Text("Accept Pickup", style: TextStyle(color: Colors.white)),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ২: অনগোয়িং ডেলিভারি (On the Way) ---
// // //   Widget _buildMyDeliveriesTab(BuildContext context) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No ongoing deliveries."));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             final String requestId = docs[index].id;
// // //
// // //             return Card(
// // //               elevation: 3,
// // //               margin: const EdgeInsets.only(bottom: 10),
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(12.0),
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Row(
// // //                       children: [
// // //                         const Icon(Icons.delivery_dining, color: Colors.green),
// // //                         const SizedBox(width: 10),
// // //                         Expanded(child: Text("Post ID: ${data['postId']}", style: const TextStyle(fontWeight: FontWeight.bold))),
// // //                         const Text("On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
// // //                       ],
// // //                     ),
// // //                     const Divider(),
// // //                     _fetchReceiverInfo(data['receiverId'] ?? ""), // রিসিভারের নাম-ফোন দেখাবে
// // //                     const SizedBox(height: 15),
// // //                     SizedBox(
// // //                       width: double.infinity,
// // //                       child: ElevatedButton.icon(
// // //                         style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
// // //                         onPressed: () async {
// // //                           await vProvider.completeDelivery(requestId);
// // //                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
// // //                         },
// // //                         icon: const Icon(Icons.check_circle_outline),
// // //                         label: const Text("Complete Delivery"),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- ট্যাব ৩: কমপ্লিটেড ডেলিভারি ---
// // //   Widget _buildCompletedDeliveriesTab(BuildContext context) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: vProvider.getCompletedDeliveries(userUid),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No completed deliveries yet."));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(10),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             return Card(
// // //               margin: const EdgeInsets.only(bottom: 8),
// // //               color: Colors.green.shade50,
// // //               child: ListTile(
// // //                 leading: const Icon(Icons.done_all, color: Colors.green),
// // //                 title: Text("Food: ${data['postId']}"),
// // //                 subtitle: const Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
// // //               ),
// // //             );
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   // --- ডাটা ফেচিং হেল্পার মেথডস ---
// // //   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading post...");
// // //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
// // //             Text("Time: ${post['pickupTime'] ?? 'N/A'}"),
// // //             Text("Location: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent)),
// // //             FutureBuilder<DocumentSnapshot>(
// // //               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
// // //               builder: (context, accSnap) {
// // //                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
// // //                 return Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start, // গ্যাপ ঠিক করার জন্য
// // //                   children: [
// // //                     Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
// // //                     Text("Phone: ${donor?['profile']?['phone'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
// // //                   ],
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _fetchReceiverInfo(String receiverId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading receiver...");
// // //         final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         final profile = user['profile'] ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const Text("Deliver To:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// // //             Text("Name: ${profile['contactPerson'] ?? 'N/A'}"),
// // //             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
// // //             Text("Address: ${profile['address'] ?? 'N/A'}"),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../../../../../../../core/constants/app_colors.dart';
// // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // import '../provider/volunteer_provider.dart';
// //
// // class VolunteerTabSection extends StatefulWidget {
// //   final TabController tabController;
// //   const VolunteerTabSection({super.key, required this.tabController});
// //
// //   @override
// //   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// // }
// //
// // class _VolunteerTabSectionState extends State<VolunteerTabSection> {
// //   bool _isAccepting = false;
// //   bool _isCompleting = false; // কমপ্লিট বাটনের জন্য নতুন লোডিং স্টেট
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     widget.tabController.addListener(() {
// //       if (mounted) setState(() {});
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         TabBar(
// //           tabAlignment: TabAlignment.start,
// //           isScrollable: true,
// //           controller: widget.tabController,
// //           labelColor: AppColor.green,
// //           unselectedLabelColor: Colors.black,
// //           indicatorColor: AppColor.green,
// //           tabs: const [
// //             Tab(text: "Available Requests"),
// //             Tab(text: "My Deliveries"),
// //             Tab(text: "Completed"),
// //           ],
// //         ),
// //         const SizedBox(height: 10),
// //
// //         Container(
// //           height: 400,
// //           decoration: BoxDecoration(
// //             color: Colors.grey.shade50,
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           child: widget.tabController.index == 0
// //               ? _buildAvailableRequestsTab(context)
// //               : widget.tabController.index == 1
// //               ? _buildMyDeliveriesTab(context)
// //               : _buildCompletedDeliveriesTab(context),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   // --- ট্যাব ১: এভেইলেবল রিকোয়েস্ট ---
// //   Widget _buildAvailableRequestsTab(BuildContext context) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: vProvider.getAvailableRequests(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// //         final docs = snapshot.data?.docs ?? [];
// //         if (docs.isEmpty) return const Center(child: Text("No new requests available."));
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(10),
// //           itemCount: docs.length,
// //           itemBuilder: (context, index) {
// //             final data = docs[index].data() as Map<String, dynamic>;
// //             return Card(
// //               margin: const EdgeInsets.only(bottom: 12),
// //               elevation: 3,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(15),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
// //                     const Divider(height: 20),
// //                     _fetchReceiverInfo(data['receiverId'] ?? ""),
// //                     const SizedBox(height: 15),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       height: 45,
// //                       child: ElevatedButton(
// //                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
// //                         onPressed: _isAccepting ? null : () async {
// //                           setState(() => _isAccepting = true);
// //                           try {
// //                             await vProvider.acceptDelivery(docs[index].id, userUid);
// //                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
// //                           } catch (e) {
// //                             debugPrint(e.toString());
// //                           } finally {
// //                             if (mounted) setState(() => _isAccepting = false);
// //                           }
// //                         },
// //                         child: _isAccepting
// //                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //                             : const Text("Accept Pickup", style: TextStyle(color: Colors.white)),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // --- ট্যাব ২: অনগোয়িং ডেলিভারি (লোডিং ফিক্স করা হয়েছে) ---
// //   Widget _buildMyDeliveriesTab(BuildContext context) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// //         final docs = snapshot.data?.docs ?? [];
// //         if (docs.isEmpty) return const Center(child: Text("No ongoing deliveries."));
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(10),
// //           itemCount: docs.length,
// //           itemBuilder: (context, index) {
// //             final data = docs[index].data() as Map<String, dynamic>;
// //             final String requestId = docs[index].id;
// //
// //             return Card(
// //               elevation: 3,
// //               margin: const EdgeInsets.only(bottom: 10),
// //               child: Padding(
// //                 padding: const EdgeInsets.all(12.0),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         const Icon(Icons.delivery_dining, color: Colors.green),
// //                         const SizedBox(width: 10),
// //                         Expanded(child: Text("Post ID: ${data['postId']}", style: const TextStyle(fontWeight: FontWeight.bold))),
// //                         const Text("On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
// //                       ],
// //                     ),
// //                     const Divider(),
// //                     _fetchReceiverInfo(data['receiverId'] ?? ""),
// //                     const SizedBox(height: 15),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       height: 45,
// //                       child: ElevatedButton(
// //                         style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
// //                         onPressed: _isCompleting ? null : () async {
// //                           setState(() => _isCompleting = true); // এখানে লোডিং শুরু
// //                           try {
// //                             await vProvider.completeDelivery(requestId);
// //                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
// //                           } catch (e) {
// //                             debugPrint(e.toString());
// //                           } finally {
// //                             if (mounted) setState(() => _isCompleting = false); // এখানে লোডিং শেষ
// //                           }
// //                         },
// //                         child: _isCompleting
// //                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //                             : const Text("Complete Delivery"),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // --- ট্যাব ৩: কমপ্লিটেড ডেলিভারি ---
// //   Widget _buildCompletedDeliveriesTab(BuildContext context) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: vProvider.getCompletedDeliveries(userUid),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// //         final docs = snapshot.data?.docs ?? [];
// //         if (docs.isEmpty) return const Center(child: Text("No completed deliveries yet."));
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(10),
// //           itemCount: docs.length,
// //           itemBuilder: (context, index) {
// //             final data = docs[index].data() as Map<String, dynamic>;
// //             return Card(
// //               margin: const EdgeInsets.only(bottom: 8),
// //               color: Colors.green.shade50,
// //               child: ListTile(
// //                 leading: const Icon(Icons.done_all, color: Colors.green),
// //                 title: Text("Food: ${data['postId']}"),
// //                 subtitle: const Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // --- ডাটা ফেচিং হেল্পার মেথডস ---
// //   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const Text("Loading post...");
// //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
// //             Text("Time: ${post['pickupTime'] ?? 'N/A'}"),
// //             Text("Location: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent)),
// //             FutureBuilder<DocumentSnapshot>(
// //               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
// //               builder: (context, accSnap) {
// //                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
// //                 return Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
// //                     Text("Phone: ${donor?['profile']?['phone'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
// //                   ],
// //                 );
// //               },
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _fetchReceiverInfo(String receiverId) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const Text("Loading receiver...");
// //         final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// //         final profile = user['profile'] ?? {};
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const Text("Deliver To:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// //             Text("Name: ${profile['contactPerson'] ?? 'N/A'}"),
// //             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
// //             Text("Address: ${profile['address'] ?? 'N/A'}"),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
//
//
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
//   // লোডিং ট্র্যাক করার জন্য রিকোয়েস্ট আইডি ব্যবহার করছি
//   String? _loadingRequestId;
//   bool _isAccepting = false;
//
//   @override
//   void initState() {
//     super.initState();
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
//           tabAlignment: TabAlignment.start,
//           isScrollable: true,
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: Colors.black,
//           indicatorColor: AppColor.green,
//           tabs: const [
//             Tab(text: "Available Requests"),
//             Tab(text: "My Deliveries"),
//             Tab(text: "Completed"),
//           ],
//         ),
//         const SizedBox(height: 10),
//
//         Container(
//           height: 400,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: widget.tabController.index == 0
//               ? _buildAvailableRequestsTab(context)
//               : widget.tabController.index == 1
//               ? _buildMyDeliveriesTab(context)
//               : _buildCompletedDeliveriesTab(context),
//         ),
//       ],
//     );
//   }
//
//   // --- ট্যাব ১: এভেইলেবল রিকোয়েস্ট ---
//   Widget _buildAvailableRequestsTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getAvailableRequests(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No new requests available."));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             final String currentId = docs[index].id;
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
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const Divider(height: 20),
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
//                         onPressed: (_isAccepting) ? null : () async {
//                           setState(() => _isAccepting = true);
//                           try {
//                             await vProvider.acceptDelivery(currentId, userUid);
//                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
//                           } finally {
//                             if (mounted) setState(() => _isAccepting = false);
//                           }
//                         },
//                         child: _isAccepting
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Accept Pickup", style: TextStyle(color: Colors.white)),
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
//   // --- ট্যাব ২: অনগোয়িং ডেলিভারি (লোডিং ফিক্সড) ---
//   Widget _buildMyDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No ongoing deliveries."));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             final String requestId = docs[index].id;
//
//             // চেক করছি এই নির্দিষ্ট কার্ডটি লোডিং অবস্থায় আছে কি না
//             bool isLoading = _loadingRequestId == requestId;
//
//             return Card(
//               elevation: 3,
//               margin: const EdgeInsets.only(bottom: 10),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.delivery_dining, color: Colors.green),
//                         const SizedBox(width: 10),
//                         Expanded(child: Text("Post ID: ${data['postId']}", style: const TextStyle(fontWeight: FontWeight.bold))),
//                         const Text("On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
//                       ],
//                     ),
//                     const Divider(),
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
//                         onPressed: isLoading ? null : () async {
//                           setState(() => _loadingRequestId = requestId); // এই কার্ডের জন্য লোডিং শুরু
//                           try {
//                             await vProvider.completeDelivery(requestId);
//                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
//                           } finally {
//                             if (mounted) setState(() => _loadingRequestId = null); // লোডিং শেষ
//                           }
//                         },
//                         child: isLoading
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Complete Delivery"),
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
//   // --- ট্যাব ৩: কমপ্লিটেড ডেলিভারি ---
//   Widget _buildCompletedDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getCompletedDeliveries(userUid),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No completed deliveries yet."));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               margin: const EdgeInsets.only(bottom: 8),
//               color: Colors.green.shade50,
//               child: ListTile(
//                 leading: const Icon(Icons.done_all, color: Colors.green),
//                 title: Text("Food: ${data['postId']}"),
//                 subtitle: const Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   // --- হেল্পার মেথডস (পোস্ট এবং ডোনর ইনফো) ---
//   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading post...");
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
//             Text("Time: ${post['pickupTime'] ?? 'N/A'}"),
//             Text("Location: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent)),
//             FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
//               builder: (context, accSnap) {
//                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
//                     Text("Phone: ${donor?['profile']?['phone'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w600)),
//                   ],
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _fetchReceiverInfo(String receiverId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading receiver...");
//         final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         final profile = user['profile'] ?? {};
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Deliver To:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
//             Text("Name: ${profile['contactPerson'] ?? 'N/A'}"),
//             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
//             Text("Address: ${profile['address'] ?? 'N/A'}"),
//           ],
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
  String? _loadingRequestId; // নির্দিষ্ট কার্ডের লোডিং ট্র্যাক করার জন্য
  bool _isAccepting = false; // ১ম ট্যাবের জন্য

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
            Tab(text: "Completed"),
          ],
        ),
        const SizedBox(height: 10),

        Container(
          height: 450, // একটু বাড়িয়ে দিলাম যাতে সব তথ্য ধরে
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.tabController.index == 0
              ? _buildAvailableRequestsTab(context)
              : widget.tabController.index == 1
              ? _buildMyDeliveriesTab(context)
              : _buildCompletedDeliveriesTab(context),
        ),
      ],
    );
  }

  // --- ট্যাব ১: Available Requests ---
  Widget _buildAvailableRequestsTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getAvailableRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("No new requests available."));

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final String currentId = docs[index].id;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
                    const Divider(height: 20),
                    _fetchReceiverInfo(data['receiverId'] ?? ""),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
                        onPressed: _isAccepting ? null : () async {
                          setState(() => _isAccepting = true);
                          try {
                            await vProvider.acceptDelivery(currentId, userUid);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
                          } finally {
                            if (mounted) setState(() => _isAccepting = false);
                          }
                        },
                        child: _isAccepting
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text("Accept Pickup", style: TextStyle(color: Colors.white)),
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

  // --- ট্যাব ২: My Deliveries (On the Way) ---
  Widget _buildMyDeliveriesTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getMyDeliveries(userUid, 'on_the_way'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("No ongoing deliveries."));

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final String requestId = docs[index].id;
            bool isLoading = _loadingRequestId == requestId;

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 10),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.delivery_dining, color: Colors.green),
                        const SizedBox(width: 10),
                        Expanded(child: Text("Post ID: ${data['postId']}", style: const TextStyle(fontWeight: FontWeight.bold))),
                        const Text("On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const Divider(),
                    _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
                    const SizedBox(height: 10),
                    _fetchReceiverInfo(data['receiverId'] ?? ""),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        onPressed: isLoading ? null : () async {
                          setState(() => _loadingRequestId = requestId);
                          try {
                            await vProvider.completeDelivery(requestId);
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
                          } finally {
                            if (mounted) setState(() => _loadingRequestId = null);
                          }
                        },
                        child: isLoading
                            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Text("Complete Delivery"),
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

  // --- ট্যাব ৩: Completed Deliveries (Food & Receiver Name সহ) ---
  Widget _buildCompletedDeliveriesTab(BuildContext context) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: vProvider.getCompletedDeliveries(userUid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("No completed deliveries yet."));

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 10),
                        Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(),
                    // খাবারের নাম ও ডোনর দেখাবে
                    _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
                    const SizedBox(height: 10),
                    // রিসিভারের নাম দেখাবে
                    _fetchReceiverInfo(data['receiverId'] ?? ""),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- ডাটা ফেচিং হেল্পার মেথডস ---
  Widget _fetchPostAndDonorInfo(String postId, String donorId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading food info...");
        final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
            Text("Pickup Time: ${post['pickupTime'] ?? 'N/A'}"),
            Text("Pickup Location: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
              builder: (context, accSnap) {
                final donor = accSnap.data?.data() as Map<String, dynamic>?;
                return Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w500));
              },
            ),
          ],
        );
      },
    );
  }

  Widget _fetchReceiverInfo(String receiverId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(receiverId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading receiver...");
        final user = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final profile = user['profile'] ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Deliver To:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey)),
            Text("Name: ${profile['contactPerson'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.w600)),
            Text("Phone: ${profile['phone'] ?? 'N/A'}"),
            Text("Address: ${profile['address'] ?? 'N/A'}"),
          ],
        );
      },
    );
  }
}