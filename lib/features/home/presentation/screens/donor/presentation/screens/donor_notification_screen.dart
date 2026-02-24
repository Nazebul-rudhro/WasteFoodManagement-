// // // // // //
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:provider/provider.dart';
// // // // // // import 'package:timeago/timeago.dart' as timeago;
// // // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // // //
// // // // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // // // import '../../../../sections/base_screen.dart';
// // // // // // import '../../../../sections/generic_notification_section.dart';
// // // // // // import '../provider/donor_provider.dart';
// // // // // //
// // // // // // class DonorNotificationScreen extends StatefulWidget {
// // // // // //   static String routeName = "donor-notification";
// // // // // //   const DonorNotificationScreen({super.key});
// // // // // //
// // // // // //   @override
// // // // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // // // }
// // // // // //
// // // // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // // //
// // // // // //   Future<List<NotificationModel>> _processNotificationData(List<DocumentSnapshot> docs) async {
// // // // // //     List<NotificationModel> formattedList = [];
// // // // // //
// // // // // //     for (var doc in docs) {
// // // // // //       final data = doc.data() as Map<String, dynamic>;
// // // // // //       String requestId = doc.id;
// // // // // //       String status = data['status'] ?? "pending";
// // // // // //       String dStatus = data['deliverystatus'] ?? "none";
// // // // // //       String volunteerName = data['volunteerName'] ?? "A volunteer";
// // // // // //
// // // // // //       String timeStr = "Just now";
// // // // // //       if (data['createdAt'] != null) {
// // // // // //         DateTime date = (data['createdAt'] as Timestamp).toDate();
// // // // // //         timeStr = timeago.format(date, locale: 'en_short');
// // // // // //       }
// // // // // //
// // // // // //       var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
// // // // // //       String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";
// // // // // //
// // // // // //       var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
// // // // // //       String receiverName = userDoc.exists
// // // // // //           ? (userDoc.data()?['profile']?['contactPerson'] ?? "Receiver")
// // // // // //           : "someone";
// // // // // //
// // // // // //       var volunteerBids = await _firestore.collection('requests').doc(requestId).collection('pickup_requests').get();
// // // // // //
// // // // // //       String displayTitle = "";
// // // // // //       String displayBody = "";
// // // // // //
// // // // // //       if (status == 'pending') {
// // // // // //         displayTitle = "Food Request";
// // // // // //         displayBody = "$receiverName requested for your '$foodName'";
// // // // // //       }
// // // // // //       else if (status == 'approved' && volunteerBids.docs.isNotEmpty) {
// // // // // //         displayTitle = "Volunteer Interested";
// // // // // //         displayBody = "${volunteerBids.docs.length} volunteer(s) want to pick up '$foodName' for $receiverName";
// // // // // //       }
// // // // // //       else if (status == 'delivered' && dStatus == 'pending') {
// // // // // //         displayTitle = "Assigned to Volunteer";
// // // // // //         displayBody = "Waiting for $volunteerName to pick up '$foodName'";
// // // // // //       }
// // // // // //       else if (dStatus == 'ongoing') {
// // // // // //         displayTitle = "On the way";
// // // // // //         displayBody = "$volunteerName has picked up '$foodName' and is going to $receiverName";
// // // // // //       }
// // // // // //       else if (dStatus == 'completed') {
// // // // // //         displayTitle = "Delivery Completed";
// // // // // //         displayBody = "$volunteerName successfully delivered '$foodName' to $receiverName";
// // // // // //       }
// // // // // //       else if (status == 'rejected') {
// // // // // //         displayTitle = "Request Rejected";
// // // // // //         displayBody = "You rejected $receiverName's request for '$foodName'";
// // // // // //       }
// // // // // //       else {
// // // // // //         displayTitle = "Update: $foodName";
// // // // // //         displayBody = "Status: ${status.toUpperCase()}";
// // // // // //       }
// // // // // //
// // // // // //       formattedList.add(
// // // // // //         NotificationModel(
// // // // // //           id: requestId,
// // // // // //           message: displayTitle,
// // // // // //           requestBy: displayBody,
// // // // // //           time: timeStr,
// // // // // //           receiverId: data['receiverId'] ?? "",
// // // // // //           postId: data['postId'] ?? "",
// // // // // //           status: status,
// // // // // //         ),
// // // // // //       );
// // // // // //     }
// // // // // //     return formattedList;
// // // // // //   }
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final auth = context.watch<GenericAuthProvider>();
// // // // // //     final donorPro = context.read<DonorProvider>();
// // // // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // // // //
// // // // // //     if (auth.user == null) return const Scaffold(body: Center(child: Text("Please Login")));
// // // // // //
// // // // // //     return Scaffold(
// // // // // //       // 🟢 ব্যাকগ্রাউন্ড কালার ডার্ক মোড অনুযায়ী অ্যাডাপ্টিভ
// // // // // //       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // // // // //       appBar: AppBar(
// // // // // //         title: Text(
// // // // // //             "Notifications",
// // // // // //             style: TextStyle(
// // // // // //                 color: isDark ? Colors.white : Colors.black87,
// // // // // //                 fontWeight: FontWeight.bold,
// // // // // //                 fontSize: 18
// // // // // //             )
// // // // // //         ),
// // // // // //         elevation: isDark ? 0 : 0.5,
// // // // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // // // //         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
// // // // // //       ),
// // // // // //       body: StreamBuilder<QuerySnapshot>(
// // // // // //         stream: _firestore
// // // // // //             .collection('requests')
// // // // // //             .where('donorId', isEqualTo: auth.user!.uid)
// // // // // //             .snapshots(),
// // // // // //         builder: (context, snapshot) {
// // // // // //           if (snapshot.hasError) return const Center(child: Text("Connection Error"));
// // // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // // //           }
// // // // // //
// // // // // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // // //             return Center(
// // // // // //                 child: Text(
// // // // // //                     "No notifications yet",
// // // // // //                     style: TextStyle(color: isDark ? Colors.white30 : Colors.grey)
// // // // // //                 )
// // // // // //             );
// // // // // //           }
// // // // // //
// // // // // //           final sortedDocs = snapshot.data!.docs.toList();
// // // // // //           sortedDocs.sort((a, b) {
// // // // // //             Timestamp t1 = a['createdAt'] ?? Timestamp.now();
// // // // // //             Timestamp t2 = b['createdAt'] ?? Timestamp.now();
// // // // // //             return t2.compareTo(t1);
// // // // // //           });
// // // // // //
// // // // // //           return FutureBuilder<List<NotificationModel>>(
// // // // // //             future: _processNotificationData(sortedDocs),
// // // // // //             builder: (context, fSnapshot) {
// // // // // //               if (fSnapshot.connectionState == ConnectionState.waiting) {
// // // // // //                 return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // // //               }
// // // // // //
// // // // // //               return SingleChildScrollView(
// // // // // //                 physics: const BouncingScrollPhysics(),
// // // // // //                 child: BaseScreen(
// // // // // //                   child: Padding(
// // // // // //                     padding: const EdgeInsets.only(top: 10),
// // // // // //                     child: NotificationSection(
// // // // // //                       notifications: fSnapshot.data!,
// // // // // //                       onApprove: (id) async {
// // // // // //                         final item = fSnapshot.data!.firstWhere((x) => x.id == id);
// // // // // //                         if (item.status == 'approved') {
// // // // // //                           ScaffoldMessenger.of(context).showSnackBar(
// // // // // //                               SnackBar(
// // // // // //                                   backgroundColor: isDark ? Colors.grey[900] : Colors.black87,
// // // // // //                                   content: const Text("Please assign a volunteer from the Delivery section.")
// // // // // //                               )
// // // // // //                           );
// // // // // //                         } else {
// // // // // //                           await donorPro.handleRequest(id, item.postId, 'approved');
// // // // // //                         }
// // // // // //                       },
// // // // // //                       onReject: (id) async {
// // // // // //                         final item = fSnapshot.data!.firstWhere((x) => x.id == id);
// // // // // //                         await donorPro.handleRequest(id, item.postId, 'rejected');
// // // // // //                       },
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               );
// // // // // //             },
// // // // // //           );
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // //
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // // import 'package:provider/provider.dart';
// // // // // // import 'package:timeago/timeago.dart' as timeago;
// // // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // // //
// // // // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // // // import '../../../../sections/base_screen.dart';
// // // // // // import '../../../../sections/generic_notification_section.dart';
// // // // // // import '../provider/donor_provider.dart';
// // // // // //
// // // // // // class DonorNotificationScreen extends StatefulWidget {
// // // // // //   static String routeName = "donor-notification";
// // // // // //   const DonorNotificationScreen({super.key});
// // // // // //
// // // // // //   @override
// // // // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // // // }
// // // // // //
// // // // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final auth = context.watch<GenericAuthProvider>();
// // // // // //     // donorPro ব্যবহার না করলে এটি সরিয়ে ফেলতে পারেন
// // // // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // // // //
// // // // // //     if (auth.user == null) {
// // // // // //       return const Scaffold(body: Center(child: Text("Please Login")));
// // // // // //     }
// // // // // //
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // // // // //       appBar: AppBar(
// // // // // //         title: Text(
// // // // // //           "Notifications",
// // // // // //           style: TextStyle(
// // // // // //             color: isDark ? Colors.white : Colors.black87,
// // // // // //             fontWeight: FontWeight.bold,
// // // // // //             fontSize: 18,
// // // // // //           ),
// // // // // //         ),
// // // // // //         elevation: isDark ? 0 : 0.5,
// // // // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // // // //         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
// // // // // //       ),
// // // // // //       body: StreamBuilder<QuerySnapshot>(
// // // // // //         stream: _firestore
// // // // // //             .collection('notifications')
// // // // // //             .where('targetId', isEqualTo: auth.user!.uid)
// // // // // //             .orderBy('createdAt', descending: true)
// // // // // //             .snapshots(),
// // // // // //         builder: (context, snapshot) {
// // // // // //           if (snapshot.hasError) {
// // // // // //             debugPrint("Firestore Error: ${snapshot.error}");
// // // // // //             // 💡 টিপস: কনসোলে একটি লিঙ্ক পাবেন, সেখানে ক্লিক করে ইনডেক্স তৈরি করে নিন।
// // // // // //             return Center(child: Text("Error: ${snapshot.error.toString().contains('index') ? 'Need to create Firestore Index' : 'Something went wrong'}"));
// // // // // //           }
// // // // // //
// // // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // // //           }
// // // // // //
// // // // // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // // //             return Center(
// // // // // //               child: Text(
// // // // // //                 "No notifications yet",
// // // // // //                 style: TextStyle(color: isDark ? Colors.white30 : Colors.grey),
// // // // // //               ),
// // // // // //             );
// // // // // //           }
// // // // // //
// // // // // //           // ডাটা ফরম্যাটিং
// // // // // //           List<NotificationModel> notifications = snapshot.data!.docs.map((doc) {
// // // // // //             final data = doc.data() as Map<String, dynamic>;
// // // // // //
// // // // // //             String timeStr = "Just now";
// // // // // //             if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // // // // //               DateTime date = (data['createdAt'] as Timestamp).toDate();
// // // // // //               timeStr = timeago.format(date, locale: 'en_short');
// // // // // //             }
// // // // // //
// // // // // //             return NotificationModel(
// // // // // //               id: doc.id,
// // // // // //               // টাইটেল হিসেবে টাইপ দেখাচ্ছি
// // // // // //               message: data['type']?.toString().toUpperCase() ?? "NOTIFICATION",
// // // // // //               // মেইন মেসেজ বডি
// // // // // //               requestBy: data['message'] ?? "No message content",
// // // // // //               time: timeStr,
// // // // // //               receiverId: data['senderId'] ?? "",
// // // // // //               postId: data['postId'] ?? "",
// // // // // //               status: data['type'] ?? "info",
// // // // // //             );
// // // // // //           }).toList();
// // // // // //
// // // // // //           return SingleChildScrollView(
// // // // // //             physics: const BouncingScrollPhysics(),
// // // // // //             child: BaseScreen(
// // // // // //               child: Padding(
// // // // // //                 padding: const EdgeInsets.only(top: 10),
// // // // // //                 child: NotificationSection(
// // // // // //                   notifications: notifications,
// // // // // //                   onApprove: (id) {
// // // // // //                     // এখানে নোটিফিকেশন ক্লিক বা অ্যাপ্রুভ লজিক দিন
// // // // // //                   },
// // // // // //                   onReject: (id) {
// // // // // //                     // রিজেক্ট লজিক
// // // // // //                   },
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           );
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // // //
// // // // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:timeago/timeago.dart' as timeago;
// // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // //
// // // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // // import '../../../../sections/base_screen.dart';
// // // // // import '../../../../sections/generic_notification_section.dart';
// // // // //
// // // // // class DonorNotificationScreen extends StatefulWidget {
// // // // //   static String routeName = "donor-notification";
// // // // //   const DonorNotificationScreen({super.key});
// // // // //
// // // // //   @override
// // // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // // }
// // // // //
// // // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final auth = context.watch<GenericAuthProvider>();
// // // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // // //
// // // // //     if (auth.user == null) {
// // // // //       return const Scaffold(body: Center(child: Text("Please Login")));
// // // // //     }
// // // // //
// // // // //     return Scaffold(
// // // // //       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // // // //       appBar: AppBar(
// // // // //         title: Text(
// // // // //           "Notifications",
// // // // //           style: TextStyle(
// // // // //             color: isDark ? Colors.white : Colors.black87,
// // // // //             fontWeight: FontWeight.bold,
// // // // //             fontSize: 18,
// // // // //           ),
// // // // //         ),
// // // // //         centerTitle: true,
// // // // //         elevation: 0,
// // // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // // //         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
// // // // //       ),
// // // // //       body: StreamBuilder<QuerySnapshot>(
// // // // //         // 💡 টিপস: orderBy ব্যবহার করলে Firestore Index প্রয়োজন হয়।
// // // // //         // যদি ডাটা না আসে, তবে আপাতত orderBy সরিয়ে চেক করুন।
// // // // //         stream: _firestore
// // // // //             .collection('notifications')
// // // // //             .where('targetId', isEqualTo: auth.user!.uid)
// // // // //             .snapshots(),
// // // // //         builder: (context, snapshot) {
// // // // //           if (snapshot.hasError) {
// // // // //             return Center(child: Text("Error: ${snapshot.error}"));
// // // // //           }
// // // // //
// // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // //           }
// // // // //
// // // // //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // // //             return Center(
// // // // //               child: Column(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 children: [
// // // // //                   Icon(Icons.notifications_off_outlined, size: 60, color: isDark ? Colors.white10 : Colors.grey[300]),
// // // // //                   const SizedBox(height: 10),
// // // // //                   Text(
// // // // //                     "No notifications yet",
// // // // //                     style: TextStyle(color: isDark ? Colors.white30 : Colors.grey),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             );
// // // // //           }
// // // // //
// // // // //           // ইনডেক্স ছাড়া ম্যানুয়ালি লেটেস্ট নোটিফিকেশন উপরে আনার জন্য সর্টিং
// // // // //           final docs = snapshot.data!.docs;
// // // // //
// // // // //           List<NotificationModel> notifications = docs.map((doc) {
// // // // //             final data = doc.data() as Map<String, dynamic>;
// // // // //
// // // // //             String timeStr = "Just now";
// // // // //             if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // // // //               DateTime date = (data['createdAt'] as Timestamp).toDate();
// // // // //               timeStr = timeago.format(date);
// // // // //             }
// // // // //
// // // // //             return NotificationModel(
// // // // //               id: doc.id,
// // // // //               // আপনার Model অনুযায়ী সঠিক ফিল্ড ম্যাপ করুন
// // // // //               message: data['message'] ?? "New update received",
// // // // //               requestBy: data['title'] ?? data['type']?.toString().toUpperCase() ?? "NOTIFICATION",
// // // // //               time: timeStr,
// // // // //               receiverId: data['senderId'] ?? "",
// // // // //               postId: data['postId'] ?? "",
// // // // //               status: data['status'] ?? "unread",
// // // // //             );
// // // // //           }).toList();
// // // // //
// // // // //           return SingleChildScrollView(
// // // // //             physics: const BouncingScrollPhysics(),
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.symmetric(vertical: 10),
// // // // //                   child: NotificationSection(
// // // // //                     notifications: notifications,
// // // // //                     onApprove: (id) {
// // // // //                       // Logic for notification click
// // // // //                     },
// // // // //                     onReject: (id) {
// // // // //                       // Delete or dismiss logic
// // // // //                     },
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           );
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // //
// // // // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // // import 'package:provider/provider.dart';
// // // // // import 'package:timeago/timeago.dart' as timeago;
// // // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // // //
// // // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // // import '../../../../sections/base_screen.dart';
// // // // // import '../../../../sections/generic_notification_section.dart';
// // // // //
// // // // // class DonorNotificationScreen extends StatefulWidget {
// // // // //   static String routeName = "donor-notification";
// // // // //   const DonorNotificationScreen({super.key});
// // // // //
// // // // //   @override
// // // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // // }
// // // // //
// // // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final auth = context.watch<GenericAuthProvider>();
// // // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // // //
// // // // //     if (auth.user == null) {
// // // // //       return const Scaffold(body: Center(child: Text("Please Login")));
// // // // //     }
// // // // //
// // // // //     return Scaffold(
// // // // //       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // // // //       appBar: AppBar(
// // // // //         title: Text(
// // // // //           "Notifications",
// // // // //           style: TextStyle(
// // // // //             color: isDark ? Colors.white : Colors.black87,
// // // // //             fontWeight: FontWeight.bold,
// // // // //             fontSize: 18,
// // // // //           ),
// // // // //         ),
// // // // //         centerTitle: true,
// // // // //         elevation: 0,
// // // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // // //         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
// // // // //       ),
// // // // //       body: StreamBuilder<QuerySnapshot>(
// // // // //         // ১. orderBy('createdAt') ব্যবহার করলে নতুন নোটিফিকেশন উপরে আসবে।
// // // // //         // 💡 গুরুত্বপূর্ণ: এটি প্রথমবার রান করলে কনসোলে একটি লিঙ্ক আসবে, সেখানে ক্লিক করে Index তৈরি করে নিতে হবে।
// // // // //         stream: _firestore
// // // // //             .collection('notifications')
// // // // //             .where('targetId', isEqualTo: auth.user!.uid)
// // // // //             .orderBy('createdAt', descending: true)
// // // // //             .snapshots(),
// // // // //         builder: (context, snapshot) {
// // // // //           if (snapshot.hasError) {
// // // // //             // যদি ইনডেক্স এরর হয় তবে এখানে মেসেজ দেখাবে
// // // // //             debugPrint("Firestore Error: ${snapshot.error}");
// // // // //             return Center(child: Text("Error: ${snapshot.error.toString().contains('index') ? 'Please wait, creating index...' : snapshot.error}"));
// // // // //           }
// // // // //
// // // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // // //           }
// // // // //
// // // // //           final docs = snapshot.data?.docs ?? [];
// // // // //
// // // // //           if (docs.isEmpty) {
// // // // //             return Center(
// // // // //               child: Column(
// // // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // // //                 children: [
// // // // //                   Icon(Icons.notifications_off_outlined, size: 60, color: isDark ? Colors.white10 : Colors.grey[300]),
// // // // //                   const SizedBox(height: 10),
// // // // //                   Text(
// // // // //                     "No notifications yet",
// // // // //                     style: TextStyle(color: isDark ? Colors.white30 : Colors.grey),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             );
// // // // //           }
// // // // //
// // // // //           // ২. ডেটা ম্যাপিং
// // // // //           List<NotificationModel> notifications = docs.map((doc) {
// // // // //             final data = doc.data() as Map<String, dynamic>;
// // // // //
// // // // //             String timeStr = "Just now";
// // // // //             if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // // // //               DateTime date = (data['createdAt'] as Timestamp).toDate();
// // // // //               timeStr = timeago.format(date);
// // // // //             }
// // // // //
// // // // //             return NotificationModel(
// // // // //               id: doc.id,
// // // // //               message: data['message'] ?? "You have a new notification",
// // // // //               requestBy: data['title'] ?? data['type']?.toString().toUpperCase() ?? "NEW REQUEST",
// // // // //               time: timeStr,
// // // // //               receiverId: data['senderId'] ?? "",
// // // // //               postId: data['postId'] ?? "",
// // // // //               status: data['status'] ?? "unread",
// // // // //             );
// // // // //           }).toList();
// // // // //
// // // // //           return SingleChildScrollView(
// // // // //             physics: const BouncingScrollPhysics(),
// // // // //             child: Column(
// // // // //               children: [
// // // // //                 Padding(
// // // // //                   padding: const EdgeInsets.symmetric(vertical: 10),
// // // // //                   child: NotificationSection(
// // // // //                     notifications: notifications,
// // // // //                     onApprove: (id) async {
// // // // //                       // নোটিফিকেশন স্ট্যাটাস আপডেট করার লজিক এখানে দিতে পারেন
// // // // //                     },
// // // // //                     onReject: (id) async {
// // // // //                       // নোটিফিকেশন ডিলিট করার লজিক
// // // // //                       await _firestore.collection('notifications').doc(id).delete();
// // // // //                     },
// // // // //                   ),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
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
// // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // //
// // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // // import '../../../../sections/generic_notification_section.dart';
// // // //
// // // // class DonorNotificationScreen extends StatefulWidget {
// // // //   static String routeName = "donor-notification";
// // // //   const DonorNotificationScreen({super.key});
// // // //
// // // //   @override
// // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // }
// // // //
// // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final auth = context.watch<GenericAuthProvider>();
// // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // //
// // // //     // ইউজার লগইন না থাকলে মেসেজ দেখাবে
// // // //     if (auth.user == null) {
// // // //       return const Scaffold(body: Center(child: Text("Please Login to see notifications")));
// // // //     }
// // // //
// // // //     return Scaffold(
// // // //       backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // // //       appBar: AppBar(
// // // //         title: Text(
// // // //           "Notifications",
// // // //           style: TextStyle(
// // // //             color: isDark ? Colors.white : Colors.black87,
// // // //             fontWeight: FontWeight.bold,
// // // //             fontSize: 18,
// // // //           ),
// // // //         ),
// // // //         centerTitle: true,
// // // //         elevation: 0,
// // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // //         iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black87),
// // // //       ),
// // // //       body: StreamBuilder<QuerySnapshot>(
// // // //         // এখানে query একদম আপনার ডাটাবেজ অনুযায়ী সেট করা
// // // //         stream: _firestore
// // // //             .collection('notifications')
// // // //             .where('targetId', isEqualTo: auth.user!.uid)
// // // //             .orderBy('createdAt', descending: true)
// // // //             .snapshots(),
// // // //         builder: (context, snapshot) {
// // // //           // ১. এরর চেক (ইনডেক্স মিসিং হলে এখানে লিঙ্ক আসবে)
// // // //           if (snapshot.hasError) {
// // // //             debugPrint("Firestore Error: ${snapshot.error}");
// // // //             return Center(
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.all(20.0),
// // // //                 child: Text(
// // // //                   "Error: ${snapshot.error}. \n\nCheck Debug Console for Index Link.",
// // // //                   textAlign: TextAlign.center,
// // // //                   style: const TextStyle(color: Colors.red),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           }
// // // //
// // // //           // ২. লোডিং স্টেট
// // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // //           }
// // // //
// // // //           final docs = snapshot.data?.docs ?? [];
// // // //
// // // //           // ৩. ডাটা না থাকলে
// // // //           if (docs.isEmpty) {
// // // //             return Center(
// // // //               child: Column(
// // // //                 mainAxisAlignment: MainAxisAlignment.center,
// // // //                 children: [
// // // //                   Icon(Icons.notifications_off_outlined,
// // // //                       size: 60,
// // // //                       color: isDark ? Colors.white10 : Colors.grey[300]),
// // // //                   const SizedBox(height: 10),
// // // //                   Text(
// // // //                     "No notifications yet",
// // // //                     style: TextStyle(color: isDark ? Colors.white30 : Colors.grey),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             );
// // // //           }
// // // //
// // // //           // ৪. ডাটা ম্যাপিং
// // // //           List<NotificationModel> notifications = docs.map((doc) {
// // // //             final data = doc.data() as Map<String, dynamic>;
// // // //
// // // //             String timeStr = "Just now";
// // // //             if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // // //               timeStr = timeago.format((data['createdAt'] as Timestamp).toDate());
// // // //             }
// // // //
// // // //             return NotificationModel(
// // // //               id: doc.id,
// // // //               message: data['message'] ?? "",
// // // //               requestBy: data['type']?.toString().toUpperCase() ?? "NOTIFICATION",
// // // //               time: timeStr,
// // // //               receiverId: data['targetId'] ?? "",
// // // //               postId: data['postId'] ?? "",
// // // //               status: data['status'] ?? "unread",
// // // //             );
// // // //           }).toList();
// // // //
// // // //           return RefreshIndicator(
// // // //             onRefresh: () async => setState(() {}),
// // // //             child: SingleChildScrollView(
// // // //               physics: const AlwaysScrollableScrollPhysics(),
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.symmetric(vertical: 10),
// // // //                 child: NotificationSection(
// // // //                   notifications: notifications,
// // // //                   onApprove: (id) async {
// // // //                     // Approve Logic
// // // //                   },
// // // //                   onReject: (id) async {
// // // //                     await _firestore.collection('notifications').doc(id).delete();
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import 'package:provider/provider.dart';
// // // // import 'package:timeago/timeago.dart' as timeago;
// // // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // // //
// // // // import '../../../../../../auth/data/model/notification_model.dart';
// // // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // // //
// // // // class DonorNotificationScreen extends StatefulWidget {
// // // //   static String routeName = "donor-notification";
// // // //   const DonorNotificationScreen({super.key});
// // // //
// // // //   @override
// // // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // // }
// // // //
// // // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final auth = context.watch<GenericAuthProvider>();
// // // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // // //
// // // //     if (auth.user == null) {
// // // //       return const Scaffold(body: Center(child: Text("Please Login First")));
// // // //     }
// // // //
// // // //     return Scaffold(
// // // //       backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
// // // //       appBar: AppBar(
// // // //         title: const Text("Notifications",
// // // //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// // // //         centerTitle: true,
// // // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // // //         foregroundColor: isDark ? Colors.white : Colors.black,
// // // //         elevation: 0.5,
// // // //       ),
// // // //       body: StreamBuilder<QuerySnapshot>(
// // // //         // ১. এখানে orderBy('createdAt', descending: true) ইনডেক্সিং এর জন্য মাস্ট।
// // // //         stream: _firestore
// // // //             .collection('notifications')
// // // //             .where('targetId', isEqualTo: auth.user!.uid)
// // // //             .orderBy('createdAt', descending: true)
// // // //             .snapshots(),
// // // //         builder: (context, snapshot) {
// // // //           // এরর হ্যান্ডলিং (ইনডেক্স না থাকলে এখানে এরর লিঙ্ক আসবে)
// // // //           if (snapshot.hasError) {
// // // //             debugPrint("Firestore Error: ${snapshot.error}");
// // // //             return Center(
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.all(20.0),
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     const Icon(Icons.error_outline, color: Colors.red, size: 50),
// // // //                     const SizedBox(height: 10),
// // // //                     Text("Indexing Required: ${snapshot.error.toString().contains('index') ? 'Please click the link in your console to create an index.' : snapshot.error}",
// // // //                         textAlign: TextAlign.center,
// // // //                         style: const TextStyle(fontSize: 12)),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           }
// // // //
// // // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // // //           }
// // // //
// // // //           final docs = snapshot.data?.docs ?? [];
// // // //
// // // //           if (docs.isEmpty) {
// // // //             return _buildEmptyState(isDark);
// // // //           }
// // // //
// // // //           return ListView.builder(
// // // //             physics: const BouncingScrollPhysics(),
// // // //             padding: const EdgeInsets.all(12),
// // // //             itemCount: docs.length,
// // // //             itemBuilder: (context, index) {
// // // //               final data = docs[index].data() as Map<String, dynamic>;
// // // //
// // // //               // টাইম ফরম্যাটিং
// // // //               String timeStr = "Just now";
// // // //               if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // // //                 timeStr = timeago.format((data['createdAt'] as Timestamp).toDate(), locale: 'en_short');
// // // //               }
// // // //
// // // //               final notification = NotificationModel(
// // // //                 id: docs[index].id,
// // // //                 message: data['title'] ?? "New Update", // টাইটেল দেখালে সুন্দর লাগে
// // // //                 requestBy: data['message'] ?? "",
// // // //                 time: timeStr,
// // // //                 receiverId: data['targetId'] ?? "",
// // // //                 postId: data['postId'] ?? "",
// // // //                 status: data['status'] ?? "unread",
// // // //               );
// // // //
// // // //               return _buildNotificationTile(notification, isDark);
// // // //             },
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   // আধুনিক নোটিফিকেশন টাইল ডিজাইন
// // // //   Widget _buildNotificationTile(NotificationModel item, bool isDark) {
// // // //     return Container(
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       decoration: BoxDecoration(
// // // //         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// // // //         borderRadius: BorderRadius.circular(15),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
// // // //             blurRadius: 10,
// // // //             offset: const Offset(0, 4),
// // // //           )
// // // //         ],
// // // //       ),
// // // //       child: ListTile(
// // // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // // //         leading: CircleAvatar(
// // // //           backgroundColor: AppColor.green.withOpacity(0.1),
// // // //           child: const Icon(Icons.notifications_active, color: AppColor.green, size: 20),
// // // //         ),
// // // //         title: Row(
// // // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //           children: [
// // // //             Expanded(
// // // //               child: Text(item.message,
// // // //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // // //                   maxLines: 1, overflow: TextOverflow.ellipsis),
// // // //             ),
// // // //             Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
// // // //           ],
// // // //         ),
// // // //         subtitle: Padding(
// // // //           padding: const EdgeInsets.only(top: 5),
// // // //           child: Text(item.requestBy,
// // // //               style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12, height: 1.3)),
// // // //         ),
// // // //         onTap: () {
// // // //           // নোটিফিকেশনে ক্লিক করলে একশন (যেমন: রিড হিসেবে মার্ক করা)
// // // //         },
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildEmptyState(bool isDark) {
// // // //     return Center(
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: [
// // // //           Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey.withOpacity(0.3)),
// // // //           const SizedBox(height: 15),
// // // //           Text("No notifications found", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:timeago/timeago.dart' as timeago;
// // // import 'package:waste_food_management/core/constants/app_colors.dart';
// // //
// // // import '../../../../../../auth/data/model/notification_model.dart';
// // // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // //
// // // class DonorNotificationScreen extends StatefulWidget {
// // //   static String routeName = "donor-notification";
// // //   const DonorNotificationScreen({super.key});
// // //
// // //   @override
// // //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // // }
// // //
// // // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final auth = context.watch<GenericAuthProvider>();
// // //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// // //
// // //     // ইউজার লগইন না থাকলে মেসেজ দেখাবে
// // //     if (auth.user == null) {
// // //       return Scaffold(
// // //         backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
// // //         body: const Center(child: Text("Please Login First")),
// // //       );
// // //     }
// // //
// // //     return Scaffold(
// // //       backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
// // //       appBar: AppBar(
// // //         title: const Text("Notifications",
// // //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// // //         centerTitle: true,
// // //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
// // //         foregroundColor: isDark ? Colors.white : Colors.black,
// // //         elevation: 0.5,
// // //       ),
// // //       body: StreamBuilder<QuerySnapshot>(
// // //         // ✅ targetId এবং createdAt দিয়ে কুয়েরি
// // //         stream: _firestore
// // //             .collection('notifications')
// // //             .where('targetId', isEqualTo: auth.user!.uid)
// // //             .orderBy('createdAt', descending: true)
// // //             .snapshots(),
// // //         builder: (context, snapshot) {
// // //
// // //           // ১. এরর চেক (ইনডেক্সিং এরর এখানে ধরা পড়বে)
// // //           if (snapshot.hasError) {
// // //             debugPrint("Firestore Error: ${snapshot.error}");
// // //             return Center(
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(20.0),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     const Icon(Icons.error_outline, color: Colors.red, size: 40),
// // //                     const SizedBox(height: 10),
// // //                     const Text("Something went wrong!", style: TextStyle(fontWeight: FontWeight.bold)),
// // //                     const SizedBox(height: 5),
// // //                     Text(
// // //                       "If you see this, check your Debug Console for a Firebase Index link and click it.",
// // //                       textAlign: TextAlign.center,
// // //                       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           }
// // //
// // //           // ২. লোডিং স্টেট
// // //           if (snapshot.connectionState == ConnectionState.waiting) {
// // //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// // //           }
// // //
// // //           final docs = snapshot.data?.docs ?? [];
// // //
// // //           // ৩. ডাটা না থাকলে এম্পটি স্টেট
// // //           if (docs.isEmpty) {
// // //             return _buildEmptyState(isDark);
// // //           }
// // //
// // //           // ৪. নোটিফিকেশন লিস্ট
// // //           return ListView.builder(
// // //             physics: const BouncingScrollPhysics(),
// // //             padding: const EdgeInsets.all(12),
// // //             itemCount: docs.length,
// // //             itemBuilder: (context, index) {
// // //               final data = docs[index].data() as Map<String, dynamic>;
// // //
// // //               // টাইম ফরম্যাটিং লজিক
// // //               String timeStr = "Just now";
// // //               if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// // //                 timeStr = timeago.format((data['createdAt'] as Timestamp).toDate(), locale: 'en_short');
// // //               }
// // //
// // //               // মডেল ম্যাপিং
// // //               final notification = NotificationModel(
// // //                 id: docs[index].id,
// // //                 message: data['title'] ?? "New Notification",
// // //                 requestBy: data['message'] ?? "You have a new update",
// // //                 time: timeStr,
// // //                 receiverId: data['targetId'] ?? "",
// // //                 postId: data['postId'] ?? "",
// // //                 status: data['status'] ?? "unread",
// // //               );
// // //
// // //               return _buildNotificationTile(notification, isDark);
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   // নোটিফিকেশন কার্ড ডিজাইন
// // //   Widget _buildNotificationTile(NotificationModel item, bool isDark) {
// // //     return Container(
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       decoration: BoxDecoration(
// // //         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// // //         borderRadius: BorderRadius.circular(15),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
// // //             blurRadius: 10,
// // //             offset: const Offset(0, 4),
// // //           )
// // //         ],
// // //       ),
// // //       child: ListTile(
// // //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //         leading: CircleAvatar(
// // //           backgroundColor: AppColor.green.withOpacity(0.1),
// // //           child: const Icon(Icons.notifications_active, color: AppColor.green, size: 20),
// // //         ),
// // //         title: Row(
// // //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //           children: [
// // //             Expanded(
// // //               child: Text(item.message,
// // //                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // //                   maxLines: 1, overflow: TextOverflow.ellipsis),
// // //             ),
// // //             Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
// // //           ],
// // //         ),
// // //         subtitle: Padding(
// // //           padding: const EdgeInsets.only(top: 5),
// // //           child: Text(item.requestBy,
// // //               style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12, height: 1.3)),
// // //         ),
// // //         onTap: () {
// // //           // নোটিফিকেশন ডিটেইলস বা মার্ক-অ্যাজ-রিড লজিক এখানে হবে
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   // এম্পটি স্টেট ডিজাইন
// // //   Widget _buildEmptyState(bool isDark) {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.notifications_none_rounded, size: 80, color: Colors.grey.withOpacity(0.3)),
// // //           const SizedBox(height: 15),
// // //           Text("No notifications found", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
// // //           const SizedBox(height: 5),
// // //           Text("We'll notify you when something arrives!", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:provider/provider.dart';
// // import 'package:timeago/timeago.dart' as timeago;
// // import 'package:waste_food_management/core/constants/app_colors.dart';
// //
// // import '../../../../../../auth/data/model/notification_model.dart';
// // import '../../../../../../auth/provider/generic_auth_provider.dart';
// //
// // class DonorNotificationScreen extends StatefulWidget {
// //   static String routeName = "donor-notification";
// //   const DonorNotificationScreen({super.key});
// //
// //   @override
// //   State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
// // }
// //
// // class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final auth = context.watch<GenericAuthProvider>();
// //     final bool isDark = Theme.of(context).brightness == Brightness.dark;
// //
// //     if (auth.user == null) {
// //       return const Scaffold(body: Center(child: Text("Please Login First")));
// //     }
// //
// //     return Scaffold(
// //       backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
// //       appBar: AppBar(
// //         title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
// //         centerTitle: true,
// //         backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// //         foregroundColor: isDark ? Colors.white : Colors.black,
// //         elevation: 0.5,
// //       ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         // ✅ Indexing এরর এড়ানোর জন্য orderBy সরিয়ে শুধু targetId দিয়ে ফিল্টার করছি
// //         stream: _firestore
// //             .collection('notifications')
// //             .where('targetId', isEqualTo: auth.user!.uid)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.hasError) {
// //             return Center(child: Text("Error: ${snapshot.error}"));
// //           }
// //
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return const Center(child: CircularProgressIndicator(color: AppColor.green));
// //           }
// //
// //           // ১. ডাটাবেজ থেকে আসা ডকুমেন্টগুলোকে একটি লিস্টে নেওয়া
// //           final List<DocumentSnapshot> docs = snapshot.data?.docs ?? [];
// //
// //           if (docs.isEmpty) {
// //             return _buildEmptyState(isDark);
// //           }
// //
// //           // ✅ ২. ডার্ট কোডের মাধ্যমে ম্যানুয়ালি সময় অনুযায়ী সর্ট করা (Indexing লাগবে না)
// //           docs.sort((a, b) {
// //             Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
// //             Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
// //             return t2.compareTo(t1); // Newest first
// //           });
// //
// //           return ListView.builder(
// //             physics: const BouncingScrollPhysics(),
// //             padding: const EdgeInsets.all(12),
// //             itemCount: docs.length,
// //             itemBuilder: (context, index) {
// //               final data = docs[index].data() as Map<String, dynamic>;
// //
// //               // সময় ফরম্যাট করা
// //               String timeStr = "Just now";
// //               if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
// //                 timeStr = timeago.format((data['createdAt'] as Timestamp).toDate(), locale: 'en_short');
// //               }
// //
// //               final notification = NotificationModel(
// //                 id: docs[index].id,
// //                 message: data['title'] ?? "New Request",
// //                 requestBy: data['message'] ?? "",
// //                 time: timeStr,
// //                 receiverId: data['targetId'] ?? "",
// //                 postId: data['postId'] ?? "",
// //                 status: data['status'] ?? "unread",
// //               );
// //
// //               return _buildNotificationTile(notification, isDark);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildNotificationTile(NotificationModel item, bool isDark) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
// //         borderRadius: BorderRadius.circular(15),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
// //             blurRadius: 10,
// //             offset: const Offset(0, 4),
// //           )
// //         ],
// //       ),
// //       child: ListTile(
// //         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //         leading: CircleAvatar(
// //           backgroundColor: AppColor.green.withOpacity(0.1),
// //           child: const Icon(Icons.notifications_active, color: AppColor.green, size: 20),
// //         ),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(
// //               child: Text(item.message, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
// //             ),
// //             Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
// //           ],
// //         ),
// //         subtitle: Padding(
// //           padding: const EdgeInsets.only(top: 5),
// //           child: Text(item.requestBy, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildEmptyState(bool isDark) {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.notifications_none_rounded, size: 80, color: Colors.grey.withOpacity(0.3)),
// //           const SizedBox(height: 15),
// //           const Text("No notifications yet", style: TextStyle(color: Colors.grey, fontSize: 16)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:waste_food_management/core/constants/app_colors.dart';
//
// import '../../../../../../auth/data/model/notification_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
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
//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<GenericAuthProvider>();
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     if (auth.user == null) {
//       return const Scaffold(body: Center(child: Text("Please Login First")));
//     }
//
//     return Scaffold(
//       backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text("Notifications",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//         centerTitle: true,
//         backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//         foregroundColor: isDark ? Colors.white : Colors.black,
//         elevation: 0.5,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         // ✅ orderBy সরিয়ে দেওয়া হয়েছে যাতে Index এরর না আসে
//         stream: _firestore
//             .collection('notifications')
//             .where('targetId', isEqualTo: auth.user!.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text("Error fetching data: ${snapshot.error}"));
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: AppColor.green));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return _buildEmptyState(isDark);
//           }
//
//           // ১. ডাটাগুলোকে একটি লিস্টে নেওয়া
//           final List<DocumentSnapshot> docs = snapshot.data!.docs;
//
//           // ২. ম্যানুয়াল সর্টিং (সবচেয়ে নতুনটি সবার উপরে থাকবে)
//           // ইনডেক্স ছাড়াই এটি কাজ করবে।
//           docs.sort((a, b) {
//             Map<String, dynamic> dataA = a.data() as Map<String, dynamic>;
//             Map<String, dynamic> dataB = b.data() as Map<String, dynamic>;
//
//             Timestamp t1 = dataA['createdAt'] ?? Timestamp(0, 0);
//             Timestamp t2 = dataB['createdAt'] ?? Timestamp(0, 0);
//             return t2.compareTo(t1); // Newest first
//           });
//
//           return ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.all(12),
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data() as Map<String, dynamic>;
//
//               // টাইম ফরম্যাটিং
//               String timeStr = "Just now";
//               if (data['createdAt'] != null) {
//                 timeStr = timeago.format((data['createdAt'] as Timestamp).toDate(), locale: 'en_short');
//               }
//
//               // ডাটা ম্যাপিং (আপনার মডেল অনুযায়ী)
//               final notification = NotificationModel(
//                 id: docs[index].id,
//                 message: data['title'] ?? "New Update",
//                 requestBy: data['message'] ?? "Check your request status",
//                 time: timeStr,
//                 receiverId: data['targetId'] ?? "",
//                 postId: data['postId'] ?? "",
//                 status: data['status'] ?? "unread",
//               );
//
//               return _buildNotificationCard(notification, isDark);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildNotificationCard(NotificationModel item, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
//         borderRadius: BorderRadius.circular(16),
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
//           child: const Icon(Icons.notifications_active, color: AppColor.green, size: 20),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: Text(item.message,
//                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                   maxLines: 1, overflow: TextOverflow.ellipsis),
//             ),
//             const SizedBox(width: 5),
//             Text(item.time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
//           ],
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 5),
//           child: Text(item.requestBy,
//               style: TextStyle(
//                   color: isDark ? Colors.white70 : Colors.black54,
//                   fontSize: 12,
//                   height: 1.3
//               )),
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
//           Icon(Icons.notifications_off_outlined, size: 70, color: Colors.grey.withOpacity(0.3)),
//           const SizedBox(height: 10),
//           Text("No notifications for now", style: TextStyle(color: Colors.grey[600])),
//         ],
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

class DonorNotificationScreen extends StatefulWidget {
  static String routeName = "donor-notification";
  const DonorNotificationScreen({super.key});

  @override
  State<DonorNotificationScreen> createState() => _DonorNotificationScreenState();
}

class _DonorNotificationScreenState extends State<DonorNotificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, String> _cache = {};

  // ভলান্টিয়ার বা রিসিভারের নাম ক্যাশ থেকে নেওয়া
  Future<String> _getProfileName(String id) async {
    if (id.isEmpty) return "Someone";
    if (_cache.containsKey(id)) return _cache[id]!;

    try {
      var snap = await _firestore.collection('accounts').doc(id).get();
      String name = snap.data()?['profile']?['contactPerson'] ?? "User";
      _cache[id] = name;
      return name;
    } catch (e) {
      return "User";
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GenericAuthProvider>();
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (auth.user == null) {
      return const Scaffold(body: Center(child: Text("Please Login First")));
    }

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0.5,
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ✅ Donor হিসেবে আপনার ID যে রিকোয়েস্টগুলোতে আছে সেগুলো ফিল্টার করা
        stream: _firestore
            .collection('requests')
            .where('donorId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColor.green));
          }

          final docs = snapshot.data?.docs ?? [];

          if (docs.isEmpty) {
            return _buildEmptyState(isDark);
          }

          // ✅ ম্যানুয়াল সর্টিং (Newest First) - ইনডেক্স এরর হবে না
          final sortedDocs = docs.toList();
          sortedDocs.sort((a, b) {
            Timestamp t1 = (a.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            Timestamp t2 = (b.data() as Map<String, dynamic>)['createdAt'] ?? Timestamp(0, 0);
            return t2.compareTo(t1);
          });

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: sortedDocs.length,
            itemBuilder: (context, index) {
              final data = sortedDocs[index].data() as Map<String, dynamic>;

              String status = data['status'] ?? "";
              String dStatus = data['deliverystatus'] ?? "";
              String vName = data['volunteerName'] ?? "A volunteer";

              String title = "Update on Food Request";
              String body = "Checking status...";

              // ডোনারের জন্য নোটিফিকেশন লজিক
              if (status == 'pending') {
                body = "A receiver is waiting for your approval.";
              } else if (status == 'approved' && dStatus == 'none') {
                body = "You approved a request. Waiting for a volunteer.";
              } else if (dStatus == 'pending') {
                body = "$vName has been assigned for delivery.";
              } else if (dStatus == 'ongoing') {
                body = "Food is being delivered by $vName.";
              } else if (dStatus == 'completed') {
                body = "Success! Food has been delivered to the receiver.";
              }

              String timeStr = data['createdAt'] != null
                  ? timeago.format((data['createdAt'] as Timestamp).toDate(), locale: 'en_short')
                  : "now";

              return _buildNotificationCard(title, body, timeStr, isDark);
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(String title, String body, String time, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
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
          child: const Icon(Icons.volunteer_activism, color: AppColor.green, size: 20),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(body, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, size: 80, color: Colors.grey.withOpacity(0.3)),
          const SizedBox(height: 10),
          const Text("No Donor Notifications"),
        ],
      ),
    );
  }
}