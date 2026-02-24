// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
//
// class VolunteerNotificationScreen extends StatefulWidget {
//   static String routeName = "/volunteer-notification";
//   const VolunteerNotificationScreen({super.key});
//
//   @override
//   State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
// }
//
// class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Map<String, String> _cache = {};
//
//   // নোটিফিকেশন লজিক প্রসেস করা
//   Future<List<NotificationModel>> _processVolunteerNotifications(
//       List<DocumentSnapshot> docs, String currentUid) async {
//     List<NotificationModel> formattedList = [];
//
//     for (var doc in docs) {
//       try {
//         final data = doc.data() as Map<String, dynamic>?;
//         if (data == null) continue;
//
//         String status = data['status'] ?? "";
//         String dStatus = data['deliverystatus'] ?? "none";
//         String vId = data['volunteerId'] ?? "";
//         String postId = data['postId'] ?? "";
//         String donorId = data['donorId'] ?? "";
//         String receiverId = data['receiverId'] ?? "";
//
//         // টাইম স্ট্যাম্প হ্যান্ডেল করা
//         Timestamp? createdAt = data['createdAt'] as Timestamp?;
//         String timeStr = createdAt != null
//             ? timeago.format(createdAt.toDate(), locale: 'en_short')
//             : "now";
//
//         // ক্যাশ থেকে ডাটা নেওয়া (বারবার ফায়ারবেস কল কমানোর জন্য)
//         String foodName = await _getCachedData("posts", postId, "foodName", "Food");
//         String donorName = await _getProfileData(donorId, "Donor");
//         String receiverName = await _getProfileData(receiverId, "Receiver");
//
//         String title = "";
//         String body = "";
//         IconData icon = Icons.notifications;
//         Color iconColor = AppColor.green;
//
//         // ভলান্টিয়ার স্পেসিফিক লজিক
//         if (vId == currentUid && status == 'delivered' && dStatus == 'pending') {
//           title = "🎊 Request Accepted!";
//           body = "Donor $donorName assigned you to deliver '$foodName' to $receiverName.";
//           icon = Icons.assignment_turned_in_rounded;
//           iconColor = Colors.blue;
//         } else if (status == 'approved' && vId.isEmpty) {
//           title = "📢 New Task Opportunity";
//           body = "'$foodName' is ready for pickup from $donorName.";
//           icon = Icons.volunteer_activism;
//           iconColor = Colors.orange;
//         } else if (vId == currentUid && dStatus == 'ongoing') {
//           title = "🚚 Ongoing Delivery";
//           body = "You are delivering '$foodName' to $receiverName.";
//           icon = Icons.local_shipping_rounded;
//           iconColor = Colors.teal;
//         } else if (vId == currentUid && dStatus == 'completed') {
//           title = "✅ Mission Accomplished";
//           body = "Successfully delivered '$foodName' to $receiverName.";
//           icon = Icons.verified_rounded;
//           iconColor = AppColor.green;
//         } else {
//           continue; // অন্য কোনো স্ট্যাটাস হলে লিস্টে দেখাবে না
//         }
//
//         formattedList.add(
//           NotificationModel(
//             id: doc.id,
//             message: title,
//             requestBy: body,
//             time: timeStr,
//             postId: postId,
//             receiverId: receiverId,
//             status: status,
//           ),
//         );
//       } catch (e) {
//         continue;
//       }
//     }
//     return formattedList;
//   }
//
//   // ডাটা ক্যাশিং ফাংশন
//   Future<String> _getCachedData(String col, String id, String field, String def) async {
//     String key = "${col}_$id";
//     if (_cache.containsKey(key)) return _cache[key]!;
//     var snap = await _firestore.collection(col).doc(id).get();
//     String val = snap.data()?[field] ?? def;
//     _cache[key] = val;
//     return val;
//   }
//
//   Future<String> _getProfileData(String id, String def) async {
//     String key = "u_$id";
//     if (_cache.containsKey(key)) return _cache[key]!;
//     var snap = await _firestore.collection('accounts').doc(id).get();
//     String val = snap.data()?['profile']?['contactPerson'] ?? def;
//     _cache[key] = val;
//     return val;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text("Notifications",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//         centerTitle: true,
//         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
//         foregroundColor: isDark ? Colors.white : Colors.black,
//         elevation: 0,
//       ),
//       body: auth.user == null
//           ? const Center(child: Text("Please login to see notifications"))
//           : StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('requests').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: AppColor.green));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return _buildEmptyState(isDark);
//           }
//
//           // ১. সময় অনুযায়ী সিরিয়াল করা (Sorting)
//           final sortedDocs = snapshot.data!.docs.toList();
//           sortedDocs.sort((a, b) {
//             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             return t2.compareTo(t1); // Newest first
//           });
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: AppColor.green));
//               }
//
//               if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
//                 return _buildEmptyState(isDark);
//               }
//
//               return ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.all(12),
//                 itemCount: fSnapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   final item = fSnapshot.data![index];
//                   return _buildNotificationCard(item, isDark);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   // নতুন আধুনিক নোটিফিকেশন কার্ড ডিজাইন
//   Widget _buildNotificationCard(NotificationModel item, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         leading: CircleAvatar(
//           backgroundColor: AppColor.green.withOpacity(0.1),
//           child: Icon(Icons. campaign, color: AppColor.green, size: 20),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(item.message, // Title
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             ),
//             Text(item.time, // Time ago
//                 style: TextStyle(color: Colors.grey, fontSize: 11)),
//           ],
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: Text(item.requestBy, // Body
//               style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(bool isDark) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.notifications_none_rounded, size: 80, color: Colors.grey.withOpacity(0.4)),
//           const SizedBox(height: 16),
//           Text("No notifications yet",
//               style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../../auth/data/model/notification_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';

class VolunteerNotificationScreen extends StatefulWidget {
  static String routeName = "/volunteer-notification";
  const VolunteerNotificationScreen({super.key});

  @override
  State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
}

class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _cache = {};

  // ডাটা ক্যাশিং ফাংশন (বারবার নেটওয়ার্ক কল বাঁচানোর জন্য)
  Future<String> _getProfileData(String id, String def) async {
    String key = "u_$id";
    if (_cache.containsKey(key)) return _cache[key]!;
    try {
      var snap = await _firestore.collection('accounts').doc(id).get();
      String val = snap.data()?['profile']?['contactPerson'] ?? def;
      _cache[key] = val;
      return val;
    } catch (_) { return def; }
  }

  Future<String> _getFoodName(String id, String def) async {
    String key = "p_$id";
    if (_cache.containsKey(key)) return _cache[key]!;
    try {
      var snap = await _firestore.collection('posts').doc(id).get();
      String val = snap.data()?['foodName'] ?? def;
      _cache[key] = val;
      return val;
    } catch (_) { return def; }
  }

  // নোটিফিকেশন প্রসেসিং লজিক
  Future<List<NotificationModel>> _processVolunteerNotifications(
      List<DocumentSnapshot> docs, String currentUid) async {
    List<NotificationModel> formattedList = [];

    for (var doc in docs) {
      try {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) continue;

        String status = data['status'] ?? "";
        String dStatus = data['deliverystatus'] ?? "none";
        String vId = data['volunteerId'] ?? "";
        String postId = data['postId'] ?? "";
        String donorId = data['donorId'] ?? "";
        String receiverId = data['receiverId'] ?? "";

        Timestamp? createdAt = data['createdAt'] as Timestamp?;
        String timeStr = createdAt != null
            ? timeago.format(createdAt.toDate(), locale: 'en_short')
            : "now";

        String foodName = await _getFoodName(postId, "Food Item");
        String donorName = await _getProfileData(donorId, "Donor");
        String receiverName = await _getProfileData(receiverId, "Receiver");

        String title = "";
        String body = "";
        IconData icon = Icons.notifications;

        // ভলান্টিয়ার লজিক ফিল্টারিং
        if (vId == currentUid && status == 'delivered' && dStatus == 'pending') {
          title = "🎊 Assignment Confirmed!";
          body = "$donorName assigned you for '$foodName'.";
          icon = Icons.check_circle;
        } else if (status == 'approved' && vId.isEmpty) {
          title = "📢 New Pickup Opportunity";
          body = "'$foodName' is ready at $donorName's location.";
          icon = Icons.volunteer_activism;
        } else if (vId == currentUid && dStatus == 'ongoing') {
          title = "🚚 Ongoing Delivery";
          body = "You are delivering '$foodName' to $receiverName.";
          icon = Icons.local_shipping;
        } else if (vId == currentUid && dStatus == 'completed') {
          title = "✅ Delivery Success";
          body = "Successfully handed over '$foodName'.";
          icon = Icons.verified;
        } else {
          continue;
        }

        formattedList.add(
          NotificationModel(
            id: doc.id,
            message: title,
            requestBy: body,
            time: timeStr,
            postId: postId,
            receiverId: receiverId,
            status: status,
          ),
        );
      } catch (e) { continue; }
    }
    return formattedList;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GenericAuthProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0.5,
      ),
      body: auth.user == null
          ? const Center(child: Text("Please Login"))
          : StreamBuilder<QuerySnapshot>(
        // ✅ টাইম অনুযায়ী ইনডেক্সিং (Newest First)
        stream: _firestore
            .collection('requests')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Indexing required. Check Firebase console."));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyState(isDark);
          }

          return FutureBuilder<List<NotificationModel>>(
            future: _processVolunteerNotifications(snapshot.data!.docs, auth.user!.uid),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColor.green));
              }

              if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
                return _buildEmptyState(isDark);
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: fSnapshot.data!.length,
                itemBuilder: (context, index) {
                  return _buildNotificationCard(fSnapshot.data![index], isDark);
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: AppColor.green.withOpacity(0.1),
          child: const Icon(Icons.campaign, color: AppColor.green, size: 20),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(item.message,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(item.requestBy,
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12, height: 1.3)),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded, size: 70, color: Colors.grey.withOpacity(0.3)),
          const SizedBox(height: 10),
          Text("No notifications found", style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}