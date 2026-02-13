import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/receiver_provider.dart';
import '../widgets/pending_tab_section.dart';
import '../widgets/approved_tab_section.dart';
import '../widgets/rejected_tab_section.dart';

class ReceiverTabSection extends StatefulWidget {
  const ReceiverTabSection({super.key});

  @override
  State<ReceiverTabSection> createState() => _ReceiverTabSectionState();
}

class _ReceiverTabSectionState extends State<ReceiverTabSection>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    /// 🔥 FETCH DATA HERE
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReceiverProvider>().fetchAllPosts();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.green,
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Approved"),
            Tab(text: "Rejected"),
          ],
        ),
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              const PendingTab(),
              ApprovedTab(),
              RejectedTab(),
            ],
          ),
        ),
      ],
    );
  }
}
