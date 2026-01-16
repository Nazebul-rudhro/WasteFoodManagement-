import 'package:flutter/material.dart';
import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
import '../sections/header_section.dart';
import '../sections/info_cards_section.dart';
import '../sections/myposts_tab_section.dart';
import '../sections/community_section.dart';
import '../sections/donation_history_section.dart';
import '../sections/faq_section.dart';
import '../sections/ngo_near_section.dart';
import '../../../auth/data/model/donation_history_model.dart';
import '../../../auth/data/model/ngo_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Sample Data
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

  final ngoList = [
    NgoModel(
      name: "Sks",
      distance: "2.5km",
      image: "assets/images/splash_screen/splashscreen_1.png",
    ),
    NgoModel(
      name: "Hope NGO",
      distance: "1.2km",
      image: "assets/images/splash_screen/splashscreen_1.png",
    ),
    NgoModel(
      name: "Helping Hands",
      distance: "3.0km",
      image: "assets/images/splash_screen/splashscreen_1.png",
    ),
    NgoModel(
      name: "Food For All",
      distance: "4.5km",
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
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- Header ----------------
              HeaderSection(
                name: "Mandeep",
                role: "Donor",
                notificationCount: 1, noticicationOnActionTap: () {  },
              ),
              SizedBox(height: screenHeight),

              // ---------------- Info Cards ----------------
              InfoCardsSection(
                title1: "Donations",
                value1: 120,
                color1: AppColor.backgrouGray,

                title2: "Feedback",
                value2: 500,
                color2: AppData.primaryColor.withOpacity(0.6),

                title3: "Points earned",
                value3: 1000,
                color3: AppColor.backgrouGray,
              ),

              SizedBox(height: screenHeight),

              // ---------------- MyPosts Tab ----------------
              MyPostsTabSection(tabController: _tabController),
              SizedBox(height: 20),

              // ---------------- Donation History ----------------
              DonationHistorySection(list: donationHistoryList, onActionTap: () { debugPrint("donation history"); },),
              SizedBox(height: 20),

              // ---------------- NGOs Near You ----------------
              NgoNearYouSection(list: ngoList, onActionTap: () { debugPrint("View NGOs Click"); },),
              SizedBox(height: 20),

              // ---------------- Community ----------------
              // const CommunitySection(),
              SizedBox(height: 20),

              // ---------------- FAQs ----------------
              // const FaqSection(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
