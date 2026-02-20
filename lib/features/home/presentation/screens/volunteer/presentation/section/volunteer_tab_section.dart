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
//   String? _loadingRequestId; // নির্দিষ্ট কার্ডের লোডিং ট্র্যাক করার জন্য
//   bool _isAccepting = false; // ১ম ট্যাবের জন্য
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
//           height: 450, // একটু বাড়িয়ে দিলাম যাতে সব তথ্য ধরে
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
//   // --- ট্যাব ১: Available Requests ---
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
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: _isAccepting ? null : () async {
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
//   // --- ট্যাব ২: My Deliveries (On the Way) ---
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
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const SizedBox(height: 10),
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: isLoading ? null : () async {
//                           setState(() => _loadingRequestId = requestId);
//                           try {
//                             await vProvider.completeDelivery(requestId);
//                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
//                           } finally {
//                             if (mounted) setState(() => _loadingRequestId = null);
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
//   // --- ট্যাব ৩: Completed Deliveries (Food & Receiver Name সহ) ---
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
//               margin: const EdgeInsets.only(bottom: 12),
//               color: Colors.white,
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: const [
//                         Icon(Icons.check_circle, color: Colors.green),
//                         SizedBox(width: 10),
//                         Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     const Divider(),
//                     // খাবারের নাম ও ডোনর দেখাবে
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const SizedBox(height: 10),
//                     // রিসিভারের নাম দেখাবে
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
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
//   // --- ডাটা ফেচিং হেল্পার মেথডস ---
//   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading food info...");
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
//             Text("Pickup Time: ${post['pickupTime'] ?? 'N/A'}"),
//             Text("Pickup Location: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
//             FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
//               builder: (context, accSnap) {
//                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
//                 return Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w500));
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
//             const Text("Deliver To:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blueGrey)),
//             Text("Name: ${profile['contactPerson'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.w600)),
//             Text("Phone: ${profile['phone'] ?? 'N/A'}"),
//             Text("Address: ${profile['address'] ?? 'N/A'}"),
//           ],
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
// class VolunteerTabSection extends StatefulWidget {
//   final TabController tabController;
//   const VolunteerTabSection({super.key, required this.tabController});
//
//   @override
//   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// }
//
// class _VolunteerTabSectionState extends State<VolunteerTabSection> {
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
//         Expanded( // Container এর বদলে Expanded ব্যবহার করা ভালো স্ক্রল ম্যানেজমেন্টের জন্য
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: TabBarView( // ট্যাব ইনডেক্স চেক করার বদলে TabBarView বেশি স্মুথ
//               controller: widget.tabController,
//               children: [
//                 _buildAvailableRequestsTab(context),
//                 _buildMyDeliveriesTab(context),
//                 _buildCompletedDeliveriesTab(context),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // --- ট্যাব ১: Available Requests ---
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
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: _isAccepting ? null : () async {
//                           setState(() => _isAccepting = true);
//                           try {
//                             await vProvider.acceptDelivery(currentId, userUid);
//                             if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
//                           } finally {
//                             if (mounted) setState(() => _isAccepting = false);
//                           }
//                         },
//                         child: _isAccepting
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Accept Pickup", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//   // --- ট্যাব ২: My Deliveries ---
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
//             bool isLoading = _loadingRequestId == requestId;
//
//             return Card(
//               elevation: 3,
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Row(
//                           children: [
//                             Icon(Icons.delivery_dining, color: Colors.green),
//                             SizedBox(width: 8),
//                             Text("Ongoing", style: TextStyle(fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(5)),
//                           child: const Text("On the Way", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
//                         ),
//                       ],
//                     ),
//                     const Divider(),
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const SizedBox(height: 10),
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: isLoading ? null : () async {
//                           setState(() => _loadingRequestId = requestId);
//                           try {
//                             await vProvider.completeDelivery(requestId);
//                             if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
//                           } finally {
//                             if (mounted) setState(() => _loadingRequestId = null);
//                           }
//                         },
//                         child: isLoading
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Mark as Completed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//   // --- ট্যাব ৩: Completed Deliveries ---
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
//               margin: const EdgeInsets.only(bottom: 12),
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.check_circle, color: Colors.green),
//                         SizedBox(width: 10),
//                         Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     const Divider(),
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const SizedBox(height: 10),
//                     _fetchReceiverInfo(data['receiverId'] ?? ""),
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
//   // --- হেল্পার মেথডস (একই থাকছে) ---
//   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading food info...");
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Food: ${post['foodName'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
//             Text("Pickup Time: ${post['pickupTime'] ?? 'N/A'}", style: const TextStyle(fontSize: 13)),
//             Text("Address: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(color: Colors.redAccent, fontSize: 13)),
//             FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('accounts').doc(donorId).get(),
//               builder: (context, accSnap) {
//                 final donor = accSnap.data?.data() as Map<String, dynamic>?;
//                 return Text("Donor: ${donor?['profile']?['contactPerson'] ?? '...'}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13));
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
//         return Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("DELIVER TO:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.blueGrey)),
//               const SizedBox(height: 5),
//               Text("Name: ${profile['contactPerson'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
//               Text("Phone: ${profile['phone'] ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
//               Text("Address: ${profile['address'] ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
//             ],
//           ),
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
// class VolunteerTabSection extends StatefulWidget {
//   final TabController tabController;
//   const VolunteerTabSection({super.key, required this.tabController});
//
//   @override
//   State<VolunteerTabSection> createState() => _VolunteerTabSectionState();
// }
//
// class _VolunteerTabSectionState extends State<VolunteerTabSection> {
//   String? _loadingRequestId;
//   bool _isAccepting = false;
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
//           unselectedLabelColor: Colors.black,
//           indicatorColor: AppColor.green,
//           tabs: const [
//             Tab(text: "Available Requests"),
//             Tab(text: "My Deliveries"),
//             Tab(text: "Completed"),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: TabBarView(
//               controller: widget.tabController,
//               children: [
//                 _buildAvailableRequestsTab(context),
//                 _buildMyDeliveriesTab(context),
//                 _buildCompletedDeliveriesTab(context),
//               ],
//             ),
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
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//         // আপনার লজিক অনুযায়ী ডাটা ফিল্টার
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
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: _isAccepting ? null : () async {
//                           setState(() => _isAccepting = true);
//                           try {
//                             await vProvider.acceptDelivery(currentId, userUid);
//                             if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Accepted!")));
//                           } finally {
//                             if (mounted) setState(() => _isAccepting = false);
//                           }
//                         },
//                         child: _isAccepting
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Accept Pickup", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//   Widget _buildMyDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getMyDeliveries(userUid),
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
//             bool isLoading = _loadingRequestId == requestId;
//
//             return Card(
//               elevation: 3,
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.delivery_dining, color: Colors.orange),
//                         SizedBox(width: 8),
//                         Text("On the Way", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
//                       ],
//                     ),
//                     const Divider(),
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
//                     const SizedBox(height: 15),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 45,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
//                         onPressed: isLoading ? null : () async {
//                           setState(() => _loadingRequestId = requestId);
//                           try {
//                             await vProvider.completeDelivery(requestId);
//                             if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delivery Completed!")));
//                           } finally {
//                             if (mounted) setState(() => _loadingRequestId = null);
//                           }
//                         },
//                         child: isLoading
//                             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//                             : const Text("Mark as Completed", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
//   Widget _buildCompletedDeliveriesTab(BuildContext context) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: vProvider.getCompletedDeliveries(userUid),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No completed deliveries."));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               elevation: 2,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     const Row(
//                       children: [
//                         Icon(Icons.check_circle, color: Colors.green),
//                         SizedBox(width: 10),
//                         Text("Delivered Successfully", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     const Divider(),
//                     _fetchPostAndDonorInfo(data['postId'] ?? "", data['donorId'] ?? ""),
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
//   // হেল্পার মেথডগুলো (আগের মতোই)
//   Widget _fetchPostAndDonorInfo(String postId, String donorId) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return const Text("Loading...");
//         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
//             Text("Address: ${post['pickupAddress'] ?? 'N/A'}", style: const TextStyle(fontSize: 13)),
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
//         if (!snapshot.hasData) return const SizedBox();
//         final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
//         return Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(8)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("DELIVER TO:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
//               Text("${profile['contactPerson'] ?? 'N/A'}", style: const TextStyle(fontWeight: FontWeight.w600)),
//               Text("${profile['address'] ?? 'N/A'}", style: const TextStyle(fontSize: 12)),
//             ],
//           ),
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
  String? _loadingRequestId;
  bool _isAccepting = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: Colors.black54,
          indicatorColor: AppColor.green,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: "Available Requests"),
            Tab(text: "Ongoing"),
            Tab(text: "Completed"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [
              _buildList(context, 0),
              _buildList(context, 1),
              _buildList(context, 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(BuildContext context, int tabIndex) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";

    Stream<QuerySnapshot> stream = tabIndex == 0
        ? vProvider.getAvailableRequests()
        : tabIndex == 1 ? vProvider.getMyDeliveries(userUid) : vProvider.getCompletedDeliveries(userUid);

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("No data found"));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            return _buildRequestCard(data, docs[index].id, tabIndex, vProvider, userUid);
          },
        );
      },
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, String uid) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          // Header Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: tab == 0 ? Colors.blue.shade50 : tab == 1 ? Colors.orange.shade50 : Colors.green.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order #${reqId.substring(0, 5)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text(tab == 0 ? "NEW" : tab == 1 ? "ON THE WAY" : "DELIVERED",
                    style: TextStyle(color: tab == 0 ? Colors.blue : tab == 1 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Food Info
                _fetchFoodHeader(data['postId']),
                const Divider(height: 30),

                // 2. Donor Section (Pickup)
                _buildContactInfo("PICKUP FROM (DONOR)", data['donorId'], Icons.location_on, Colors.redAccent),
                const SizedBox(height: 20),

                // 3. Receiver Section (Deliver)
                _buildContactInfo("DELIVER TO (RECEIVER)", data['receiverId'], Icons.near_me, Colors.blue),

                if (tab != 2) ...[
                  const SizedBox(height: 20),
                  _buildButton(tab, reqId, vProvider, uid),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fetchFoodHeader(String postId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("Loading food...");
        final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.fastfood, color: AppColor.green),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _badge(Icons.shopping_bag, "Qty: ${post['quantity'] ?? 'N/A'}", Colors.orange),
                      const SizedBox(width: 8),
                      _badge(Icons.timer, post['pickupTime'] ?? 'ASAP', Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactInfo(String label, String userId, IconData icon, Color themeColor) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(userId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Text("...");
        final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: themeColor),
                const SizedBox(width: 8),
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: themeColor, letterSpacing: 1)),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profile['contactPerson'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(profile['phone'] ?? 'N/A', style: const TextStyle(color: Colors.black87, fontSize: 13)),
                  Text(profile['address'] ?? 'N/A', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _badge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildButton(int tab, String id, VolunteerProvider vp, String uid) {
    bool loading = (tab == 0 && _isAccepting) || (tab == 1 && _loadingRequestId == id);
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        onPressed: loading ? null : () async {
          setState(() => tab == 0 ? _isAccepting = true : _loadingRequestId = id);
          try {
            tab == 0 ? await vp.acceptDelivery(id, uid) : await vp.completeDelivery(id);
          } finally {
            if (mounted) setState(() { _isAccepting = false; _loadingRequestId = null; });
          }
        },
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(tab == 0 ? "ACCEPT PICKUP" : "MARK AS DELIVERED",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}