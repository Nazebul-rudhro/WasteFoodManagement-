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
//
//   Future<List<NotificationModel>> _processReceiverNotifications(List<QueryDocumentSnapshot> docs) async {
//     List<NotificationModel> formattedList = [];
//
//     for (var doc in docs) {
//       final data = doc.data() as Map<String, dynamic>;
//       String status = data['status'] ?? "pending";
//       String timeStr = data['createdAt'] != null
//           ? timeago.format((data['createdAt'] as Timestamp).toDate())
//           : "Just now";
//
//       // Food Name fetch kora
//       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
//       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";
//
//       // Role wise status message handle kora
//       String displayMessage = "";
//       String updateBy = "";
//
//       if (status == 'approved') {
//         displayMessage = "Donor approved your request for $foodName";
//         updateBy = "From Donor";
//       } else if (status == 'received') {
//         displayMessage = "Volunteer has picked up your $foodName";
//         updateBy = "Volunteer Action";
//       } else if (status == 'delivered') {
//         displayMessage = "Your $foodName has been delivered successfully!";
//         updateBy = "Delivered";
//       } else if (status == 'rejected') {
//         displayMessage = "Your request for $foodName was rejected";
//         updateBy = "Update";
//       }
//
//       formattedList.add(
//         NotificationModel(
//           id: doc.id,
//           message: displayMessage,
//           requestBy: updateBy,
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
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Notifications"),
//         backgroundColor: AppColor.soft_green,
//         elevation: 1,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('requests')
//             .where('receiverId', isEqualTo: auth.user?.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No notifications found"));
//
//           // Pending status chara baki shob status notification hisebe dekhabe
//           final filteredDocs = snapshot.data!.docs.where((doc) => doc['status'] != 'pending').toList();
//
//           if (filteredDocs.isEmpty) return const Center(child: Text("No updates yet"));
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processReceiverNotifications(filteredDocs),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//               return SingleChildScrollView(
//                 child: BaseScreen(
//                   child: NotificationSection(
//                     notifications: fSnapshot.data ?? [],
//                     onApprove: (id) {}, // Receiver-er jonno logic dorkar nei
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

        // ✅ ১. সঠিক টাইম ইনডেক্সিং (Short format)
        String timeStr = "Just now";
        if (data['createdAt'] != null) {
          DateTime date = (data['createdAt'] as Timestamp).toDate();
          timeStr = timeago.format(date, locale: 'en_short');
        }

        // ✅ ২. ক্যাশ থেকে ডেটা ফেচ (Fast Loading)
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

        // ✅ ৩. এরর ফিক্সড লজিক (Variables declared properly)
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text("Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: AppColor.soft_green,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: auth.user == null
          ? const Center(child: Text("Please Login"))
          : StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where('receiverId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No updates yet"));

          // ✅ ৪. টাইম অনুযায়ী শর্টিং (নতুন আগে)
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
                return const Center(child: CircularProgressIndicator());
              }

              // ✅ ৫. গ্যাপ কমানোর জন্য লিস্ট ডিজাইন
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
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