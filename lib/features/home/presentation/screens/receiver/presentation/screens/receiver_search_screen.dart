//
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//           automaticallyImplyLeading: false, // ব্যাক বাটন লুকানোর জন্য
//           flexibleSpace: _buildHeader(),
//         ),
//       ),
//       body: BaseScreen(
//         child: StreamBuilder<QuerySnapshot>(
//           // 🔥 কন্ডিশন: শুধুমাত্র status "available" ডাটাবেজ থেকে আনবে
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
//             // 🔥 ডায়নামিক ফিল্টারিং (Expiry Date + Search)
//             final filteredDocs = snapshot.data!.docs.where((doc) {
//               try {
//                 final data = doc.data() as Map<String, dynamic>;
//
//                 // ১. এক্সপায়ারি চেক (আজকের তারিখ পার হয়ে গেলে দেখাবে না)
//                 if (data['expiryDate'] != null) {
//                   DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
//                   if (expiry.isBefore(now)) return false;
//                 }
//
//                 // ২. সার্চ কুয়েরি চেক
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
//   // --- কাস্টম হেডার ও সার্চ এরিয়া ---
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
//           const Text(
//             "Find Food Nearby 🍏",
//             style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 15),
//           TextField(
//             onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
//             decoration: InputDecoration(
//               hintText: "Search by food name...",
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
//   // --- ফুড কার্ড ডিজাইন ---
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
//                     Text(
//                       data['foodName'] ?? "Unnamed",
//                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       maxLines: 1, overflow: TextOverflow.ellipsis,
//                     ),
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
//
// import 'package:cloud_firestore/cloud_firestore.dart';
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
//                 // এক্সপায়ারি চেক
//                 if (data['expiryDate'] != null) {
//                   DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
//                   if (expiry.isBefore(now)) return false;
//                 }
//
//                 // সার্চ চেক
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
//   // --- Header ---
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
//   // --- Food Card ---
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
//   // --- Details Alert with Request Button ---
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
//                     // --- Buttons ---
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
//   // --- Send Request Logic ---
//   Future<void> _sendRequest(BuildContext context, Map<String, dynamic> postData) async {
//     try {
//       // requests কালেকশনে ডাটা সেভ করা হচ্ছে
//       await FirebaseFirestore.instance.collection('requests').add({
//         'foodName': postData['foodName'],
//         'donorId': postData['donorId'], // পোস্টের মালিকের আইডি
//         'status': 'pending',
//         'requestTime': FieldValue.serverTimestamp(),
//         // 'receiverId': 'YOUR_AUTH_USER_ID', // FirebaseAuth থাকলে ইউজারের আইডি দিন
//       });
//
//       Navigator.pop(context); // ডায়ালগ বন্ধ করা
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Request sent successfully!"), backgroundColor: AppColor.green),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
//       );
//     }
//   }
//
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



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: _buildHeader(),
        ),
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          // শুধুমাত্র available স্ট্যাটাসের খাবারগুলো আনা হচ্ছে
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('status', isEqualTo: 'available')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return _buildInfoMessage("Error loading food items");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: AppColor.green));
            }

            final DateTime now = DateTime.now();

            final filteredDocs = snapshot.data!.docs.where((doc) {
              try {
                final data = doc.data() as Map<String, dynamic>;

                // 🔥 কন্ডিশন ১: ইউজার অলরেডি রিকোয়েস্ট করলে তাকে আর দেখাবে না
                List requestedUsers = data['requestedUsers'] ?? [];
                if (requestedUsers.contains(currentUserId)) return false;

                // ২. এক্সপায়ারি চেক
                if (data['expiryDate'] != null) {
                  DateTime expiry = (data['expiryDate'] as Timestamp).toDate();
                  if (expiry.isBefore(now)) return false;
                }

                // ৩. সার্চ চেক
                String foodName = (data['foodName'] ?? "").toString().toLowerCase();
                if (!foodName.contains(_searchQuery)) return false;

                return true;
              } catch (e) {
                return false;
              }
            }).toList();

            if (filteredDocs.isEmpty) {
              return _buildInfoMessage("No available food items found.");
            }

            return ListView.builder(
              itemCount: filteredDocs.length,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final doc = filteredDocs[index];
                final data = doc.data() as Map<String, dynamic>;
                data['docId'] = doc.id; // রিকোয়েস্ট পাঠানোর জন্য আইডি সেভ করা হচ্ছে
                return _buildFoodCard(data);
              },
            );
          },
        ),
      ),
    );
  }

  // --- Header ডিজাইন ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      decoration: BoxDecoration(
        color: AppColor.green.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text("Find Food Nearby 🍏",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 15),
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value.toLowerCase()),
            decoration: InputDecoration(
              hintText: "Search by food name...",
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
                    Text(data['foodName'] ?? "Unnamed",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    _buildBadge(data['foodType'] ?? "General"),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.orange),
                        const SizedBox(width: 5),
                        Text(data['pickupTime'] ?? 'N/A', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.red),
                        const SizedBox(width: 5),
                        Expanded(child: Text(data['pickupAddress'] ?? 'N/A', style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis)),
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
                    _detailRow(Icons.category, "Food Type", data['foodType']),
                    _detailRow(Icons.health_and_safety, "Condition", data['foodCondition']),
                    _detailRow(Icons.timer, "Pickup Time", data['pickupTime']),
                    _detailRow(Icons.location_on, "Address", data['pickupAddress']),
                    _detailRow(Icons.description, "Notes", data['description']),
                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("CLOSE", style: TextStyle(color: Colors.red)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () => _sendRequest(context, data),
                            child: const Text("REQUEST NOW", style: TextStyle(color: Colors.white, fontSize: 11)),
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

  // --- 🔥 রিকোয়েস্ট লজিক (পোস্ট রিমুভ করার ব্যবস্থা সহ) ---
  Future<void> _sendRequest(BuildContext context, Map<String, dynamic> postData) async {
    try {
      // ১. requests কালেকশনে ডাটা সেভ
      await FirebaseFirestore.instance.collection('requests').add({
        'postId': postData['docId'],
        'foodName': postData['foodName'],
        'donorId': postData['donorId'],
        'receiverId': currentUserId,
        'status': 'pending',
        'requestTime': FieldValue.serverTimestamp(),
      });

      // ২. 🔥 পোস্টের ভেতর requestedUsers লিস্টে ইউজারের আইডি যোগ করা
      // এটি করার সাথে সাথে StreamBuilder অটোমেটিক এই পোস্টটিকে লিস্ট থেকে সরিয়ে দেবে
      await FirebaseFirestore.instance.collection('posts').doc(postData['docId']).update({
        'requestedUsers': FieldValue.arrayUnion([currentUserId])
      });

      Navigator.pop(context); // ডায়ালগ বন্ধ করা
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Request sent! Removing from list..."), backgroundColor: AppColor.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  // --- হেল্পার উইজেটস ---
  Widget _detailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          errorBuilder: (c, e, s) => Container(color: Colors.grey[100], child: const Icon(Icons.fastfood, color: Colors.grey)));
    }
    return Container(color: Colors.grey[100], child: const Icon(Icons.fastfood, color: Colors.grey));
  }

  Widget _buildInfoMessage(String msg) => Center(child: Text(msg, style: const TextStyle(color: Colors.grey)));
}