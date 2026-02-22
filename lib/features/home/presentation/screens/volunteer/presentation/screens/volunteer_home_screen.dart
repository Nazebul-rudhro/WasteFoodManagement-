
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../../../../app/app_theme.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
// import '../provider/volunteer_provider.dart';
// import '../section/volunteer_notification_screen.dart';
// import '../section/volunteer_tab_section.dart';
//
// class VolunteerHomeScreen extends StatefulWidget {
//   static String routeName = "volunteer-home";
//   const VolunteerHomeScreen({super.key});
//
//   @override
//   State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
// }
//
// class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   final faqList = [
//     FaqItem(question: "How do I start a delivery?", answer: "Go to the 'Requests' tab, find an approved request and click Accept."),
//     FaqItem(question: "Is there a time limit?", answer: "Yes, please try to deliver within 1-2 hours to ensure food freshness."),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     // ৩টি ট্যাব: Available, Ongoing, Completed
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<GenericAuthProvider>(context);
//     // userUid এবং অন্যান্য ডাটা সেফলি হ্যান্ডেল করা
//     final String userUid = authProvider.user?.uid ?? "";
//     final String userName = authProvider.userData?['profile']?['name'] ?? "Volunteer";
//     final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";
//
//     // স্ক্রিন হাইট ক্যালকুলেশন
//     final double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: BaseScreen(
//           // SingleChildScrollView সরানো হয়েছে কারণ TabBarView এর নিজস্ব স্ক্রলিং দরকার হতে পারে
//           // যদি BaseScreen এর ভেতর স্ক্রলিং থাকে তবে নিচের Column টি ঠিকঠাক কাজ করবে
//           child: CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     // ১. হেডার সেকশন
//                     // HeaderSection(
//                     //   name: userName,
//                     //   role: userRole,
//                     //   notificationCount: 1,
//                     //   noticicationOnActionTap: () {
//                     //     Navigator.pushNamed(context, VolunteerNotificationSection.routeName);
//                     //   },
//                     // ),
//
//                     // HeaderSection update inside VolunteerHomeScreen
//                     HeaderSection(
//                       name: userName,
//                       role: userRole,
//                       notificationCount: authProvider.notificationCount, // Provider theke real count ashbe
//                       noticicationOnActionTap: () {
//                         authProvider.resetNotificationCount();
//                         Navigator.pushNamed(context, VolunteerNotificationScreen.routeName);
//                       },
//                     ),
//                     const SizedBox(height: 20),
//
//                     // ২. ইনফো কার্ড সেকশন (StreamBuilder)
//                     StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('requests')
//                           .where('volunteerId', isEqualTo: userUid)
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState == ConnectionState.waiting) {
//                           return const Center(child: CircularProgressIndicator());
//                         }
//
//                         int completed = 0;
//                         int ongoing = 0;
//
//                         if (snapshot.hasData) {
//                           for (var doc in snapshot.data!.docs) {
//                             String status = doc['status'] ?? "";
//                             if (status == 'completed') completed++;
//                             if (status == 'on_the_way') ongoing++;
//                           }
//                         }
//
//                         return InfoCardsSection(
//                           title1: "Delivered",
//                           value1: completed,
//                           color1: AppColor.soft_green,
//                           title2: "Ongoing",
//                           value2: ongoing,
//                           color2: AppColor.green,
//                           title3: "Points",
//                           value3: completed * 10,
//                           color3: AppColor.soft_green,
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 20),
//
//                     // ৩. ট্যাব সেকশন
//                     // মনে রাখবেন: TabBarView কে একটি নির্দিষ্ট Height দিতেই হবে
//                     SizedBox(
//                       height: screenHeight * 0.6, // স্ক্রিনের ৬০% জায়গা ট্যাবের জন্য
//                       child: VolunteerTabSection(tabController: _tabController),
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // ৪. এফএকিউ সেকশন
//                     FaqSection(faqs: faqList),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../../app/app_theme.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';
import '../provider/volunteer_provider.dart';
import '../section/volunteer_notification_screen.dart';
import '../section/volunteer_tab_section.dart';

class VolunteerHomeScreen extends StatefulWidget {
  static String routeName = "volunteer-home";
  const VolunteerHomeScreen({super.key});

  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final faqList = [
    FaqItem(question: "How do I start a delivery?", answer: "Go to the 'Requests' tab, find an approved request and click Accept."),
    FaqItem(question: "Is there a time limit?", answer: "Yes, please try to deliver within 1-2 hours to ensure food freshness."),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<GenericAuthProvider>(context);
    final String userUid = authProvider.user?.uid ?? "";
    final String userName = authProvider.userData?['profile']?['contactPerson'] ?? "Volunteer";
    final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BaseScreen(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // ১. হেডার সেকশন
                    HeaderSection(
                      name: userName,
                      role: userRole,
                      notificationCount: authProvider.notificationCount,
                      noticicationOnActionTap: () {
                        authProvider.resetNotificationCount();
                        Navigator.pushNamed(context, VolunteerNotificationScreen.routeName);
                      },
                    ),
                    const SizedBox(height: 20),

                    // ২. ইনফো কার্ড সেকশন (Dynamic Stream theke Points o Tasks asbe)
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('accounts')
                          .doc(userUid)
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        // User Profile theke data fetch
                        final userData = userSnapshot.data?.data() as Map<String, dynamic>? ?? {};
                        final profile = userData['profile'] as Map<String, dynamic>? ?? {};

                        final int totalPoints = profile['points'] ?? 0;
                        final int totalTasks = profile['totalTasks'] ?? 0;

                        // Ongoing tasks-er jonno onno stream (optional check)
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('requests')
                              .where('volunteerId', isEqualTo: userUid)
                              .where('deliverystatus', isEqualTo: 'ongoing')
                              .snapshots(),
                          builder: (context, requestSnapshot) {
                            int ongoingCount = requestSnapshot.data?.docs.length ?? 0;

                            return InfoCardsSection(
                              title1: "Delivered",
                              value1: totalTasks, // User profile -> totalTasks theke asche
                              color1: AppColor.soft_green,
                              title2: "Ongoing",
                              value2: ongoingCount, // Database-er filter theke asche
                              color2: AppColor.green,
                              title3: "Points",
                              value3: totalPoints, // User profile -> points theke asche
                              color3: AppColor.soft_green,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // ৩. ট্যাব সেকশন
                    SizedBox(
                      height: screenHeight * 0.7, // Height thoda barano hoyeche scroll safety-r jonno
                      child: VolunteerTabSection(tabController: _tabController),
                    ),

                    const SizedBox(height: 20),

                    // ৪. এফএকিউ সেকশন
                    FaqSection(faqs: faqList),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}