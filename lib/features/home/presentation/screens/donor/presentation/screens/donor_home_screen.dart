// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import '../../../../../../../app/app_routes.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/community_section_model.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/community_section.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
// import '../../../../sections/myposts_tab_section.dart';
// import '../../../../sections/donor_recent_section.dart';
// import 'donor_notification_screen.dart';
// import 'food_donation_list_screen.dart';
//
// class DonorHomeScreen extends StatefulWidget {
//   static String routeName = "/doner-home";
//   const DonorHomeScreen({super.key});
//
//   @override
//   State<DonorHomeScreen> createState() => _DonorHomeScreenState();
// }
//
// class _DonorHomeScreenState extends State<DonorHomeScreen> with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//
//     // পেজ লোড হওয়ার সাথে সাথে ডাটা ফেচ করা
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         final auth = context.read<GenericAuthProvider>();
//         auth.fetchUserData(); // এটি আপনার প্রোফাইল এবং স্ট্যাটাস লোড করবে
//         // নোট: আপনার প্রোভাইডারে যদি লিসেনার (Stream) থাকে তবে নিচের মেথডগুলো নিজে থেকেই আপডেট হবে
//         auth.countUserStats();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   // ডামি ডাটা: কমিউনিটি সেকশন
//   final List<CommunitySectionModel> communityList = [
//     CommunitySectionModel(
//       id: "1",
//       timeAgo: "2h ago",
//       title: "We visit places to serve people",
//       quantity: "50kg",
//       status: "Know More",
//       image: "assets/images/splash_screen/splashscreen_1.png",
//       onTap: () => debugPrint("Card 1 tapped"),
//     ),
//   ];
//
//   // ডামি ডাটা: FAQ সেকশন
//   final List<FaqItem> faqList = [
//     FaqItem(question: "Who will pick up the food?", answer: "Verified volunteers or nearby receivers."),
//     FaqItem(question: "Can we perform a one-time donation?", answer: "Yes, you can."),
//     FaqItem(question: "Is the donation free?", answer: "Yes, all donations are free."),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // স্ক্রিন হাইট রেসপন্সিভ করার জন্য
//     final h = MediaQuery.of(context).size.height * 0.01;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Consumer<GenericAuthProvider>(
//           builder: (context, auth, _) {
//             // প্রোফাইল থেকে নাম এবং রোল বের করা
//             final profile = auth.userData?['profile'];
//             final displayName = profile?['contactPerson'] ?? profile?['businessOrFullName'] ?? "User";
//             final displayRole = auth.userData?['role'] ?? "Donor";
//
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await auth.fetchUserData();
//                 await auth.countUserStats();
//               },
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: BaseScreen(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // হেডার সেকশন: নাম, রোল এবং নোটিফিকেশন
//                       HeaderSection(
//                         name: displayName,
//                         role: displayRole.toString().toUpperCase(),
//                         notificationCount: auth.notificationCount,
//                         noticicationOnActionTap: () {
//                           auth.resetNotificationCount();
//                           Navigator.pushNamed(context, DonorNotificationScreen.routeName);
//                         },
//                       ),
//
//                       SizedBox(height: h * 2),
//
//                       // ইনফো কার্ডস সেকশন: স্ট্যাটাস প্রদর্শন
//                       InfoCardsSection(
//                         title1: "Donations",
//                         value1: auth.totalDonations, // এপ্রুভড ডোনেশন সংখ্যা
//                         color1: AppColor.soft_green,
//
//                         title2: "Total Post",
//                         value2: auth.totalPosts, // মোট করা পোস্টের সংখ্যা (রিয়েল-টাইম)
//                         color2: AppColor.green,
//
//                         title3: "Points",
//                         value3: auth.totalDonations * 10, // প্রতিটি ডোনেশনে ১০ পয়েন্ট
//                         color3: AppColor.soft_green,
//                       ),
//
//                       SizedBox(height: h * 3),
//
//                       // মাই অ্যাক্টিভিটিস সেকশন (Tabs)
//                        Text("My Activities",
//                           style: AppData.heading2,),
//                       SizedBox(
//                         height: 400, // ট্যাব সেকশনের জন্য ফিক্সড হাইট
//                         child: MyPostsTabSection(tabController: _tabController),
//                       ),
//
//                       SizedBox(height: h * 2),
//
//                       // রিসেন্ট ডোনেশন সেকশন
//                       DonorRecentSection(
//                         onActionTap: () => Navigator.push(
//                             context, AppRoutes.smooth(const FoodDonationListScreen())),
//                       ),
//
//                       SizedBox(height: h * 2),
//
//                       // কমিউনিটি সেকশন
//                       CommunitySection(list: communityList, onActionTab: () {}),
//
//                       SizedBox(height: h * 2),
//
//                       // FAQ সেকশন
//                       FaqSection(faqs: faqList),
//
//                       SizedBox(height: h * 4),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_theme.dart';
import '../../../../../../../app/app_routes.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/community_section_model.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/community_section.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';
import '../../../../sections/myposts_tab_section.dart';
import '../../../../sections/donor_recent_section.dart';
import 'donor_notification_screen.dart';
import 'food_donation_list_screen.dart';

class DonorHomeScreen extends StatefulWidget {
  static String routeName = "/doner-home";
  const DonorHomeScreen({super.key});

  @override
  State<DonorHomeScreen> createState() => _DonorHomeScreenState();
}

class _DonorHomeScreenState extends State<DonorHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // পেজ লোড হওয়ার সাথে সাথে ডাটা ফেচ করা
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final auth = context.read<GenericAuthProvider>();
        auth.fetchUserData();
        auth.countUserStats();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ডামি ডাটা: কমিউনিটি সেকশন
  final List<CommunitySectionModel> communityList = [
    CommunitySectionModel(
      id: "1",
      timeAgo: "2h ago",
      title: "We visit places to serve people",
      quantity: "50kg",
      status: "Know More",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () => debugPrint("Card 1 tapped"),
    ),
  ];

  // ডামি ডাটা: FAQ সেকশন
  final List<FaqItem> faqList = [
    FaqItem(question: "Who will pick up the food?", answer: "Verified volunteers or nearby receivers."),
    FaqItem(question: "Can we perform a one-time donation?", answer: "Yes, you can."),
    FaqItem(question: "Is the donation free?", answer: "Yes, all donations are free."),
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<GenericAuthProvider>(
          builder: (context, auth, _) {
            // ১. ডাটাবেজ ম্যাপ স্ট্রাকচার অনুযায়ী ডাটা বের করা
            final userData = auth.userData ?? {};
            final profile = userData['profile'] as Map<String, dynamic>? ?? {};

            // ফিল্ড নেম অনুযায়ী ভ্যালু এসাইন (Donor-এর জন্য)
            final displayName = profile['contactPerson'] ?? profile['businessOrFullName'] ?? "User";
            final displayRole = userData['role']?.toString().toUpperCase() ?? "DONOR";

            // ২. ডাইনামিক পয়েন্ট এবং ডোনেশন কাউন্ট
            final int points = profile['points'] ?? 0; // Firestore points field
            final int totalDonations = profile['totalDonations'] ?? 0; // Firestore totalDonations field
            final int totalPosts = auth.totalPosts; // Provider-এর ইন্টারনাল পোস্ট কাউন্ট

            return RefreshIndicator(
              onRefresh: () async {
                await auth.fetchUserData();
                await auth.countUserStats();
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BaseScreen(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // হেডার সেকশন
                      HeaderSection(
                        name: displayName,
                        role: displayRole,
                        notificationCount: auth.notificationCount,
                        noticicationOnActionTap: () {
                          auth.resetNotificationCount();
                          Navigator.pushNamed(context, DonorNotificationScreen.routeName);
                        },
                      ),

                      SizedBox(height: h * 2),

                      // আপডেট করা ইনফো কার্ডস সেকশন (Dynamic Data)
                      InfoCardsSection(
                        title1: "Donations",
                        value1: totalDonations, // profile -> totalDonations field
                        color1: AppColor.soft_green,

                        title2: "Total Post",
                        value2: totalPosts, // auth.totalPosts (Provider count)
                        color2: AppColor.green,

                        title3: "Points",
                        value3: points, // profile -> points field
                        color3: AppColor.soft_green,
                      ),

                      SizedBox(height: h * 3),

                      // মাই অ্যাক্টিভিটিস সেকশন (Tabs)
                      Text("My Activities", style: AppData.heading2),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 450,
                        child: MyPostsTabSection(tabController: _tabController),
                      ),

                      SizedBox(height: h * 2),

                      // রিসেন্ট ডোনেশন সেকশন
                      DonorRecentSection(
                        onActionTap: () => Navigator.push(
                            context, AppRoutes.smooth(const FoodDonationListScreen())),
                      ),

                      SizedBox(height: h * 2),
                      CommunitySection(list: communityList, onActionTab: () {}),
                      SizedBox(height: h * 2),
                      FaqSection(faqs: faqList),
                      SizedBox(height: h * 4),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}