// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../app/app_theme.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/community_section_model.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/data/model/ngo_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/community_section.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
// import '../../../donor/presentation/screens/donor_notification_screen.dart';
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
//   final communityList = [
//     CommunitySectionModel(
//       id: "1",
//       timeAgo: "2h ago",
//       title: "We visit places to serve people",
//       quantity: "50kg",
//       status: "Know More",
//       image: "assets/images/splash_screen/splashscreen_1.png",
//       onTap: () => print("Card 1 tapped"),
//     ),
//   ];
//
//   final faqList = [
//     FaqItem(question: "How do I start a delivery?", answer: "Go to the 'Requests' tab, find an approved request..."),
//     FaqItem(question: "Is there a time limit?", answer: "Yes, 1-2 hours to ensure freshness."),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
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
//     final String userName = authProvider.userData?['profile']?['name'] ?? "User";
//     final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";
//     final double screenHeight = MediaQuery.of(context).size.height * 0.01;
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView( // পুরো স্ক্রিন স্ক্রল হবে
//           child: BaseScreen(
//             child: Column(
//               children: [
//                 HeaderSection(
//                   name: userName,
//                   role: userRole,
//                   notificationCount: 1,
//                   noticicationOnActionTap: () {
//                     Navigator.pushNamed(context, DonorNotificationScreen.routeName);
//                   },
//                 ),
//                 SizedBox(height: screenHeight * 2),
//                 InfoCardsSection(
//                   title1: "Total Delivery",
//                   value1: authProvider.totalDonations,
//                   color1: AppColor.soft_green,
//                   title2: "Request",
//                   value2: authProvider.totalReceived,
//                   color2: AppColor.green,
//                   title3: "Points",
//                   value3: 1000,
//                   color3: AppColor.soft_green,
//                 ),
//                 SizedBox(height: screenHeight * 2),
//
//                 // ট্যাব সেকশন
//                 VolunteerTabSection(tabController: _tabController),
//
//                 // SizedBox(height: screenHeight * 2),
//                 // CommunitySection(
//                 //   list: communityList,
//                 //   onActionTab: () => print("View Feed tapped!"),
//                 // ),
//                 SizedBox(height: screenHeight * 2),
//                 FaqSection(faqs: faqList),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// } // <-- এই ব্র্যাকেটটি আগে মিসিং ছিল



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../../app/app_theme.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/community_section_model.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/data/model/ngo_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/community_section.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';
import '../../../donor/presentation/screens/donor_notification_screen.dart';
import '../provider/volunteer_provider.dart';
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
    final vProvider = Provider.of<VolunteerProvider>(context, listen: false);

    final String userUid = authProvider.user?.uid ?? "";
    final String userName = authProvider.userData?['profile']?['name'] ?? "User";
    final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(
            child: Column(
              children: [
                // ১. হেডার সেকশন
                HeaderSection(
                  name: userName,
                  role: userRole,
                  notificationCount: 1,
                  noticicationOnActionTap: () {
                    Navigator.pushNamed(context, DonorNotificationScreen.routeName);
                  },
                ),
                SizedBox(height: screenHeight * 2),

                // ২. ইনফো কার্ড সেকশন (ডাইনামিক কাউন্ট সহ)
                StreamBuilder<QuerySnapshot>(
                  // আমরা requests কালেকশন থেকে ভলান্টিয়ারের সব ডাটা একবারে আনছি
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .where('volunteerId', isEqualTo: userUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    int completed = 0;
                    int ongoing = 0;

                    if (snapshot.hasData) {
                      for (var doc in snapshot.data!.docs) {
                        String status = doc['status'] ?? "";
                        if (status == 'completed') completed++;
                        if (status == 'on_the_way') ongoing++;
                      }
                    }

                    return InfoCardsSection(
                      title1: "Delivered",
                      value1: completed,
                      color1: AppColor.soft_green,
                      title2: "Ongoing",
                      value2: ongoing,
                      color2: AppColor.green,
                      title3: "Points",
                      value3: completed * 10, // এটি আপনি চাইলে ইউজার প্রোফাইল থেকে আনতে পারেন
                      color3: AppColor.soft_green,
                    );
                  },
                ),

                SizedBox(height: screenHeight * 2),

                // ৩. ট্যাব সেকশন (Available, My Deliveries, Completed)
                VolunteerTabSection(tabController: _tabController),

                SizedBox(height: screenHeight * 2),

                // ৪. এফএকিউ সেকশন
                FaqSection(faqs: faqList),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}