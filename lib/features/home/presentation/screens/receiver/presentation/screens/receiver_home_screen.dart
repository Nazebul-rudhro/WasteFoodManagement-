import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';

import '../../../../../../../app/app_theme.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/community_section_model.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/community_section.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';

class ReceiverHomeScreen extends StatefulWidget {
  static String routeName = "receiver-home";

  const ReceiverHomeScreen({super.key});

  @override
  State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
  @override
  void initState() {
    super.initState();
    // স্ক্রিন ওপেন হওয়ার সাথে সাথে লেটেস্ট ডাটা নিশ্চিত করা
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final auth = context.read<GenericAuthProvider>();
        auth.fetchUserData();
      }
    });
  }

  // কমিউনিটি লিস্ট ডাটা
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
      title: "Food distribution in local area",
      quantity: "20kg",
      status: "Know More",
      image: "assets/images/splash_screen/splashscreen_1.png",
      onTap: () => debugPrint("Card 2 tapped"),
    ),
  ];

  // FAQ লিস্ট ডাটা
  final List<FaqItem> faqList = [
    FaqItem(
      question: "Who will pick up the food?",
      answer: "Verified volunteers or nearby receivers will pick up the food directly from the donor's location.",
    ),
    FaqItem(
      question: "How does the Volunteer help?",
      answer: "Volunteers accept pickup requests, collect the food from the donor, and deliver it safely to the receiver's address.",
    ),
    FaqItem(
      question: "Can I join as a Volunteer?",
      answer: "Yes, anyone can register as a volunteer to help transport food and bridge the gap between donors and those in need.",
    ),
    FaqItem(
      question: "Is there any cost for the Receiver?",
      answer: "No, the food is completely free. The goal is to manage food waste and serve the community through generous donations.",
    ),
    FaqItem(
      question: "What should Donors ensure before donating?",
      answer: "Donors should ensure the food is fresh, hygienic, and properly packed before the volunteer or receiver arrives for pickup.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Consumer<GenericAuthProvider>(
          builder: (context, auth, _) {
            // প্রোফাইল থেকে নাম এবং ডাটা নেওয়া
            final profile = auth.userData?['profile'];
            final displayName = profile?['contactPerson'] ??
                profile?['businessOrFullName'] ?? "Receiver";
            final displayRole = auth.userData?['role'] ?? "Receiver";

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BaseScreen(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// --- HEADER SECTION ---
                    HeaderSection(
                      name: displayName,
                      role: displayRole.toString().toUpperCase(),
                      notificationCount: 1,
                      noticicationOnActionTap: () => Navigator.pushNamed(
                          context, DonorNotificationScreen.routeName),
                    ),
                    SizedBox(height: screenHeight * 2),

                    /// --- INFO CARDS ---
                    InfoCardsSection(
                      title1: "Received",
                      value1: auth.totalReceived, // এখানে এখন সঠিক Approved সংখ্যা দেখাবে
                      color1: AppColor.soft_green,
                      title2: "Feedback",
                      value2: 0,
                      color2:AppColor.green,
                      title3: "Points",
                      value3: auth.totalReceived * 10,
                      color3: AppColor.soft_green,
                    ),
                    SizedBox(height: screenHeight * 3),

                    /// --- RECEIVER TAB SECTION ---
                    const ReceiverTabSection(),
                    SizedBox(height: screenHeight * 2),

                    /// --- RECENT DONATIONS SECTION ---
                    const ReceiverRecentSection(),
                    SizedBox(height: screenHeight * 3),

                    /// --- COMMUNITY SECTION ---
                    CommunitySection(
                      list: communityList,
                      onActionTab: () => debugPrint("View Feed tapped!"),
                    ),
                    SizedBox(height: screenHeight * 2),

                    /// --- FAQ SECTION ---
                    FaqSection(faqs: faqList),
                    SizedBox(height: screenHeight * 4),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}