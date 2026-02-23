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

    CommunitySectionModel(
      id: "2",
      timeAgo: "5h ago",
      title: "We visit places to serve people",
      quantity: "70kg",
      status: "Know More",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () => debugPrint("Card 2 tapped"),
    ),


  ];

  final List<FaqItem> faqList = [
    FaqItem(question: "Who will pick up the food?", answer: "Verified volunteers or nearby receivers."),
    FaqItem(question: "Can we perform a one-time donation?", answer: "Yes, you can."),
    FaqItem(question: "Is the donation free?", answer: "Yes, all donations are free."),
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height * 0.01;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // Adaptive background
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Consumer<GenericAuthProvider>(
          builder: (context, auth, _) {
            final userData = auth.userData ?? {};
            final profile = userData['profile'] as Map<String, dynamic>? ?? {};

            final displayName = profile['contactPerson'] ?? profile['businessOrFullName'] ?? "User";
            final displayRole = userData['role']?.toString().toUpperCase() ?? "DONOR";

            final int points = profile['points'] ?? 0;
            final int totalDonations = profile['totalDonations'] ?? 0;
            final int totalPosts = auth.totalPosts;

            return RefreshIndicator(
              color: AppColor.primary,
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
                      // --- Header Section ---
                      HeaderSection(
                        name: displayName,
                        role: displayRole,
                        notificationCount: auth.notificationCount,
                        noticicationOnActionTap: () {
                          auth.resetNotificationCount();
                          Navigator.pushNamed(context, DonorNotificationScreen.routeName);
                        },
                      ),

                      SizedBox(height: h * 2.5),

                      // --- Info Cards Section (Night Mode Optimized) ---
                      InfoCardsSection(
                        title1: "Donations",
                        value1: totalDonations,
                        // Dark Mode: Soft tint of Primary, Light Mode: Soft green
                        color1: isDark
                            ? AppColor.soft_green
                            : AppColor.soft_green,

                        title2: "Total Post",
                        value2: totalPosts,
                        color2: AppColor.green, // Signature brand color

                        title3: "Points",
                        value3: points,
                        color3: isDark
                            ? AppColor.soft_green
                            : AppColor.soft_green,
                      ),

                      SizedBox(height: h * 3),

                      // --- My Activities Section ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                            "My Activities",
                            style: AppData.heading2.copyWith(
                                color: isDark ? AppColor.white : AppColor.black
                            )
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tab Section Container (Dark Surface)
                      Container(
                        height: 460,
                        decoration: BoxDecoration(
                          color: isDark ? AppColor.gray.withOpacity(0.1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2)) : null,
                        ),
                        child: MyPostsTabSection(tabController: _tabController),
                      ),

                      SizedBox(height: h * 3),

                      // --- Recent Donations ---
                      DonorRecentSection(
                        onActionTap: () => Navigator.push(
                            context, AppRoutes.smooth(const FoodDonationListScreen())),
                      ),

                      SizedBox(height: h * 3),
                      CommunitySection(list: communityList, onActionTab: () {}),
                      SizedBox(height: h * 3),

                      // --- FAQ Section ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                            "Common FAQ",
                            style: AppData.heading2.copyWith(
                                color: isDark ? AppColor.white : AppColor.black,
                                fontSize: 18
                            )
                        ),
                      ),
                      const SizedBox(height: 10),
                      FaqSection(faqs: faqList),

                      SizedBox(height: h * 6),
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