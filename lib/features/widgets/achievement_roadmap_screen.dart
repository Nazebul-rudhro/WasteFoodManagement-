import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart'; // আপনার প্রোজেক্টের পাথ অনুযায়ী

class AchievementRoadmapSheet extends StatelessWidget {
  final dynamic activityData;
  final String title;

  const AchievementRoadmapSheet({
    super.key,
    required this.activityData,
    this.title = "Achievement Journey",
  });

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // ডাটা হ্যান্ডেলিং
    final int currentActivity = (activityData is int) ? activityData : int.tryParse(activityData.toString()) ?? 0;

    final List<Map<String, dynamic>> milestones = [
      {"goal": 1, "title": "The Beginning", "reward": "10 Pts", "icon": Icons.star_border},
      {"goal": 5, "title": "Regular Member", "reward": "50 Pts", "icon": Icons.favorite_border},
      {"goal": 10, "title": "Active Member", "reward": "100 Pts", "icon": Icons.volunteer_activism},
      {"goal": 20, "title": "Rising Star", "reward": "200 Pts", "icon": Icons.trending_up},
      {"goal": 50, "title": "Community Pillar", "reward": "500 Pts", "icon": Icons.auto_awesome},
      {"goal": 100, "title": "Century Milestone", "reward": "1000 Pts", "icon": Icons.workspace_premium},
      {"goal": 250, "title": "Silver Badge", "reward": "2500 Pts", "icon": Icons.military_tech},
      {"goal": 500, "title": "Golden Hero", "reward": "5000 Pts", "icon": Icons.emoji_events},
      {"goal": 750, "title": "Legendary Status", "reward": "8000 Pts", "icon": Icons.auto_graph},
      {"goal": 1000, "title": "King of Charity", "reward": "10000 Pts", "icon": Icons.king_bed},
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        // ডার্ক মোডে AppColor.black বা dark variant ব্যবহার করতে পারেন
        color: isDark ? const Color(0xFF121212) : AppColor.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          // হ্যান্ডেল বার
          Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                  color: isDark ? AppColor.mediumtgray : AppColor.lightgray,
                  borderRadius: BorderRadius.circular(10)
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColor.white : AppColor.black,
                )
            ),
          ),
          Divider(height: 1, color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightgray),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: milestones.length,
              itemBuilder: (context, index) {
                final item = milestones[index];
                final int goal = item['goal'];
                final bool isUnlocked = currentActivity >= goal;

                return IntrinsicHeight(
                  child: Row(
                    children: [
                      // রোডম্যাপ লাইন ও আইকন
                      Column(
                        children: [
                          Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(
                              color: isUnlocked ? AppColor.green : AppColor.mediumtgray.withOpacity(0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                                isUnlocked ? Icons.check : Icons.lock,
                                size: 12,
                                color: AppColor.white
                            ),
                          ),
                          if (index != milestones.length - 1)
                            Expanded(
                                child: Container(
                                  width: 2,
                                  color: isUnlocked ? AppColor.green : AppColor.mediumtgray.withOpacity(0.2),
                                )
                            ),
                        ],
                      ),
                      const SizedBox(width: 15),
                      // মাইলস্টোন কার্ড
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? AppColor.green.withOpacity(isDark ? 0.12 : 0.05)
                                : (isDark ? AppColor.white.withOpacity(0.02) : AppColor.white),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: isUnlocked
                                    ? AppColor.green.withOpacity(0.4)
                                    : AppColor.lightgray.withOpacity(0.5)
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item['icon'],
                                color: isUnlocked ? AppColor.green : AppColor.mediumtgray,
                                size: 26,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? AppColor.white : AppColor.black,
                                        )
                                    ),
                                    Text(
                                        "Goal: $goal • Reward: ${item['reward']}",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: AppColor.mediumtgray
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              if (isUnlocked)
                                const Icon(Icons.verified, color: AppColor.green, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}