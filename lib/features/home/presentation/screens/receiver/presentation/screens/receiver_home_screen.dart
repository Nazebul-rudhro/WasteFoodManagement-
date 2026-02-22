// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';
// //
// // import '../../../../../../../app/app_theme.dart';
// // import '../../../../../../../core/constants/app_colors.dart';
// // import '../../../../../../auth/data/model/community_section_model.dart';
// // import '../../../../../../auth/data/model/faq_item_model.dart';
// // import '../../../../../../auth/provider/generic_auth_provider.dart';
// // import '../../../../sections/base_screen.dart';
// // import '../../../../sections/community_section.dart';
// // import '../../../../sections/faq_section.dart';
// // import '../../../../sections/header_section.dart';
// // import '../../../../sections/info_cards_section.dart';
// //
// // class ReceiverHomeScreen extends StatefulWidget {
// //   static String routeName = "receiver-home";
// //
// //   const ReceiverHomeScreen({super.key});
// //
// //   @override
// //   State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
// // }
// //
// // class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       if (mounted) {
// //         final auth = context.read<GenericAuthProvider>();
// //         auth.fetchUserData();
// //         auth.loadUserRole();
// //       }
// //     });
// //   }
// //
// //   final List<CommunitySectionModel> communityList = [
// //     CommunitySectionModel(
// //       id: "1",
// //       timeAgo: "2h ago",
// //       title: "We visit places to serve people",
// //       quantity: "50kg",
// //       status: "Know More",
// //       image: "assets/images/splash_screen/splashscreen_1.png",
// //       onTap: () => debugPrint("Card 1 tapped"),
// //     ),
// //     CommunitySectionModel(
// //       id: "2",
// //       timeAgo: "5h ago",
// //       title: "Food distribution in local area",
// //       quantity: "20kg",
// //       status: "Know More",
// //       image: "assets/images/splash_screen/splashscreen_1.png",
// //       onTap: () => debugPrint("Card 2 tapped"),
// //     ),
// //   ];
// //
// //   final List<FaqItem> faqList = [
// //     FaqItem(
// //       question: "Who will pick up the food?",
// //       answer: "Verified volunteers or nearby receivers will pick up the food directly from the donor's location.",
// //     ),
// //     FaqItem(
// //       question: "How does the Volunteer help?",
// //       answer: "Volunteers accept pickup requests, collect the food from the donor, and deliver it safely to the receiver's address.",
// //     ),
// //     FaqItem(
// //       question: "Can I join as a Volunteer?",
// //       answer: "Yes, anyone can register as a volunteer to help transport food and bridge the gap between donors and those in need.",
// //     ),
// //     FaqItem(
// //       question: "Is there any cost for the Receiver?",
// //       answer: "No, the food is completely free.",
// //     ),
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // স্ক্রিন রেন্ডারিং এর জন্য ডাইনামিক হাইট ইউনিট
// //     final double screenHeight = MediaQuery.of(context).size.height * 0.01;
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Consumer<GenericAuthProvider>(
// //           builder: (context, auth, _) {
// //             final profile = auth.userData?['profile'];
// //             final displayName = profile?['contactPerson'] ??
// //                 profile?['businessOrFullName'] ?? "User";
// //             final displayRole = auth.selectedRole ?? "Receiver";
// //
// //             return RefreshIndicator(
// //               color: AppColor.green,
// //               onRefresh: () => auth.fetchUserData(),
// //               child: SingleChildScrollView(
// //                 physics: const BouncingScrollPhysics(),
// //                 child: BaseScreen(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       /// --- HEADER SECTION ---
// //                       HeaderSection(
// //                         name: displayName,
// //                         role: displayRole.toUpperCase(),
// //                         notificationCount: auth.notificationCount,
// //                         noticicationOnActionTap: () {
// //                           // নোটিফিকেশন রিসেট এবং নেভিগেশন
// //                           auth.resetNotificationCount();
// //                           Navigator.pushNamed(context, DonorNotificationScreen.routeName);
// //                         },
// //                       ),
// //                       SizedBox(height: screenHeight * 2),
// //
// //                       /// --- INFO CARDS SECTION (সংশোধিত) ---
// //                       InfoCardsSection(
// //                         // ১. বাম দিকে 'Pending' (আপনার প্রোভাইডারের নোটিফিকেশন কাউন্ট থেকে আসবে)
// //                         title1: "Pending",
// //                         value1: auth.pendingCount,
// //                         color1: AppColor.soft_green,
// //
// //                         // ২. মাঝখানে 'Received' (টোটাল এপ্রুভড রিকোয়েস্ট)
// //                         title2: "Received",
// //                         value2: auth.totalReceived,
// //                         color2: AppColor.green,
// //
// //                         // ৩. ডান দিকে 'Points' (এপ্রুভড কাউন্টের ১০ গুণ)
// //                         title3: "Points",
// //                         value3: auth.totalReceived * 10,
// //                         color3: AppColor.soft_green,
// //                       ),
// //
// //                       SizedBox(height: screenHeight * 3),
// //
// //                       /// --- TAB SECTION ---
// //                       const ReceiverTabSection(),
// //                       SizedBox(height: screenHeight * 2),
// //
// //                       /// --- RECENT SECTION ---
// //                       const ReceiverRecentSection(),
// //                       SizedBox(height: screenHeight * 3),
// //
// //                       /// --- COMMUNITY SECTION ---
// //                       CommunitySection(
// //                         list: communityList,
// //                         onActionTab: () => debugPrint("View Feed tapped!"),
// //                       ),
// //                       SizedBox(height: screenHeight * 2),
// //
// //                       /// --- FAQ SECTION ---
// //                       FaqSection(faqs: faqList),
// //                       SizedBox(height: screenHeight * 4),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';
// import '../../../../../../../app/app_theme.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/community_section_model.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/community_section.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
//
// class ReceiverHomeScreen extends StatefulWidget {
//   static String routeName = "receiver-home";
//   const ReceiverHomeScreen({super.key});
//
//   @override
//   State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
// }
//
// class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // পেজ লোড হওয়ার সাথে সাথে ডাটা ফেচ করা
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         final auth = context.read<GenericAuthProvider>();
//         auth.fetchUserData(); // এটি প্রোফাইল এবং রোল লোড করে লিসেনার চালু করবে
//       }
//     });
//   }
//
//   // ডামি কমিউনিটি ডাটা
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
//     CommunitySectionModel(
//       id: "2",
//       timeAgo: "5h ago",
//       title: "Food distribution in local area",
//       quantity: "20kg",
//       status: "Know More",
//       image: "assets/images/splash_screen/splashscreen_1.png",
//       onTap: () => debugPrint("Card 2 tapped"),
//     ),
//   ];
//
//   // FAQ ডাটা
//   final List<FaqItem> faqList = [
//     FaqItem(
//       question: "Who will pick up the food?",
//       answer: "Verified volunteers or nearby receivers will pick up the food directly from the donor's location.",
//     ),
//     FaqItem(
//       question: "Is there any cost for the Receiver?",
//       answer: "No, the food is completely free.",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final double h = MediaQuery.of(context).size.height * 0.01;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Consumer<GenericAuthProvider>(
//           builder: (context, auth, _) {
//             // প্রোফাইল ডাটা বের করা
//             final profile = auth.userData?['profile'];
//             final displayName = profile?['contactPerson'] ??
//                 profile?['businessOrFullName'] ?? "User";
//             final displayRole = auth.selectedRole ?? "Receiver";
//
//             return RefreshIndicator(
//               color: AppColor.green,
//               onRefresh: () async => await auth.fetchUserData(),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: BaseScreen(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// --- HEADER SECTION ---
//                       HeaderSection(
//                         name: displayName,
//                         role: displayRole.toUpperCase(),
//                         notificationCount: auth.notificationCount,
//                         noticicationOnActionTap: () {
//                           auth.resetNotificationCount();
//                           Navigator.pushNamed(context, DonorNotificationScreen.routeName);
//                         },
//                       ),
//                       SizedBox(height: h * 2),
//
//                       /// --- INFO CARDS SECTION ---
//                       InfoCardsSection(
//                         title1: "Pending",
//                         value1: auth.pendingCount,
//                         color1: AppColor.soft_green,
//
//                         title2: "Received",
//                         value2: auth.totalReceived,
//                         color2: AppColor.green,
//
//                         title3: "Points",
//                         value3: auth.totalReceived * 10,
//                         color3: AppColor.soft_green,
//                       ),
//
//                       SizedBox(height: h * 3),
//
//                       /// --- TAB SECTION (My Requests) ---
//                       // Note: নিশ্চিত হোন ReceiverTabSection এর ভেতর ListView/TabBar ঠিক আছে
//                       const ReceiverTabSection(),
//
//                       SizedBox(height: h * 2),
//
//                       /// --- RECENT SECTION ---
//                       const ReceiverRecentSection(),
//
//                       SizedBox(height: h * 3),
//
//                       /// --- COMMUNITY SECTION ---
//                       CommunitySection(
//                         list: communityList,
//                         onActionTab: () {},
//                       ),
//
//                       SizedBox(height: h * 2),
//
//                       /// --- FAQ SECTION ---
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


//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
//
// class ReceiverHomeScreen extends StatefulWidget {
//   static String routeName = "receiver-home";
//   const ReceiverHomeScreen({super.key});
//
//   @override
//   State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
// }
//
// class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         context.read<GenericAuthProvider>().fetchUserData();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA), // 🔹 হালকা গ্রে ব্যাকগ্রাউন্ড প্রফেশনাল লাগে
//       body: SafeArea(
//         child: Consumer<GenericAuthProvider>(
//           builder: (context, auth, _) {
//             final profile = auth.userData?['profile'];
//             final displayName = profile?['contactPerson'] ?? profile?['businessOrFullName'] ?? "User";
//
//             return RefreshIndicator(
//               color: AppColor.green,
//               onRefresh: () async => await auth.fetchUserData(),
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: BaseScreen(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       HeaderSection(
//                         name: displayName,
//                         role: (auth.selectedRole ?? "Receiver").toUpperCase(),
//                         notificationCount: auth.notificationCount,
//                         noticicationOnActionTap: () => auth.resetNotificationCount(),
//                       ),
//                       const SizedBox(height: 20),
//
//                       InfoCardsSection(
//                         title1: "Pending",
//                         value1: auth.pendingCount,
//                         color1: Colors.orange.shade400, // 🔹 মডার্ন কালার
//                         title2: "Received",
//                         value2: auth.totalReceived,
//                         color2: AppColor.green,
//                         title3: "Points",
//                         value3: auth.totalReceived * 10,
//                         color3: Colors.blue.shade400,
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       /// --- মডার্ন ট্যাব সেকশন ---
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 4.0),
//                         child: ReceiverTabSection(),
//                       ),
//
//                       const SizedBox(height: 25),
//                       const ReceiverRecentSection(),
//                       const SizedBox(height: 25),
//                       // কমিউনিটি এবং FAQ আগের মতোই থাকবে
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

//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_notification_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';
// import '../../../../../../../core/constants/app_colors.dart';
// import '../../../../../../auth/data/model/faq_item_model.dart';
// import '../../../../../../auth/provider/generic_auth_provider.dart';
// import '../../../../sections/base_screen.dart';
// import '../../../../sections/faq_section.dart';
// import '../../../../sections/header_section.dart';
// import '../../../../sections/info_cards_section.dart';
// import '../provider/receiver_provider.dart';
//
// class ReceiverHomeScreen extends StatefulWidget {
//   static String routeName = "receiver-home";
//   const ReceiverHomeScreen({super.key});
//
//   @override
//   State<ReceiverHomeScreen> createState() => _ReceiverHomeScreenState();
// }
//
// class _ReceiverHomeScreenState extends State<ReceiverHomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // 🔹 পেজ লোড হওয়ার সাথে সাথে সব ডাটা একসাথে ফেচ করা
//     _fetchInitialData();
//   }
//
//   void _fetchInitialData() {
//     Future.microtask(() {
//       if (mounted) {
//         // ১. ইউজারের প্রোফাইল ডাটা লোড
//         context.read<GenericAuthProvider>().fetchUserData();
//         // ২. রিসিভারের রিয়েল-টাইম পোস্ট এবং রিকোয়েস্ট ডাটা লোড (সবচেয়ে জরুরি)
//         context.read<ReceiverProvider>().fetchAllPosts();
//       }
//     });
//   }
//
//
//   final List<FaqItem> faqList = [
//     FaqItem(
//       question: "Who will pick up the food?",
//       answer: "Verified volunteers or nearby receivers will pick up the food directly from the donor's location.",
//     ),
//     FaqItem(
//       question: "Is there any cost for the Receiver?",
//       answer: "No, the food is completely free.",
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//
//     // 🔹 দুটি প্রোভাইডারকেই লিসেন (watch) করা হচ্ছে
//     final auth = context.watch<GenericAuthProvider>();
//     final receiver = context.watch<ReceiverProvider>();
//
//     // প্রোফাইল ডাটা হ্যান্ডলিং
//     final profile = auth.userData?['profile'];
//     final displayName = profile?['contactPerson'] ?? profile?['businessOrFullName'] ?? "User";
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       body: SafeArea(
//         child: RefreshIndicator(
//           color: AppColor.green,
//           onRefresh: () async {
//             await auth.fetchUserData();
//             receiver.fetchAllPosts(); // রিফ্রেশ করলে পোস্টও আপডেট হবে
//           },
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: BaseScreen(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // --- হেডার সেকশন ---
//                   // HeaderSection(
//                   //   name: displayName,
//                   //   role: (auth.selectedRole ?? "Receiver").toUpperCase(),
//                   //   notificationCount: auth.notificationCount,
//                   //   noticicationOnActionTap: () => tomar mto class banaiya dio,
//                   // ),
//
//
//                   HeaderSection(
//                     name: displayName,
//                     role: (auth.selectedRole ?? "Receiver").toUpperCase(),
//                     notificationCount: auth.notificationCount,
//                     // Apnar HeaderSection er variable nam-i rakha holo:
//                     noticicationOnActionTap: () {
//                       auth.resetNotificationCount();
//                       Navigator.pushNamed(context, ReceiverNotificationScreen.routeName);
//                     },
//                   ),
//                   const SizedBox(height: 20),
//
//                   // --- ইনফো কার্ড সেকশন (রিয়েল-টাইম ডাটা ব্যবহার) ---
//                   InfoCardsSection(
//                     title1: "Pending",
//                     // 🔹 সরাসরি রিসিভার প্রোভাইডার থেকে কাউন্ট নেওয়া হচ্ছে
//                     value1: receiver.pendingPosts.length,
//                     color1: Colors.orange.shade400,
//
//                     title2: "Received",
//                     value2: receiver.approvedPosts.length,
//                     color2: AppColor.green,
//
//                     title3: "Points",
//                     value3: receiver.approvedPosts.length * 10,
//                     color3: Colors.blue.shade400,
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   /// --- মডার্ন ট্যাব সেকশন ---
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 4.0),
//                     child: ReceiverTabSection(),
//                   ),
//
//                   const SizedBox(height: 25),
//
//                   /// --- রিসেন্ট পোস্ট সেকশন ---
//                   const ReceiverRecentSection(),
//                   // SizedBox(height: h * 2),
// //
// //                       /// --- FAQ SECTION ---
//                       FaqSection(faqs: faqList),
//
//                   const SizedBox(height: 25),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/myreceive_tab_section.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_notification_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/recent_receiver_section.dart';
import '../../../../../../../core/constants/app_colors.dart';
import '../../../../../../auth/data/model/faq_item_model.dart';
import '../../../../../../auth/provider/generic_auth_provider.dart';
import '../../../../sections/base_screen.dart';
import '../../../../sections/faq_section.dart';
import '../../../../sections/header_section.dart';
import '../../../../sections/info_cards_section.dart';
import '../provider/receiver_provider.dart';

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
    _fetchInitialData();
  }

  void _fetchInitialData() {
    Future.microtask(() {
      if (mounted) {
        context.read<GenericAuthProvider>().fetchUserData();
        context.read<ReceiverProvider>().fetchAllPosts();
      }
    });
  }

  final List<FaqItem> faqList = [
    FaqItem(
      question: "Who will pick up the food?",
      answer: "Verified volunteers or nearby receivers will pick up the food directly from the donor's location.",
    ),
    FaqItem(
      question: "Is there any cost for the Receiver?",
      answer: "No, the food is completely free.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // 🔹 দুটি প্রোভাইডারকেই লিসেন করা হচ্ছে
    final auth = context.watch<GenericAuthProvider>();
    final receiver = context.watch<ReceiverProvider>();

    // ১. ডাটাবেজ স্ট্রাকচার অনুযায়ী প্রোফাইল ডাটা বের করা
    final userData = auth.userData ?? {};
    final profile = userData['profile'] as Map<String, dynamic>? ?? {};

    // ২. ফিল্ড নেম ম্যাপিং (আপনার দেয়া ডাটাবেজ অনুযায়ী)
    final displayName = profile['contactPerson'] ?? profile['businessOrFullName'] ?? "User";
    final int points = profile['points'] ?? 0; // Firestore 'points' field
    final int totalReceives = profile['totalReceives'] ?? 0; // Firestore 'totalReceives' field

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.green,
          onRefresh: () async {
            await auth.fetchUserData();
            receiver.fetchAllPosts();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BaseScreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- হেডার সেকশন ---
                  HeaderSection(
                    name: displayName,
                    role: (auth.selectedRole ?? "Receiver").toUpperCase(),
                    notificationCount: auth.notificationCount,
                    noticicationOnActionTap: () {
                      auth.resetNotificationCount();
                      Navigator.pushNamed(context, ReceiverNotificationScreen.routeName);
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- ইনফো কার্ড সেকশন (রিয়েল-টাইম প্রোফাইল ডাটা) ---
                  InfoCardsSection(
                    title1: "Pending",
                    // রিসিভার প্রোভাইডার থেকে বর্তমানে কয়টি রিকোয়েস্ট পেন্ডিং তা দেখাচ্ছে
                    value1: receiver.pendingPosts.length,
                    color1: Colors.orange.shade400,

                    title2: "Received",
                    // ৩. স্ট্যাটিক ক্যালকুলেশন বাদ দিয়ে প্রোফাইল থেকে মোট রিসিভ সংখ্যা দেখাচ্ছে
                    value2: totalReceives,
                    color2: AppColor.green,

                    title3: "Points",
                    // ৪. সরাসরি ডাটাবেজের 'points' ফিল্ড থেকে ভ্যালু আসছে
                    value3: points,
                    color3: Colors.blue.shade400,
                  ),

                  const SizedBox(height: 30),

                  /// --- ট্যাব সেকশন (Activities) ---
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: ReceiverTabSection(),
                  ),

                  const SizedBox(height: 25),

                  /// --- রিসেন্ট পোস্ট সেকশন ---
                  const ReceiverRecentSection(),

                  /// --- FAQ SECTION ---
                  FaqSection(faqs: faqList),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}