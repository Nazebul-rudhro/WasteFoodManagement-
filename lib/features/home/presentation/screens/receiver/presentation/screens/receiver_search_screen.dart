// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
//
// class ReceiverSearchScreen extends StatefulWidget {
//   const ReceiverSearchScreen({super.key});
//
//   @override
//   State<ReceiverSearchScreen> createState() => _ReceiverSearchScreenState();
// }
//
// class _ReceiverSearchScreenState extends State<ReceiverSearchScreen> {
//   String _searchQuery = "";
//   final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
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
//           automaticallyImplyLeading: false,
//           flexibleSpace: _buildHeader(),
//         ),
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           // শুধুমাত্র available স্ট্যাটাসের খাবারগুলো আনা হচ্ছে
//           stream: FirebaseFirestore.instance
//               .collection('posts')
//               .where('status', isEqualTo: 'available')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) return _buildInfoMessage("Error loading food items");
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             }
//
//             final DateTime now = DateTime.now();
//
//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               try {
//                 final data = doc.data() as Map<String, dynamic>;
//
//                 // 🔥 কন্ডিশন ১: ইউজার অলরেডি রিকোয়েস্ট করলে তাকে আর দেখাবে না
//                 List requestedUsers = data['requestedUsers'] ?? [];
//                 if (requestedUsers.contains(currentUserId)) return false;
//
//                 // ২. এক্সপায়ারি চেক
//                 if (data['expiryDate'] != null) {
//                   DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
//                   if (expiry.isBefore(now)) return false;
//                 }
//
//                 // ৩. সার্চ চেক
//                 String foodName = (data['foodName'] ?? "").toString().toLowerCase();
//                 if (!foodName.contains(_searchQuery)) return false;
//
//                 return true;
//               } catch (e) {
//                 return false;
//               }
//             }).toList();
//
//             if (filteredDocs.isEmpty) {
//               return _buildInfoMessage("No available food items found.");
//             }
//
//             return ListView.builder(
//               itemCount: filteredDocs.length,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final doc = filteredDocs[index];
//                 final data = doc.data() as Map<String, dynamic>;
//                 data['docId'] = doc.id; // রিকোয়েস্ট পাঠানোর জন্য আইডি সেভ করা হচ্ছে
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
//           const Text("Find Food Nearby 🍏",
//               style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
//           const SizedBox(height: 15),
//           TextField(
//             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
//             decoration: InputDecoration(
//               hintText: "Search by food name...",
//               prefixIcon: const Icon(Icons.search, color: AppColor.green),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- ফুড কার্ড ---
//   Widget _buildFoodCard(Map<String, dynamic> data) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
//       ),
//       child: InkWell(
//         onTap: () => _showProductDetails(context, data),
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
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                         maxLines: 1, overflow: TextOverflow.ellipsis),
//                     const SizedBox(height: 4),
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
//                         Expanded(child: Text(data['pickupAddress'] ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
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
//   // --- ডিটেইলস পপ-আপ ---
//   void _showProductDetails(BuildContext context, Map<String, dynamic> data) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['foodName'] ?? "Details", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                     const Divider(height: 25),
//                     _detailRow(Icons.category, "Food Type", data['foodType']),
//                     _detailRow(Icons.health_and_safety, "Condition", data['foodCondition']),
//                     _detailRow(Icons.timer, "Pickup Time", data['pickupTime']),
//                     _detailRow(Icons.location_on, "Address", data['pickupAddress']),
//                     _detailRow(Icons.description, "Notes", data['description']),
//                     const SizedBox(height: 20),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: Colors.red),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("CLOSE", style: TextStyle(color: Colors.red)),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.green,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             onPressed: () => _sendRequest(context, data),
//                             child: const Text("REQUEST NOW", style: TextStyle(color: Colors.white, fontSize: 11)),
//                           ),
//                         ),
//                       ],
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
//   // --- 🔥 রিকোয়েস্ট লজিক (পোস্ট রিমুভ করার ব্যবস্থা সহ) ---
//   Future<void> _sendRequest(BuildContext context, Map<String, dynamic> postData) async {
//     try {
//       // ১. requests কালেকশনে ডাটা সেভ
//       await FirebaseFirestore.instance.collection('requests').add({
//         'postId': postData['docId'],
//         'foodName': postData['foodName'],
//         'donorId': postData['donorId'],
//         'receiverId': currentUserId,
//         'status': 'pending',
//         'requestTime': FieldValue.serverTimestamp(),
//       });
//
//       // ২. 🔥 পোস্টের ভেতর requestedUsers লিস্টে ইউজারের আইডি যোগ করা
//       // এটি করার সাথে সাথে StreamBuilder অটোমেটিক এই পোস্টটিকে লিস্ট থেকে সরিয়ে দেবে
//       await FirebaseFirestore.instance.collection('posts').doc(postData['docId']).update({
//         'requestedUsers': FieldValue.arrayUnion([currentUserId])
//       });
//
//       Navigator.pop(context); // ডায়ালগ বন্ধ করা
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Request sent! Removing from list..."), backgroundColor: AppColor.green),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }
//   }
//
//   // --- হেল্পার উইজেটস ---
//   Widget _detailRow(IconData icon, String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 18, color: AppColor.green),
//           const SizedBox(width: 10),
//           Expanded(child: Text("$label: ${value ?? 'N/A'}", style: const TextStyle(fontSize: 14))),
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
//           errorBuilder: (c, e, s) => Container(color: Colors.grey[100], child: const Icon(Icons.fastfood, color: Colors.grey)));
//     }
//     return Container(color: Colors.grey[100], child: const Icon(Icons.fastfood, color: Colors.grey));
//   }
//
//   Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// }

//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
//
// class ReceiverSearchScreen extends StatefulWidget {
//   const ReceiverSearchScreen({super.key});
//
//   @override
//   State<ReceiverSearchScreen> createState() => _ReceiverSearchScreenState();
// }
//
// class _ReceiverSearchScreenState extends State<ReceiverSearchScreen> {
//   String _searchQuery = "";
//   final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";
//
//   @override
//   Widget build(BuildContext context) {
//     // ডার্ক মোড চেক করার জন্য ভেরিয়েবল
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(160),
//         child: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           flexibleSpace: _buildHeader(isDark),
//         ),
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('posts')
//               .where('status', isEqualTo: 'available')
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) return _buildInfoMessage("Error loading food items");
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: AppColor.green));
//             }
//
//             final DateTime now = DateTime.now();
//
//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               try {
//                 final data = doc.data() as Map<String, dynamic>;
//                 List requestedUsers = data['requestedUsers'] ?? [];
//                 if (requestedUsers.contains(currentUserId)) return false;
//
//                 if (data['expiryDate'] != null) {
//                   DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
//                   if (expiry.isBefore(now)) return false;
//                 }
//
//                 String foodName = (data['foodName'] ?? "").toString().toLowerCase();
//                 if (!foodName.contains(_searchQuery)) return false;
//
//                 return true;
//               } catch (e) {
//                 return false;
//               }
//             }).toList();
//
//             if (filteredDocs.isEmpty) {
//               return _buildInfoMessage("No available food items found.");
//             }
//
//             return ListView.builder(
//               itemCount: filteredDocs.length,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final doc = filteredDocs[index];
//                 final data = doc.data() as Map<String, dynamic>;
//                 data['docId'] = doc.id;
//                 return _buildFoodCard(data, isDark);
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   // --- Header ডিজাইন (Dark mode support) ---
//   Widget _buildHeader(bool isDark) {
//     return Container(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
//       decoration: BoxDecoration(
//         color: AppColor.green.withOpacity(0.15),
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text("Find Food Nearby 🍏",
//               style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: isDark ? Colors.white : Colors.black87)),
//           const SizedBox(height: 15),
//           TextField(
//             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
//             style: TextStyle(color: isDark ? Colors.white : Colors.black),
//             decoration: InputDecoration(
//               hintText: "Search by food name...",
//               hintStyle: TextStyle(color: isDark ? Colors.grey : Colors.grey[600]),
//               prefixIcon: const Icon(Icons.search, color: AppColor.green),
//               filled: true,
//               fillColor: isDark ? const Color(0xFF2C2C2C) : Colors.white,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: BorderSide.none),
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // --- ফুড কার্ড (Dark mode support) ---
//   Widget _buildFoodCard(Map<String, dynamic> data, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: InkWell(
//         onTap: () => _showProductDetails(context, data, isDark),
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
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                             color: isDark ? Colors.white : Colors.black),
//                         maxLines: 1, overflow: TextOverflow.ellipsis),
//                     const SizedBox(height: 4),
//                     _buildBadge(data['foodType'] ?? "General"),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.access_time, size: 14, color: Colors.orange),
//                         const SizedBox(width: 5),
//                         Text(data['pickupTime'] ?? 'N/A',
//                             style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.black87)),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on_outlined, size: 14, color: Colors.red),
//                         const SizedBox(width: 5),
//                         Expanded(child: Text(data['pickupAddress'] ?? 'N/A',
//                             style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[500] : Colors.grey),
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
//   // --- ডিটেইলস পপ-আপ (Dark mode support) ---
//   void _showProductDetails(BuildContext context, Map<String, dynamic> data, bool isDark) {
//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//                 child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(data['foodName'] ?? "Details",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
//                     Divider(height: 25, color: isDark ? Colors.grey[800] : Colors.grey[300]),
//                     _detailRow(Icons.category, "Food Type", data['foodType'], isDark),
//                     _detailRow(Icons.health_and_safety, "Condition", data['foodCondition'], isDark),
//                     _detailRow(Icons.timer, "Pickup Time", data['pickupTime'], isDark),
//                     _detailRow(Icons.location_on, "Address", data['pickupAddress'], isDark),
//                     _detailRow(Icons.description, "Notes", data['description'], isDark),
//                     const SizedBox(height: 20),
//
//                     Row(
//                       children: [
//                         Expanded(
//                           child: OutlinedButton(
//                             style: OutlinedButton.styleFrom(
//                               side: const BorderSide(color: Colors.red),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("CLOSE", style: TextStyle(color: Colors.red)),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColor.green,
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                             ),
//                             onPressed: () => _sendRequest(context, data),
//                             child: const Text("REQUEST NOW", style: TextStyle(color: Colors.white, fontSize: 11)),
//                           ),
//                         ),
//                       ],
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
//   // --- হেল্পার উইজেটস (Dark mode friendly) ---
//   Widget _detailRow(IconData icon, String label, String? value, bool isDark) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, size: 18, color: AppColor.green),
//           const SizedBox(width: 10),
//           Expanded(child: Text("$label: ${value ?? 'N/A'}",
//               style: TextStyle(fontSize: 14, color: isDark ? Colors.grey[300] : Colors.black87))),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBadge(String label) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     decoration: BoxDecoration(color: AppColor.green.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
//     child: Text(label, style: const TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold)),
//   );
//
//   // --- বাকি ফাংশনগুলো আগের মতোই ---
//   Future<void> _sendRequest(BuildContext context, Map<String, dynamic> postData) async {
//     try {
//       await FirebaseFirestore.instance.collection('requests').add({
//         'postId': postData['docId'],
//         'foodName': postData['foodName'],
//         'donorId': postData['donorId'],
//         'receiverId': currentUserId,
//         'status': 'pending',
//         'requestTime': FieldValue.serverTimestamp(),
//       });
//
//       await FirebaseFirestore.instance.collection('posts').doc(postData['docId']).update({
//         'requestedUsers': FieldValue.arrayUnion([currentUserId])
//       });
//
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Request sent! Removing from list..."), backgroundColor: AppColor.green),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }
//   }
//
//   Widget _buildImage(dynamic urls, {double? height, double? width}) {
//     if (urls != null && urls is List && urls.isNotEmpty) {
//       return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover,
//           errorBuilder: (c, e, s) => Container(color: Colors.grey[300], child: const Icon(Icons.fastfood, color: Colors.grey)));
//     }
//     return Container(color: Colors.grey[300], child: const Icon(Icons.fastfood, color: Colors.grey));
//   }
//
//   Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../../../../services/notification_service.dart';

class ReceiverSearchScreen extends StatefulWidget {
  const ReceiverSearchScreen({super.key});

  @override
  State<ReceiverSearchScreen> createState() => _ReceiverSearchScreenState();
}

class _ReceiverSearchScreenState extends State<ReceiverSearchScreen> {
  String _searchQuery = "";
  final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? "";

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(isDark),
          Expanded(
            child: BaseScreen(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .where('status', isEqualTo: 'available')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return _buildInfoMessage("Error loading items");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: AppColor.green));
                  }

                  final DateTime now = DateTime.now();

                  // ফিল্টারিং লজিক
                  final filteredDocs = snapshot.data!.docs.where((doc) {
                    try {
                      final data = doc.data() as Map<String, dynamic>;
                      List requestedUsers = data['requestedUsers'] ?? [];

                      // অলরেডি রিকোয়েস্ট করা পোস্ট হাইড থাকবে
                      if (requestedUsers.contains(currentUserId)) return false;

                      // এক্সপায়ারড পোস্ট হাইড থাকবে
                      if (data['expiryDate'] != null) {
                        DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
                        if (expiry.isBefore(now)) return false;
                      }

                      // সার্চ কুয়েরি ম্যাচিং
                      String foodName = (data['foodName'] ?? "").toString().toLowerCase();
                      return foodName.contains(_searchQuery);
                    } catch (e) {
                      return false;
                    }
                  }).toList();

                  if (filteredDocs.isEmpty) {
                    return _emptySearchState(isDark);
                  }

                  return ListView.builder(
                    itemCount: filteredDocs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final doc = filteredDocs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      data['docId'] = doc.id;
                      return _buildFoodCard(data, isDark);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- আধুনিক সার্চ হেডার ---
  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 25),
      decoration: BoxDecoration(
        color: AppColor.green,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Find Food Nearby 🍏",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            style: const TextStyle(color: Colors.black, fontSize: 14),
            decoration: InputDecoration(
              hintText: "Search by food name...",
              hintStyle: TextStyle(color: Colors.grey[500]),
              prefixIcon: const Icon(Icons.search, color: AppColor.green),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  // --- ফুড কার্ড ---
  Widget _buildFoodCard(Map<String, dynamic> data, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: isDark ? Colors.black26 : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)
          )
        ],
      ),
      child: InkWell(
        onTap: () => _showProductDetails(context, data, isDark),
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
              child: _buildImage(data['imageUrls'], width: 110, height: 110),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['foodName'] ?? "Unnamed",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : Colors.black),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 5),
                    _buildBadge(data['foodType'] ?? "General"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: AppColor.green),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(data['pickupAddress'] ?? 'N/A',
                              style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
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

  // --- ডিটেইলস পপ-আপ ---
  void _showProductDetails(BuildContext context, Map<String, dynamic> data, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                child: _buildImage(data['imageUrls'], height: 180, width: double.infinity),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['foodName'] ?? "Details",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87)),
                    const SizedBox(height: 5),
                    Text(data['foodCondition'] ?? "Fresh", style: const TextStyle(color: AppColor.green, fontSize: 13, fontWeight: FontWeight.bold)),
                    const Divider(height: 25),
                    _detailRow(Icons.timer_outlined, "Pickup", data['pickupTime'], isDark),
                    _detailRow(Icons.location_on_outlined, "Address", data['pickupAddress'], isDark),
                    _detailRow(Icons.description_outlined, "Note", data['description'], isDark),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close", style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => _sendRequest(context, data),
                            child: const Text("Request Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
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

  // --- ডাটা সেভ এবং নোটিফিকেশন লজিক ---
  Future<void> _sendRequest(BuildContext context, Map<String, dynamic> postData) async {
    try {
      final String postId = postData['docId'];
      final String donorId = postData['donorId'] ?? "";

      await FirebaseFirestore.instance.collection('requests').add({
        'postId': postId,
        'foodTitle': postData['foodName'],
        'donorId': donorId,
        'receiverId': currentUserId,
        'status': 'pending',
        'requestTime': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'requestedUsers': FieldValue.arrayUnion([currentUserId])
      });

      // ডোনারকে নোটিফিকেশন পাঠানো ✅
      if (donorId.isNotEmpty) {
        NotificationService.sendNewRequestNotification(
            donorId: donorId,
            foodName: postData['foodName'] ?? "Food Item",
            postId: postId
        );
      }

      Navigator.pop(context); // Close dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request sent successfully!"), backgroundColor: AppColor.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red));
    }
  }

  // --- হেল্পার উইজেটস ---
  Widget _detailRow(IconData icon, String label, String? value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColor.green),
          const SizedBox(width: 10),
          Expanded(child: Text("$label: ${value ?? 'N/A'}",
              style: TextStyle(fontSize: 13, color: isDark ? Colors.grey[300] : Colors.black87))),
        ],
      ),
    );
  }

  Widget _buildBadge(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: AppColor.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: const TextStyle(color: AppColor.green, fontSize: 10, fontWeight: FontWeight.bold)),
  );

  Widget _buildImage(dynamic urls, {double? height, double? width}) {
    if (urls != null && urls is List && urls.isNotEmpty) {
      return Image.network(urls[0], height: height, width: width, fit: BoxFit.cover,
          errorBuilder: (c, e, s) => Container(width: width, height: height, color: Colors.grey[300], child: const Icon(Icons.fastfood, color: Colors.white)));
    }
    return Container(width: width, height: height, color: Colors.grey[300], child: const Icon(Icons.fastfood, color: Colors.white));
  }

  Widget _emptySearchState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: isDark ? Colors.white10 : Colors.grey[200]),
          const SizedBox(height: 10),
          Text("No results found", style: TextStyle(color: isDark ? Colors.grey[600] : Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
}