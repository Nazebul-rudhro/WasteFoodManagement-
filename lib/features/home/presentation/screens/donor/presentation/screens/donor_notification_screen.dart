// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// import '../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/generic_notification_section.dart';
// import '../provider/donor_provider.dart';
//
// class DonorNotificationScreen extends StatefulWidget {
//   static String routeName = "donor-notification";
//   const DonorNotificationScreen({super.key});
//
//   @override
//   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// }
//
// class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<List<NotificationModel>> _processNotificationData(List<DocumentSnapshot> docs) async {
//     List<NotificationModel> formattedList = [];
//
//     for (var doc in docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       String requestId = doc.id;
//       String status = data['status'] ?? "pending";
//       String dStatus = data['deliverystatus'] ?? "none";
//       String volunteerName = data['volunteerName'] ?? "A volunteer";
//
//       // ✅ Time Formatting
//       String timeStr = "Just now";
//       if (data['createdAt'] != null) {
//         DateTime date = (data['createdAt'] as Timestamp).toDate();
//         timeStr = timeago.format(date, locale: 'en_short');
//       }
//
//       // ✅ 1. Food Name Fetch
//       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
//       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";
//
//       // ✅ 2. Receiver Name Fetch
//       var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
//       String receiverName = userDoc.exists
//           ? (userDoc.data()?['profile']?['contactPerson'] ?? "Receiver")
//           : "someone";
//
//       // ✅ 3. Check for Volunteer Interest
//       var volunteerBids = await _firestore.collection('requests').doc(requestId).collection('pickup_requests').get();
//
//       // --- Full User Friendly Messaging ---
//       String displayTitle = "";
//       String displayBody = "";
//
//       if (status == 'pending') {
//         displayTitle = "Food Request";
//         displayBody = "$receiverName requested for your '$foodName'";
//       }
//       else if (status == 'approved' && volunteerBids.docs.isNotEmpty) {
//         displayTitle = "Volunteer Interested";
//         displayBody = "${volunteerBids.docs.length} volunteer(s) want to pick up '$foodName' for $receiverName";
//       }
//       else if (status == 'delivered' && dStatus == 'pending') {
//         displayTitle = "Assigned to Volunteer";
//         displayBody = "Waiting for $volunteerName to pick up '$foodName'";
//       }
//       else if (dStatus == 'ongoing') {
//         displayTitle = "On the way";
//         displayBody = "$volunteerName has picked up '$foodName' and is going to $receiverName";
//       }
//       else if (dStatus == 'completed') {
//         displayTitle = "Delivery Completed";
//         displayBody = "$volunteerName successfully delivered '$foodName' to $receiverName";
//       }
//       else if (status == 'rejected') {
//         displayTitle = "Request Rejected";
//         displayBody = "You rejected $receiverName's request for '$foodName'";
//       }
//       else {
//         displayTitle = "Update: $foodName";
//         displayBody = "Status: ${status.toUpperCase()}";
//       }
//
//       formattedList.add(
//         NotificationModel(
//           id: requestId,
//           message: displayTitle,
//           requestBy: displayBody,
//           time: timeStr,
//           receiverId: data['receiverId'] ?? "",
//           postId: data['postId'] ?? "",
//           status: status,
//         ),
//       );
//     }
//     return formattedList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//     final donorPro = context.read<DonorProvider>();
//
//     if (auth.user == null) return const Scaffold(body: Center(child: Text("Please Login")));
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title:  Text("Notifications", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
//         elevation: 0.5,
//         backgroundColor: AppColor.soft_green,
//         iconTheme: const IconThemeData(color: Colors.black87),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('requests')
//             .where('donorId', isEqualTo: auth.user!.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return const Center(child: Text("Connection Error"));
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No notifications yet", style: TextStyle(color: Colors.grey)));
//           }
//
//           // sorting locally to avoid index errors
//           final sortedDocs = snapshot.data!.docs.toList();
//           sortedDocs.sort((a, b) {
//             Timestamp t1 = a['createdAt'] ?? Timestamp.now();
//             Timestamp t2 = b['createdAt'] ?? Timestamp.now();
//             return t2.compareTo(t1);
//           });
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processNotificationData(sortedDocs),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: BaseScreen(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: NotificationSection(
//                       notifications: fSnapshot.data!,
//                       onApprove: (id) async {
//                         final item = fSnapshot.data!.firstWhere((x) => x.id == id);
//                         if (item.status == 'approved') {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Please assign a volunteer from the Delivery section."))
//                           );
//                         } else {
//                           await donorPro.handleRequest(id, item.postId, 'approved');
//                         }
//                       },
//                       onReject: (id) async {
//                         final item = fSnapshot.data!.firstWhere((x) => x.id == id);
//                         await donorPro.handleRequest(id, item.postId, 'rejected');
//                       },
//                     ),
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
import 'package:waste_food_management/core/constants/app_colors.dart';

import '../../../../../../auth/data/model/notification_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/generic_notification_section.dart';
import '../provider/donor_provider.dart';

class DonorNotificationScreen extends StatefulWidget {
  static String routeName = "donor-notification";
  const DonorNotificationScreen({super.key});

  @override
  State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
}

class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NotificationModel>> _processNotificationData(List<DocumentSnapshot> docs) async {
    List<NotificationModel> formattedList = [];

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      String requestId = doc.id;
      String status = data['status'] ?? "pending";
      String dStatus = data['deliverystatus'] ?? "none";
      String volunteerName = data['volunteerName'] ?? "A volunteer";

      String timeStr = "Just now";
      if (data['createdAt'] != null) {
        DateTime date = (data['createdAt'] as Timestamp).toDate();
        timeStr = timeago.format(date, locale: 'en_short');
      }

      var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
      String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";

      var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
      String receiverName = userDoc.exists
          ? (userDoc.data()?['profile']?['contactPerson'] ?? "Receiver")
          : "someone";

      var volunteerBids = await _firestore.collection('requests').doc(requestId).collection('pickup_requests').get();

      String displayTitle = "";
      String displayBody = "";

      if (status == 'pending') {
        displayTitle = "Food Request";
        displayBody = "$receiverName requested for your '$foodName'";
      }
      else if (status == 'approved' && volunteerBids.docs.isNotEmpty) {
        displayTitle = "Volunteer Interested";
        displayBody = "${volunteerBids.docs.length} volunteer(s) want to pick up '$foodName' for $receiverName";
      }
      else if (status == 'delivered' && dStatus == 'pending') {
        displayTitle = "Assigned to Volunteer";
        displayBody = "Waiting for $volunteerName to pick up '$foodName'";
      }
      else if (dStatus == 'ongoing') {
        displayTitle = "On the way";
        displayBody = "$volunteerName has picked up '$foodName' and is going to $receiverName";
      }
      else if (dStatus == 'completed') {
        displayTitle = "Delivery Completed";
        displayBody = "$volunteerName successfully delivered '$foodName' to $receiverName";
      }
      else if (status == 'rejected') {
        displayTitle = "Request Rejected";
        displayBody = "You rejected $receiverName's request for '$foodName'";
      }
      else {
        displayTitle = "Update: $foodName";
        displayBody = "Status: ${status.toUpperCase()}";
      }

      formattedList.add(
        NotificationModel(
          id: requestId,
          message: displayTitle,
          requestBy: displayBody,
          time: timeStr,
          receiverId: data['receiverId'] ?? "",
          postId: data['postId'] ?? "",
          status: status,
        ),
      );
    }
    return formattedList;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GenericAuthProvider>();
    final donorPro = context.read<DonorProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (auth.user == null) return const Scaffold(body: Center(child: Text("Please Login")));

    return Scaffold(
      // 🟢 ব্যাকগ্রাউন্ড কালার ডার্ক মোড অনুযায়ী অ্যাডাপ্টিভ
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(
            "Notifications",
            style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18
            )
        ),
        elevation: isDark ? 0 : 0.5,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where('donorId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Connection Error"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.green));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
                child: Text(
                    "No notifications yet",
                    style: TextStyle(color: isDark ? Colors.white30 : Colors.grey)
                )
            );
          }

          final sortedDocs = snapshot.data!.docs.toList();
          sortedDocs.sort((a, b) {
            Timestamp t1 = a['createdAt'] ?? Timestamp.now();
            Timestamp t2 = b['createdAt'] ?? Timestamp.now();
            return t2.compareTo(t1);
          });

          return FutureBuilder<List<NotificationModel>>(
            future: _processNotificationData(sortedDocs),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColor.green));
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BaseScreen(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: NotificationSection(
                      notifications: fSnapshot.data!,
                      onApprove: (id) async {
                        final item = fSnapshot.data!.firstWhere((x) => x.id == id);
                        if (item.status == 'approved') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: isDark ? Colors.grey[900] : Colors.black87,
                                  content: const Text("Please assign a volunteer from the Delivery section.")
                              )
                          );
                        } else {
                          await donorPro.handleRequest(id, item.postId, 'approved');
                        }
                      },
                      onReject: (id) async {
                        final item = fSnapshot.data!.firstWhere((x) => x.id == id);
                        await donorPro.handleRequest(id, item.postId, 'rejected');
                      },
                    ),
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