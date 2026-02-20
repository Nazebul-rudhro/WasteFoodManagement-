import 'package:flutter/material.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../widgets/pending_tab_section.dart';
import '../widgets/approved_tab_section.dart';
import '../widgets/rejected_tab_section.dart';
//
// class ReceiverTabSection extends StatefulWidget {
//   const ReceiverTabSection({super.key});
//
//   @override
//   State<ReceiverTabSection> createState() => _ReceiverTabSectionState();
// }
//
// class _ReceiverTabSectionState extends State<ReceiverTabSection>
//     with TickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _tabController = TabController(length: 3, vsync: this);
//
//     /// 🔥 FETCH DATA HERE
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ReceiverProvider>().fetchAllPosts();
//     });
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
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabAlignment: TabAlignment.start,
//           isScrollable: true,
//           labelColor: Colors.green,
//           unselectedLabelColor: Colors.black,
//           indicatorColor: Colors.green,
//           tabs: const [
//             Tab(text: "Pending"),
//             Tab(text: "Approved"),
//             Tab(text: "Rejected"),
//           ],
//         ),
//         SizedBox(
//           height: 400,
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               const PendingTab(),
//               ApprovedTab(),
//               RejectedTab(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }



class ReceiverTabSection extends StatefulWidget {
  const ReceiverTabSection({super.key});
  @override
  State<ReceiverTabSection> createState() => _ReceiverTabSectionState();
}

class _ReceiverTabSectionState extends State<ReceiverTabSection> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColor.green,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColor.green,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 380, // 🔹 ফিক্সড হাইট যাতে স্ক্রল স্মুথ থাকে
          child: TabBarView(
            controller: _tabController,
            children: const [
              PendingTab(),
              ApprovedTab(),
              RejectedTab(),
            ],
          ),
        ),
      ],
    );
  }
}