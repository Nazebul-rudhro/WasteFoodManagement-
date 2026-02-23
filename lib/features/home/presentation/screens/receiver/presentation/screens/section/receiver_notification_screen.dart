// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../../sections/base_screen.dart';
// import '../../../../../sections/generic_notification_section.dart';
//
// class ReceiverNotificationScreen extends StatefulWidget {
//   static String routeName = "receiver-notification";
//   const ReceiverNotificationScreen({super.key});
//
//   @override
//   State<ReceiverNotificationScreen> createState() => _ReceiverNotificationScreenState();
// }
//
// class _ReceiverNotificationScreenState extends State<ReceiverNotificationScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final Map<String, String> _cache = {};
//
//   Future<List<NotificationModel>> _processReceiverNotifications(List<DocumentSnapshot> docs) async {
//     List<NotificationModel> formattedList = [];
//
//     for (var doc in docs) {
//       try {
//         final data = doc.data() as Map<String, dynamic>?;
//         if (data == null) continue;
//
//         String status = data['status'] ?? "pending";
//         String dStatus = data['deliverystatus'] ?? "none";
//         String postId = data['postId'] ?? "";
//         String donorId = data['donorId'] ?? "";
//         String volunteerName = data['volunteerName'] ?? "A volunteer";
//
//         // ✅ ১. সঠিক টাইম ইনডেক্সিং (Short format)
//         String timeStr = "Just now";
//         if (data['createdAt'] != null) {
//           DateTime date = (data['createdAt'] as Timestamp).toDate();
//           timeStr = timeago.format(date, locale: 'en_short');
//         }
//
//         // ✅ ২. ক্যাশ থেকে ডেটা ফেচ (Fast Loading)
//         String foodName = _cache["p_$postId"] ?? "";
//         if (foodName.isEmpty && postId.isNotEmpty) {
//           var pDoc = await _firestore.collection('posts').doc(postId).get();
//           foodName = pDoc.exists ? (pDoc.data()?['foodName'] ?? "Food") : "Food Item";
//           _cache["p_$postId"] = foodName;
//         }
//
//         String donorName = _cache["d_$donorId"] ?? "";
//         if (donorName.isEmpty && donorId.isNotEmpty) {
//           var dDoc = await _firestore.collection('accounts').doc(donorId).get();
//           donorName = dDoc.exists ? (dDoc.data()?['profile']?['contactPerson'] ?? "Donor") : "Donor";
//           _cache["d_$donorId"] = donorName;
//         }
//
//         // ✅ ৩. এরর ফিক্সড লজিক (Variables declared properly)
//         String title = "";
//         String body = "";
//
//         if (status == 'approved' && dStatus == 'none') {
//           title = "🎊 Request Accepted!";
//           body = "Donor $donorName approved your request for '$foodName'. Finding a volunteer...";
//         }
//         else if (status == 'approved' && dStatus == 'pending') {
//           title = "🤝 Volunteer Assigned";
//           body = "$volunteerName is ready to pick up your '$foodName' from $donorName.";
//         }
//         else if (dStatus == 'ongoing') {
//           title = "🚚 Food is on the way!";
//           body = "$volunteerName has picked up your '$foodName' and is coming to you.";
//         }
//         else if (dStatus == 'completed') {
//           title = "✅ Enjoy Your Meal!";
//           body = "Successfully received '$foodName' delivered by $volunteerName.";
//         }
//         else if (status == 'rejected') {
//           title = "❌ Request Declined";
//           body = "Sorry, your request for '$foodName' was not accepted.";
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
//             receiverId: data['receiverId'] ?? "",
//             postId: postId,
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
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:  Text("Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         backgroundColor: AppColor.soft_green,
//         elevation: 0.5,
//         centerTitle: true,
//       ),
//       body: auth.user == null
//           ? const Center(child: Text("Please Login"))
//           : StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('requests')
//             .where('receiverId', isEqualTo: auth.user!.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No updates yet"));
//
//           // ✅ ৪. টাইম অনুযায়ী শর্টিং (নতুন আগে)
//           final sortedDocs = snapshot.data!.docs.toList();
//           sortedDocs.sort((a, b) {
//             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             return t2.compareTo(t1);
//           });
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processReceiverNotifications(sortedDocs),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting && !fSnapshot.hasData) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               // ✅ ৫. গ্যাপ কমানোর জন্য লিস্ট ডিজাইন
//               return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 5),
//                   child: NotificationSection(
//                     notifications: fSnapshot.data ?? [],
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
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/notification_model.dart';
import '../../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../../sections/base_screen.dart';
import '../../../../../sections/generic_notification_section.dart';

class ReceiverNotificationScreen extends StatefulWidget {
  static String routeName = "receiver-notification";
  const ReceiverNotificationScreen({super.key});

  @override
  State<ReceiverNotificationScreen> createState() => _ReceiverNotificationScreenState();
}

class _ReceiverNotificationScreenState extends State<ReceiverNotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _cache = {};

  Future<List<NotificationModel>> _processReceiverNotifications(List<DocumentSnapshot> docs) async {
    List<NotificationModel> formattedList = [];

    for (var doc in docs) {
      try {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) continue;

        String status = data['status'] ?? "pending";
        String dStatus = data['deliverystatus'] ?? "none";
        String postId = data['postId'] ?? "";
        String donorId = data['donorId'] ?? "";
        String volunteerName = data['volunteerName'] ?? "A volunteer";

        String timeStr = "Just now";
        if (data['createdAt'] != null) {
          DateTime date = (data['createdAt'] as Timestamp).toDate();
          timeStr = timeago.format(date, locale: 'en_short');
        }

        String foodName = _cache["p_$postId"] ?? "";
        if (foodName.isEmpty && postId.isNotEmpty) {
          var pDoc = await _firestore.collection('posts').doc(postId).get();
          foodName = pDoc.exists ? (pDoc.data()?['foodName'] ?? "Food") : "Food Item";
          _cache["p_$postId"] = foodName;
        }

        String donorName = _cache["d_$donorId"] ?? "";
        if (donorName.isEmpty && donorId.isNotEmpty) {
          var dDoc = await _firestore.collection('accounts').doc(donorId).get();
          donorName = dDoc.exists ? (dDoc.data()?['profile']?['contactPerson'] ?? "Donor") : "Donor";
          _cache["d_$donorId"] = donorName;
        }

        String title = "";
        String body = "";

        if (status == 'approved' && dStatus == 'none') {
          title = "🎊 Request Accepted!";
          body = "Donor $donorName approved your request for '$foodName'. Finding a volunteer...";
        }
        else if (status == 'approved' && dStatus == 'pending') {
          title = "🤝 Volunteer Assigned";
          body = "$volunteerName is ready to pick up your '$foodName' from $donorName.";
        }
        else if (dStatus == 'ongoing') {
          title = "🚚 Food is on the way!";
          body = "$volunteerName has picked up your '$foodName' and is coming to you.";
        }
        else if (dStatus == 'completed') {
          title = "✅ Enjoy Your Meal!";
          body = "Successfully received '$foodName' delivered by $volunteerName.";
        }
        else if (status == 'rejected') {
          title = "❌ Request Declined";
          body = "Sorry, your request for '$foodName' was not accepted.";
        } else {
          continue;
        }

        formattedList.add(
          NotificationModel(
            id: doc.id,
            message: title,
            requestBy: body,
            time: timeStr,
            receiverId: data['receiverId'] ?? "",
            postId: postId,
            status: status,
          ),
        );
      } catch (e) {
        continue;
      }
    }
    return formattedList;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GenericAuthProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // ডার্ক মোডে ডার্ক কালার এবং লাইট মোডে হোয়াইট
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(
            "Notifications",
            style: TextStyle(
                color: isDark ? AppColor.white : AppColor.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
            )
        ),
        // ডার্ক মোডে AppBar-এর কালার একটু গ্রে-িশ রাখা হয়েছে, লাইট মোডে আপনার সিগনেচার সফট গ্রিন
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: isDark ? AppColor.white : AppColor.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: auth.user == null
          ? const Center(child: Text("Please Login"))
          : StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where('receiverId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.green));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No updates yet",
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
            future: _processReceiverNotifications(sortedDocs),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting && !fSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator(color: AppColor.green));
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: NotificationSection(
                    notifications: fSnapshot.data ?? [],
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