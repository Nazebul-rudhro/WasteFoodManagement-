import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
import 'package:waste_food_management/features/home/presentation/sections/header_section.dart';

import '../../../../../../../app/app_theme.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../core/constants/app_image.dart';
import '../../../../../../auth/data/model/community_section_model.dart';
import '../../../../../../auth/data/model/donation_history_model.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/data/model/ngo_model.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/community_section.dart';
import '../../../../sections/donation_history_section.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/info_cards_section.dart';
import '../../../../sections/myposts_tab_section.dart';
import '../../../../sections/ngo_near_section.dart';

class VolunteerHomeScreen extends StatefulWidget {
  static String routeName = "volunteer-home";

  const VolunteerHomeScreen({super.key});

  @override
  State<VolunteerHomeScreen> createState() => _ReceiverHomeScreenState();
}

class _ReceiverHomeScreenState extends State<VolunteerHomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final donationHistoryList =[
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
    NGOModel(
      name: "Sks",
      distance: "2.5km",
      image: "assets/images/splash_screen/splashscreen_1.png", location: '', foodRequirement: '',
    ),
    NGOModel(
      name: "Hope NGO",
      distance: "1.2km",
      image: "assets/images/splash_screen/splashscreen_1.png", location: '', foodRequirement: '',
    ),
    NGOModel(
      name: "Helping Hands",
      distance: "3.0km",
      image: "assets/images/splash_screen/splashscreen_1.png", location: '', foodRequirement: '',
    ),
    NGOModel(
      name: "Food For All",
      distance: "4.5km",
      image: "assets/images/splash_screen/splashscreen_1.png", location: '', foodRequirement: '',
    ),
  ];

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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height * 0.01;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(child: Column(children: [

            HeaderSection(
                name: "Mandeep", role: "Volunteer", notificationCount: 1, noticicationOnActionTap: () { Navigator.pushNamed(context, DonorNotificationScreen.routeName); },),
            SizedBox(height: screenHeight,),


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
            SizedBox(height: screenHeight,),

            MyPostsTabSection(tabController: _tabController),
            SizedBox(height: screenHeight,),
            // DonationHistorySection(list: donationHistoryList,),

            SizedBox(height: screenHeight,),
            NgoNearYouSection(list: ngoList, onActionTap: () {  },),
            SizedBox(height: screenHeight,),
            // const CommunitySection(),
            CommunitySection(
              list: communityList,
              onActionTab: () {
                print("View Feed tapped!");
              },
            ),
            SizedBox(height: screenHeight,),
            FaqSection(faqs: faqList),


          ])),
        ),
      ),
    );
  }
}
