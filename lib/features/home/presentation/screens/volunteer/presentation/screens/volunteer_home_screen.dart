import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../section/volunteer_tab_section.dart';

class VolunteerHomeScreen extends StatefulWidget {
  static String routeName = "volunteer-home";
  const VolunteerHomeScreen({super.key});

  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  final communityList = [
    CommunitySectionModel(
      id: "1",
      timeAgo: "2h ago",
      title: "We visit places to serve people",
      quantity: "50kg",
      status: "Know More",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () => print("Card 1 tapped"),
    ),
  ];

  final faqList = [
    FaqItem(question: "How do I start a delivery?", answer: "Go to the 'Requests' tab, find an approved request..."),
    FaqItem(question: "Is there a time limit?", answer: "Yes, 1-2 hours to ensure freshness."),
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
    final authProvider = Provider.of<GenericAuthProvider>(context);
    final String userName = authProvider.userData?['profile']?['name'] ?? "User";
    final String userRole = authProvider.selectedRole?.toUpperCase() ?? "VOLUNTEER";
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // পুরো স্ক্রিন স্ক্রল হবে
          child: BaseScreen(
            child: Column(
              children: [
                HeaderSection(
                  name: userName,
                  role: userRole,
                  notificationCount: 1,
                  noticicationOnActionTap: () {
                    Navigator.pushNamed(context, DonorNotificationScreen.routeName);
                  },
                ),
                SizedBox(height: screenHeight * 2),
                InfoCardsSection(
                  title1: "Donations",
                  value1: authProvider.totalDonations,
                  color1: AppColor.backgrouGray,
                  title2: "Received",
                  value2: authProvider.totalReceived,
                  color2: AppData.primaryColor.withOpacity(0.6),
                  title3: "Points",
                  value3: 1000,
                  color3: AppColor.backgrouGray,
                ),
                SizedBox(height: screenHeight * 2),

                // ট্যাব সেকশন
                VolunteerTabSection(tabController: _tabController),

                SizedBox(height: screenHeight * 2),
                CommunitySection(
                  list: communityList,
                  onActionTab: () => print("View Feed tapped!"),
                ),
                SizedBox(height: screenHeight * 2),
                FaqSection(faqs: faqList),
              ],
            ),
          ),
        ),
      ),
    );
  }
} // <-- এই ব্র্যাকেটটি আগে মিসিং ছিল