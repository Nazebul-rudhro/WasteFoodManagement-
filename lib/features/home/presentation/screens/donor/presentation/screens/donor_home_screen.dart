// import 'package:flutter/material.dart';
//
// import '../../../../../../../app/app_routes.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/community_section_model.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/data/model/ngo_model.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/community_section.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
// import '../../../../sections/myposts_tab_section.dart';
// import '../../../../sections/donor_recent_section.dart';
// import 'donor_notification_screen.dart';
// import 'food_donation_list_screen.dart';
// class DonorHomeScreen extends StatefulWidget {
//   static String routeName = "/doner-home";
//
//   const DonorHomeScreen({super.key});
//
//   @override
//   State<DonorHomeScreen> createState() => _DonorHomeScreenState();
// }
//
// class _DonorHomeScreenState extends State<DonorHomeScreen>
//     with TickerProviderStateMixin {
//
//   late TabController _tabController;
//
//   /// 🔹 NGO LIST (later Firestore theke asbe)
//   final List<NGOModel> ngoList = [
//     NGOModel(
//       name: "SKS Foundation",
//       pickupTime: "2.5 km",
//       imageUrl: "assets/images/splash_screen/splashscreen_1.png",
//       location: "Dhaka",
//       foodRequirement: "Rice, Curry",
//     ),
//     NGOModel(
//       name: "Hope NGO",
//       pickupTime: "1.2 km",
//       imageUrl: "assets/images/splash_screen/splashscreen_1.png",
//       location: "Mirpur",
//       foodRequirement: "Dry Food",
//     ),
//     NGOModel(
//       name: "Helping Hands",
//       pickupTime: "3.0 km",
//       imageUrl: "assets/images/splash_screen/splashscreen_1.png",
//       location: "Uttara",
//       foodRequirement: "Cooked Food",
//     ),
//   ];
//
//
//
//   final communityList = [
//     CommunitySectionModel(
//       id: "1",
//       timeAgo: "2h ago",
//       title: "We visit places to serve people",
//       quantity: "50kg",
//       status: "Know More",
//       image: "assets/images/splash_screen/splashscreen_1.png",
//       onTap: () {
//         print("Card 1 tapped");
//       },
//     ),
//     CommunitySectionModel(
//       id: "2",
//       timeAgo: "1d ago",
//       title: "Join our volunteer program",
//       quantity: "30 volunteers",
//       status: "Join Now",
//       image: "assets/images/splash_screen/splashscreen_1.png",
//       onTap: () {
//         print("Card 2 tapped");
//       },
//     ),
//   ];
//
//
//
//
//   final faqList = [
//     FaqItem(
//       question: "Who will pick up the food?",
//       answer: "Verified volunteers or nearby receivers will pick up the food.",
//     ),
//     FaqItem(
//       question: "Can we perform a one-time donation?",
//       answer: "Yes, you can donate only once if you want.",
//     ),
//     FaqItem(
//       question: "Is the donation free?",
//       answer: "Yes, all donations are completely free of cost.",
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
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
//     final h = MediaQuery.of(context).size.height * 0.01;
//
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: BaseScreen(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 HeaderSection(
//                   name: "Mandeep",
//                   role: "Donor",
//                   notificationCount: 1,
//                   noticicationOnActionTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       DonorNotificationScreen.routeName,
//                     );
//                   },
//                 ),
//
//                 SizedBox(height: h),
//
//                 InfoCardsSection(
//                   title1: "Donations",
//                   value1: 120,
//                   color1: AppColor.soft_green,
//                   title2: "Feedback",
//                   value2: 500,
//                   color2: AppColor.lightGreen,
//                   title3: "Points earned",
//                   value3: 1000,
//                   color3: AppColor.soft_green,
//                 ),
//
//                 SizedBox(height: h),
//
//                 MyPostsTabSection(tabController: _tabController),
//
//                 SizedBox(height: h),
//
//                 /// 🔥 NGO SECTION
//                 // NgoNearYouSection(
//                 //   onActionTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       AppRoutes.smooth(const NgoListScreen()),
//                 //     );
//                 //   },
//                 // ),
//
//
//                 DonorRecentSection(
//                   onActionTap: () {
//                     Navigator.push(context, AppRoutes.smooth(const FoodDonationListScreen()));
//                   },
//                 ),
//
//
//                 SizedBox(height: h),
//
//                 CommunitySection(
//                   list: communityList,
//                   onActionTab: () {
//                     debugPrint("View Feed tapped");
//                   },
//                 ),
//
//                 SizedBox(height: h),
//
//                 FaqSection(faqs: faqList),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//





import 'package:flutter/material.dart';
import '../../../../../../../app/app_routes.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/community_section_model.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  final communityList = [
    CommunitySectionModel(
      id: "1",
      timeAgo: "2h ago",
      title: "We visit places to serve people",
      quantity: "50kg",
      status: "Know More",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () {
        print("Card 1 tapped");
      },
    ),
    CommunitySectionModel(
      id: "2",
      timeAgo: "1d ago",
      title: "Join our volunteer program",
      quantity: "30 volunteers",
      status: "Join Now",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () {
        print("Card 2 tapped");
      },
    ),
  ];


    final faqList = [
    FaqItem(
      question: "Who will pick up the food?",
      answer: "Verified volunteers or nearby receivers will pick up the food.",
    ),
    FaqItem(
      question: "Can we perform a one-time donation?",
      answer: "Yes, you can donate only once if you want.",
    ),
    FaqItem(
      question: "Is the donation free?",
      answer: "Yes, all donations are completely free of cost.",
    ),
  ];


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      body: SafeArea(
        child: BaseScreen(
          child: CustomScrollView(
            slivers: [
              // ১. উপরের সব সেকশন (Header, Info, Posts Tab)
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderSection(
                      name: "Mandeep",
                      role: "Donor",
                      notificationCount: 1,
                      noticicationOnActionTap: () => Navigator.pushNamed(context, DonorNotificationScreen.routeName),
                    ),
                    SizedBox(height: h),
                    InfoCardsSection(
                      title1: "Donations", value1: 120, color1: AppColor.soft_green,
                      title2: "Feedback", value2: 500, color2: AppColor.lightGreen,
                      title3: "Points earned", value3: 1000, color3: AppColor.soft_green,
                    ),
                    SizedBox(height: h * 2),

                    // ২. MyPostsTabSection - এখানে নির্দিষ্ট হাইট দেওয়া হয়েছে যেন ওভারল্যাপ না হয়
                    const Text("My Activities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 400, // ট্যাব ভিউটির জন্য একটি ফিক্সড জায়গা বরাদ্দ
                      child: MyPostsTabSection(tabController: _tabController),
                    ),

                    SizedBox(height: h * 2),

                    // ৩. Recent Donation সেকশন
                    DonorRecentSection(
                      onActionTap: () => Navigator.push(context, AppRoutes.smooth(const FoodDonationListScreen())),
                    ),

                    SizedBox(height: h),

                    // ৪. অন্যান্য সেকশন
                    CommunitySection(
                      list: communityList, // আপনার ডাটা লিস্ট
                      onActionTab: () {},
                    ),

                    SizedBox(height: h),

                    FaqSection(faqs: faqList), // আপনার FAQ লিস্ট

                    const SizedBox(height: 10), // নিচে কিছু এক্সট্রা স্পেস
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