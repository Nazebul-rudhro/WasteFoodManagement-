// // import 'package:flutter/material.dart';
// // import '../../../auth/data/model/ngo_model.dart';
// // import '../widgets/ngo_card.dart';
// //
// // class GenericDonorList extends StatelessWidget {
// //   GenericDonorList({super.key});
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       itemCount: ngoList.length,
// //       itemBuilder: (context, index) {
// //         final ngo = ngoList[index];
// //         return NGOCard(
// //           ngo: ngo,
// //           onViewDetails: () => print("View details ${ngo.name}"),
// //           onDonate: () => print("Donate to ${ngo.name}"),
// //         );
// //       },
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../auth/data/model/post_model.dart';
// import '../widgets/post_card.dart';
//
// class GenericDonorList extends StatelessWidget {
//   const GenericDonorList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .orderBy('createdAt', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(
//             child: Text("কোনো খাবারের পোস্ট পাওয়া যায়নি"),
//           );
//         }
//
//         final posts = snapshot.data!.docs
//             .map((doc) => PostModel.fromSnapshot(doc))
//             .toList();
//
//         return ListView.builder(
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             return PostCard(post: posts[index]);
//           },
//         );
//       },
//     );
//   }
// }


//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../auth/data/model/post_model.dart';
// import '../widgets/post_card.dart';
//
// class GenericDonorList extends StatelessWidget {
//   const GenericDonorList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       // 1. Basic query without ordering to ensure it doesn't fail on indexing
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .where('status', isEqualTo: 'available')
//           .snapshots(),
//       builder: (context, snapshot) {
//         // 2. Handle connection states
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         // 3. Catch Firestore specific errors
//         if (snapshot.hasError) {
//           return Center(child: Text("Firebase Error: ${snapshot.error}"));
//         }
//
//         // 4. Check if data exists
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text("No available food posts found."));
//         }
//
//         // 5. Safe Mapping using a Try-Catch block
//         try {
//           final posts = snapshot.data!.docs.map((doc) {
//             // Check if data is null before passing to model
//             if (doc.data() == null) {
//               throw Exception("Document data is null for ID: ${doc.id}");
//             }
//             return PostModel.fromSnapshot(doc);
//           }).toList();
//
//           return ListView.builder(
//             itemCount: posts.length,
//             padding: const EdgeInsets.all(8),
//             itemBuilder: (context, index) {
//               return PostCard(post: posts[index]);
//             },
//           );
//         } catch (e) {
//           // This captures Mapping errors (e.g., missing fields in Firestore)
//           debugPrint("Mapping Error details: $e");
//           return Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Data Error: Some fields are missing in Firestore or Model mismatch.\n\nError: $e",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             ),
//           );
//         }
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
      // Added ordering back for a professional look.
      // Ensure the Index is "Enabled" in Firebase console.
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('status', isEqualTo: 'available')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint("GenericList Error: ${snapshot.error}");
          return Center(child: Text("Error: Check Firestore Indexing or Rules."));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No available food posts found."));
        }

        // Safe Parsing Loop: Prevents the screen from breaking if 1 document is bad
        final List<PostModel> validPosts = [];
        for (var doc in snapshot.data!.docs) {
          try {
            validPosts.add(PostModel.fromSnapshot(doc));
          } catch (e) {
            debugPrint("Skipping broken post ${doc.id}: $e");
          }
        }

        if (validPosts.isEmpty) {
          return const Center(child: Text("Posts found, but data formatting is incorrect."));
        }

        return ListView.builder(
          itemCount: validPosts.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            return PostCard(post: validPosts[index]);
          },
        );
      },
    );
  }
}