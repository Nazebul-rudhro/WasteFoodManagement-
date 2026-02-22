/*
//
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
//   // 🔹 Step 1: Process Data (Status Check, Food Name & User Name Fetching)
//   Future<List<NotificationModel>> _processNotificationData(List<QueryDocumentSnapshot> docs) async {
//     List<NotificationModel> formattedList = [];
//
//     for (var doc in docs) {
//       final data = doc.data() as Map<String, dynamic>;
//
//       // ✅ Status Check (Pending, Approved, Rejected, Delivered)
//       String status = data['status'] ?? "pending";
//
//       String timeStr = data['createdAt'] != null
//           ? timeago.format((data['createdAt'] as Timestamp).toDate())
//           : "Just now";
//
//       // ✅ Fetch Food Name from 'posts' collection using postId
//       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
//       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";
//
//       // ✅ Fetch Receiver Name from 'accounts' collection
//       var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
//       String userName = userDoc.exists
//           ? (userDoc.data()?['businessOrFullName'] ?? userDoc.data()?['profile']?['contactPerson'] ?? "User")
//           : "Someone";
//
//       formattedList.add(
//         NotificationModel(
//           id: doc.id,
//           message: foodName,
//           requestBy: "Requested by: $userName",
//           time: timeStr,
//           receiverId: data['receiverId'] ?? "",
//           postId: data['postId'] ?? "",
//           status: status, // Final Checked Status
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
//     if (auth.user == null) return const Scaffold(body: Center(child: Text("Login Required")));
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notifications"), elevation: 1, backgroundColor: AppColor.soft_green,),
//       body: StreamBuilder<QuerySnapshot>(
//         // 🔹 Firebase theke donor-er shob requests niye asha hosse
//         stream: _firestore
//             .collection('requests')
//             .where('donorId', isEqualTo: auth.user!.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No Requests Found"));
//           }
//
//           // 🔹 Local Filter: requests theke status check kora (Index er jhamela thakbe na)
//           final filteredDocs = snapshot.data!.docs.where((doc) {
//             final st = doc['status'] as String;
//             return ['pending', 'approved', 'rejected', 'delivered'].contains(st);
//           }).toList();
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processNotificationData(filteredDocs),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
//                 return const Center(child: Text("No Data After Processing"));
//               }
//
//               return SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: BaseScreen(
//                   child: NotificationSection(
//                     notifications: fSnapshot.data!,
//                     onApprove: (id) async {
//                       final item = fSnapshot.data!.firstWhere((x) => x.id == id);
//                       await donorPro.handleRequest(id, item.postId, 'approved');
//                     },
//                     onReject: (id) async {
//                       final item = fSnapshot.data!.firstWhere((x) => x.id == id);
//                       await donorPro.handleRequest(id, item.postId, 'rejected');
//                     },
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

  // 🔹 Step 1: Process Data (Status Check, Food Name & User Name Fetching)
  Future<List<NotificationModel>> _processNotificationData(List<DocumentSnapshot> docs) async {
    List<NotificationModel> formattedList = [];

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      String requestId = doc.id;
      String status = data['status'] ?? "pending";
      String dStatus = data['deliverystatus'] ?? "none";

      // ✅ টাইম ফরম্যাটিং (নতুন রিকোয়েস্টের জন্য '1m' বা 'Just now')
      String timeStr = "Just now";
      if (data['createdAt'] != null) {
        DateTime date = (data['createdAt'] as Timestamp).toDate();
        timeStr = timeago.format(date, locale: 'en_short');
      }

      // ✅ ১. খাবারের নাম (Posts Collection থেকে)
      var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
      String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";

      // ✅ ২. রিসিভারের নাম (Accounts Collection থেকে)
      var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
      String receiverName = userDoc.exists
          ? (userDoc.data()?['profile']?['contactPerson'] ?? "Receiver")
          : "Someone";

      // ✅ ৩. ভলান্টিয়ার রিকোয়েস্ট চেক (Sub-collection: pickup_requests)
      var volunteerBids = await _firestore.collection('requests').doc(requestId).collection('pickup_requests').get();

      // --- ইউজার ফ্রেন্ডলি মেসেজ লজিক ---
      String displayTitle = "";
      String displayBody = "";

      if (status == 'pending') {
        displayTitle = "New Request Received!";
        displayBody = "$receiverName wants '$foodName' now.";
      } else if (status == 'approved' && volunteerBids.docs.isNotEmpty) {
        displayTitle = "Volunteer Interest!";
        displayBody = "${volunteerBids.docs.length} volunteer(s) ready to pick up '$foodName'";
      } else if (status == 'delivered' && dStatus == 'pending') {
        displayTitle = "Assigned & Waiting";
        displayBody = "Waiting for ${data['volunteerName'] ?? 'Volunteer'} to pickup '$foodName'";
      } else if (dStatus == 'ongoing') {
        displayTitle = "Order is On the Way";
        displayBody = "${data['volunteerName']} is delivering '$foodName'";
      } else if (dStatus == 'completed') {
        displayTitle = "Mission Successful ✅";
        displayBody = "'$foodName' reached to $receiverName";
      } else {
        displayTitle = "Food Status: ${status.toUpperCase()}";
        displayBody = "Update for $foodName item.";
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

    if (auth.user == null) return const Scaffold(body: Center(child: Text("Please Login First")));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Recent Notifications", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // 🔹 এখানে orderBy করা হয়নি যাতে ইনডেক্স এরর না আসে
        stream: _firestore
            .collection('requests')
            .where('donorId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text("Something went wrong. Please check your internet."));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none_rounded, size: 70, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No notifications yet", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          // 🔹 ম্যানুয়াল সর্টিং (যাতে লেটেস্ট নোটিফিকেশন উপরে আসে)
          final sortedDocs = snapshot.data!.docs.toList();
          sortedDocs.sort((a, b) {
            Timestamp t1 = a['createdAt'] ?? Timestamp.now();
            Timestamp t2 = b['createdAt'] ?? Timestamp.now();
            return t2.compareTo(t1); // নতুন ডাটা সবার উপরে
          });

          return FutureBuilder<List<NotificationModel>>(
            future: _processNotificationData(sortedDocs),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
                return const Center(child: Text("Processing Notifications..."));
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
                              const SnackBar(content: Text("Assign a volunteer from the Delivery tab."))
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
}*/






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

      // ✅ Time Formatting
      String timeStr = "Just now";
      if (data['createdAt'] != null) {
        DateTime date = (data['createdAt'] as Timestamp).toDate();
        timeStr = timeago.format(date, locale: 'en_short');
      }

      // ✅ 1. Food Name Fetch
      var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
      String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";

      // ✅ 2. Receiver Name Fetch
      var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
      String receiverName = userDoc.exists
          ? (userDoc.data()?['profile']?['contactPerson'] ?? "Receiver")
          : "someone";

      // ✅ 3. Check for Volunteer Interest
      var volunteerBids = await _firestore.collection('requests').doc(requestId).collection('pickup_requests').get();

      // --- Full User Friendly Messaging ---
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

    if (auth.user == null) return const Scaffold(body: Center(child: Text("Please Login")));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text("Notifications", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        elevation: 0.5,
        backgroundColor: AppColor.soft_green,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('requests')
            .where('donorId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Connection Error"));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No notifications yet", style: TextStyle(color: Colors.grey)));
          }

          // sorting locally to avoid index errors
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
                return const Center(child: CircularProgressIndicator());
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
                              const SnackBar(content: Text("Please assign a volunteer from the Delivery section."))
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