import 'package:flutter/material.dart';

import '../../../../app/app_theme.dart';
import '../../../../core/constants/app_colors.dart';
class MyPostsTabSection extends StatelessWidget {
  final TabController tabController;

  const MyPostsTabSection({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: tabController,
          labelColor: AppColor.green,
          unselectedLabelColor: AppColor.black,
          indicatorColor: AppColor.lightGreen,
          tabs: const [
            Tab(text: "My Post"),
            Tab(text: "Receivers Requests"),
          ],
        ),
        SizedBox(
          height: 200,
          child: TabBarView(
            controller: tabController,
            children: [
              SingleChildScrollView(
                child: Card(
                  // color: AppColor.soft_green,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Nothing till now",
                          style: AppData.heading2.copyWith(
                            color: AppColor.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Divider(
                          thickness: 1,
                          color: AppColor.black.withOpacity(0.5),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Do You Have Some food to donate?",
                          style: AppData.heading2,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.add, color: AppColor.white,),
                          label: Text(
                            "Create Donation Post",
                            style: AppData.heading2.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    "Receivers Requests Content Here",
                    style: AppData.heading3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}