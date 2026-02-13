// import 'package:flutter/material.dart';
// import '../../../auth/data/model/ngo_model.dart';
// import '../widgets/ngo_card.dart';
//
// class GenericDonorList extends StatelessWidget {
//   GenericDonorList({super.key});
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       itemCount: ngoList.length,
//       itemBuilder: (context, index) {
//         final ngo = ngoList[index];
//         return NGOCard(
//           ngo: ngo,
//           onViewDetails: () => print("View details ${ngo.name}"),
//           onDonate: () => print("Donate to ${ngo.name}"),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../auth/data/model/post_model.dart';
import '../widgets/post_card.dart';

class GenericDonorList extends StatelessWidget {
  const GenericDonorList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("কোনো খাবারের পোস্ট পাওয়া যায়নি"),
          );
        }

        final posts = snapshot.data!.docs
            .map((doc) => PostModel.fromSnapshot(doc))
            .toList();

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: posts[index]);
          },
        );
      },
    );
  }
}
