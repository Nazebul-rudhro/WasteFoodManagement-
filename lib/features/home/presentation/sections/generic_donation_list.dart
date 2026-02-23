// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../../auth/data/model/post_model.dart';
// import '../widgets/post_card.dart';
//
// class GenericDonorList extends StatelessWidget {
//   const GenericDonorList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       // 🔹 লজিক: স্ট্যাটাস 'available' হতে হবে এবং expiryDate এখনকার সময়ের চেয়ে বেশি হতে হবে
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .where('status', isEqualTo: 'available')
//           .where('expiryDate', isGreaterThan: Timestamp.now())
//           .orderBy('expiryDate', descending: false) // যেটা আগে এক্সপায়ার হবে সেটা আগে দেখাবে
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.green));
//         }
//
//         if (snapshot.hasError) {
//           // 🛑 যদি এখানে "Loading" বা "Index Error" দেখায়, তবে কনসোলের লিঙ্কে ক্লিক করে Index Save করতে হবে
//           debugPrint("Firestore Error: ${snapshot.error}");
//           return const Center(child: Text("Database configuration in progress..."));
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return const Center(child: Text("No fresh food available at this moment."));
//         }
//
//         final List<PostModel> posts = docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//
//         return ListView.separated(
//           itemCount: posts.length,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           separatorBuilder: (context, index) => const SizedBox(height: 16),
//           itemBuilder: (context, index) => PostCard(post: posts[index]),
//         );
//       },
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart'; // AppColor ইম্পোর্ট করা হয়েছে
import '../../../auth/data/model/post_model.dart';
import '../widgets/post_card.dart';

class GenericDonorList extends StatelessWidget {
  const GenericDonorList({super.key});

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক করার জন্য লজিক
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('status', isEqualTo: 'available')
          .where('expiryDate', isGreaterThan: Timestamp.now())
          .orderBy('expiryDate', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColor.green),
          );
        }

        if (snapshot.hasError) {
          debugPrint("Firestore Error: ${snapshot.error}");
          return Center(
            child: Text(
              "Database configuration in progress...",
              style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.no_food_outlined,
                  size: 60,
                  color: isDark ? Colors.white24 : Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  "No fresh food available at this moment.",
                  style: TextStyle(
                    color: isDark ? Colors.white38 : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        final List<PostModel> posts =
        docs.map((doc) => PostModel.fromSnapshot(doc)).toList();

        return ListView.separated(
          itemCount: posts.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          physics: const BouncingScrollPhysics(), // স্মুথ স্ক্রলিং এর জন্য
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => PostCard(post: posts[index]),
        );
      },
    );
  }
}