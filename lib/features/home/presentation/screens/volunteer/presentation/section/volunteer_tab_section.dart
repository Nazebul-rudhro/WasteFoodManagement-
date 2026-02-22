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
// // //   String? _loadingRequestId;
// // //   bool _isAccepting = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: Colors.black54,
// // //           indicatorColor: AppColor.green,
// // //           isScrollable: true,
// // //           tabAlignment: TabAlignment.start,
// // //           tabs: const [
// // //             Tab(text: "Available Requests"),
// // //             Tab(text: "Ongoing"),
// // //             Tab(text: "Completed"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildList(context, 0),
// // //               _buildList(context, 1),
// // //               _buildList(context, 2),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildList(BuildContext context, int tabIndex) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final userUid = Provider.of<GenericAuthProvider>(context, listen: false).user?.uid ?? "";
// // //
// // //     Stream<QuerySnapshot> stream = tabIndex == 0
// // //         ? vProvider.getAvailableRequests()
// // //         : tabIndex == 1 ? vProvider.getMyDeliveries(userUid) : vProvider.getCompletedDeliveries(userUid);
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: stream,
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No data found"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             return _buildRequestCard(data, docs[index].id, tabIndex, vProvider, userUid);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, String uid) {
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 16),
// // //       elevation: 4,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: Column(
// // //         children: [
// // //           // Header Status
// // //           Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
// // //             decoration: BoxDecoration(
// // //               color: tab == 0 ? Colors.blue.shade50 : tab == 1 ? Colors.orange.shade50 : Colors.green.shade50,
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
// // //             ),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text("Order #${reqId.substring(0, 5)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// // //                 Text(tab == 0 ? "NEW" : tab == 1 ? "ON THE WAY" : "DELIVERED",
// // //                     style: TextStyle(color: tab == 0 ? Colors.blue : tab == 1 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
// // //               ],
// // //             ),
// // //           ),
// // //
// // //           Padding(
// // //             padding: const EdgeInsets.all(15),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 // 1. Food Info
// // //                 _fetchFoodHeader(data['postId']),
// // //                 const Divider(height: 30),
// // //
// // //                 // 2. Donor Section (Pickup)
// // //                 _buildContactInfo("PICKUP FROM (DONOR)", data['donorId'], Icons.location_on, Colors.redAccent),
// // //                 const SizedBox(height: 20),
// // //
// // //                 // 3. Receiver Section (Deliver)
// // //                 _buildContactInfo("DELIVER TO (RECEIVER)", data['receiverId'], Icons.near_me, Colors.blue),
// // //
// // //                 if (tab != 2) ...[
// // //                   const SizedBox(height: 20),
// // //                   _buildButton(tab, reqId, vProvider, uid),
// // //                 ]
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _fetchFoodHeader(String postId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading food...");
// // //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         return Row(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(10),
// // //               decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
// // //               child: const Icon(Icons.fastfood, color: AppColor.green),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       _badge(Icons.shopping_bag, "Qty: ${post['quantity'] ?? 'N/A'}", Colors.orange),
// // //                       const SizedBox(width: 8),
// // //                       _badge(Icons.timer, post['pickupTime'] ?? 'ASAP', Colors.grey),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildContactInfo(String label, String userId, IconData icon, Color themeColor) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(userId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("...");
// // //         final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 Icon(icon, size: 16, color: themeColor),
// // //                 const SizedBox(width: 8),
// // //                 Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: themeColor, letterSpacing: 1)),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Padding(
// // //               padding: const EdgeInsets.only(left: 24),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(profile['contactPerson'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// // //                   Text(profile['phone'] ?? 'N/A', style: const TextStyle(color: Colors.black87, fontSize: 13)),
// // //                   Text(profile['address'] ?? 'N/A', style: const TextStyle(color: Colors.grey, fontSize: 12)),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _badge(IconData icon, String text, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, size: 12, color: color),
// // //           const SizedBox(width: 4),
// // //           Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildButton(int tab, String id, VolunteerProvider vp, String uid) {
// // //     bool loading = (tab == 0 && _isAccepting) || (tab == 1 && _loadingRequestId == id);
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       height: 48,
// // //       child: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: AppColor.green,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //           elevation: 0,
// // //         ),
// // //         onPressed: loading ? null : () async {
// // //           setState(() => tab == 0 ? _isAccepting = true : _loadingRequestId = id);
// // //           try {
// // //             tab == 0 ? await vp.acceptDelivery(id, uid) : await vp.completeDelivery(id);
// // //           } finally {
// // //             if (mounted) setState(() { _isAccepting = false; _loadingRequestId = null; });
// // //           }
// // //         },
// // //         child: loading
// // //             ? const CircularProgressIndicator(color: Colors.white)
// // //             : Text(tab == 0 ? "ACCEPT PICKUP" : "MARK AS DELIVERED",
// // //             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // //
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
// // //   String? _loadingRequestId;
// // //   bool _isRequesting = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: Colors.black54,
// // //           indicatorColor: AppColor.green,
// // //           isScrollable: true,
// // //           tabAlignment: TabAlignment.start,
// // //           tabs: const [
// // //             Tab(text: "Available Requests"),
// // //             Tab(text: "Ongoing"),
// // //             Tab(text: "Completed"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildList(context, 0),
// // //               _buildList(context, 1),
// // //               _buildList(context, 2),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildList(BuildContext context, int tabIndex) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// // //     final userUid = authProvider.user?.uid ?? "";
// // //
// // //     Stream<QuerySnapshot> stream = tabIndex == 0
// // //         ? vProvider.getAvailableRequests()
// // //         : tabIndex == 1
// // //         ? vProvider.getMyDeliveries(userUid)
// // //         : vProvider.getCompletedDeliveries(userUid);
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: stream,
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No data found"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>;
// // //             return _buildRequestCard(data, docs[index].id, tabIndex, vProvider, authProvider);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, GenericAuthProvider auth) {
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 16),
// // //       elevation: 4,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: Column(
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
// // //             decoration: BoxDecoration(
// // //               color: tab == 0 ? Colors.blue.shade50 : tab == 1 ? Colors.orange.shade50 : Colors.green.shade50,
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
// // //             ),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text("Order #${reqId.substring(0, 5)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// // //                 Text(tab == 0 ? "AVAILABLE" : tab == 1 ? "ON THE WAY" : "DELIVERED",
// // //                     style: TextStyle(color: tab == 0 ? Colors.blue : tab == 1 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(15),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 _fetchFoodHeader(data['postId']),
// // //                 const Divider(height: 30),
// // //                 _buildContactInfo("PICKUP FROM (DONOR)", data['donorId'], Icons.location_on, Colors.redAccent),
// // //                 const SizedBox(height: 20),
// // //                 _buildContactInfo("DELIVER TO (RECEIVER)", data['receiverId'], Icons.near_me, Colors.blue),
// // //                 if (tab != 2) ...[
// // //                   const SizedBox(height: 20),
// // //                   _buildButton(tab, reqId, vProvider, auth),
// // //                 ]
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- Reused Helper Methods (fetchFoodHeader, buildContactInfo, badge) ---
// // //   // (Assuming these stay same as your original code for UI consistency)
// // //   Widget _fetchFoodHeader(String postId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading food...");
// // //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         return Row(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(10),
// // //               decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
// // //               child: const Icon(Icons.fastfood, color: AppColor.green),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       _badge(Icons.shopping_bag, "Qty: ${post['quantity'] ?? 'N/A'}", Colors.orange),
// // //                       const SizedBox(width: 8),
// // //                       _badge(Icons.timer, post['pickupTime'] ?? 'ASAP', Colors.grey),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildContactInfo(String label, String userId, IconData icon, Color themeColor) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(userId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("...");
// // //         final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 Icon(icon, size: 16, color: themeColor),
// // //                 const SizedBox(width: 8),
// // //                 Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: themeColor, letterSpacing: 1)),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Padding(
// // //               padding: const EdgeInsets.only(left: 24),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(profile['contactPerson'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// // //                   Text(profile['phone'] ?? 'N/A', style: const TextStyle(color: Colors.black87, fontSize: 13)),
// // //                   Text(profile['address'] ?? 'N/A', style: const TextStyle(color: Colors.grey, fontSize: 12)),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _badge(IconData icon, String text, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, size: 12, color: color),
// // //           const SizedBox(width: 4),
// // //           Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- Updated Button Logic ---
// // //   Widget _buildButton(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth) {
// // //     bool loading = (tab == 0 && _isRequesting) || (tab == 1 && _loadingRequestId == id);
// // //     String uid = auth.user?.uid ?? "";
// // //     String name = auth.userData?['profile']?['contactPerson'] ?? "Volunteer";
// // //
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       height: 48,
// // //       child: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: tab == 0 ? Colors.blue : AppColor.green,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //           elevation: 0,
// // //         ),
// // //         onPressed: loading ? null : () async {
// // //           setState(() => tab == 0 ? _isRequesting = true : _loadingRequestId = id);
// // //           try {
// // //             if (tab == 0) {
// // //               await vp.requestPickup(id, uid, name);
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 const SnackBar(content: Text("Pickup request sent to Donor!")),
// // //               );
// // //             } else {
// // //               await vp.completeDelivery(id);
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 const SnackBar(content: Text("Delivery marked as Completed!")),
// // //               );
// // //             }
// // //           } finally {
// // //             if (mounted) setState(() { _isRequesting = false; _loadingRequestId = null; });
// // //           }
// // //         },
// // //         child: loading
// // //             ? const CircularProgressIndicator(color: Colors.white)
// // //             : Text(tab == 0 ? "REQUEST PICKUP" : "MARK AS DELIVERED",
// // //             style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
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
// // //   String? _loadingRequestId;
// // //   bool _isActionProcessing = false;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         TabBar(
// // //           controller: widget.tabController,
// // //           labelColor: AppColor.green,
// // //           unselectedLabelColor: Colors.black54,
// // //           indicatorColor: AppColor.green,
// // //           isScrollable: true,
// // //           tabAlignment: TabAlignment.start,
// // //           tabs: const [
// // //             Tab(text: "Available Requests"),
// // //             Tab(text: "Ongoing"),
// // //             Tab(text: "Completed"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [
// // //               _buildList(context, 0),
// // //               _buildList(context, 1),
// // //               _buildList(context, 2),
// // //             ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildList(BuildContext context, int tabIndex) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// // //     final userUid = authProvider.user?.uid ?? "";
// // //
// // //     Stream<QuerySnapshot> stream = tabIndex == 0
// // //         ? vProvider.getAvailableRequests()
// // //         : tabIndex == 1
// // //         ? vProvider.getMyDeliveries(userUid)
// // //         : vProvider.getCompletedDeliveries(userUid);
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: stream,
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //         final docs = snapshot.data?.docs ?? [];
// // //
// // //         // ফিল্টারিং: Available ট্যাবে যদি অলরেডি অন্য কারো জন্য খাবারটি ডেলিভারি প্রসেসে থাকে, তবে তা দেখাবে না
// // //         var filteredDocs = docs;
// // //         if (tabIndex == 0) {
// // //           filteredDocs = docs.where((doc) {
// // //             final d = doc.data() as Map<String, dynamic>;
// // //             // যদি status 'delivered' হয়, তবে চেক করবে এই ইউজারকেই ডোনার সিলেক্ট করেছে কি না
// // //             if (d['status'] == 'delivered') {
// // //               return d['volunteerId'] == userUid;
// // //             }
// // //             return true; // status 'approved' হলে সবাই দেখবে
// // //           }).toList();
// // //         }
// // //
// // //         if (filteredDocs.isEmpty) return const Center(child: Text("No data found"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: filteredDocs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = filteredDocs[index].data() as Map<String, dynamic>;
// // //             return _buildRequestCard(data, filteredDocs[index].id, tabIndex, vProvider, authProvider);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, GenericAuthProvider auth) {
// // //     String cardStatus = "AVAILABLE";
// // //     if (tab == 0 && data['status'] == 'delivered') cardStatus = "READY TO PICKUP";
// // //     if (tab == 1) cardStatus = "ON THE WAY";
// // //     if (tab == 2) cardStatus = "DELIVERED";
// // //
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 16),
// // //       elevation: 4,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: Column(
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
// // //             decoration: BoxDecoration(
// // //               color: tab == 0 ? (data['status'] == 'delivered' ? Colors.indigo.shade50 : Colors.blue.shade50) : tab == 1 ? Colors.orange.shade50 : Colors.green.shade50,
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
// // //             ),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text("Order #${reqId.substring(0, 5)}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// // //                 Text(cardStatus,
// // //                     style: TextStyle(color: tab == 0 ? Colors.blue : tab == 1 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
// // //               ],
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.all(15),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 _fetchFoodHeader(data['postId']),
// // //                 const Divider(height: 30),
// // //                 _buildContactInfo("PICKUP FROM (DONOR)", data['donorId'], Icons.location_on, Colors.redAccent),
// // //                 const SizedBox(height: 20),
// // //                 _buildContactInfo("DELIVER TO (RECEIVER)", data['receiverId'], Icons.near_me, Colors.blue),
// // //                 if (tab != 2) ...[
// // //                   const SizedBox(height: 20),
// // //                   _buildButton(tab, reqId, vProvider, auth, data),
// // //                 ]
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildButton(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
// // //     bool loading = _loadingRequestId == id && _isActionProcessing;
// // //     String uid = auth.user?.uid ?? "";
// // //     String name = auth.userData?['profile']?['contactPerson'] ?? "Volunteer";
// // //
// // //     // বাটন টেক্সট লজিক
// // //     String btnText = "";
// // //     if (tab == 0) {
// // //       btnText = (data['status'] == 'delivered') ? "CONFIRM PICKUP" : "REQUEST PICKUP";
// // //     } else {
// // //       btnText = "MARK AS COMPLETED";
// // //     }
// // //
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       height: 48,
// // //       child: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: tab == 0 ? (data['status'] == 'delivered' ? Colors.indigo : Colors.blue) : AppColor.green,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //           elevation: 0,
// // //         ),
// // //         onPressed: loading ? null : () async {
// // //           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
// // //           try {
// // //             if (tab == 0) {
// // //               if (data['status'] == 'delivered') {
// // //                 // পিকআপ কনফার্ম করা
// // //                 await vp.confirmPickup(id);
// // //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Food Picked Up! Moved to Ongoing.")));
// // //               } else {
// // //                 // রিকোয়েস্ট পাঠানো
// // //                 await vp.requestPickup(id, uid, name);
// // //                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request sent to Donor!")));
// // //               }
// // //             } else {
// // //               // ডেলিভারি সম্পন্ন করা
// // //               await vp.completeDelivery(id);
// // //             }
// // //           } finally {
// // //             if (mounted) setState(() { _isActionProcessing = false; _loadingRequestId = null; });
// // //           }
// // //         },
// // //         child: loading
// // //             ? const CircularProgressIndicator(color: Colors.white)
// // //             : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// // //       ),
// // //     );
// // //   }
// // //
// // //   // --- Reused Helper Methods (fetchFoodHeader, buildContactInfo, badge) remain same ---
// // //   Widget _fetchFoodHeader(String postId) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("Loading food...");
// // //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// // //         return Row(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(10),
// // //               decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
// // //               child: const Icon(Icons.fastfood, color: AppColor.green),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: [
// // //                       _badge(Icons.shopping_bag, "Qty: ${post['quantity'] ?? 'N/A'}", Colors.orange),
// // //                       const SizedBox(width: 8),
// // //                       _badge(Icons.timer, post['pickupTime'] ?? 'ASAP', Colors.grey),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildContactInfo(String label, String userId, IconData icon, Color themeColor) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(userId).get(),
// // //       builder: (context, snapshot) {
// // //         if (!snapshot.hasData) return const Text("...");
// // //         final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
// // //         return Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Row(
// // //               children: [
// // //                 Icon(icon, size: 16, color: themeColor),
// // //                 const SizedBox(width: 8),
// // //                 Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: themeColor, letterSpacing: 1)),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Padding(
// // //               padding: const EdgeInsets.only(left: 24),
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(profile['contactPerson'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// // //                   Text(profile['phone'] ?? 'N/A', style: const TextStyle(color: Colors.black87, fontSize: 13)),
// // //                   Text(profile['address'] ?? 'N/A', style: const TextStyle(color: Colors.grey, fontSize: 12)),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _badge(IconData icon, String text, Color color) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, size: 12, color: color),
// // //           const SizedBox(width: 4),
// // //           Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:intl/intl.dart'; // Formatting er jonno
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
// //   String? _loadingRequestId;
// //   bool _isActionProcessing = false;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         TabBar(
// //           controller: widget.tabController,
// //           labelColor: AppColor.green,
// //           unselectedLabelColor: Colors.black54,
// //           indicatorColor: AppColor.green,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           tabs: const [
// //             Tab(text: "Available Requests"),
// //             Tab(text: "Ongoing"),
// //             Tab(text: "Completed"),
// //           ],
// //         ),
// //         Expanded(
// //           child: TabBarView(
// //             controller: widget.tabController,
// //             children: [
// //               _buildList(context, 0),
// //               _buildList(context, 1),
// //               _buildList(context, 2),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildList(BuildContext context, int tabIndex) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// //     final userUid = authProvider.user?.uid ?? "";
// //
// //     Stream<QuerySnapshot> stream = tabIndex == 0
// //         ? vProvider.getAvailableRequests()
// //         : tabIndex == 1
// //         ? vProvider.getMyDeliveries(userUid)
// //         : vProvider.getCompletedDeliveries(userUid);
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: stream,
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //         }
// //
// //         if (snapshot.hasError) {
// //           return Center(child: Text("Error: ${snapshot.error}. Make sure Firestore index is created."));
// //         }
// //
// //         final docs = snapshot.data?.docs ?? [];
// //         var filteredDocs = docs;
// //
// //         if (tabIndex == 0) {
// //           filteredDocs = docs.where((doc) {
// //             final d = doc.data() as Map<String, dynamic>;
// //             if (d['status'] == 'delivered') {
// //               return d['volunteerId'] == userUid;
// //             }
// //             return true;
// //           }).toList();
// //         }
// //
// //         if (filteredDocs.isEmpty) {
// //           return const Center(child: Text("No data found", style: TextStyle(color: Colors.grey)));
// //         }
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: filteredDocs.length,
// //           itemBuilder: (context, index) {
// //             final data = filteredDocs[index].data() as Map<String, dynamic>;
// //             return _buildRequestCard(data, filteredDocs[index].id, tabIndex, vProvider, authProvider);
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, GenericAuthProvider auth) {
// //     String cardStatus = "AVAILABLE";
// //     if (tab == 0 && data['status'] == 'delivered') cardStatus = "READY TO PICKUP";
// //     if (tab == 1) cardStatus = "ON THE WAY";
// //     if (tab == 2) cardStatus = "DELIVERED";
// //
// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       elevation: 4,
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //       child: Column(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
// //             decoration: BoxDecoration(
// //               color: tab == 0
// //                   ? (data['status'] == 'delivered' ? Colors.indigo.shade50 : Colors.blue.shade50)
// //                   : tab == 1 ? Colors.orange.shade50 : Colors.green.shade50,
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text("Order #${reqId.substring(0, 5).toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
// //                     if (tab == 2 && data['completedAt'] != null)
// //                       Text(
// //                         DateFormat('dd MMM, hh:mm a').format((data['completedAt'] as Timestamp).toDate()),
// //                         style: const TextStyle(fontSize: 10, color: Colors.black54),
// //                       ),
// //                   ],
// //                 ),
// //                 Text(cardStatus,
// //                     style: TextStyle(color: tab == 0 ? Colors.blue : tab == 1 ? Colors.orange : Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(15),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 _fetchFoodHeader(data['postId']),
// //                 const Divider(height: 30),
// //                 _buildContactInfo("PICKUP FROM (DONOR)", data['donorId'], Icons.location_on, Colors.redAccent),
// //                 const SizedBox(height: 20),
// //                 _buildContactInfo("DELIVER TO (RECEIVER)", data['receiverId'], Icons.near_me, Colors.blue),
// //                 if (tab != 2) ...[
// //                   const SizedBox(height: 20),
// //                   _buildButton(tab, reqId, vProvider, auth, data),
// //                 ]
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildButton(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
// //     bool loading = _loadingRequestId == id && _isActionProcessing;
// //     String uid = auth.user?.uid ?? "";
// //     String name = auth.userData?['profile']?['contactPerson'] ?? "Volunteer";
// //
// //     String btnText = "";
// //     if (tab == 0) {
// //       btnText = (data['status'] == 'delivered') ? "CONFIRM PICKUP" : "REQUEST PICKUP";
// //     } else {
// //       btnText = "MARK AS COMPLETED";
// //     }
// //
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 48,
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: tab == 0 ? (data['status'] == 'delivered' ? Colors.indigo : Colors.blue) : AppColor.green,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //           elevation: 0,
// //         ),
// //         onPressed: loading ? null : () async {
// //           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
// //           try {
// //             if (tab == 0) {
// //               if (data['status'] == 'delivered') {
// //                 await vp.confirmPickup(id);
// //                 _showMsg("Food Picked Up! Moved to Ongoing.");
// //               } else {
// //                 await vp.requestPickup(id, uid, name);
// //                 _showMsg("Request sent to Donor!");
// //               }
// //             } else {
// //               // 🔹 Rewards update with donorId and receiverId
// //               await vp.completeDelivery(
// //                 requestId: id,
// //                 volunteerId: uid,
// //                 donorId: data['donorId'] ?? "",
// //                 receiverId: data['receiverId'] ?? "",
// //               );
// //               _showMsg("Mission Completed! Points rewarded.");
// //             }
// //           } catch (e) {
// //             _showMsg("Error: $e");
// //           } finally {
// //             if (mounted) setState(() { _isActionProcessing = false; _loadingRequestId = null; });
// //           }
// //         },
// //         child: loading
// //             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //             : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// //       ),
// //     );
// //   }
// //
// //   void _showMsg(String msg) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating));
// //   }
// //
// //   Widget _fetchFoodHeader(String postId) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const Text("Loading food details...");
// //         final post = snapshot.data!.data() as Map<String, dynamic>? ?? {};
// //         return Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(10),
// //               decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
// //               child: const Icon(Icons.fastfood, color: AppColor.green),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(post['foodName'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //                   const SizedBox(height: 4),
// //                   Row(
// //                     children: [
// //                       _badge(Icons.shopping_bag, "Qty: ${post['quantity'] ?? 'N/A'}", Colors.orange),
// //                       const SizedBox(width: 8),
// //                       _badge(Icons.timer, post['pickupTime'] ?? 'ASAP', Colors.grey),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildContactInfo(String label, String userId, IconData icon, Color themeColor) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('accounts').doc(userId).get(),
// //       builder: (context, snapshot) {
// //         if (!snapshot.hasData) return const Text("Fetching user...");
// //         final profile = (snapshot.data!.data() as Map<String, dynamic>?)?['profile'] ?? {};
// //         return Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               children: [
// //                 Icon(icon, size: 16, color: themeColor),
// //                 const SizedBox(width: 8),
// //                 Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: themeColor, letterSpacing: 1)),
// //               ],
// //             ),
// //             const SizedBox(height: 8),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 24),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(profile['contactPerson'] ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// //                   Text(profile['phone'] ?? 'N/A', style: const TextStyle(color: Colors.black87, fontSize: 13)),
// //                   Text(profile['address'] ?? 'N/A', style: const TextStyle(color: Colors.grey, fontSize: 12)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _badge(IconData icon, String text, Color color) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 12, color: color),
// //           const SizedBox(width: 4),
// //           Text(text, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
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
//   bool _isActionProcessing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: Colors.black54,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           tabs: const [
//             Tab(text: "Available"),
//             Tab(text: "Ongoing"),
//             Tab(text: "Completed"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [ _buildList(0), _buildList(1), _buildList(2) ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildList(int tabIndex) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
//     final String userUid = authProvider.user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
//       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
//       vProvider.getCompletedDeliveries(userUid),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) return Center(child: Text("Data Error: Check Indexing"));
//         if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No Data Available"));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>? ?? {};
//             final String reqId = docs[index].id;
//
//             // Tab 0 specific filtering
//             if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
//               return const SizedBox.shrink();
//             }
//
//             return _buildRequestCard(data, reqId, tabIndex, vProvider, authProvider);
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildRequestCard(Map<String, dynamic> data, String reqId, int tab, VolunteerProvider vProvider, GenericAuthProvider auth) {
//     // Time handle comfortably
//     String timeText = "";
//     if (tab == 2 && data['completedAt'] != null) {
//       try {
//         timeText = DateFormat('dd MMM, hh:mm a').format((data['completedAt'] as Timestamp).toDate());
//       } catch (_) { timeText = "Time N/A"; }
//     }
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("ID: #${reqId.substring(0, 5)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
//                 if (timeText.isNotEmpty) Text(timeText, style: TextStyle(fontSize: 10, color: AppColor.green)),
//               ],
//             ),
//             const Divider(),
//             _fetchFoodInfo(data['postId'] ?? ""),
//             const SizedBox(height: 10),
//             _userTile("DONOR", data['donorId'] ?? "", Icons.upload, Colors.orange),
//             _userTile("RECEIVER", data['receiverId'] ?? "", Icons.download, Colors.blue),
//             if (tab != 2) ...[
//               const SizedBox(height: 15),
//               _actionButton(tab, reqId, vProvider, auth, data),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _actionButton(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
//     bool loading = _loadingRequestId == id && _isActionProcessing;
//     String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "REQUEST PICKUP") : "COMPLETE DELIVERY";
//
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, foregroundColor: Colors.white),
//         onPressed: loading ? null : () async {
//           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
//           try {
//             if (tab == 0) {
//               if (data['status'] == 'delivered') { await vp.confirmPickup(id); }
//               else { await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer"); }
//             } else {
//               await vp.completeDelivery(
//                 requestId: id,
//                 volunteerId: auth.user?.uid ?? "",
//                 donorId: data['donorId'] ?? "",
//                 receiverId: data['receiverId'] ?? "",
//               );
//             }
//           } catch (e) {
//             _showMsg("Error: $e");
//           } finally {
//             if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
//           }
//         },
//         child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : Text(btnText),
//       ),
//     );
//   }
//
//   Widget _fetchFoodInfo(String postId) {
//     if (postId.isEmpty) return const Text("Food Info Missing");
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
//       builder: (context, snapshot) {
//         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//         return Text(d['foodName'] ?? "Loading Food...", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
//       },
//     );
//   }
//
//   Widget _userTile(String label, String uid, IconData icon, Color color) {
//     if (uid.isEmpty) return Text("$label: ID Missing", style: TextStyle(fontSize: 11, color: Colors.red));
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
//       builder: (context, snapshot) {
//         final p = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 2),
//           child: Row(
//             children: [
//               Icon(icon, size: 14, color: color),
//               const SizedBox(width: 5),
//               Text("$label: ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
//               Text(p['contactPerson'] ?? "Unknown", style: const TextStyle(fontSize: 11)),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showMsg(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
// }

//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
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
//   bool _isActionProcessing = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: Colors.black54,
//           indicatorColor: AppColor.green,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           tabs: const [
//             Tab(text: "Available"),
//             Tab(text: "Ongoing"),
//             Tab(text: "Completed"),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: widget.tabController,
//             children: [ _buildList(0), _buildList(1), _buildList(2) ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildList(int tabIndex) {
//     final vProvider = Provider.of<VolunteerProvider>(context);
//     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
//     final String userUid = authProvider.user?.uid ?? "";
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
//       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
//       vProvider.getCompletedDeliveries(userUid),
//       builder: (context, snapshot) {
//         // 🔥 DATABASE ERROR HANDLING:
//         // Jodi "The query requires an index" error ashe, Console-er link e click koro.
//         if (snapshot.hasError) {
//           return Center(child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text("Database Indexing Required. Check Console Link.",
//                 textAlign: TextAlign.center, style: TextStyle(color: Colors.red)),
//           ));
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) return const Center(child: Text("No Requests Found"));
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>? ?? {};
//             final String reqId = docs[index].id;
//
//             // Available tab extra safety check
//             if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
//               return const SizedBox.shrink();
//             }
//
//             return _buildCard(data, reqId, tabIndex, vProvider, authProvider);
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth) {
//     // Time rendering based on tab
//     String displayTime = "N/A";
//     Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
//     if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 15),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Order #${id.substring(0, 5).toUpperCase()}", style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
//                 Text(displayTime, style: TextStyle(fontSize: 11, color: AppColor.green, fontWeight: FontWeight.w500)),
//               ],
//             ),
//             const Divider(height: 20),
//             _fetchFoodHeader(data['postId'] ?? ""),
//             const SizedBox(height: 12),
//             _userRow("Donor", data['donorId'] ?? "", Icons.circle, Colors.orange),
//             _userRow("Receiver", data['receiverId'] ?? "", Icons.location_on, Colors.blue),
//             if (tab != 2) ...[
//               const SizedBox(height: 15),
//               _buildBtn(tab, id, vp, auth, data),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
//     bool loading = _loadingRequestId == id && _isActionProcessing;
//     String txt = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "REQUEST PICKUP") : "MARK COMPLETED";
//
//     return SizedBox(
//       width: double.infinity,
//       height: 45,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//         onPressed: loading ? null : () async {
//           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
//           try {
//             if (tab == 0) {
//               if (data['status'] == 'delivered') await vp.confirmPickup(id);
//               else await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
//             } else {
//               await vp.completeDelivery(requestId: id, volunteerId: auth.user?.uid ?? "", donorId: data['donorId'] ?? "", receiverId: data['receiverId'] ?? "");
//             }
//           } catch (e) { _showMsg("Error: $e"); }
//           finally { if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; }); }
//         },
//         child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)) : Text(txt, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
//
//   Widget _fetchFoodHeader(String pid) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
//       builder: (context, snapshot) {
//         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//         return Text(d['foodName'] ?? "Loading...", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold));
//       },
//     );
//   }
//
//   Widget _userRow(String label, String uid, IconData icon, Color col) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
//       builder: (context, snapshot) {
//         final p = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
//         return Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: Row(
//             children: [
//               Icon(icon, size: 14, color: col),
//               const SizedBox(width: 6),
//               Text("$label: ", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//               Expanded(child: Text(p['contactPerson'] ?? "Fetching...", style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showMsg(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
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
  bool _isActionProcessing = false;

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
            Tab(text: "Available"),
            Tab(text: "Ongoing"),
            Tab(text: "Completed"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [ _buildList(0), _buildList(1), _buildList(2) ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(int tabIndex) {
    final vProvider = Provider.of<VolunteerProvider>(context);
    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final String userUid = authProvider.user?.uid ?? "";

    return StreamBuilder<QuerySnapshot>(
      stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
      tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
      vProvider.getCompletedDeliveries(userUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Database Indexing Required. Check Console.",
              textAlign: TextAlign.center, style: TextStyle(color: Colors.red)));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) return const Center(child: Text("No Requests Found"));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>? ?? {};
            final String reqId = docs[index].id;

            // Simple tab-0 filter for personal ready requests
            if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
              return const SizedBox.shrink();
            }

            return _buildCard(data, reqId, tabIndex, vProvider, authProvider);
          },
        );
      },
    );
  }

  Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth) {
    String displayTime = "N/A";
    Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
    if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          // Top Header Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ORDER #${id.substring(0, 5).toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
                Text(displayTime, style: TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Food and Pickup Time Info
                _fetchFoodDetailsHeader(data['postId'] ?? ""),

                const Divider(height: 25, thickness: 0.5),

                // 2. Donor Info (Pickup)
                _buildContactRow(
                  title: "PICKUP FROM (DONOR)",
                  uid: data['donorId'] ?? "",
                  icon: Icons.location_on,
                  color: Colors.redAccent,
                ),

                const SizedBox(height: 18),

                // 3. Receiver Info (Drop-off)
                _buildContactRow(
                  title: "DELIVER TO (RECEIVER)",
                  uid: data['receiverId'] ?? "",
                  icon: Icons.near_me,
                  color: Colors.blueAccent,
                ),

                if (tab != 2) ...[
                  const SizedBox(height: 20),
                  _buildBtn(tab, id, vp, auth, data),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color}) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
      builder: (context, snapshot) {
        final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
        final String name = profile['contactPerson'] ?? "Loading...";
        final String address = profile['address'] ?? "No address provided";
        final String phone = profile['phone'] ?? "N/A";

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 0.5)),
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(address, style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _fetchFoodDetailsHeader(String pid) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
      builder: (context, snapshot) {
        final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
        final String food = d['foodName'] ?? "Food Item";
        final String time = d['pickupTime'] ?? "ASAP";

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(food, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
            )
          ],
        );
      },
    );
  }

  Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
    bool loading = _loadingRequestId == id && _isActionProcessing;
    String txt = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "REQUEST PICKUP") : "MARK COMPLETED";

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        onPressed: loading ? null : () async {
          setState(() { _loadingRequestId = id; _isActionProcessing = true; });
          try {
            if (tab == 0) {
              if (data['status'] == 'delivered') await vp.confirmPickup(id);
              else await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
            } else {
              await vp.completeDelivery(
                  requestId: id,
                  volunteerId: auth.user?.uid ?? "",
                  donorId: data['donorId'] ?? "",
                  receiverId: data['receiverId'] ?? ""
              );
            }
          } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"))); }
          finally { if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; }); }
        },
        child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) :
        Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}