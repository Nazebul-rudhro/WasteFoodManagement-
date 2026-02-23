// import 'package:flutter/material.dart';
// import '../../../../app/app_routes.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../sections/header_section.dart';
// import '../sections/info_cards_section.dart';
// import '../sections/myposts_tab_section.dart';
// import '../sections/donation_history_section.dart';
// import '../sections/donor_recent_section.dart';
// import '../../../auth/data/model/donation_history_model.dart';
// import 'donor/presentation/screens/food_donation_list_screen.dart';
//
// class HomePageScreen extends StatefulWidget {
//   const HomePageScreen({super.key});
//
//   static const String routeName = '/home';
//
//   @override
//   State<HomePageScreen> createState() => _HomePageScreenState();
// }
//
// class _HomePageScreenState extends State<HomePageScreen>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   // Sample Data
//   final donationHistoryList = [
//     DonationHistoryModel(
//       id: "324800",
//       timeAgo: "3 Days Ago",
//       title: "Rice Bowl with curry on",
//       quantity: "10 Plate",
//       status: "Completed",
//       image: "assets/images/splash_screen/splashscreen_1.png",
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
//     // ডার্ক মোড চেক করার জন্য (ইউজার ফ্রেন্ডলি লুকের জন্য)
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     final double screenHeight = MediaQuery.of(context).size.height * 0.01;
//
//     return Scaffold(
//       // ব্যাকগ্রাউন্ড থিম অনুযায়ী অটোমেটিক চেঞ্জ হবে
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ---------------- Header ----------------
//               HeaderSection(
//                 name: "Mandeep",
//                 role: "Donor",
//                 notificationCount: 1,
//                 noticicationOnActionTap: () {
//                   debugPrint("Notification Tapped");
//                 },
//               ),
//               SizedBox(height: screenHeight * 2),
//
//               // ---------------- Info Cards ----------------
//               // এখানে primary color এরর ফিক্স করা হয়েছে
//               InfoCardsSection(
//                 title1: "Donations",
//                 value1: 120,
//                 color1: isDark ? AppColor.gray.withOpacity(0.3) : AppColor.backgrouGray,
//
//                 title2: "Feedback",
//                 value2: 500,
//                 color2: AppColor.primary.withOpacity(0.2), // AppColor.primary ব্যবহার করা হয়েছে
//
//                 title3: "Points earned",
//                 value3: 1000,
//                 color3: isDark ? AppColor.gray.withOpacity(0.3) : AppColor.backgrouGray,
//               ),
//
//               SizedBox(height: screenHeight * 2),
//
//               // ---------------- MyPosts Tab ----------------
//               MyPostsTabSection(tabController: _tabController),
//               const SizedBox(height: 20),
//
//               // ---------------- Donation History ----------------
//               DonationHistorySection(
//                 list: donationHistoryList,
//                 onActionTap: () {
//                   debugPrint("donation history clicked");
//                 },
//               ),
//               const SizedBox(height: 20),
//
//               // ---------------- Recent Actions / NGOs ----------------
//               DonorRecentSection(
//                 onActionTap: () {
//                   Navigator.push(
//                     context,
//                     AppRoutes.smooth(const FoodDonationListScreen()),
//                   );
//                 },
//               ),
//
//               const SizedBox(height: 30), // নিচের দিকে একটু বাড়তি স্পেস
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../../../../app/app_routes.dart';
import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../sections/header_section.dart';
import '../sections/info_cards_section.dart';
import '../sections/myposts_tab_section.dart';
import '../sections/donation_history_section.dart';
import '../sections/donor_recent_section.dart';
import '../../../auth/data/model/donation_history_model.dart';
import 'donor/presentation/screens/food_donation_list_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final donationHistoryList = [
    DonationHistoryModel(
      id: "324800",
      timeAgo: "3 Days Ago",
      title: "Rice Bowl with curry on",
      quantity: "10 Plate",
      status: "Completed",
      image: "assets/images/splash_screen/splashscreen_1.png",
    ),
  ];

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

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      // বডির কালার থিম অনুযায়ী অটোমেটিক হবে
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              HeaderSection(
                name: "Mandeep",
                role: "Donor",
                notificationCount: 1,
                noticicationOnActionTap: () {
                  debugPrint("Notification Tapped");
                },
              ),
              SizedBox(height: screenHeight * 2),

              // Info Cards (কালার ফিক্স করা হয়েছে)
              InfoCardsSection(
                title1: "Donations",
                value1: 120,
                color1: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.backgrouGray,

                title2: "Feedback",
                value2: 500,
                color2: AppColor.primary.withOpacity(0.2),

                title3: "Points earned",
                value3: 1000,
                color3: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.backgrouGray,
              ),

              SizedBox(height: screenHeight * 2),

              MyPostsTabSection(tabController: _tabController),
              const SizedBox(height: 20),

              DonationHistorySection(
                list: donationHistoryList,
                onActionTap: () {
                  debugPrint("donation history clicked");
                },
              ),
              const SizedBox(height: 20),

              DonorRecentSection(
                onActionTap: () {
                  Navigator.push(
                    context,
                    AppRoutes.smooth(const FoodDonationListScreen()),
                  );
                },
              ),

              const SizedBox(height: 100), // নেভিগেশন বারের কার্ভের জন্য বাড়তি জায়গা
            ],
          ),
        ),
      ),
    );
  }
}