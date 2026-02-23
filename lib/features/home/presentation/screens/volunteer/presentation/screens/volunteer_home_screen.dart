// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
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
//     final String userUid = authProvider.user?.uid ?? "";
//     final String userName = authProvider.userData?['profile']?['contactPerson'] ?? "Volunteer";
//     final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";
//
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       // ডার্ক মোডে থিমের ব্যাকগ্রাউন্ড অটো নিবে
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: BaseScreen(
//           child: CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   children: [
//                     // ১. হেডার সেকশন
//                     HeaderSection(
//                       name: userName,
//                       role: userRole,
//                       notificationCount: authProvider.notificationCount,
//                       noticicationOnActionTap: () {
//                         authProvider.resetNotificationCount();
//                         Navigator.pushNamed(context, VolunteerNotificationScreen.routeName);
//                       },
//                     ),
//                     const SizedBox(height: 20),
//
//                     // ২. ইনফো কার্ড সেকশন (StreamBuilder)
//                     StreamBuilder<DocumentSnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('accounts')
//                           .doc(userUid)
//                           .snapshots(),
//                       builder: (context, userSnapshot) {
//                         final userData = userSnapshot.data?.data() as Map<String, dynamic>? ?? {};
//                         final profile = userData['profile'] as Map<String, dynamic>? ?? {};
//
//                         final int totalPoints = profile['points'] ?? 0;
//                         final int totalTasks = profile['totalTasks'] ?? 0;
//
//                         return StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance
//                               .collection('requests')
//                               .where('volunteerId', isEqualTo: userUid)
//                               .where('deliverystatus', isEqualTo: 'ongoing')
//                               .snapshots(),
//                           builder: (context, requestSnapshot) {
//                             int ongoingCount = requestSnapshot.data?.docs.length ?? 0;
//
//                             return InfoCardsSection(
//                               title1: "Delivered",
//                               value1: totalTasks,
//                               // ডার্ক মোডে সফট গ্রিন কালার অ্যাডজাস্টমেন্ট
//                               color1: isDark
//                                   ? AppColor.green.withOpacity(0.15)
//                                   : AppColor.soft_green,
//                               title2: "Ongoing",
//                               value2: ongoingCount,
//                               color2: AppColor.green,
//                               title3: "Points",
//                               value3: totalPoints,
//                               color3: isDark
//                                   ? AppColor.green.withOpacity(0.15)
//                                   : AppColor.soft_green,
//                             );
//                           },
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 10),
//
//                     // ৩. ট্যাব সেকশন (ট্যাব বার ও লিস্ট ভিউ)
//                     SizedBox(
//                       height: screenHeight * 0.75, // হাইট সামান্য বাড়ানো হয়েছে
//                       child: VolunteerTabSection(tabController: _tabController),
//                     ),
//
//                     const SizedBox(height: 10),
//
//                     // ৪. এফএকিউ সেকশন
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 4),
//                       child: FaqSection(faqs: faqList),
//                     ),
//
//                     const SizedBox(height: 110), // কার্ভ নেভিগেশন বারের জন্য সেফ স্পেস
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
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BaseScreen(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
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

                    // ২. ইনফো কার্ড সেকশন
                    StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('accounts')
                          .doc(userUid)
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        final userData = userSnapshot.data?.data() as Map<String, dynamic>? ?? {};
                        final profile = userData['profile'] as Map<String, dynamic>? ?? {};

                        final int totalPoints = profile['points'] ?? 0;
                        final int totalTasks = profile['totalTasks'] ?? 0;

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
                              value1: totalTasks,
                              // ডার্ক মোডে সলিড ডার্ক সারফেস এবং লাইট মোডে সফট গ্রিন
                              color1: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,

                              title2: "Ongoing",
                              value2: ongoingCount,
                              color2: AppColor.green, // মেইন গ্রিন কালার

                              title3: "Points",
                              value3: totalPoints,
                              color3: isDark ? const Color(0xFF1E1E1E) : AppColor.soft_green,
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // ৩. ট্যাব সেকশন
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: screenHeight * 0.50,
                      decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark ? Colors.white10 : Colors.transparent,
                          )
                      ),
                      child: VolunteerTabSection(tabController: _tabController),
                    ),

                    const SizedBox(height: 20),

                    // ৪. এফএকিউ সেকশন
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Support FAQ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          FaqSection(faqs: faqList),
                        ],
                      ),
                    ),

                    const SizedBox(height: 120),
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