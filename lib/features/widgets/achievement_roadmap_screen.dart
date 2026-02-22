// import 'package:flutter/material.dart';
//
// class AchievementRoadmapSheet extends StatelessWidget {
//   final int currentActivity;
//
//   const AchievementRoadmapSheet({super.key, required this.currentActivity});
//
//   @override
//   Widget build(BuildContext context) {
//     // ১ থেকে ১০০০ মাইলস্টোনের লিস্ট
//     final List<Map<String, dynamic>> milestones = [
//       {"goal": 1, "title": "First Step", "reward": "10 Pts", "icon": Icons.star_border},
//       {"goal": 5, "title": "Helper", "reward": "50 Pts", "icon": Icons.favorite_border},
//       {"goal": 10, "title": "Contributor", "reward": "100 Pts", "icon": Icons.volunteer_activism},
//       {"goal": 20, "title": "Rising Star", "reward": "200 Pts", "icon": Icons.trending_up},
//       {"goal": 35, "title": "Steady Hand", "reward": "350 Pts", "icon": Icons.handshake_outlined},
//       {"goal": 50, "title": "Consistent", "reward": "500 Pts", "icon": Icons.auto_awesome},
//       {"goal": 75, "title": "Reliable", "reward": "750 Pts", "icon": Icons.verified_outlined},
//       {"goal": 100, "title": "Century Maker", "reward": "1000 Pts", "icon": Icons.workspace_premium},
//       {"goal": 150, "title": "Bronze Warrior", "reward": "1500 Pts", "icon": Icons.shield_outlined},
//       {"goal": 200, "title": "Silver Badge", "reward": "2000 Pts", "icon": Icons.military_tech},
//       {"goal": 250, "title": "Gold Member", "reward": "2500 Pts", "icon": Icons.stars},
//       {"goal": 300, "title": "Elite Volunteer", "reward": "3000 Pts", "icon": Icons.diamond_outlined},
//       {"goal": 400, "title": "Community Pillar", "reward": "4000 Pts", "icon": Icons.account_balance},
//       {"goal": 500, "title": "Half-Way Master", "reward": "5000 Pts", "icon": Icons.bolt},
//       {"goal": 600, "title": "Super Active", "reward": "6000 Pts", "icon": Icons.rocket_launch},
//       {"goal": 700, "title": "Unstoppable", "reward": "7000 Pts", "icon": Icons.speed},
//       {"goal": 800, "title": "Legendary Status", "reward": "8000 Pts", "icon": Icons.auto_graph},
//       {"goal": 900, "title": "Grand Master", "reward": "9000 Pts", "icon": Icons.castle},
//       {"goal": 950, "title": "Final Countdown", "reward": "9500 Pts", "icon": Icons.timer},
//       {"goal": 1000, "title": "King of Charity", "reward": "10000 Pts", "icon": Icons.king_bed},
//     ];
//
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 15),
//           Container(
//             width: 40,
//             height: 5,
//             decoration: BoxDecoration(
//               color: Colors.grey[300],
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Text(
//               "Journey to 1000 Tasks",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const Divider(height: 1),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               itemCount: milestones.length,
//               itemBuilder: (context, index) {
//                 final item = milestones[index];
//                 final int goal = item['goal'];
//                 final bool isUnlocked = currentActivity >= goal;
//                 final bool isLast = index == milestones.length - 1;
//
//                 return IntrinsicHeight(
//                   child: Row(
//                     children: [
//                       // Roadmap Line & Icon
//                       Column(
//                         children: [
//                           Container(
//                             width: 26,
//                             height: 26,
//                             decoration: BoxDecoration(
//                               color: isUnlocked ? Colors.green : Colors.grey.shade300,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               isUnlocked ? Icons.check : Icons.lock,
//                               size: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                           if (!isLast)
//                             Expanded(
//                               child: Container(
//                                 width: 2,
//                                 color: isUnlocked ? Colors.green : Colors.grey.shade300,
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(width: 15),
//                       // Milestone Card
//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 20),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: isUnlocked ? Colors.green.withOpacity(0.05) : Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(
//                               color: isUnlocked ? Colors.green.withOpacity(0.2) : Colors.grey.shade200,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.02),
//                                 blurRadius: 5,
//                               )
//                             ],
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(item['icon'],
//                                   color: isUnlocked ? Colors.green : Colors.grey.shade400,
//                                   size: 28),
//                               const SizedBox(width: 15),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       item['title'],
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: isUnlocked ? Colors.black87 : Colors.grey.shade600,
//                                       ),
//                                     ),
//                                     Text(
//                                       "Goal: $goal Activity • Reward: ${item['reward']}",
//                                       style: const TextStyle(fontSize: 10, color: Colors.grey),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               if (isUnlocked)
//                                 const Icon(Icons.verified, color: Colors.green, size: 18),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
//
//
// import 'package:flutter/material.dart';
//
// class AchievementRoadmapSheet extends StatelessWidget {
//   final int currentActivity; // এটি Donor, Receiver বা Volunteer সবার ভ্যালু গ্রহণ করবে
//   final String title; // ডাইনামিক টাইটেল (যেমন: "Donation Journey" বা "Task Journey")
//
//   const AchievementRoadmapSheet({
//     super.key,
//     required this.currentActivity,
//     this.title = "Achievement Journey",
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // মাইলস্টোন লিস্ট (সবার জন্য কমন গোল)
//     final List<Map<String, dynamic>> milestones = [
//       {"goal": 1, "title": "The Beginning", "reward": "10 Pts", "icon": Icons.star_border},
//       {"goal": 5, "title": "Regular Contributor", "reward": "50 Pts", "icon": Icons.favorite_border},
//       {"goal": 10, "title": "Active Member", "reward": "100 Pts", "icon": Icons.volunteer_activism},
//       {"goal": 20, "title": "Rising Star", "reward": "200 Pts", "icon": Icons.trending_up},
//       {"goal": 50, "title": "Community Pillar", "reward": "500 Pts", "icon": Icons.auto_awesome},
//       {"goal": 100, "title": "Century Milestone", "reward": "1000 Pts", "icon": Icons.workspace_premium},
//       {"goal": 250, "title": "Silver Badge", "reward": "2500 Pts", "icon": Icons.military_tech},
//       {"goal": 500, "title": "Golden Hero", "reward": "5000 Pts", "icon": Icons.emoji_events},
//       {"goal": 750, "title": "Legendary Status", "reward": "8000 Pts", "icon": Icons.auto_graph},
//       {"goal": 1000, "title": "King of Charity", "reward": "10000 Pts", "icon": Icons.king_bed},
//     ];
//
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 15),
//           Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           ),
//           const Divider(height: 1),
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               itemCount: milestones.length,
//               itemBuilder: (context, index) {
//                 final item = milestones[index];
//                 final int goal = item['goal'];
//                 final bool isUnlocked = currentActivity >= goal;
//                 final bool isLast = index == milestones.length - 1;
//
//                 return IntrinsicHeight(
//                   child: Row(
//                     children: [
//                       Column(
//                         children: [
//                           Container(
//                             width: 26, height: 26,
//                             decoration: BoxDecoration(
//                               color: isUnlocked ? Colors.green : Colors.grey.shade300,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(isUnlocked ? Icons.check : Icons.lock, size: 14, color: Colors.white),
//                           ),
//                           if (!isLast)
//                             Expanded(child: Container(width: 2, color: isUnlocked ? Colors.green : Colors.grey.shade300)),
//                         ],
//                       ),
//                       const SizedBox(width: 15),
//                       Expanded(
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 20),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: isUnlocked ? Colors.green.withOpacity(0.05) : Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             border: Border.all(color: isUnlocked ? Colors.green.withOpacity(0.2) : Colors.grey.shade200),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(item['icon'], color: isUnlocked ? Colors.green : Colors.grey.shade400, size: 28),
//                               const SizedBox(width: 15),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold, color: isUnlocked ? Colors.black87 : Colors.grey.shade600)),
//                                     Text("Goal: $goal • Reward: ${item['reward']}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
//                                   ],
//                                 ),
//                               ),
//                               if (isUnlocked) const Icon(Icons.verified, color: Colors.green, size: 18),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class AchievementRoadmapSheet extends StatelessWidget {
  final dynamic activityData; // এটি যে কোনো টাইপ ডাটা গ্রহণ করবে
  final String title;

  const AchievementRoadmapSheet({
    super.key,
    required this.activityData,
    this.title = "Achievement Journey",
  });

  @override
  Widget build(BuildContext context) {
    // ডাটা যদি null হয় বা সংখ্যা না হয়, তবে ০ ধরে নেবে
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
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
                      Column(
                        children: [
                          Container(
                            width: 24, height: 24,
                            decoration: BoxDecoration(
                              color: isUnlocked ? Colors.green : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(isUnlocked ? Icons.check : Icons.lock, size: 12, color: Colors.white),
                          ),
                          if (index != milestones.length - 1)
                            Expanded(child: Container(width: 2, color: isUnlocked ? Colors.green : Colors.grey.shade300)),
                        ],
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUnlocked ? Colors.green.withOpacity(0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: isUnlocked ? Colors.green.withOpacity(0.2) : Colors.grey.shade100),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
                          ),
                          child: Row(
                            children: [
                              Icon(item['icon'], color: isUnlocked ? Colors.green : Colors.grey.shade400),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title'], style: TextStyle(fontWeight: FontWeight.bold, color: isUnlocked ? Colors.black87 : Colors.grey)),
                                    Text("Goal: $goal • Reward: ${item['reward']}", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                  ],
                                ),
                              ),
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