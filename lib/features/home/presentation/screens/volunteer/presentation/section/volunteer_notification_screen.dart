// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:timeago/timeago.dart' as timeago;
// // // // // import '../../../../../../../../core/constants/app_colors.dart';
// // // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // // import '../../../../sections/base_screen.dart';
// // // // // import '../../../../sections/generic_notification_section.dart';
// // // // //
// // // // // class VolunteerNotificationScreen extends StatefulWidget {
// // // // //   static String routeName = "/volunteer-notification";
// // // // //   const VolunteerNotificationScreen({super.key});
// // // // //
// // // // //   @override
// // // // //   State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
// // // // // }
// // // // //
// // // // // class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   Future<List<NotificationModel>> _processVolunteerNotifications(List<QueryDocumentSnapshot> docs) async {
// // // // //     List<NotificationModel> formattedList = [];
// // // // //
// // // // //     for (var doc in docs) {
// // // // //       final data = doc.data() as Map<String, dynamic>;
// // // // //
// // // // //       String timeStr = data['createdAt'] != null
// // // // //           ? timeago.format((data['createdAt'] as Timestamp).toDate())
// // // // //           : "Just now";
// // // // //
// // // // //       // ১. খাবারের নাম আনা
// // // // //       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
// // // // //       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Unknown Food";
// // // // //
// // // // //       // ২. ডোনারের নাম বা লোকেশন আনা (Pick-up point)
// // // // //       var donorDoc = await _firestore.collection('accounts').doc(data['donorId']).get();
// // // // //       String donorName = donorDoc.exists
// // // // //           ? (donorDoc.data()?['profile']?['contactPerson'] ?? "Donor")
// // // // //           : "Nearby Donor";
// // // // //
// // // // //       formattedList.add(
// // // // //         NotificationModel(
// // // // //           id: doc.id,
// // // // //           message: "New Delivery Available: $foodName",
// // // // //           requestBy: "Pick-up from: $donorName",
// // // // //           time: timeStr,
// // // // //           postId: data['postId'] ?? "",
// // // // //           receiverId: data['receiverId'] ?? "",
// // // // //           status: data['status'] ?? "approved",
// // // // //         ),
// // // // //       );
// // // // //     }
// // // // //     return formattedList;
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final auth = context.watch<GenericAuthProvider>();
// // // // //
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: const Text("Available Tasks"),
// // // // //         backgroundColor: AppColor.soft_green,
// // // // //         elevation: 1,
// // // // //       ),
// // // // //       body: StreamBuilder<QuerySnapshot>(
// // // // //         // লজিক: শুধু সেই রিকোয়েস্টগুলো দেখাবে যেগুলো Approved এবং এখনো কোনো ভলান্টিয়ার নেয়নি
// // // // //         stream: _firestore
// // // // //             .collection('requests')
// // // // //             .where('status', isEqualTo: 'approved')
// // // // //             .snapshots(),
// // // // //         builder: (context, snapshot) {
// // // // //           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // // // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // //             return const Center(child: Text("No new delivery requests found"));
// // // // //           }
// // // // //
// // // // //           return FutureBuilder<List<NotificationModel>>(
// // // // //             future: _processVolunteerNotifications(snapshot.data!.docs),
// // // // //             builder: (context, fSnapshot) {
// // // // //               if (fSnapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // // // //
// // // // //               return SingleChildScrollView(
// // // // //                 child: BaseScreen(
// // // // //                   child: NotificationSection(
// // // // //                     notifications: fSnapshot.data ?? [],
// // // // //                     // ভলান্টিয়ার এখানে 'Accept' বাটনে ক্লিক করে কাজ শুরু করবে
// // // // //                     onApprove: (id) async {
// // // // //                       // এখানে আপনার VolunteerProvider থেকে 'Accept Delivery' মেথড কল হবে
// // // // //                       debugPrint("Delivery Accepted: $id");
// // // // //                     },
// // // // //                     onReject: (id) => debugPrint("Delivery Ignored"),
// // // // //                   ),
// // // // //                 ),
// // // // //               );
// // // // //             },
// // // // //           );
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // //
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:timeago/timeago.dart' as timeago;
// // // // import '../../../../../../../../core/constants/app_colors.dart';
// // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // import '../../../../sections/base_screen.dart';
// // // // import '../../../../sections/generic_notification_section.dart';
// // // //
// // // // class VolunteerNotificationScreen extends StatefulWidget {
// // // //   static String routeName = "/volunteer-notification";
// // // //   const VolunteerNotificationScreen({super.key});
// // // //
// // // //   @override
// // // //   State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
// // // // }
// // // //
// // // // class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
// // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // //
// // // //   Future<List<NotificationModel>> _processVolunteerNotifications(
// // // //       List<QueryDocumentSnapshot> docs, String currentUid) async {
// // // //     List<NotificationModel> formattedList = [];
// // // //
// // // //     for (var doc in docs) {
// // // //       final data = doc.data() as Map<String, dynamic>;
// // // //       String status = data['status'] ?? "";
// // // //       String volunteerId = data['volunteerId'] ?? "";
// // // //
// // // //       String timeStr = data['createdAt'] != null
// // // //           ? timeago.format((data['createdAt'] as Timestamp).toDate())
// // // //           : "Just now";
// // // //
// // // //       // ১. খাবারের নাম এবং ডিটেইলস ফেচ করা (Professional Approach)
// // // //       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
// // // //       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Food";
// // // //
// // // //       String displayMessage = "";
// // // //       String subTitle = "";
// // // //
// // // //       // ২. কন্ডিশনাল মেসেজিং (Status & Ownership onushare)
// // // //       if (status == 'approved' && (volunteerId.isEmpty)) {
// // // //         displayMessage = "New Delivery Task: $foodName is ready for pickup.";
// // // //         subTitle = "Status: Available";
// // // //       } else if (volunteerId == currentUid) {
// // // //         if (status == 'received') {
// // // //           displayMessage = "Ongoing: You have picked up $foodName.";
// // // //           subTitle = "Status: In Progress";
// // // //         } else if (status == 'delivered') {
// // // //           displayMessage = "Completed: You delivered $foodName.";
// // // //           subTitle = "Status: Successful";
// // // //         } else {
// // // //           continue; // Onno kono status hole skip
// // // //         }
// // // //       } else {
// // // //         continue; // Onno volunteer er task hole skip
// // // //       }
// // // //
// // // //       formattedList.add(
// // // //         NotificationModel(
// // // //           id: doc.id,
// // // //           message: displayMessage,
// // // //           requestBy: subTitle,
// // // //           time: timeStr,
// // // //           postId: data['postId'] ?? "",
// // // //           receiverId: data['receiverId'] ?? "",
// // // //           status: status,
// // // //         ),
// // // //       );
// // // //     }
// // // //     // Newest notifications on top
// // // //     return formattedList.reversed.toList();
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final auth = context.watch<GenericAuthProvider>();
// // // //
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: const Text("Task Notifications"),
// // // //         backgroundColor: AppColor.soft_green,
// // // //         elevation: 1,
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: StreamBuilder<QuerySnapshot>(
// // // //         // 🔥 All requests stream korchi jate history ebong new task dui-i pawa jay
// // // //         stream: _firestore.collection('requests').snapshots(),
// // // //         builder: (context, snapshot) {
// // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // //             return const Center(child: CircularProgressIndicator());
// // // //           }
// // // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // //             return const Center(child: Text("No tasks or activity found"));
// // // //           }
// // // //
// // // //           return FutureBuilder<List<NotificationModel>>(
// // // //             future: _processVolunteerNotifications(snapshot.data!.docs, auth.user?.uid ?? ""),
// // // //             builder: (context, fSnapshot) {
// // // //               if (fSnapshot.connectionState == ConnectionState.waiting) {
// // // //                 return const Center(child: CircularProgressIndicator());
// // // //               }
// // // //               if (fSnapshot.data == null || fSnapshot.data!.isEmpty) {
// // // //                 return const Center(child: Text("No relevant notifications"));
// // // //               }
// // // //
// // // //               return SingleChildScrollView(
// // // //                 physics: const BouncingScrollPhysics(),
// // // //                 child: BaseScreen(
// // // //                   child: NotificationSection(
// // // //                     notifications: fSnapshot.data!,
// // // //                     onApprove: (id) {
// // // //                       // Logic to accept task (Move to Received)
// // // //                     },
// // // //                     onReject: (id) {
// // // //                       // Logic to ignore or cancel
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             },
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:timeago/timeago.dart' as timeago;
// // // import '../../../../../../../../core/constants/app_colors.dart';
// // // import '../../../../../../auth/data/model/notification_model.dart';
// // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // import '../../../../sections/base_screen.dart';
// // // import '../../../../sections/generic_notification_section.dart';
// // //
// // // class VolunteerNotificationScreen extends StatefulWidget {
// // //   static String routeName = "/volunteer-notification";
// // //   const VolunteerNotificationScreen({super.key});
// // //
// // //   @override
// // //   State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
// // // }
// // //
// // // class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   Future<List<NotificationModel>> _processVolunteerNotifications(
// // //       List<QueryDocumentSnapshot> docs, String currentUid) async {
// // //     List<NotificationModel> formattedList = [];
// // //
// // //     for (var doc in docs) {
// // //       final data = doc.data() as Map<String, dynamic>;
// // //       String status = data['status'] ?? "";
// // //       String volunteerId = data['volunteerId'] ?? "";
// // //
// // //       String timeStr = data['createdAt'] != null
// // //           ? timeago.format((data['createdAt'] as Timestamp).toDate())
// // //           : "Just now";
// // //
// // //       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
// // //       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Unknown Food";
// // //
// // //       String displayMessage = "";
// // //       String subTitle = "";
// // //
// // //       if (status == 'approved' && (volunteerId.isEmpty)) {
// // //         displayMessage = "Available: $foodName is ready for pickup";
// // //         subTitle = "New Task";
// // //       } else if (volunteerId == currentUid) {
// // //         if (status == 'received') {
// // //           displayMessage = "Ongoing: Pickup completed for $foodName";
// // //           subTitle = "In Progress";
// // //         } else if (status == 'delivered') {
// // //           displayMessage = "Completed: Delivered $foodName successfully";
// // //           subTitle = "Task Done";
// // //         } else {
// // //           continue;
// // //         }
// // //       } else {
// // //         continue;
// // //       }
// // //
// // //       formattedList.add(
// // //         NotificationModel(
// // //           id: doc.id,
// // //           message: displayMessage,
// // //           requestBy: subTitle,
// // //           time: timeStr,
// // //           postId: data['postId'] ?? "",
// // //           receiverId: data['receiverId'] ?? "",
// // //           status: status,
// // //         ),
// // //       );
// // //     }
// // //     return formattedList.reversed.toList();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final auth = context.watch<GenericAuthProvider>();
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("Notifications"),
// // //         backgroundColor: AppColor.soft_green,
// // //       ),
// // //       body: StreamBuilder<QuerySnapshot>(
// // //         stream: _firestore.collection('requests').snapshots(),
// // //         builder: (context, snapshot) {
// // //           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //
// // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // //             return const Center(child: Text("No notifications"));
// // //           }
// // //
// // //           return FutureBuilder<List<NotificationModel>>(
// // //             future: _processVolunteerNotifications(snapshot.data!.docs, auth.user?.uid ?? ""),
// // //             builder: (context, fSnapshot) {
// // //               if (fSnapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// // //               if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) return const Center(child: Text("No tasks found"));
// // //
// // //               return SingleChildScrollView(
// // //                 child: BaseScreen(
// // //                   child: NotificationSection(
// // //                     notifications: fSnapshot.data!,
// // //                     onApprove: (id) {
// // //                       // Logic for accepting the available task
// // //                     },
// // //                     onReject: (id) {},
// // //                   ),
// // //                 ),
// // //               );
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:provider/provider.dart';
// // import 'package:timeago/timeago.dart' as timeago;
// // import '../../../../../../../../core/constants/app_colors.dart';
// // import '../../../../../../auth/data/model/notification_model.dart';
// // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // import '../../../../sections/base_screen.dart';
// // import '../../../../sections/generic_notification_section.dart';
// //
// // class VolunteerNotificationScreen extends StatefulWidget {
// //   static String routeName = "/volunteer-notification";
// //   const VolunteerNotificationScreen({super.key});
// //
// //   @override
// //   State<VolunteerNotificationScreen> createState() => _VolunteerNotificationScreenState();
// // }
// //
// // class _VolunteerNotificationScreenState extends State<VolunteerNotificationScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final Map<String, String> _cache = {}; // Fast loading er jonno
// //
// //   Future<List<NotificationModel>> _processVolunteerNotifications(
// //       List<DocumentSnapshot> docs, String currentUid) async {
// //     List<NotificationModel> formattedList = [];
// //
// //     for (var doc in docs) {
// //       try {
// //         final data = doc.data() as Map<String, dynamic>?;
// //         if (data == null) continue;
// //
// //         String status = data['status'] ?? "";
// //         String dStatus = data['deliverystatus'] ?? "none";
// //         String vId = data['volunteerId'] ?? "";
// //         String postId = data['postId'] ?? "";
// //         String donorId = data['donorId'] ?? "";
// //         String receiverId = data['receiverId'] ?? "";
// //
// //         // ✅ 1. Exact Time Formatting
// //         String timeStr = "Just now";
// //         if (data['createdAt'] != null) {
// //           DateTime date = (data['createdAt'] as Timestamp).toDate();
// //           timeStr = timeago.format(date);
// //         }
// //
// //         // ✅ 2. Fetching Identity (Donor, Receiver, Food Name)
// //         String foodName = _cache["p_$postId"] ?? "";
// //         if (foodName.isEmpty && postId.isNotEmpty) {
// //           var pDoc = await _firestore.collection('posts').doc(postId).get();
// //           foodName = pDoc.exists ? (pDoc.data()?['foodName'] ?? "Food Item") : "Food";
// //           _cache["p_$postId"] = foodName;
// //         }
// //
// //         String donorName = _cache["d_$donorId"] ?? "";
// //         if (donorName.isEmpty && donorId.isNotEmpty) {
// //           var dDoc = await _firestore.collection('accounts').doc(donorId).get();
// //           donorName = dDoc.exists ? (dDoc.data()?['profile']?['contactPerson'] ?? "Donor") : "Donor";
// //           _cache["d_$donorId"] = donorName;
// //         }
// //
// //         String receiverName = _cache["r_$receiverId"] ?? "";
// //         if (receiverName.isEmpty && receiverId.isNotEmpty) {
// //           var rDoc = await _firestore.collection('accounts').doc(receiverId).get();
// //           receiverName = rDoc.exists ? (rDoc.data()?['profile']?['contactPerson'] ?? "Receiver") : "Receiver";
// //           _cache["r_$receiverId"] = receiverName;
// //         }
// //
// //         String displayTitle = "";
// //         String displayBody = "";
// //
// //         // ✅ 3. Role-Based Messaging (Clear who is who)
// //         if (status == 'approved' && vId.isEmpty) {
// //           displayTitle = "🎁 New Task from Donor: $donorName";
// //           displayBody = "Donor $donorName approved '$foodName'. You can pick it up for $receiverName.";
// //         } else if (vId == currentUid) {
// //           if (status == 'delivered' && dStatus == 'pending') {
// //             displayTitle = "🤝 Handover: Pickup confirmed by $donorName";
// //             displayBody = "You have the '$foodName' now. Please deliver it to $receiverName.";
// //           } else if (dStatus == 'ongoing') {
// //             displayTitle = "🚚 Ongoing: Delivering to $receiverName";
// //             displayBody = "You are carrying '$foodName' from $donorName to $receiverName.";
// //           } else if (dStatus == 'completed') {
// //             displayTitle = "✅ Successfully Delivered to $receiverName";
// //             displayBody = "You successfully delivered '$foodName' from $donorName.";
// //           } else { continue; }
// //         } else { continue; }
// //
// //         formattedList.add(
// //           NotificationModel(
// //             id: doc.id,
// //             message: displayTitle,
// //             requestBy: displayBody,
// //             time: timeStr,
// //             postId: postId,
// //             receiverId: receiverId,
// //             status: status,
// //           ),
// //         );
// //       } catch (e) { continue; }
// //     }
// //     return formattedList;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final auth = context.watch<GenericAuthProvider>();
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         title: const Text("Volunteer Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
// //         backgroundColor: Colors.white,
// //         elevation: 0.5,
// //         iconTheme: const IconThemeData(color: Colors.black),
// //       ),
// //       body: auth.user == null
// //           ? const Center(child: Text("Login Required"))
// //           : StreamBuilder<QuerySnapshot>(
// //         stream: _firestore.collection('requests').snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
// //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No notifications"));
// //
// //           // ✅ 4. STRICT TIME SORTING (Latest on top)
// //           // Firebase theke random ashleo amra ekhane local-vabe sort kore nichhi
// //           final sortedDocs = snapshot.data!.docs.toList();
// //           sortedDocs.sort((a, b) {
// //             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
// //             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
// //             return t2.compareTo(t1); // t2 age mane "Just now" shobar upore thakbe
// //           });
// //
// //           return FutureBuilder<List<NotificationModel>>(
// //             future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
// //             builder: (context, fSnapshot) {
// //               if (fSnapshot.connectionState == ConnectionState.waiting && !fSnapshot.hasData) {
// //                 return const Center(child: CircularProgressIndicator());
// //               }
// //               if (fSnapshot.data == null || fSnapshot.data!.isEmpty) return const Center(child: Text("No relevant tasks found"));
// //
// //               return SingleChildScrollView(
// //                 physics: const BouncingScrollPhysics(),
// //                 child: BaseScreen(
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(top: 10),
// //                     child: NotificationSection(
// //                       notifications: fSnapshot.data!,
// //                       onApprove: (id) {},
// //                       onReject: (id) {},
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
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
//         String requestId = doc.id;
//         String status = data['status'] ?? "";
//         String dStatus = data['deliverystatus'] ?? "none";
//         String vId = data['volunteerId'] ?? "";
//         String postId = data['postId'] ?? "";
//         String donorId = data['donorId'] ?? "";
//         String receiverId = data['receiverId'] ?? "";
//
//         // ✅ ১. সঠিক টাইম ইনডেক্সিং (Newest on top)
//         String timeStr = "Just now";
//         if (data['createdAt'] != null) {
//           DateTime date = (data['createdAt'] as Timestamp).toDate();
//           timeStr = timeago.format(date);
//         }
//
//         // ✅ ২. ক্যাশিং ডাটা (নামগুলো একবার আনলে আর আনবে না - ফাস্ট লোডিং)
//         String foodName = _cache["p_$postId"] ?? "";
//         if (foodName.isEmpty && postId.isNotEmpty) {
//           var pDoc = await _firestore.collection('posts').doc(postId).get();
//           foodName = pDoc.exists ? (pDoc.data()?['foodName'] ?? "Food") : "Food";
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
//         String receiverName = _cache["r_$receiverId"] ?? "";
//         if (receiverName.isEmpty && receiverId.isNotEmpty) {
//           var rDoc = await _firestore.collection('accounts').doc(receiverId).get();
//           receiverName = rDoc.exists ? (rDoc.data()?['profile']?['contactPerson'] ?? "Receiver") : "Receiver";
//           _cache["r_$receiverId"] = receiverName;
//         }
//
//         String title = "";
//         String body = "";
//
//         // ✅ ৩. প্রফেশনাল লজিক (ডোনার ভলান্টিয়ারকে সিলেক্ট করলে কী দেখাবে)
//
//         // কেস ১: ডোনার খাবার এপ্রুভ করেছে, কিন্তু কোনো ভলান্টিয়ার এখনো রিকোয়েস্ট করেনি
//         if (status == 'approved' && vId.isEmpty) {
//           title = "📢 New Delivery Opportunity!";
//           body = "Donor $donorName is looking for a volunteer for '$foodName'. Help $receiverName now!";
//         }
//         // কেস ২: ডোনার এই ভলান্টিয়ারকে ডেলিভারির জন্য সিলেক্ট করেছে
//         else if (vId == currentUid) {
//           if (status == 'delivered' && dStatus == 'pending') {
//             title = "🎊 Congrats! Donor Picked You";
//             body = "$donorName accepted your request for '$foodName'. Please go and pickup the food.";
//           } else if (dStatus == 'ongoing') {
//             title = "🚚 Ongoing Delivery";
//             body = "You are delivering '$foodName' from $donorName to $receiverName.";
//           } else if (dStatus == 'completed') {
//             title = "✅ Task Completed!";
//             body = "Successful delivery of '$foodName' from $donorName to $receiverName.";
//           } else {
//             continue;
//           }
//         } else {
//           continue;
//         }
//
//         formattedList.add(
//           NotificationModel(
//             id: requestId,
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
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text("Task Notifications", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//       ),
//       body: auth.user == null
//           ? const Center(child: Text("Login Required"))
//           : StreamBuilder<QuerySnapshot>(
//         stream: _firestore.collection('requests').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text("No notifications"));
//
//           // ✅ ৪. টাইম ইনডেক্সিং (Strict Sorting: Newest first)
//           final sortedDocs = snapshot.data!.docs.toList();
//           sortedDocs.sort((a, b) {
//             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
//             return t2.compareTo(t1); // t2 বড় মানে নতুন ডাটা আগে আসবে
//           });
//
//           return FutureBuilder<List<NotificationModel>>(
//             future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
//             builder: (context, fSnapshot) {
//               if (fSnapshot.connectionState == ConnectionState.waiting && !fSnapshot.hasData) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//               if (fSnapshot.data == null || fSnapshot.data!.isEmpty) {
//                 return const Center(child: Text("No active tasks found"));
//               }
//
//               return ListView.builder(
//                 itemCount: fSnapshot.data!.length,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 physics: const BouncingScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   final item = fSnapshot.data![index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     child: NotificationSection(
//                       notifications: [item],
//                       onApprove: (id) {},
//                       onReject: (id) {},
//                     ),
//                   );
//                 },
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

        // ✅ ১. সঠিক টাইম ইনডেক্সিং (Newest on top)
        String timeStr = "Just now";
        Timestamp? createdAt = data['createdAt'] as Timestamp?;
        if (createdAt != null) {
          timeStr = timeago.format(createdAt.toDate(), locale: 'en_short'); // '1m', '2h' format
        }

        // ✅ ২. ডেটা ফেচিং (খাবার, ডোনার ও রিসিভারের নাম)
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

        // ✅ ৩. আপনার কাঙ্ক্ষিত লজিক: ডোনার ভলান্টিয়ারকে এক্সেপ্ট করলে
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

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // হালকা গ্রে ব্যাকগ্রাউন্ড
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: auth.user == null
          ? const Center(child: Text("Please Login"))
          : StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('requests').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          // ✅ ৪. নতুন নোটিফিকেশন সবার উপরে রাখতে শর্টিং
          final sortedDocs = snapshot.data!.docs.toList();
          sortedDocs.sort((a, b) {
            Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            return t2.compareTo(t1);
          });

          return FutureBuilder<List<NotificationModel>>(
            future: _processVolunteerNotifications(sortedDocs, auth.user!.uid),
            builder: (context, fSnapshot) {
              if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
                return const Center(child: Text("No tasks found"));
              }

              // ✅ ৫. গ্যাপ কমানোর জন্য সরাসরি NotificationSection এ পুরো লিস্ট পাঠানো হয়েছে
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5), // ওপর-নিচে কম গ্যাপ
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