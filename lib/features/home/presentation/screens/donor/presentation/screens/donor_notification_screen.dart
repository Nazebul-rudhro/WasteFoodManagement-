
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
  Future<List<NotificationModel>> _processNotificationData(List<QueryDocumentSnapshot> docs) async {
    List<NotificationModel> formattedList = [];

    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;

      // ✅ Status Check (Pending, Approved, Rejected, Delivered)
      String status = data['status'] ?? "pending";

      String timeStr = data['createdAt'] != null
          ? timeago.format((data['createdAt'] as Timestamp).toDate())
          : "Just now";

      // ✅ Fetch Food Name from 'posts' collection using postId
      var postDoc = await _firestore.collection('posts').doc(data['postId']).get();
      String foodName = postDoc.exists ? (postDoc.data()?['foodName'] ?? "Food Item") : "Deleted Post";

      // ✅ Fetch Receiver Name from 'accounts' collection
      var userDoc = await _firestore.collection('accounts').doc(data['receiverId']).get();
      String userName = userDoc.exists
          ? (userDoc.data()?['businessOrFullName'] ?? userDoc.data()?['profile']?['contactPerson'] ?? "User")
          : "Someone";

      formattedList.add(
        NotificationModel(
          id: doc.id,
          message: foodName,
          requestBy: "Requested by: $userName",
          time: timeStr,
          receiverId: data['receiverId'] ?? "",
          postId: data['postId'] ?? "",
          status: status, // Final Checked Status
        ),
      );
    }
    return formattedList;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<GenericAuthProvider>();
    final donorPro = context.read<DonorProvider>();

    if (auth.user == null) return const Scaffold(body: Center(child: Text("Login Required")));

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications"), elevation: 1, backgroundColor: AppColor.soft_green,),
      body: StreamBuilder<QuerySnapshot>(
        // 🔹 Firebase theke donor-er shob requests niye asha hosse
        stream: _firestore
            .collection('requests')
            .where('donorId', isEqualTo: auth.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text("Error: ${snapshot.error}"));
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Requests Found"));
          }

          // 🔹 Local Filter: requests theke status check kora (Index er jhamela thakbe na)
          final filteredDocs = snapshot.data!.docs.where((doc) {
            final st = doc['status'] as String;
            return ['pending', 'approved', 'rejected', 'delivered'].contains(st);
          }).toList();

          return FutureBuilder<List<NotificationModel>>(
            future: _processNotificationData(filteredDocs),
            builder: (context, fSnapshot) {
              if (fSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!fSnapshot.hasData || fSnapshot.data!.isEmpty) {
                return const Center(child: Text("No Data After Processing"));
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BaseScreen(
                  child: NotificationSection(
                    notifications: fSnapshot.data!,
                    onApprove: (id) async {
                      final item = fSnapshot.data!.firstWhere((x) => x.id == id);
                      await donorPro.handleRequest(id, item.postId, 'approved');
                    },
                    onReject: (id) async {
                      final item = fSnapshot.data!.firstWhere((x) => x.id == id);
                      await donorPro.handleRequest(id, item.postId, 'rejected');
                    },
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