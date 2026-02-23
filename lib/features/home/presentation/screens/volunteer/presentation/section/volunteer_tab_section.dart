// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:intl/intl.dart';
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
// // //             Tab(text: "Available"),
// // //             Tab(text: "Ongoing"),
// // //             Tab(text: "Completed"),
// // //           ],
// // //         ),
// // //         Expanded(
// // //           child: TabBarView(
// // //             controller: widget.tabController,
// // //             children: [ _buildList(0), _buildList(1), _buildList(2) ],
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // //
// // //   Widget _buildList(int tabIndex) {
// // //     final vProvider = Provider.of<VolunteerProvider>(context);
// // //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// // //     final String userUid = authProvider.user?.uid ?? "";
// // //
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
// // //       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
// // //       vProvider.getCompletedDeliveries(userUid),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.hasError) {
// // //           return const Center(child: Text("Database Indexing Required. Check Console.",
// // //               textAlign: TextAlign.center, style: TextStyle(color: Colors.red)));
// // //         }
// // //
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // //         }
// // //
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) return const Center(child: Text("No Requests Found"));
// // //
// // //         return ListView.builder(
// // //           padding: const EdgeInsets.all(12),
// // //           itemCount: docs.length,
// // //           itemBuilder: (context, index) {
// // //             final data = docs[index].data() as Map<String, dynamic>? ?? {};
// // //             final String reqId = docs[index].id;
// // //
// // //             // Simple tab-0 filter for personal ready requests
// // //             if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
// // //               return const SizedBox.shrink();
// // //             }
// // //
// // //             return _buildCard(data, reqId, tabIndex, vProvider, authProvider);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth) {
// // //     String displayTime = "N/A";
// // //     Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
// // //     if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());
// // //
// // //     return Card(
// // //       margin: const EdgeInsets.only(bottom: 20),
// // //       elevation: 3,
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // //       child: Column(
// // //         children: [
// // //           // Top Header Bar
// // //           Container(
// // //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// // //             decoration: BoxDecoration(
// // //               color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
// // //               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// // //             ),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 Text("ORDER #${id.substring(0, 5).toUpperCase()}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1)),
// // //                 Text(displayTime, style: TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
// // //               ],
// // //             ),
// // //           ),
// // //
// // //           Padding(
// // //             padding: const EdgeInsets.all(15),
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 // 1. Food and Pickup Time Info
// // //                 _fetchFoodDetailsHeader(data['postId'] ?? ""),
// // //
// // //                 const Divider(height: 25, thickness: 0.5),
// // //
// // //                 // 2. Donor Info (Pickup)
// // //                 _buildContactRow(
// // //                   title: "PICKUP FROM (DONOR)",
// // //                   uid: data['donorId'] ?? "",
// // //                   icon: Icons.location_on,
// // //                   color: Colors.redAccent,
// // //                 ),
// // //
// // //                 const SizedBox(height: 18),
// // //
// // //                 // 3. Receiver Info (Drop-off)
// // //                 _buildContactRow(
// // //                   title: "DELIVER TO (RECEIVER)",
// // //                   uid: data['receiverId'] ?? "",
// // //                   icon: Icons.near_me,
// // //                   color: Colors.blueAccent,
// // //                 ),
// // //
// // //                 if (tab != 2) ...[
// // //                   const SizedBox(height: 20),
// // //                   _buildBtn(tab, id, vp, auth, data),
// // //                 ]
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color}) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
// // //       builder: (context, snapshot) {
// // //         final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
// // //         final String name = profile['contactPerson'] ?? "Loading...";
// // //         final String address = profile['address'] ?? "No address provided";
// // //         final String phone = profile['phone'] ?? "N/A";
// // //
// // //         return Row(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Icon(icon, size: 20, color: color),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 0.5)),
// // //                   Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// // //                   Text(address, style: const TextStyle(fontSize: 12, color: Colors.black87)),
// // //                   Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _fetchFoodDetailsHeader(String pid) {
// // //     return FutureBuilder<DocumentSnapshot>(
// // //       future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
// // //       builder: (context, snapshot) {
// // //         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
// // //         final String food = d['foodName'] ?? "Food Item";
// // //         final String time = d['pickupTime'] ?? "ASAP";
// // //
// // //         return Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Expanded(child: Text(food, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green))),
// // //             Container(
// // //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// // //               decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
// // //               child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
// // //             )
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
// // //     bool loading = _loadingRequestId == id && _isActionProcessing;
// // //     String txt = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "REQUEST PICKUP") : "MARK COMPLETED";
// // //
// // //     return SizedBox(
// // //       width: double.infinity,
// // //       height: 48,
// // //       child: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: AppColor.green,
// // //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// // //           elevation: 0,
// // //         ),
// // //         onPressed: loading ? null : () async {
// // //           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
// // //           try {
// // //             if (tab == 0) {
// // //               if (data['status'] == 'delivered') await vp.confirmPickup(id);
// // //               else await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
// // //             } else {
// // //               await vp.completeDelivery(
// // //                   requestId: id,
// // //                   volunteerId: auth.user?.uid ?? "",
// // //                   donorId: data['donorId'] ?? "",
// // //                   receiverId: data['receiverId'] ?? ""
// // //               );
// // //             }
// // //           } catch (e) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"))); }
// // //           finally { if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; }); }
// // //         },
// // //         child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) :
// // //         Text(txt, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
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
// // import 'package:intl/intl.dart';
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
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Column(
// //       children: [
// //         TabBar(
// //           controller: widget.tabController,
// //           labelColor: AppColor.green,
// //           unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
// //           indicatorColor: AppColor.green,
// //           indicatorSize: TabBarIndicatorSize.label,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           dividerColor: Colors.transparent,
// //           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //           tabs: const [
// //             Tab(text: "Available"),
// //             Tab(text: "Ongoing"),
// //             Tab(text: "Completed"),
// //           ],
// //         ),
// //         Expanded(
// //           child: TabBarView(
// //             controller: widget.tabController,
// //             children: [ _buildList(0), _buildList(1), _buildList(2) ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildList(int tabIndex) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// //     final String userUid = authProvider.user?.uid ?? "";
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
// //       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
// //       vProvider.getCompletedDeliveries(userUid),
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError) {
// //           return const Center(child: Text("Error loading data", style: TextStyle(color: Colors.red)));
// //         }
// //
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //         }
// //
// //         final docs = snapshot.data?.docs ?? [];
// //
// //         // --- Empty State Logic ---
// //         if (docs.isEmpty) {
// //           return _buildEmptyState(tabIndex, isDark);
// //         }
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: docs.length,
// //           itemBuilder: (context, index) {
// //             final data = docs[index].data() as Map<String, dynamic>? ?? {};
// //             final String reqId = docs[index].id;
// //
// //             // Filter for personal ready requests in the Available tab
// //             if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
// //               return const SizedBox.shrink();
// //             }
// //
// //             return _buildCard(data, reqId, tabIndex, vProvider, authProvider, isDark);
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // UI for when no delivery requests are found
// //   Widget _buildEmptyState(int index, bool isDark) {
// //     String message = index == 0 ? "No delivery requests available right now." :
// //     index == 1 ? "You have no ongoing deliveries." :
// //     "You haven't completed any deliveries yet.";
// //
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.inventory_2_outlined, size: 64, color: AppColor.green.withOpacity(0.2)),
// //           const SizedBox(height: 16),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 40),
// //             child: Text(
// //               message,
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                   fontSize: 15,
// //                   color: isDark ? Colors.white60 : Colors.black54,
// //                   fontWeight: FontWeight.w500
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth, bool isDark) {
// //     String displayTime = "N/A";
// //     Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
// //     if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());
// //
// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 20),
// //       elevation: isDark ? 0 : 2,
// //       color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// //       shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           side: isDark ? const BorderSide(color: Colors.white10) : BorderSide.none
// //       ),
// //       child: Column(
// //         children: [
// //           // Header Bar
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// //             decoration: BoxDecoration(
// //               color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text("ORDER #${id.substring(0, 5).toUpperCase()}",
// //                     style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 11,
// //                         color: isDark ? Colors.white70 : Colors.black87,
// //                         letterSpacing: 1
// //                     )
// //                 ),
// //                 Text(displayTime, style: const TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //           ),
// //
// //           Padding(
// //             padding: const EdgeInsets.all(15),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 _fetchFoodDetailsHeader(data['postId'] ?? "", isDark),
// //                 const Divider(height: 25, thickness: 0.5),
// //
// //                 _buildContactRow(
// //                   title: "PICKUP FROM (DONOR)",
// //                   uid: data['donorId'] ?? "",
// //                   icon: Icons.location_on,
// //                   color: Colors.redAccent,
// //                   isDark: isDark,
// //                 ),
// //
// //                 const SizedBox(height: 18),
// //
// //                 _buildContactRow(
// //                   title: "DELIVER TO (RECEIVER)",
// //                   uid: data['receiverId'] ?? "",
// //                   icon: Icons.near_me,
// //                   color: Colors.blueAccent,
// //                   isDark: isDark,
// //                 ),
// //
// //                 if (tab != 2) ...[
// //                   const SizedBox(height: 20),
// //                   _buildBtn(tab, id, vp, auth, data),
// //                 ]
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color, required bool isDark}) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
// //       builder: (context, snapshot) {
// //         final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
// //         final String name = profile['contactPerson'] ?? "Loading Name...";
// //         final String address = profile['address'] ?? "Address not provided";
// //         final String phone = profile['phone'] ?? "N/A";
// //
// //         return Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Icon(icon, size: 20, color: color),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isDark ? Colors.grey : Colors.grey[600])),
// //                   Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
// //                   Text(address, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
// //                   Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _fetchFoodDetailsHeader(String pid, bool isDark) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
// //       builder: (context, snapshot) {
// //         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
// //         final String food = d['foodName'] ?? "Food Item";
// //         final String time = d['pickupTime'] ?? "ASAP";
// //
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(child: Text(food, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green))),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //               decoration: BoxDecoration(
// //                   color: Colors.orange.withOpacity(isDark ? 0.2 : 0.1),
// //                   borderRadius: BorderRadius.circular(8)
// //               ),
// //               child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
// //     bool loading = _loadingRequestId == id && _isActionProcessing;
// //     String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "REQUEST PICKUP") : "MARK COMPLETED";
// //
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 48,
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: AppColor.green,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //           elevation: 0,
// //         ),
// //         onPressed: loading ? null : () async {
// //           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
// //           try {
// //             if (tab == 0) {
// //               if (data['status'] == 'delivered') {
// //                 await vp.confirmPickup(id);
// //               } else {
// //                 await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
// //               }
// //             } else {
// //               await vp.completeDelivery(
// //                   requestId: id,
// //                   volunteerId: auth.user?.uid ?? "",
// //                   donorId: data['donorId'] ?? "",
// //                   receiverId: data['receiverId'] ?? ""
// //               );
// //             }
// //           } catch (e) {
// //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action failed: $e")));
// //           } finally {
// //             if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
// //           }
// //         },
// //         child: loading
// //             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //             : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// //       ),
// //     );
// //   }
// // }
//
// //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:intl/intl.dart';
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
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return Column(
// //       children: [
// //         TabBar(
// //           controller: widget.tabController,
// //           labelColor: AppColor.green,
// //           unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
// //           indicatorColor: AppColor.green,
// //           indicatorSize: TabBarIndicatorSize.label,
// //           isScrollable: true,
// //           tabAlignment: TabAlignment.start,
// //           dividerColor: Colors.transparent,
// //           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //           tabs: const [
// //             Tab(text: "Available"),
// //             Tab(text: "Ongoing"),
// //             Tab(text: "Completed"),
// //           ],
// //         ),
// //         Expanded(
// //           child: TabBarView(
// //             controller: widget.tabController,
// //             children: [ _buildList(0), _buildList(1), _buildList(2) ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildList(int tabIndex) {
// //     final vProvider = Provider.of<VolunteerProvider>(context);
// //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// //     final String userUid = authProvider.user?.uid ?? "";
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
// //       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
// //       vProvider.getCompletedDeliveries(userUid),
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError) {
// //           return const Center(child: Text("Error fetching data", style: TextStyle(color: Colors.red)));
// //         }
// //
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //         }
// //
// //         final docs = snapshot.data?.docs ?? [];
// //
// //         // --- PRO EMPTY STATE HANDLER ---
// //         if (docs.isEmpty) {
// //           return _buildEmptyState(tabIndex, isDark);
// //         }
// //
// //         return ListView.builder(
// //           padding: const EdgeInsets.all(12),
// //           itemCount: docs.length,
// //           itemBuilder: (context, index) {
// //             final data = docs[index].data() as Map<String, dynamic>? ?? {};
// //             final String reqId = docs[index].id;
// //
// //             if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
// //               return const SizedBox.shrink();
// //             }
// //
// //             return _buildCard(data, reqId, tabIndex, vProvider, authProvider, isDark);
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // Visual UI for Empty Tabs
// //   Widget _buildEmptyState(int index, bool isDark) {
// //     String message = index == 0 ? "No Requests Available" :
// //     index == 1 ? "No Active Deliveries" :
// //     "No History Found";
// //
// //     String subMessage = index == 0 ? "New food donation requests from donors will appear here." :
// //     index == 1 ? "Accept an available request to start helping others." :
// //     "Once you complete a delivery, it will be listed here.";
// //
// //     return Center(
// //       child: Padding(
// //         padding: const EdgeInsets.symmetric(horizontal: 40),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(25),
// //               decoration: BoxDecoration(
// //                 color: AppColor.green.withOpacity(0.05),
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Icon(
// //                   index == 0 ? Icons.local_shipping_outlined :
// //                   index == 1 ? Icons.assignment_outlined : Icons.history_edu_outlined,
// //                   size: 70,
// //                   color: AppColor.green.withOpacity(0.4)
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Text(
// //               message,
// //               style: TextStyle(
// //                   fontSize: 18,
// //                   fontWeight: FontWeight.bold,
// //                   color: isDark ? Colors.white : Colors.black87
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               subMessage,
// //               textAlign: TextAlign.center,
// //               style: TextStyle(
// //                   fontSize: 13,
// //                   color: isDark ? Colors.white60 : Colors.black54,
// //                   height: 1.5
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth, bool isDark) {
// //     String displayTime = "N/A";
// //     Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
// //     if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());
// //
// //     return Card(
// //       margin: const EdgeInsets.only(bottom: 20),
// //       elevation: isDark ? 0 : 3,
// //       color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// //       shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(20),
// //           side: isDark ? const BorderSide(color: Colors.white10) : BorderSide.none
// //       ),
// //       child: Column(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// //             decoration: BoxDecoration(
// //               color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
// //               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// //             ),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Text("ORDER #${id.substring(0, 5).toUpperCase()}",
// //                     style: TextStyle(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 11,
// //                         color: isDark ? Colors.white70 : Colors.black87,
// //                         letterSpacing: 1
// //                     )
// //                 ),
// //                 Text(displayTime, style: const TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
// //               ],
// //             ),
// //           ),
// //
// //           Padding(
// //             padding: const EdgeInsets.all(15),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 _fetchFoodDetailsHeader(data['postId'] ?? "", isDark),
// //                 const Divider(height: 25, thickness: 0.5),
// //                 _buildContactRow(
// //                   title: "PICKUP FROM (DONOR)",
// //                   uid: data['donorId'] ?? "",
// //                   icon: Icons.location_on,
// //                   color: Colors.redAccent,
// //                   isDark: isDark,
// //                 ),
// //                 const SizedBox(height: 18),
// //                 _buildContactRow(
// //                   title: "DELIVER TO (RECEIVER)",
// //                   uid: data['receiverId'] ?? "",
// //                   icon: Icons.near_me,
// //                   color: Colors.blueAccent,
// //                   isDark: isDark,
// //                 ),
// //                 if (tab != 2) ...[
// //                   const SizedBox(height: 20),
// //                   _buildBtn(tab, id, vp, auth, data),
// //                 ]
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color, required bool isDark}) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
// //       builder: (context, snapshot) {
// //         final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
// //         final String name = profile['contactPerson'] ?? "Loading...";
// //         final String address = profile['address'] ?? "Address not specified";
// //         final String phone = profile['phone'] ?? "N/A";
// //
// //         return Row(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Icon(icon, size: 20, color: color),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isDark ? Colors.grey : Colors.grey[600])),
// //                   Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
// //                   Text(address, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
// //                   Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _fetchFoodDetailsHeader(String pid, bool isDark) {
// //     return FutureBuilder<DocumentSnapshot>(
// //       future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
// //       builder: (context, snapshot) {
// //         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
// //         final String food = d['foodName'] ?? "Food Item";
// //         final String time = d['pickupTime'] ?? "ASAP";
// //
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(child: Text(food, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green))),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //               decoration: BoxDecoration(
// //                   color: Colors.orange.withOpacity(isDark ? 0.2 : 0.1),
// //                   borderRadius: BorderRadius.circular(8)
// //               ),
// //               child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
// //             )
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
// //     bool loading = _loadingRequestId == id && _isActionProcessing;
// //     String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "ACCEPT REQUEST") : "MARK AS COMPLETED";
// //
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 48,
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: AppColor.green,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //           elevation: 0,
// //         ),
// //         onPressed: loading ? null : () async {
// //           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
// //           try {
// //             if (tab == 0) {
// //               if (data['status'] == 'delivered') {
// //                 await vp.confirmPickup(id);
// //               } else {
// //                 await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
// //               }
// //             } else {
// //               await vp.completeDelivery(
// //                   requestId: id,
// //                   volunteerId: auth.user?.uid ?? "",
// //                   donorId: data['donorId'] ?? "",
// //                   receiverId: data['receiverId'] ?? ""
// //               );
// //             }
// //           } catch (e) {
// //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
// //           } finally {
// //             if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
// //           }
// //         },
// //         child: loading
// //             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
// //             : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
// //       ),
// //     );
// //   }
// // }
//
//
//
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       children: [
//         TabBar(
//           controller: widget.tabController,
//           labelColor: AppColor.green,
//           unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
//           indicatorColor: AppColor.green,
//           indicatorSize: TabBarIndicatorSize.label,
//           isScrollable: true,
//           tabAlignment: TabAlignment.start,
//           dividerColor: Colors.transparent,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return StreamBuilder<QuerySnapshot>(
//       stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
//       tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
//       vProvider.getCompletedDeliveries(userUid),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return const Center(child: Text("Error fetching data", style: TextStyle(color: Colors.red)));
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//
//         if (docs.isEmpty) {
//           return _buildEmptyState(tabIndex, isDark);
//         }
//
//         return Column(
//           children: [
//             // Centered Header for Available Tab
//             if (tabIndex == 0)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         "Requests Near You",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: isDark ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "Claim a request below to start delivering.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: isDark ? Colors.white60 : Colors.black54,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         height: 2,
//                         width: 40,
//                         color: AppColor.green.withOpacity(0.5),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 itemCount: docs.length,
//                 itemBuilder: (context, index) {
//                   final data = docs[index].data() as Map<String, dynamic>? ?? {};
//                   final String reqId = docs[index].id;
//
//                   if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
//                     return const SizedBox.shrink();
//                   }
//
//                   return _buildCard(data, reqId, tabIndex, vProvider, authProvider, isDark);
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildEmptyState(int index, bool isDark) {
//     if (index == 0) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Opacity(
//             opacity: 0.6,
//             child: Card(
//               elevation: 0,
//               color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade300),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.restaurant_outlined, size: 60, color: AppColor.green.withOpacity(0.3)),
//                     const SizedBox(height: 15),
//                     const Text("No Requests Available", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Donors haven't posted any food nearby. Please check back later!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.inbox_outlined, size: 50, color: AppColor.green.withOpacity(0.3)),
//           const SizedBox(height: 10),
//           Text(
//             index == 1 ? "No ongoing deliveries" : "No delivery history",
//             style: TextStyle(color: isDark ? Colors.white60 : Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth, bool isDark) {
//     String displayTime = "N/A";
//     Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
//     if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());
//
//     return Card(
//       margin: const EdgeInsets.only(bottom: 20),
//       elevation: isDark ? 0 : 3,
//       color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//           side: isDark ? const BorderSide(color: Colors.white10) : BorderSide.none
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//             decoration: BoxDecoration(
//               color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("ORDER #${id.substring(0, 5).toUpperCase()}",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 11,
//                         color: isDark ? Colors.white70 : Colors.black87,
//                         letterSpacing: 1
//                     )
//                 ),
//                 Text(displayTime, style: const TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _fetchFoodDetailsHeader(data['postId'] ?? "", isDark),
//                 const Divider(height: 25, thickness: 0.5),
//                 _buildContactRow(
//                   title: "PICKUP FROM (DONOR)",
//                   uid: data['donorId'] ?? "",
//                   icon: Icons.location_on,
//                   color: Colors.redAccent,
//                   isDark: isDark,
//                 ),
//                 const SizedBox(height: 18),
//                 _buildContactRow(
//                   title: "DELIVER TO (RECEIVER)",
//                   uid: data['receiverId'] ?? "",
//                   icon: Icons.near_me,
//                   color: Colors.blueAccent,
//                   isDark: isDark,
//                 ),
//                 if (tab != 2) ...[
//                   const SizedBox(height: 20),
//                   _buildBtn(tab, id, vp, auth, data),
//                 ]
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color, required bool isDark}) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
//       builder: (context, snapshot) {
//         final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
//         final String name = profile['contactPerson'] ?? "Loading...";
//         final String address = profile['address'] ?? "Address not specified";
//         final String phone = profile['phone'] ?? "N/A";
//
//         return Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, size: 20, color: color),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isDark ? Colors.grey : Colors.grey[600])),
//                   Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
//                   Text(address, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
//                   Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _fetchFoodDetailsHeader(String pid, bool isDark) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: FirebaseFirestore.instance.collection('posts').doc(pid).get(),
//       builder: (context, snapshot) {
//         final d = snapshot.data?.data() as Map<String, dynamic>? ?? {};
//         final String food = d['foodName'] ?? "Food Item";
//         final String time = d['pickupTime'] ?? "ASAP";
//
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(child: Text(food, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.green))),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                   color: Colors.orange.withOpacity(isDark ? 0.2 : 0.1),
//                   borderRadius: BorderRadius.circular(8)
//               ),
//               child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
//     bool loading = _loadingRequestId == id && _isActionProcessing;
//     String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "ACCEPT REQUEST") : "MARK AS COMPLETED";
//
//     return SizedBox(
//       width: double.infinity,
//       height: 48,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppColor.green,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           elevation: 0,
//         ),
//         onPressed: loading ? null : () async {
//           setState(() { _loadingRequestId = id; _isActionProcessing = true; });
//           try {
//             if (tab == 0) {
//               if (data['status'] == 'delivered') {
//                 await vp.confirmPickup(id);
//               } else {
//                 await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
//               }
//             } else {
//               await vp.completeDelivery(
//                   requestId: id,
//                   volunteerId: auth.user?.uid ?? "",
//                   donorId: data['donorId'] ?? "",
//                   receiverId: data['receiverId'] ?? ""
//               );
//             }
//           } catch (e) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
//           } finally {
//             if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
//           }
//         },
//         child: loading
//             ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
//             : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
//       ),
//     );
//   }
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        TabBar(
          controller: widget.tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: isDark ? Colors.white70 : Colors.black54,
          indicatorColor: AppColor.green,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<QuerySnapshot>(
      stream: tabIndex == 0 ? vProvider.getAvailableRequests() :
      tabIndex == 1 ? vProvider.getMyDeliveries(userUid) :
      vProvider.getCompletedDeliveries(userUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error fetching data", style: TextStyle(color: Colors.red)));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return _buildEmptyState(tabIndex, isDark);
        }

        // --- CENTERED LAYOUT FOR AVAILABLE CARDS ---
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Shrinks column to fit children
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (tabIndex == 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Requests Near You",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Claim a request below to start delivering.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(height: 3, width: 30, decoration: BoxDecoration(color: AppColor.green, borderRadius: BorderRadius.circular(10))),
                      ],
                    ),
                  ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shrinkWrap: true, // IMPORTANT: Makes list take only needed space
                  physics: const NeverScrollableScrollPhysics(), // Scroll handled by SingleChildScrollView
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>? ?? {};
                    final String reqId = docs[index].id;

                    if (tabIndex == 0 && data['status'] == 'delivered' && data['volunteerId'] != userUid) {
                      return const SizedBox.shrink();
                    }

                    return _buildCard(data, reqId, tabIndex, vProvider, authProvider, isDark);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(int index, bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Opacity(
          opacity: 0.6,
          child: Card(
            elevation: 0,
            color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                      index == 0 ? Icons.restaurant_outlined :
                      index == 1 ? Icons.local_shipping_outlined : Icons.history,
                      size: 60, color: AppColor.green.withOpacity(0.3)
                  ),
                  const SizedBox(height: 15),
                  Text(
                      index == 0 ? "No Requests Available" :
                      index == 1 ? "No Active Deliveries" : "No History Found",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                  ),
                  const SizedBox(height: 10),
                  Text(
                    index == 0 ? "Donors haven't posted any food nearby. Check back later!" :
                    index == 1 ? "You aren't delivering anything right now." : "Your delivery logs will appear here.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> data, String id, int tab, VolunteerProvider vp, GenericAuthProvider auth, bool isDark) {
    String displayTime = "N/A";
    Timestamp? ts = (tab == 0) ? data['createdAt'] : (tab == 1) ? data['pickupAt'] : data['completedAt'];
    if (ts != null) displayTime = DateFormat('hh:mm a, dd MMM').format(ts.toDate());

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: isDark ? 0 : 3,
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isDark ? const BorderSide(color: Colors.white10) : BorderSide.none
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: tab == 2 ? Colors.grey.withOpacity(0.1) : AppColor.green.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("ORDER #${id.substring(0, 5).toUpperCase()}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: isDark ? Colors.white70 : Colors.black87,
                        letterSpacing: 1
                    )
                ),
                Text(displayTime, style: const TextStyle(fontSize: 10, color: AppColor.green, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fetchFoodDetailsHeader(data['postId'] ?? "", isDark),
                const Divider(height: 25, thickness: 0.5),
                _buildContactRow(
                  title: "PICKUP FROM (DONOR)",
                  uid: data['donorId'] ?? "",
                  icon: Icons.location_on,
                  color: Colors.redAccent,
                  isDark: isDark,
                ),
                const SizedBox(height: 18),
                _buildContactRow(
                  title: "DELIVER TO (RECEIVER)",
                  uid: data['receiverId'] ?? "",
                  icon: Icons.near_me,
                  color: Colors.blueAccent,
                  isDark: isDark,
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

  Widget _buildContactRow({required String title, required String uid, required IconData icon, required Color color, required bool isDark}) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('accounts').doc(uid).get(),
      builder: (context, snapshot) {
        final profile = (snapshot.data?.data() as Map<String, dynamic>?)?['profile'] ?? {};
        final String name = profile['contactPerson'] ?? "Loading...";
        final String address = profile['address'] ?? "Address not specified";
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
                  Text(title, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isDark ? Colors.grey : Colors.grey[600])),
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDark ? Colors.white : Colors.black)),
                  Text(address, style: TextStyle(fontSize: 12, color: isDark ? Colors.white70 : Colors.black87)),
                  Text("📞 $phone", style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _fetchFoodDetailsHeader(String pid, bool isDark) {
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
              decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Text("🕒 $time", style: const TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
            )
          ],
        );
      },
    );
  }

  Widget _buildBtn(int tab, String id, VolunteerProvider vp, GenericAuthProvider auth, Map<String, dynamic> data) {
    bool loading = _loadingRequestId == id && _isActionProcessing;
    String btnText = tab == 0 ? (data['status'] == 'delivered' ? "CONFIRM PICKUP" : "ACCEPT REQUEST") : "MARK AS COMPLETED";

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
              if (data['status'] == 'delivered') {
                await vp.confirmPickup(id);
              } else {
                await vp.requestPickup(id, auth.user?.uid ?? "", auth.userData?['profile']?['contactPerson'] ?? "Volunteer");
              }
            } else {
              await vp.completeDelivery(
                  requestId: id,
                  volunteerId: auth.user?.uid ?? "",
                  donorId: data['donorId'] ?? "",
                  receiverId: data['receiverId'] ?? ""
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
          } finally {
            if (mounted) setState(() { _loadingRequestId = null; _isActionProcessing = false; });
          }
        },
        child: loading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text(btnText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
      ),
    );
  }
}