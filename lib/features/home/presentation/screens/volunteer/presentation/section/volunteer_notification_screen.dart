// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/generic_notification_section.dart';
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
//         // ✅ ১. সঠিক টাইম ইনডেক্সিং (Newest on top)
//         String timeStr = "Just now";
//         Timestamp? createdAt = data['createdAt'] as Timestamp?;
//         if (createdAt != null) {
//           timeStr = timeago.format(createdAt.toDate(), locale: 'en_short'); // '1m', '2h' format
//         }
//
//         // ✅ ২. ডেটা ফেচিং (খাবার, ডোনার ও রিসিভারের নাম)
//         String foodName = _cache["p_$postId"] ?? "Food";
//         if (!_cache.containsKey("p_$postId")) {
//           var pDoc = await _firestore.collection('posts').doc(postId).get();
//           foodName = pDoc.data()?['foodName'] ?? "Food";
//           _cache["p_$postId"] = foodName;
//         }
//
//         String donorName = _cache["d_$donorId"] ?? "Donor";
//         if (!_cache.containsKey("d_$donorId")) {
//           var dDoc = await _firestore.collection('accounts').doc(donorId).get();
//           donorName = dDoc.data()?['profile']?['contactPerson'] ?? "Donor";
//           _cache["d_$donorId"] = donorName;
//         }
//
//         String receiverName = _cache["r_$receiverId"] ?? "Receiver";
//         if (!_cache.containsKey("r_$receiverId")) {
//           var rDoc = await _firestore.collection('accounts').doc(receiverId).get();
//           receiverName = rDoc.data()?['profile']?['contactPerson'] ?? "Receiver";
//           _cache["r_$receiverId"] = receiverName;
//         }
//
//         String title = "";
//         String body = "";
//
//         // ✅ ৩. আপনার কাঙ্ক্ষিত লজিক: ডোনার ভলান্টিয়ারকে এক্সেপ্ট করলে
//         if (vId == currentUid && status == 'delivered' && dStatus == 'pending') {
//           title = "🎊 Donor Accepted Your Request!";
//           body = "$donorName picked you for delivering '$foodName' to $receiverName.";
//         }
//         else if (status == 'approved' && vId.isEmpty) {
//           title = "📢 New Opportunity";
//           body = "'$foodName' is ready. Help $donorName to reach $receiverName.";
//         }
//         else if (vId == currentUid && dStatus == 'ongoing') {
//           title = "🚚 Pickup Done";
//           body = "You are on your way to deliver '$foodName' to $receiverName.";
//         }
//         else if (vId == currentUid && dStatus == 'completed') {
//           title = "✅ Delivery Successful";
//           body = "Successfully delivered '$foodName' to $receiverName.";
//         } else {
//           continue;
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
//       } catch (e) { continue; }
//     }
//     return formattedList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5), // হালকা গ্রে ব্যাকগ্রাউন্ড
//       appBar: AppBar(
//         title: const Text("Notifications", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         centerTitle: true,
//       ),
//       body: auth.user == null
//           ? const Center(child: Text("Please Login"))
//           : StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('requests').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//           // ✅ ৪. নতুন নোটিফিকেশন সবার উপরে রাখতে শর্টিং
//           final sortedDocs = snapshot.data!.docs.toList();
//           sortedDocs.sort((a, b) {
//             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             return t2.compareTo(t1);
//           });
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
//             builder: (context, fSnapshot) {
//               if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
//                 return const Center(child: Text("No tasks found"));
//               }
//
//               // ✅ ৫. গ্যাপ কমানোর জন্য সরাসরি NotificationSection এ পুরো লিস্ট পাঠানো হয়েছে
//               return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5), // ওপর-নিচে কম গ্যাপ
//                   child: NotificationSection(
//                     notifications: fSnapshot.data!,
//                     onApprove: (id) {},
//                     onReject: (id) {},
//                   ),
//                 ),
//               );
//             },
//           );
//         },
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
import '../../../../sections/generic_notification_section.dart';
import '../../../../../../../core/constants/app_colors.dart'; // পাথ নিশ্চিত করুন

class VolunteerNotificationScreen extends StatefulWidget {
  static String routeName = "/volunteer-notification";
  const VolunteerNotificationScreen({super.key});

  @override
  State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
}

class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _cache = {};

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

        String timeStr = "Just now";
        Timestamp? createdAt = data['createdAt'] as Timestamp?;
        if (createdAt != null) {
          timeStr = timeago.format(createdAt.toDate(), locale: 'en_short');
        }

        String foodName = _cache["p_$postId"] ?? "Food";
        if (!_cache.containsKey("p_$postId")) {
          var pDoc = await _firestore.collection('posts').doc(postId).get();
          foodName = pDoc.data()?['foodName'] ?? "Food";
          _cache["p_$postId"] = foodName;
        }

        String donorName = _cache["d_$donorId"] ?? "Donor";
        if (!_cache.containsKey("d_$donorId")) {
          var dDoc = await _firestore.collection('accounts').doc(donorId).get();
          donorName = dDoc.data()?['profile']?['contactPerson'] ?? "Donor";
          _cache["d_$donorId"] = donorName;
        }

        String receiverName = _cache["r_$receiverId"] ?? "Receiver";
        if (!_cache.containsKey("r_$receiverId")) {
          var rDoc = await _firestore.collection('accounts').doc(receiverId).get();
          receiverName = rDoc.data()?['profile']?['contactPerson'] ?? "Receiver";
          _cache["r_$receiverId"] = receiverName;
        }

        String title = "";
        String body = "";

        if (vId == currentUid && status == 'delivered' && dStatus == 'pending') {
          title = "🎊 Donor Accepted Your Request!";
          body = "$donorName picked you for delivering '$foodName' to $receiverName.";
        }
        else if (status == 'approved' && vId.isEmpty) {
          title = "📢 New Opportunity";
          body = "'$foodName' is ready. Help $donorName to reach $receiverName.";
        }
        else if (vId == currentUid && dStatus == 'ongoing') {
          title = "🚚 Pickup Done";
          body = "You are on your way to deliver '$foodName' to $receiverName.";
        }
        else if (vId == currentUid && dStatus == 'completed') {
          title = "✅ Delivery Successful";
          body = "Successfully delivered '$foodName' to $receiverName.";
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
      // ব্যাকগ্রাউন্ড কালার অ্যাডজাস্টমেন্ট
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(
            "Notifications",
            style: TextStyle(
                color: isDark ? AppColor.white : AppColor.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
            )
        ),
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? AppColor.white : AppColor.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: auth.user == null
          ? const Center(child: Text("Please Login"))
          : StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No notifications yet",
                style: TextStyle(color: isDark ? Colors.grey : AppColor.black),
              ),
            );
          }

          final sortedDocs = snapshot.data!.docs.toList();
          sortedDocs.sort((a, b) {
            Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            return t2.compareTo(t1);
          });

          return FutureBuilder<List<NotificationModel>>(
            future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColor.green));
              }

              if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No tasks found",
                    style: TextStyle(color: isDark ? Colors.grey : AppColor.black),
                  ),
                );
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: NotificationSection(
                    notifications: fSnapshot.data!,
                    onApprove: (id) {},
                    onReject: (id) {},
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}