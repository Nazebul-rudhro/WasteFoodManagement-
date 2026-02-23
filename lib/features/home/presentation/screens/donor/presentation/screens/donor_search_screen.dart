// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // // // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // // // // //
// // // // // // class DonorSearchScreen extends StatefulWidget {
// // // // // //   const DonorSearchScreen({super.key});
// // // // // //
// // // // // //   @override
// // // // // //   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// // // // // // }
// // // // // //
// // // // // // class _DonorSearchScreenState extends State<DonorSearchScreen> {
// // // // // //   String _searchQuery = "";
// // // // // //   final DateTime _now = DateTime.now(); // বর্তমান সময়
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       body: BaseScreen(
// // // // // //         child: Padding(
// // // // // //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // //           child: Column(
// // // // // //             children: [
// // // // // //               const SizedBox(height: 20),
// // // // // //               // --- ১. সার্চ বার ---
// // // // // //               TextField(
// // // // // //                 onChanged: (value) {
// // // // // //                   setState(() {
// // // // // //                     _searchQuery = value.toLowerCase();
// // // // // //                   });
// // // // // //                 },
// // // // // //                 decoration: InputDecoration(
// // // // // //                   hintText: "Search available food...",
// // // // // //                   prefixIcon: const Icon(Icons.search, color: AppColor.green),
// // // // // //                   filled: true,
// // // // // //                   fillColor: Colors.grey[100],
// // // // // //                   border: OutlineInputBorder(
// // // // // //                     borderRadius: BorderRadius.circular(15),
// // // // // //                     borderSide: BorderSide.none,
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //               const SizedBox(height: 10),
// // // // // //
// // // // // //               // --- ২. লাইভ ডাটা লিস্ট ---
// // // // // //               Expanded(
// // // // // //                 child: StreamBuilder<QuerySnapshot>(
// // // // // //                   stream: FirebaseFirestore.instance.collection('posts').snapshots(),
// // // // // //                   builder: (context, snapshot) {
// // // // // //                     if (snapshot.hasError) {
// // // // // //                       return const Center(child: Text("Connection Error"));
// // // // // //                     }
// // // // // //
// // // // // //                     if (snapshot.connectionState == ConnectionState.waiting) {
// // // // // //                       return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // // //                     }
// // // // // //
// // // // // //                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // // //                       return const Center(child: Text("No food items found"));
// // // // // //                     }
// // // // // //
// // // // // //                     // ডাঁটা ফিল্টারিং লজিক (Status + Expiry + Search)
// // // // // //                     final filteredDocs = snapshot.data!.docs.where((doc) {
// // // // // //                       final data = doc.data() as Map<String, dynamic>;
// // // // // //
// // // // // //                       // ক. স্ট্যাটাস চেক
// // // // // //                       bool isNotCompleted = data['status'] != "completed";
// // // // // //
// // // // // //                       // খ. এক্সপায়ারি ডেট চেক (Timestamp handle)
// // // // // //                       bool isNotExpired = true;
// // // // // //                       if (data['expiryDate'] != null) {
// // // // // //                         DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
// // // // // //                         isNotExpired = expiry.isAfter(_now); // যদি এক্সপায়ারি টাইম বর্তমানের চেয়ে বেশি হয়
// // // // // //                       }
// // // // // //
// // // // // //                       // গ. সার্চ কুয়েরি চেক
// // // // // //                       String foodName = (data['foodName'] ?? "").toString().toLowerCase();
// // // // // //                       bool matchesSearch = foodName.contains(_searchQuery);
// // // // // //
// // // // // //                       return isNotCompleted && isNotExpired && matchesSearch;
// // // // // //                     }).toList();
// // // // // //
// // // // // //                     if (filteredDocs.isEmpty) {
// // // // // //                       return const Center(child: Text("No fresh food available at this moment."));
// // // // // //                     }
// // // // // //
// // // // // //                     return ListView.builder(
// // // // // //                       itemCount: filteredDocs.length,
// // // // // //                       physics: const BouncingScrollPhysics(),
// // // // // //                       itemBuilder: (context, index) {
// // // // // //                         final doc = filteredDocs[index];
// // // // // //                         final data = doc.data() as Map<String, dynamic>;
// // // // // //
// // // // // //                         return Card(
// // // // // //                           elevation: 0,
// // // // // //                           margin: const EdgeInsets.only(bottom: 12),
// // // // // //                           shape: RoundedRectangleBorder(
// // // // // //                             borderRadius: BorderRadius.circular(12),
// // // // // //                             side: BorderSide(color: Colors.grey.shade200),
// // // // // //                           ),
// // // // // //                           child: ListTile(
// // // // // //                             contentPadding: const EdgeInsets.all(10),
// // // // // //                             leading: ClipRRect(
// // // // // //                               borderRadius: BorderRadius.circular(8),
// // // // // //                               child: _buildImage(data['imageUrls']),
// // // // // //                             ),
// // // // // //                             title: Text(
// // // // // //                               data['foodName'] ?? "Unnamed Item",
// // // // // //                               style: const TextStyle(fontWeight: FontWeight.bold),
// // // // // //                             ),
// // // // // //                             subtitle: Text(
// // // // // //                               "Expires: ${data['pickupTime'] ?? 'N/A'}\nLocation: ${data['pickupAddress'] ?? 'N/A'}",
// // // // // //                               style: const TextStyle(fontSize: 12),
// // // // // //                             ),
// // // // // //                             trailing: const Icon(Icons.chevron_right, color: AppColor.green),
// // // // // //                             onTap: () {
// // // // // //                               // Details স্ক্রিনে যাওয়ার কোড এখানে দিন
// // // // // //                             },
// // // // // //                           ),
// // // // // //                         );
// // // // // //                       },
// // // // // //                     );
// // // // // //                   },
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // ইমেজের জন্য আলাদা উইজেট (যাতে এরর না আসে)
// // // // // //   Widget _buildImage(dynamic urls) {
// // // // // //     if (urls != null && urls is List && urls.isNotEmpty) {
// // // // // //       return Image.network(
// // // // // //         urls[0],
// // // // // //         width: 60,
// // // // // //         height: 60,
// // // // // //         fit: BoxFit.cover,
// // // // // //         errorBuilder: (context, error, stackTrace) => _defaultIcon(),
// // // // // //       );
// // // // // //     }
// // // // // //     return _defaultIcon();
// // // // // //   }
// // // // // //
// // // // // //   Widget _defaultIcon() {
// // // // // //     return Container(
// // // // // //       width: 60,
// // // // // //       height: 60,
// // // // // //       color: Colors.grey[200],
// // // // // //       child: const Icon(Icons.fastfood, color: Colors.grey),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // //
// // // // // //
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // // // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // // // // //
// // // // // // class DonorSearchScreen extends StatefulWidget {
// // // // // //   const DonorSearchScreen({super.key});
// // // // // //
// // // // // //   @override
// // // // // //   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// // // // // // }
// // // // // //
// // // // // // class _DonorSearchScreenState extends State<DonorSearchScreen> {
// // // // // //   String _searchQuery = "";
// // // // // //   final DateTime _now = DateTime.now();
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: Colors.white,
// // // // // //       appBar: AppBar(_buildHeader(),),
// // // // // //       body: BaseScreen(
// // // // // //         child: Column(
// // // // // //           children: [
// // // // // //             // --- ১. কাস্টম হেডার ও সার্চ এরিয়া ---
// // // // // //
// // // // // //
// // // // // //             // --- ২. লাইভ ডাটা লিস্ট ---
// // // // // //             Expanded(
// // // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // // //                 stream: FirebaseFirestore.instance.collection('posts').snapshots(),
// // // // // //                 builder: (context, snapshot) {
// // // // // //                   if (snapshot.hasError) return _buildInfoMessage("Connection Error");
// // // // // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // // // // //                     return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // // //                   }
// // // // // //                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // // //                     return _buildInfoMessage("No food items available.");
// // // // // //                   }
// // // // // //
// // // // // //                   // ডাঁটা ফিল্টারিং (Status + Expiry + Search)
// // // // // //                   final filteredDocs = snapshot.data!.docs.where((doc) {
// // // // // //                     final data = doc.data() as Map<String, dynamic>;
// // // // // //                     bool isNotCompleted = data['status'] != "completed";
// // // // // //                     bool isNotExpired = true;
// // // // // //                     if (data['expiryDate'] != null) {
// // // // // //                       DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
// // // // // //                       isNotExpired = expiry.isAfter(_now);
// // // // // //                     }
// // // // // //                     String foodName = (data['foodName'] ?? "").toString().toLowerCase();
// // // // // //                     return isNotCompleted && isNotExpired && foodName.contains(_searchQuery);
// // // // // //                   }).toList();
// // // // // //
// // // // // //                   if (filteredDocs.isEmpty) {
// // // // // //                     return _buildInfoMessage("No active matches found.");
// // // // // //                   }
// // // // // //
// // // // // //                   return ListView.builder(
// // // // // //                     itemCount: filteredDocs.length,
// // // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // // //                     physics: const BouncingScrollPhysics(),
// // // // // //                     itemBuilder: (context, index) {
// // // // // //                       final data = filteredDocs[index].data() as Map<String, dynamic>;
// // // // // //                       return _buildFoodCard(data);
// // // // // //                     },
// // // // // //                   );
// // // // // //                 },
// // // // // //               ),
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // --- হেডার ডিজাইন ---
// // // // // //   Widget _buildHeader() {
// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 25),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: AppColor.green.withOpacity(0.1),
// // // // // //         borderRadius: const BorderRadius.only(
// // // // // //           bottomLeft: Radius.circular(30),
// // // // // //           bottomRight: Radius.circular(30),
// // // // // //         ),
// // // // // //       ),
// // // // // //       child: Column(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           const Text(
// // // // // //             "Available Food 🍏",
// // // // // //             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
// // // // // //           ),
// // // // // //           const SizedBox(height: 15),
// // // // // //           TextField(
// // // // // //             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
// // // // // //             decoration: InputDecoration(
// // // // // //               hintText: "Search by food name...",
// // // // // //               prefixIcon: const Icon(Icons.search, color: AppColor.green),
// // // // // //               filled: true,
// // // // // //               fillColor: Colors.white,
// // // // // //               border: OutlineInputBorder(
// // // // // //                 borderRadius: BorderRadius.circular(15),
// // // // // //                 borderSide: BorderSide.none,
// // // // // //               ),
// // // // // //               contentPadding: EdgeInsets.zero,
// // // // // //             ),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // --- লিস্ট কার্ড ডিজাইন ---
// // // // // //   Widget _buildFoodCard(Map<String, dynamic> data) {
// // // // // //     return Container(
// // // // // //       margin: const EdgeInsets.only(bottom: 16),
// // // // // //       decoration: BoxDecoration(
// // // // // //         color: Colors.white,
// // // // // //         borderRadius: BorderRadius.circular(20),
// // // // // //         boxShadow: [
// // // // // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
// // // // // //         ],
// // // // // //       ),
// // // // // //       child: InkWell(
// // // // // //         onTap: () => _showProductDetails(context, data), // ক্লিক করলে এলার্ট দেখাবে
// // // // // //         borderRadius: BorderRadius.circular(20),
// // // // // //         child: Row(
// // // // // //           children: [
// // // // // //             // ইমেজ
// // // // // //             SizedBox(
// // // // // //               width: 100,
// // // // // //               height: 100,
// // // // // //               child: ClipRRect(
// // // // // //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
// // // // // //                 child: _buildImage(data['imageUrls']),
// // // // // //               ),
// // // // // //             ),
// // // // // //             // টেক্সট তথ্য
// // // // // //             Expanded(
// // // // // //               child: Padding(
// // // // // //                 padding: const EdgeInsets.all(12),
// // // // // //                 child: Column(
// // // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                   children: [
// // // // // //                     Text(
// // // // // //                       data['foodName'] ?? "Unnamed",
// // // // // //                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// // // // // //                       maxLines: 1, overflow: TextOverflow.ellipsis,
// // // // // //                     ),
// // // // // //                     const SizedBox(height: 4),
// // // // // //                     Text("📍 ${data['pickupAddress'] ?? 'N/A'}", style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1),
// // // // // //                     const SizedBox(height: 8),
// // // // // //                     Row(
// // // // // //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // // //                       children: [
// // // // // //                         _buildBadge(data['foodType'] ?? "Food", AppColor.green),
// // // // // //                         const Icon(Icons.arrow_forward_outlined, color: AppColor.green, size: 20),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   // --- ক্লিক করলে যে এলার্ট দেখাবে ---
// // // // // //   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder: (context) => Dialog(
// // // // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // // // //         child: SingleChildScrollView(
// // // // // //           child: Column(
// // // // // //             mainAxisSize: MainAxisSize.min,
// // // // // //             children: [
// // // // // //               Stack(
// // // // // //                 children: [
// // // // // //                   ClipRRect(
// // // // // //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// // // // // //                     child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
// // // // // //                   ),
// // // // // //                   Positioned(right: 10, top: 10, child: CircleAvatar(backgroundColor: Colors.white, child: CloseButton(onPressed: () => Navigator.pop(context)))),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               Padding(
// // // // // //                 padding: const EdgeInsets.all(20),
// // // // // //                 child: Column(
// // // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                   children: [
// // // // // //                     Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // // // //                     const SizedBox(height: 15),
// // // // // //                     _detailRow(Icons.info_outline, "Condition", data['foodCondition'] ?? "N/A"),
// // // // // //                     _detailRow(Icons.group_outlined, "Serves", "${data['estimatePersons'] ?? '0'} Persons"),
// // // // // //                     _detailRow(Icons.access_time, "Pickup", data['pickupTime'] ?? "N/A"),
// // // // // //                     _detailRow(Icons.location_on_outlined, "Address", data['pickupAddress'] ?? "N/A"),
// // // // // //                     _detailRow(Icons.notes, "Notes", data['description'] ?? "No notes provided."),
// // // // // //                     const SizedBox(height: 20),
// // // // // //                     SizedBox(
// // // // // //                       width: double.infinity,
// // // // // //                       child: ElevatedButton(
// // // // // //                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
// // // // // //                         onPressed: () => Navigator.pop(context),
// // // // // //                         child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _detailRow(IconData icon, String label, String value) {
// // // // // //     return Padding(
// // // // // //       padding: const EdgeInsets.only(bottom: 10),
// // // // // //       child: Row(
// // // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //         children: [
// // // // // //           Icon(icon, size: 18, color: AppColor.green),
// // // // // //           const SizedBox(width: 10),
// // // // // //           Expanded(child: Text("$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black87))),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _buildBadge(String label, Color color) {
// // // // // //     return Container(
// // // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// // // // // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
// // // // // //       child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
// // // // // //     );
// // // // // //   }
// // // // // //
// // // // // //   Widget _buildImage(dynamic urls, {double? height, double? width}) {
// // // // // //     if (urls != null && urls is List && urls.isNotEmpty) {
// // // // // //       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover, errorBuilder: (c, e, s) => _defaultIcon());
// // // // // //     }
// // // // // //     return _defaultIcon();
// // // // // //   }
// // // // // //
// // // // // //   Widget _defaultIcon() {
// // // // // //     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey));
// // // // // //   }
// // // // // //
// // // // // //   Widget _buildInfoMessage(String msg) {
// // // // // //     return Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // // // //
// // // // // class DonorSearchScreen extends StatefulWidget {
// // // // //   const DonorSearchScreen({super.key});
// // // // //
// // // // //   @override
// // // // //   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// // // // // }
// // // // //
// // // // // class _DonorSearchScreenState extends State<DonorSearchScreen> {
// // // // //   String _searchQuery = "";
// // // // //   final DateTime _now = DateTime.now();
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       // AppBar এর উচ্চতা কিছুটা বাড়িয়ে দেওয়া হয়েছে যাতে ডিজাইন সুন্দর দেখায়
// // // // //       appBar: PreferredSize(
// // // // //         preferredSize: const Size.fromHeight(150),
// // // // //         child: AppBar(
// // // // //           backgroundColor: Colors.transparent,
// // // // //           elevation: 0,
// // // // //           flexibleSpace: _buildHeader(),
// // // // //         ),
// // // // //       ),
// // // // //       body: BaseScreen(
// // // // //         child: Column(
// // // // //           children: [
// // // // //             const SizedBox(height: 10),
// // // // //             // --- ২. লাইভ ডাটা লিস্ট ---
// // // // //             Expanded(
// // // // //               child: StreamBuilder<QuerySnapshot>(
// // // // //                 stream: FirebaseFirestore.instance.collection('posts').snapshots(),
// // // // //                 builder: (context, snapshot) {
// // // // //                   if (snapshot.hasError) return _buildInfoMessage("Connection Error");
// // // // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // // // //                     return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // //                   }
// // // // //                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // //                     return _buildInfoMessage("No food items available.");
// // // // //                   }
// // // // //
// // // // //                   // ডাঁটা ফিল্টারিং (Status + Expiry + Search)
// // // // //                   final filteredDocs = snapshot.data!.docs.where((doc) {
// // // // //                     final data = doc.data() as Map<String, dynamic>;
// // // // //                     bool isNotCompleted = data['status'] != "completed";
// // // // //                     bool isNotExpired = true;
// // // // //                     if (data['expiryDate'] != null) {
// // // // //                       DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
// // // // //                       isNotExpired = expiry.isAfter(_now);
// // // // //                     }
// // // // //                     String foodName = (data['foodName'] ?? "").toString().toLowerCase();
// // // // //                     return isNotCompleted && isNotExpired && foodName.contains(_searchQuery);
// // // // //                   }).toList();
// // // // //
// // // // //                   if (filteredDocs.isEmpty) {
// // // // //                     return _buildInfoMessage("No active matches found.");
// // // // //                   }
// // // // //
// // // // //                   return ListView.builder(
// // // // //                     itemCount: filteredDocs.length,
// // // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // // //                     physics: const BouncingScrollPhysics(),
// // // // //                     itemBuilder: (context, index) {
// // // // //                       final data = filteredDocs[index].data() as Map<String, dynamic>;
// // // // //                       return _buildFoodCard(data);
// // // // //                     },
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // --- হেডার ডিজাইন (AppBar এর জন্য) ---
// // // // //   Widget _buildHeader() {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
// // // // //       decoration: BoxDecoration(
// // // // //         color: AppColor.green.withOpacity(0.1),
// // // // //         borderRadius: const BorderRadius.only(
// // // // //           bottomLeft: Radius.circular(30),
// // // // //           bottomRight: Radius.circular(30),
// // // // //         ),
// // // // //       ),
// // // // //       child: Column(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         mainAxisAlignment: MainAxisAlignment.end,
// // // // //         children: [
// // // // //           const Text(
// // // // //             "Available Food 🍏",
// // // // //             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
// // // // //           ),
// // // // //           const SizedBox(height: 15),
// // // // //           TextField(
// // // // //             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
// // // // //             decoration: InputDecoration(
// // // // //               hintText: "Search by food name...",
// // // // //               prefixIcon: const Icon(Icons.search, color: AppColor.green),
// // // // //               filled: true,
// // // // //               fillColor: Colors.white,
// // // // //               border: OutlineInputBorder(
// // // // //                 borderRadius: BorderRadius.circular(15),
// // // // //                 borderSide: BorderSide.none,
// // // // //               ),
// // // // //               contentPadding: EdgeInsets.zero,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // --- আপনার পছন্দমতো সাজানো লিস্ট কার্ড ডিজাইন ---
// // // // //   Widget _buildFoodCard(Map<String, dynamic> data) {
// // // // //     return Container(
// // // // //       margin: const EdgeInsets.only(bottom: 16),
// // // // //       decoration: BoxDecoration(
// // // // //         color: Colors.white,
// // // // //         borderRadius: BorderRadius.circular(20),
// // // // //         boxShadow: [
// // // // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
// // // // //         ],
// // // // //       ),
// // // // //       child: InkWell(
// // // // //         onTap: () => _showProductDetails(context, data),
// // // // //         borderRadius: BorderRadius.circular(20),
// // // // //         child: Row(
// // // // //           children: [
// // // // //             // ইমেজ সেকশন
// // // // //             SizedBox(
// // // // //               width: 110,
// // // // //               height: 110,
// // // // //               child: ClipRRect(
// // // // //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
// // // // //                 child: _buildImage(data['imageUrls']),
// // // // //               ),
// // // // //             ),
// // // // //             // আপনার ক্রম অনুযায়ী তথ্য সেকশন
// // // // //             Expanded(
// // // // //               child: Padding(
// // // // //                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     // ১. Food Name
// // // // //                     Text(
// // // // //                       data['foodName'] ?? "Unnamed Food",
// // // // //                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black87),
// // // // //                       maxLines: 1, overflow: TextOverflow.ellipsis,
// // // // //                     ),
// // // // //                     const SizedBox(height: 4),
// // // // //                     // ২. Food Type
// // // // //                     _buildBadge(data['foodType'] ?? "General", AppColor.green),
// // // // //                     const SizedBox(height: 6),
// // // // //                     // ৩. Pickup Time
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         const Icon(Icons.access_time, size: 14, color: Colors.orange),
// // // // //                         const SizedBox(width: 5),
// // // // //                         Text(
// // // // //                           data['pickupTime'] ?? "N/A",
// // // // //                           style: const TextStyle(fontSize: 12, color: Colors.black54),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     const SizedBox(height: 4),
// // // // //                     // ৪. Location
// // // // //                     Row(
// // // // //                       children: [
// // // // //                         const Icon(Icons.location_on_outlined, size: 14, color: Colors.redAccent),
// // // // //                         const SizedBox(width: 5),
// // // // //                         Expanded(
// // // // //                           child: Text(
// // // // //                             data['pickupAddress'] ?? "N/A",
// // // // //                             style: const TextStyle(fontSize: 12, color: Colors.grey),
// // // // //                             maxLines: 1, overflow: TextOverflow.ellipsis,
// // // // //                           ),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   // --- ফুল ইনফরমেশন এলার্ট ---
// // // // //   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) => Dialog(
// // // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // // //         child: SingleChildScrollView(
// // // // //           child: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               Stack(
// // // // //                 children: [
// // // // //                   ClipRRect(
// // // // //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// // // // //                     child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
// // // // //                   ),
// // // // //                   Positioned(
// // // // //                       right: 10,
// // // // //                       top: 10,
// // // // //                       child: CircleAvatar(
// // // // //                           backgroundColor: Colors.white,
// // // // //                           child: CloseButton(onPressed: () => Navigator.pop(context))
// // // // //                       )
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               Padding(
// // // // //                 padding: const EdgeInsets.all(20),
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // // //                     const SizedBox(height: 15),
// // // // //                     _detailRow(Icons.category_outlined, "Food Type", data['foodType'] ?? "General"),
// // // // //                     _detailRow(Icons.info_outline, "Condition", data['foodCondition'] ?? "N/A"),
// // // // //                     _detailRow(Icons.group_outlined, "Serves", "${data['estimatePersons'] ?? '0'} Persons"),
// // // // //                     _detailRow(Icons.access_time, "Pickup Time", data['pickupTime'] ?? "N/A"),
// // // // //                     _detailRow(Icons.location_on_outlined, "Location", data['pickupAddress'] ?? "N/A"),
// // // // //                     _detailRow(Icons.notes, "Notes", data['description'] ?? "No notes provided."),
// // // // //                     const SizedBox(height: 20),
// // // // //                     SizedBox(
// // // // //                       width: double.infinity,
// // // // //                       child: ElevatedButton(
// // // // //                         style: ElevatedButton.styleFrom(
// // // // //                             backgroundColor: AppColor.green,
// // // // //                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
// // // // //                         ),
// // // // //                         onPressed: () => Navigator.pop(context),
// // // // //                         child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _detailRow(IconData icon, String label, String value) {
// // // // //     return Padding(
// // // // //       padding: const EdgeInsets.only(bottom: 10),
// // // // //       child: Row(
// // // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // // //         children: [
// // // // //           Icon(icon, size: 18, color: AppColor.green),
// // // // //           const SizedBox(width: 10),
// // // // //           Expanded(child: Text("$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black87))),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildBadge(String label, Color color) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// // // // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
// // // // //       child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
// // // // //     );
// // // // //   }
// // // // //
// // // // //   Widget _buildImage(dynamic urls, {double? height, double? width}) {
// // // // //     if (urls != null && urls is List && urls.isNotEmpty) {
// // // // //       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover, errorBuilder: (c, e, s) => _defaultIcon());
// // // // //     }
// // // // //     return _defaultIcon();
// // // // //   }
// // // // //
// // // // //   Widget _defaultIcon() {
// // // // //     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey));
// // // // //   }
// // // // //
// // // // //   Widget _buildInfoMessage(String msg) {
// // // // //     return Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// // // // //   }
// // // // // }
// // // //
// // // //
// // // //
// // // //
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // // //
// // // // class DonorSearchScreen extends StatefulWidget {
// // // //   const DonorSearchScreen({super.key});
// // // //
// // // //   @override
// // // //   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// // // // }
// // // //
// // // // class _DonorSearchScreenState extends State<DonorSearchScreen> {
// // // //   String _searchQuery = "";
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     // Protibar build er somoy current time update hobe filter er jonno
// // // //     final DateTime now = DateTime.now();
// // // //
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: PreferredSize(
// // // //         preferredSize: const Size.fromHeight(160),
// // // //         child: AppBar(
// // // //           backgroundColor: Colors.transparent,
// // // //           elevation: 0,
// // // //           flexibleSpace: _buildHeader(),
// // // //         ),
// // // //       ),
// // // //       body: BaseScreen(
// // // //         child: Column(
// // // //           children: [
// // // //             const SizedBox(height: 10),
// // // //             // --- LIVE DATA LIST ---
// // // //             Expanded(
// // // //               child: StreamBuilder<QuerySnapshot>(
// // // //                 stream: FirebaseFirestore.instance.collection('posts').snapshots(),
// // // //                 builder: (context, snapshot) {
// // // //                   if (snapshot.hasError) return _buildInfoMessage("Connection Error");
// // // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // // //                     return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // //                   }
// // // //                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // //                     return _buildInfoMessage("No food items available.");
// // // //                   }
// // // //
// // // //                   // 🔥 STRICT FILTERING LOGIC 🔥
// // // //                   final filteredDocs = snapshot.data!.docs.where((doc) {
// // // //                     final data = doc.data() as Map<String, dynamic>;
// // // //
// // // //                     // 1. Status Check: "completed" hole show hobe na
// // // //                     bool isAvailable = data['status'] != "completed";
// // // //
// // // //                     // 2. Expiry Check: Date par hoye gele show hobe na
// // // //                     bool isNotExpired = true;
// // // //                     if (data['expiryDate'] != null) {
// // // //                       DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
// // // //                       isNotExpired = expiry.isAfter(now); // Expiry time ki ekhonkar cheye beshi?
// // // //                     }
// // // //
// // // //                     // 3. Search Query Check
// // // //                     String foodName = (data['foodName'] ?? "").toString().toLowerCase();
// // // //                     bool matchesSearch = foodName.contains(_searchQuery);
// // // //
// // // //                     // Shob gulo condition true hote hobe
// // // //                     return isAvailable && isNotExpired && matchesSearch;
// // // //                   }).toList();
// // // //
// // // //                   if (filteredDocs.isEmpty) {
// // // //                     return _buildInfoMessage("No fresh food items found.");
// // // //                   }
// // // //
// // // //                   return ListView.builder(
// // // //                     itemCount: filteredDocs.length,
// // // //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// // // //                     physics: const BouncingScrollPhysics(),
// // // //                     itemBuilder: (context, index) {
// // // //                       final data = filteredDocs[index].data() as Map<String, dynamic>;
// // // //                       return _buildFoodCard(data);
// // // //                     },
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Header with Search Bar ---
// // // //   Widget _buildHeader() {
// // // //     return Container(
// // // //       padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColor.green.withOpacity(0.1),
// // // //         borderRadius: const BorderRadius.only(
// // // //           bottomLeft: Radius.circular(30),
// // // //           bottomRight: Radius.circular(30),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         mainAxisAlignment: MainAxisAlignment.end,
// // // //         children: [
// // // //           const Text(
// // // //             "Available Food 🍏",
// // // //             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
// // // //           ),
// // // //           const SizedBox(height: 15),
// // // //           TextField(
// // // //             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
// // // //             decoration: InputDecoration(
// // // //               hintText: "Search by food name...",
// // // //               prefixIcon: const Icon(Icons.search, color: AppColor.green),
// // // //               filled: true,
// // // //               fillColor: Colors.white,
// // // //               border: OutlineInputBorder(
// // // //                 borderRadius: BorderRadius.circular(15),
// // // //                 borderSide: BorderSide.none,
// // // //               ),
// // // //               contentPadding: EdgeInsets.zero,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Professional Food Card ---
// // // //   Widget _buildFoodCard(Map<String, dynamic> data) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 16),
// // // //       decoration: BoxDecoration(
// // // //         color: Colors.white,
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         boxShadow: [
// // // //           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
// // // //         ],
// // // //       ),
// // // //       child: InkWell(
// // // //         onTap: () => _showProductDetails(context, data),
// // // //         borderRadius: BorderRadius.circular(20),
// // // //         child: Row(
// // // //           children: [
// // // //             SizedBox(
// // // //               width: 110,
// // // //               height: 110,
// // // //               child: ClipRRect(
// // // //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
// // // //                 child: _buildImage(data['imageUrls']),
// // // //               ),
// // // //             ),
// // // //             Expanded(
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(data['foodName'] ?? "Unnamed Food", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
// // // //                     const SizedBox(height: 4),
// // // //                     _buildBadge(data['foodType'] ?? "General", AppColor.green),
// // // //                     const SizedBox(height: 6),
// // // //                     Row(
// // // //                       children: [
// // // //                         const Icon(Icons.access_time, size: 14, color: Colors.orange),
// // // //                         const SizedBox(width: 5),
// // // //                         Text(data['pickupTime'] ?? "N/A", style: const TextStyle(fontSize: 12, color: Colors.black54)),
// // // //                       ],
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Row(
// // // //                       children: [
// // // //                         const Icon(Icons.location_on_outlined, size: 14, color: Colors.redAccent),
// // // //                         const SizedBox(width: 5),
// // // //                         Expanded(child: Text(data['pickupAddress'] ?? "N/A", style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // --- Product Information Alert ---
// // // //   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => Dialog(
// // // //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// // // //         child: SingleChildScrollView(
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               Stack(
// // // //                 children: [
// // // //                   ClipRRect(
// // // //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// // // //                     child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
// // // //                   ),
// // // //                   Positioned(right: 10, top: 10, child: CircleAvatar(backgroundColor: Colors.white, child: CloseButton(onPressed: () => Navigator.pop(context)))),
// // // //                 ],
// // // //               ),
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(20),
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// // // //                     const SizedBox(height: 15),
// // // //                     _detailRow(Icons.category_outlined, "Food Type", data['foodType'] ?? "General"),
// // // //                     _detailRow(Icons.info_outline, "Condition", data['foodCondition'] ?? "N/A"),
// // // //                     _detailRow(Icons.group_outlined, "Serves", "${data['estimatePersons'] ?? '0'} Persons"),
// // // //                     _detailRow(Icons.access_time, "Pickup Time", data['pickupTime'] ?? "N/A"),
// // // //                     _detailRow(Icons.location_on_outlined, "Location", data['pickupAddress'] ?? "N/A"),
// // // //                     _detailRow(Icons.notes, "Notes", data['description'] ?? "No notes provided."),
// // // //                     const SizedBox(height: 20),
// // // //                     SizedBox(
// // // //                       width: double.infinity,
// // // //                       child: ElevatedButton(
// // // //                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
// // // //                         onPressed: () => Navigator.pop(context),
// // // //                         child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _detailRow(IconData icon, String label, String value) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(bottom: 10),
// // // //       child: Row(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Icon(icon, size: 18, color: AppColor.green),
// // // //           const SizedBox(width: 10),
// // // //           Expanded(child: Text("$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black87))),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildBadge(String label, Color color) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// // // //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
// // // //       child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildImage(dynamic urls, {double? height, double? width}) {
// // // //     if (urls != null && urls is List && urls.isNotEmpty) {
// // // //       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover, errorBuilder: (c, e, s) => _defaultIcon());
// // // //     }
// // // //     return _defaultIcon();
// // // //   }
// // // //
// // // //   Widget _defaultIcon() {
// // // //     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey));
// // // //   }
// // // //
// // // //   Widget _buildInfoMessage(String msg) {
// // // //     return Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// // // //   }
// // // // }
// // //
// // //
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// //
// // class DonorSearchScreen extends StatefulWidget {
// //   const DonorSearchScreen({super.key});
// //
// //   @override
// //   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// // }
// //
// // class _DonorSearchScreenState extends State<DonorSearchScreen> {
// //   String _searchQuery = "";
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(160),
// //         child: AppBar(
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           flexibleSpace: _buildHeader(),
// //         ),
// //       ),
// //       body: BaseScreen(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 10),
// //             Expanded(
// //               child: StreamBuilder<QuerySnapshot>(
// //                 // 'posts' কালেকশন থেকে ডাটা আনা হচ্ছে
// //                 stream: FirebaseFirestore.instance.collection('posts').snapshots(),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.hasError) return _buildInfoMessage("Connection Error");
// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //                   }
// //                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// //                     return _buildInfoMessage("No food items available.");
// //                   }
// //
// //                   // বর্তমান সময়
// //                   final DateTime now = DateTime.now();
// //
// //                   // 🔥 ফিল্টারিং লজিক - খুব মন দিয়ে দেখুন 🔥
// //                   final filteredDocs = snapshot.data!.docs.where((doc) {
// //                     final data = doc.data() as Map<String, dynamic>;
// //
// //                     // ১. স্ট্যাটাস চেক: যদি 'completed' হয় তবে সরাসরি বাদ (false)
// //                     String status = (data['status'] ?? "").toString().toLowerCase();
// //                     if (status == "completed") {
// //                       return false;
// //                     }
// //
// //                     // ২. এক্সপায়ারি চেক: বর্তমান সময়ের চেয়ে কম হলে বাদ
// //                     if (data['expiryDate'] != null) {
// //                       DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
// //                       if (expiry.isBefore(now)) {
// //                         return false; // সময় পার হয়ে গেছে, তাই দেখাবে না
// //                       }
// //                     }
// //
// //                     // ৩. সার্চ কুয়েরি চেক
// //                     String foodName = (data['foodName'] ?? "").toString().toLowerCase();
// //                     return foodName.contains(_searchQuery);
// //
// //                   }).toList();
// //
// //                   if (filteredDocs.isEmpty) {
// //                     return _buildInfoMessage("No fresh or available food items.");
// //                   }
// //
// //                   return ListView.builder(
// //                     itemCount: filteredDocs.length,
// //                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //                     physics: const BouncingScrollPhysics(),
// //                     itemBuilder: (context, index) {
// //                       final data = filteredDocs[index].data() as Map<String, dynamic>;
// //                       return _buildFoodCard(data);
// //                     },
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // --- Header ডিজাইন ---
// //   Widget _buildHeader() {
// //     return Container(
// //       padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
// //       decoration: BoxDecoration(
// //         color: AppColor.green.withOpacity(0.1),
// //         borderRadius: const BorderRadius.only(
// //           bottomLeft: Radius.circular(30),
// //           bottomRight: Radius.circular(30),
// //         ),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         children: [
// //           const Text("Available Food 🍏", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
// //           const SizedBox(height: 15),
// //           TextField(
// //             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
// //             decoration: InputDecoration(
// //               hintText: "Search food name...",
// //               prefixIcon: const Icon(Icons.search, color: AppColor.green),
// //               filled: true,
// //               fillColor: Colors.white,
// //               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
// //               contentPadding: EdgeInsets.zero,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   // --- ফুড কার্ড ডিজাইন ---
// //   Widget _buildFoodCard(Map<String, dynamic> data) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 16),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
// //       ),
// //       child: InkWell(
// //         onTap: () => _showProductDetails(context, data),
// //         borderRadius: BorderRadius.circular(20),
// //         child: Row(
// //           children: [
// //             SizedBox(
// //               width: 110, height: 110,
// //               child: ClipRRect(
// //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
// //                 child: _buildImage(data['imageUrls']),
// //               ),
// //             ),
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
// //                     const SizedBox(height: 4),
// //                     _buildBadge(data['foodType'] ?? "General", AppColor.green),
// //                     const SizedBox(height: 6),
// //                     Row(
// //                       children: [
// //                         const Icon(Icons.access_time, size: 14, color: Colors.orange),
// //                         const SizedBox(width: 5),
// //                         Text(data['pickupTime'] ?? "N/A", style: const TextStyle(fontSize: 12, color: Colors.black54)),
// //                       ],
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Row(
// //                       children: [
// //                         const Icon(Icons.location_on_outlined, size: 14, color: Colors.redAccent),
// //                         const SizedBox(width: 5),
// //                         Expanded(child: Text(data['pickupAddress'] ?? "N/A", style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // --- এলার্ট ডায়ালগ ---
// //   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => Dialog(
// //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Stack(
// //                 children: [
// //                   ClipRRect(
// //                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
// //                     child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
// //                   ),
// //                   Positioned(right: 10, top: 10, child: CircleAvatar(backgroundColor: Colors.white, child: CloseButton(onPressed: () => Navigator.pop(context)))),
// //                 ],
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(20),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
// //                     const SizedBox(height: 15),
// //                     _detailRow(Icons.category_outlined, "Food Type", data['foodType'] ?? "General"),
// //                     _detailRow(Icons.info_outline, "Condition", data['foodCondition'] ?? "N/A"),
// //                     _detailRow(Icons.group_outlined, "Serves", "${data['estimatePersons'] ?? '0'} Persons"),
// //                     _detailRow(Icons.access_time, "Pickup Time", data['pickupTime'] ?? "N/A"),
// //                     _detailRow(Icons.location_on_outlined, "Location", data['pickupAddress'] ?? "N/A"),
// //                     _detailRow(Icons.notes, "Notes", data['description'] ?? "No notes provided."),
// //                     const SizedBox(height: 20),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       child: ElevatedButton(
// //                         style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
// //                         onPressed: () => Navigator.pop(context),
// //                         child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _detailRow(IconData icon, String label, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 10),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Icon(icon, size: 18, color: AppColor.green),
// //           const SizedBox(width: 10),
// //           Expanded(child: Text("$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black87))),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget _buildBadge(String label, Color color) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
// //       decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
// //       child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
// //     );
// //   }
// //
// //   Widget _buildImage(dynamic urls, {double? height, double? width}) {
// //     if (urls != null && urls is List && urls.isNotEmpty) {
// //       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover, errorBuilder: (c, e, s) => _defaultIcon());
// //     }
// //     return _defaultIcon();
// //   }
// //
// //   Widget _defaultIcon() {
// //     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood, color: Colors.grey));
// //   }
// //
// //   Widget _buildInfoMessage(String msg) {
// //     return Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// //   }
// // }
// //
// //
//
//
//
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
//
// class DonorSearchScreen extends StatefulWidget {
//   const DonorSearchScreen({super.key});
//
//   @override
//   State<DonorSearchScreen> createState() => _DonorSearchScreenState();
// }
//
// class _DonorSearchScreenState extends State<DonorSearchScreen> {
//   String _searchQuery = "";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(160),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           flexibleSpace: _buildHeader(),
//         ),
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           // কন্ডিশন ১: সরাসরি Firebase থেকে 'completed' গুলোকে বাদ দেওয়া হচ্ছে
//           stream: FirebaseFirestore.instance
//               .collection('posts')
//               .where('status', isNotEqualTo: 'completed')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) return _buildInfoMessage("Error loading data");
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             }
//
//             final DateTime now = DateTime.now();
//
//             // কন্ডিশন ২: ডেট এক্সপায়ার এবং সার্চ ফিল্টারিং
//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               final data = doc.data() as Map<String, dynamic>;
//
//               // এক্সপায়ারি চেক: আজকের তারিখের আগের হলে শো করবে না
//               if (data['expiryDate'] != null) {
//                 try {
//                   DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
//                   if (expiry.isBefore(now)) return false;
//                 } catch (e) {
//                   debugPrint("Date error: $e");
//                 }
//               }
//
//               // সার্চ ফিল্টারিং
//               String foodName = (data['foodName'] ?? "").toString().toLowerCase();
//               return foodName.contains(_searchQuery);
//             }).toList();
//
//             if (filteredDocs.isEmpty) {
//               return _buildInfoMessage("No fresh food items found.");
//             }
//
//             return ListView.builder(
//               itemCount: filteredDocs.length,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final data = filteredDocs[index].data() as Map<String, dynamic>;
//                 return _buildFoodCard(data);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // --- Header ডিজাইন ---
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
//       decoration: BoxDecoration(
//         color: AppColor.green.withOpacity(0.1),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           const Text("Available Food 🍏",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
//           const SizedBox(height: 15),
//           TextField(
//             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
//             decoration: InputDecoration(
//               hintText: "Search food name...",
//               prefixIcon: const Icon(Icons.search, color: AppColor.green),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: BorderSide.none,
//               ),
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- মেইন লিস্ট কার্ড ডিজাইন ---
//   Widget _buildFoodCard(Map<String, dynamic> data) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
//         ],
//       ),
//       child: InkWell(
//         onTap: () => _showProductDetails(context, data), // ক্লিক করলে এলার্ট দেখাবে
//         borderRadius: BorderRadius.circular(20),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 110, height: 110,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
//                 child: _buildImage(data['imageUrls']),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['foodName'] ?? "Unnamed",
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                     const SizedBox(height: 5),
//                     _buildBadge(data['foodType'] ?? "General"),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.access_time, size: 14, color: Colors.orange),
//                         const SizedBox(width: 5),
//                         Text(data['pickupTime'] ?? 'N/A', style: const TextStyle(fontSize: 12)),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on_outlined, size: 14, color: Colors.red),
//                         const SizedBox(width: 5),
//                         Expanded(child: Text(data['pickupAddress'] ?? 'N/A',
//                             style: const TextStyle(fontSize: 12, color: Colors.grey),
//                             maxLines: 1, overflow: TextOverflow.ellipsis)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- ফুল ইনফরমেশন এলার্ট ডিজাইন ---
//   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // ১. ইমেজ সেকশন
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                     child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
//                   ),
//                   Positioned(
//                     right: 10, top: 10,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: IconButton(
//                         icon: const Icon(Icons.close, color: Colors.red),
//                         onPressed: () => Navigator.pop(context),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // ২. টেক্সট ডিটেইলস
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['foodName'] ?? "Details",
//                         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     const Divider(height: 30),
//                     _infoRow(Icons.category, "Food Type", data['foodType']),
//                     _infoRow(Icons.timer, "Pickup Time", data['pickupTime']),
//                     _infoRow(Icons.location_on, "Location", data['pickupAddress']),
//                     _infoRow(Icons.people, "Estimate Persons", "${data['estimatePersons'] ?? '0'} Persons"),
//                     _infoRow(Icons.description, "Notes", data['description'] ?? "No extra notes."),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColor.green,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         onPressed: () => Navigator.pop(context),
//                         child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 20, color: AppColor.green),
//           const SizedBox(width: 10),
//           Expanded(child: Text("$label: ${value ?? 'N/A'}",
//               style: const TextStyle(fontSize: 14, color: Colors.black87))),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBadge(String label) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
//     child: Text(label, style: const TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold)),
//   );
//
//   Widget _buildImage(dynamic urls, {double? height, double? width}) {
//     if (urls != null && urls is List && urls.isNotEmpty) {
//       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover,
//           errorBuilder: (c, e, s) => Container(color: Colors.grey[200], child: const Icon(Icons.fastfood)));
//     }
//     return Container(color: Colors.grey[200], child: const Icon(Icons.fastfood));
//   }
//
//   Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// }








import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

class DonorSearchScreen extends StatefulWidget {
  const DonorSearchScreen({super.key});

  @override
  State<DonorSearchScreen> createState() => _DonorSearchScreenState();
}

class _DonorSearchScreenState extends State<DonorSearchScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: _buildHeader(),
        ),
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          // কন্ডিশন: সরাসরি ডাটাবেজ থেকে শুধুমাত্র "available" পোস্টগুলো আনা হচ্ছে
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('status', isEqualTo: 'available')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return _buildInfoMessage("Something went wrong");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColor.green));
            }

            final DateTime now = DateTime.now();

            // 🚀 ডায়নামিক ফিল্টারিং (Expiry Date + Search)
            final filteredDocs = snapshot.data!.docs.where((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;

                // ১. এক্সপায়ারি চেক
                if (data['expiryDate'] != null) {
                  DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
                  if (expiry.isBefore(now)) return false; // মেয়াদ শেষ হলে দেখাবে না
                }

                // ২. সার্চ চেক
                String foodName = (data['foodName'] ?? "").toString().toLowerCase();
                if (!foodName.contains(_searchQuery)) return false;

                return true;
              } catch (e) {
                return false; // কোনো ডাটাতে এরর থাকলে সেই পোস্টটি স্কিপ করবে
              }
            }).toList();

            if (filteredDocs.isEmpty) {
              return _buildInfoMessage("No available food found near you.");
            }

            return ListView.builder(
              itemCount: filteredDocs.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final data = filteredDocs[index].data() as Map<String, dynamic>;
                return _buildFoodCard(data);
              },
            );
          },
        ),
      ),
    );
  }

  // --- কাস্টম হেডার ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(0.1),
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Available Food 🍏", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: "Search food name...",
              prefixIcon: const Icon(Icons.search, color: AppColor.green),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  // --- ফুড কার্ড ডিজাইন ---
  Widget _buildFoodCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: InkWell(
        onTap: () => _showProductDetails(context, data),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            SizedBox(
              width: 110, height: 110,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
                child: _buildImage(data['imageUrls']),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['foodName'] ?? "Unnamed", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    _buildBadge(data['foodType'] ?? "Food"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(data['pickupTime'] ?? 'Anytime', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.red),
                        const SizedBox(width: 5),
                        Expanded(child: Text(data['pickupAddress'] ?? 'No Address', style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- ডায়নামিক ডিটেইলস পপ-আপ ---
  void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['foodName'] ?? "Details", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Divider(height: 25),
                    _infoRow(Icons.category, "Category", data['foodType']),
                    _infoRow(Icons.health_and_safety, "Condition", data['foodCondition']),
                    _infoRow(Icons.timer, "Pickup", data['pickupTime']),
                    _infoRow(Icons.location_on, "Address", data['pickupAddress']),
                    _infoRow(Icons.notes, "Description", data['description']),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: AppColor.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("CLOSE", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColor.green),
          const SizedBox(width: 10),
          Expanded(child: Text("$label: ${value ?? 'N/A'}", style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: const TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold)),
  );

  Widget _buildImage(dynamic urls, {double? height, double? width}) {
    if (urls != null && urls is List && urls.isNotEmpty) {
      return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(color: Colors.grey[100], child: const Icon(Icons.image_not_supported)));
    }
    return Container(color: Colors.grey[100], child: const Icon(Icons.fastfood, color: Colors.grey));
  }

  Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
}