// // // // // import 'package:flutter/material.dart';
// // // // // import '../../../auth/data/model/ngo_model.dart';
// // // // // import '../widgets/ngo_card.dart';
// // // // //
// // // // // class GenericDonorList extends StatelessWidget {
// // // // //   GenericDonorList({super.key});
// // // // //
// // // // //
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return ListView.builder(
// // // // //       padding: const EdgeInsets.symmetric(vertical: 8),
// // // // //       itemCount: ngoList.length,
// // // // //       itemBuilder: (context, index) {
// // // // //         final ngo = ngoList[index];
// // // // //         return NGOCard(
// // // // //           ngo: ngo,
// // // // //           onViewDetails: () => print("View details ${ngo.name}"),
// // // // //           onDonate: () => print("Donate to ${ngo.name}"),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../../../auth/data/model/post_model.dart';
// // // // import '../widgets/post_card.dart';
// // // //
// // // // class GenericDonorList extends StatelessWidget {
// // // //   const GenericDonorList({super.key});
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return StreamBuilder<QuerySnapshot>(
// // // //       stream: FirebaseFirestore.instance
// // // //           .collection('posts')
// // // //           .orderBy('createdAt', descending: true)
// // // //           .snapshots(),
// // // //       builder: (context, snapshot) {
// // // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }
// // // //
// // // //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // //           return const Center(
// // // //             child: Text("কোনো খাবারের পোস্ট পাওয়া যায়নি"),
// // // //           );
// // // //         }
// // // //
// // // //         final posts = snapshot.data!.docs
// // // //             .map((doc) => PostModel.fromSnapshot(doc))
// // // //             .toList();
// // // //
// // // //         return ListView.builder(
// // // //           itemCount: posts.length,
// // // //           itemBuilder: (context, index) {
// // // //             return PostCard(post: posts[index]);
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../../../auth/data/model/post_model.dart';
// // // // import '../widgets/post_card.dart';
// // // //
// // // // class GenericDonorList extends StatelessWidget {
// // // //   const GenericDonorList({super.key});
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return StreamBuilder<QuerySnapshot>(
// // // //       // 1. Basic query without ordering to ensure it doesn't fail on indexing
// // // //       stream: FirebaseFirestore.instance
// // // //           .collection('posts')
// // // //           .where('status', isEqualTo: 'available')
// // // //           .snapshots(),
// // // //       builder: (context, snapshot) {
// // // //         // 2. Handle connection states
// // // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }
// // // //
// // // //         // 3. Catch Firestore specific errors
// // // //         if (snapshot.hasError) {
// // // //           return Center(child: Text("Firebase Error: ${snapshot.error}"));
// // // //         }
// // // //
// // // //         // 4. Check if data exists
// // // //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // //           return const Center(child: Text("No available food posts found."));
// // // //         }
// // // //
// // // //         // 5. Safe Mapping using a Try-Catch block
// // // //         try {
// // // //           final posts = snapshot.data!.docs.map((doc) {
// // // //             // Check if data is null before passing to model
// // // //             if (doc.data() == null) {
// // // //               throw Exception("Document data is null for ID: ${doc.id}");
// // // //             }
// // // //             return PostModel.fromSnapshot(doc);
// // // //           }).toList();
// // // //
// // // //           return ListView.builder(
// // // //             itemCount: posts.length,
// // // //             padding: const EdgeInsets.all(8),
// // // //             itemBuilder: (context, index) {
// // // //               return PostCard(post: posts[index]);
// // // //             },
// // // //           );
// // // //         } catch (e) {
// // // //           // This captures Mapping errors (e.g., missing fields in Firestore)
// // // //           debugPrint("Mapping Error details: $e");
// // // //           return Center(
// // // //             child: Padding(
// // // //               padding: const EdgeInsets.all(16.0),
// // // //               child: Text(
// // // //                 "Data Error: Some fields are missing in Firestore or Model mismatch.\n\nError: $e",
// // // //                 textAlign: TextAlign.center,
// // // //                 style: const TextStyle(color: Colors.red),
// // // //               ),
// // // //             ),
// // // //           );
// // // //         }
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // //
// // // // import 'package:flutter/material.dart';
// // // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // // import '../../../auth/data/model/post_model.dart';
// // // // import '../widgets/post_card.dart';
// // // //
// // // // class GenericDonorList extends StatelessWidget {
// // // //   const GenericDonorList({super.key});
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return StreamBuilder<QuerySnapshot>(
// // // //       // Added ordering back for a professional look.
// // // //       // Ensure the Index is "Enabled" in Firebase console.
// // // //       stream: FirebaseFirestore.instance
// // // //           .collection('posts')
// // // //           .where('status', isEqualTo: 'available')
// // // //           .orderBy('createdAt', descending: true)
// // // //           .snapshots(),
// // // //       builder: (context, snapshot) {
// // // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // // //           return const Center(child: CircularProgressIndicator());
// // // //         }
// // // //
// // // //         if (snapshot.hasError) {
// // // //           debugPrint("GenericList Error: ${snapshot.error}");
// // // //           return Center(child: Text("Error: Check Firestore Indexing or Rules."));
// // // //         }
// // // //
// // // //         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
// // // //           return const Center(child: Text("No available food posts found."));
// // // //         }
// // // //
// // // //         // Safe Parsing Loop: Prevents the screen from breaking if 1 document is bad
// // // //         final List<PostModel> validPosts = [];
// // // //         for (var doc in snapshot.data!.docs) {
// // // //           try {
// // // //             validPosts.add(PostModel.fromSnapshot(doc));
// // // //           } catch (e) {
// // // //             debugPrint("Skipping broken post ${doc.id}: $e");
// // // //           }
// // // //         }
// // // //
// // // //         if (validPosts.isEmpty) {
// // // //           return const Center(child: Text("Posts found, but data formatting is incorrect."));
// // // //         }
// // // //
// // // //         return ListView.builder(
// // // //           itemCount: validPosts.length,
// // // //           padding: const EdgeInsets.all(8),
// // // //           itemBuilder: (context, index) {
// // // //             return PostCard(post: validPosts[index]);
// // // //           },
// // // //         );
// // // //       },
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:flutter/material.dart';
// // // import '../../../auth/data/model/post_model.dart';
// // // import '../widgets/post_card.dart';
// // //
// // // class GenericDonorList extends StatelessWidget {
// // //   const GenericDonorList({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return StreamBuilder<QuerySnapshot>(
// // //       stream: FirebaseFirestore.instance
// // //           .collection('posts')
// // //           .where('status', isEqualTo: 'available')
// // //           .orderBy('createdAt', descending: true)
// // //           .snapshots(),
// // //       builder: (context, snapshot) {
// // //         if (snapshot.connectionState == ConnectionState.waiting) {
// // //           return const Center(child: CircularProgressIndicator(color: Colors.green));
// // //         }
// // //
// // //         if (snapshot.hasError) {
// // //           return const Center(child: Text("Unable to load posts. Please try again later."));
// // //         }
// // //
// // //         final docs = snapshot.data?.docs ?? [];
// // //         if (docs.isEmpty) {
// // //           return _buildEmptyState();
// // //         }
// // //
// // //         // Safe Parsing
// // //         final List<PostModel> validPosts = docs.map((doc) {
// // //           try {
// // //             return PostModel.fromSnapshot(doc);
// // //           } catch (e) {
// // //             return null;
// // //           }
// // //         }).whereType<PostModel>().toList();
// // //
// // //         return ListView.separated(
// // //           itemCount: validPosts.length,
// // //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// // //           separatorBuilder: (context, index) => const SizedBox(height: 16),
// // //           itemBuilder: (context, index) {
// // //             return PostCard(post: validPosts[index]);
// // //           },
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   Widget _buildEmptyState() {
// // //     return Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.fastfood_outlined, size: 80, color: Colors.grey.shade300),
// // //           const SizedBox(height: 16),
// // //           const Text("No active donations nearby",
// // //               style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import '../../../auth/data/model/post_model.dart';
// // import '../widgets/post_card.dart';
// //
// // class GenericDonorList extends StatelessWidget {
// //   const GenericDonorList({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       // Firestore থেকে শুধুমাত্র এভেইলঅ্যাবল পোস্টগুলো ফিল্টার করে আনা হচ্ছে
// //       stream: FirebaseFirestore.instance
// //           .collection('posts')
// //           .where('status', isEqualTo: 'available')
// //           .orderBy('createdAt', descending: true)
// //           .snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator(color: Colors.green));
// //         }
// //
// //         if (snapshot.hasError) {
// //           return const Center(child: Text("ডেটা লোড করতে সমস্যা হচ্ছে!"));
// //         }
// //
// //         final docs = snapshot.data?.docs ?? [];
// //         if (docs.isEmpty) {
// //           return _buildEmptyState();
// //         }
// //
// //         // নিরাপদভাবে ডাটা পার্সিং করা হচ্ছে
// //         final List<PostModel> validPosts = docs.map((doc) {
// //           try {
// //             return PostModel.fromSnapshot(doc);
// //           } catch (e) {
// //             return null;
// //           }
// //         }).whereType<PostModel>().toList();
// //
// //         return ListView.separated(
// //           itemCount: validPosts.length,
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
// //           separatorBuilder: (context, index) => const SizedBox(height: 16),
// //           itemBuilder: (context, index) {
// //             return PostCard(post: validPosts[index]);
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   // যদি ডাটাবেজে কোনো পোস্ট না থাকে
// //   Widget _buildEmptyState() {
// //     return Center(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Icon(Icons.no_food_outlined, size: 80, color: Colors.grey.shade300),
// //           const SizedBox(height: 16),
// //           const Text("এই মুহূর্তে কোনো দান পাওয়া যায়নি।",
// //               style: TextStyle(color: Colors.grey, fontSize: 16)),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
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
//       // Fetching available posts sorted by newest first
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .where('status', isEqualTo: 'available')
//           .orderBy('createdAt', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.green));
//         }
//
//         if (snapshot.hasError) {
//           return const Center(child: Text("Error: Unable to load data."));
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return _buildEmptyState();
//         }
//
//         // Safe data parsing to prevent crashes
//         final List<PostModel> validPosts = docs.map((doc) {
//           try {
//             return PostModel.fromSnapshot(doc);
//           } catch (e) {
//             return null;
//           }
//         }).whereType<PostModel>().toList();
//
//         return ListView.separated(
//           itemCount: validPosts.length,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           separatorBuilder: (context, index) => const SizedBox(height: 20),
//           itemBuilder: (context, index) {
//             return PostCard(post: validPosts[index]);
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.layers_clear_outlined, size: 80, color: Colors.grey.shade300),
//           const SizedBox(height: 16),
//           const Text("No active donations found",
//               style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500)),
//         ],
//       ),
//     );
//   }
// }



//
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
//       // 🔹 FILTER: Show only 'available' posts where Expiry > NOW
//       stream: FirebaseFirestore.instance
//           .collection('posts')
//           .where('status', isEqualTo: 'available')
//           .where('expiryDate', isGreaterThan: Timestamp.now())
//           .orderBy('expiryDate', descending: false)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.green));
//         }
//
//         if (snapshot.hasError) {
//           debugPrint("Error: ${snapshot.error}");
//           // 🛑 This error occurs if you haven't created the Index yet.
//           return const Center(
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Text("Database is indexing... Please click the link in your Debug Console/Logs to enable filtering."),
//             ),
//           );
//         }
//
//         final docs = snapshot.data?.docs ?? [];
//         if (docs.isEmpty) {
//           return const Center(child: Text("No fresh food available at the moment."));
//         }
//
//         final validPosts = docs.map((doc) => PostModel.fromSnapshot(doc)).toList();
//
//         return ListView.separated(
//           itemCount: validPosts.length,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           separatorBuilder: (context, index) => const SizedBox(height: 20),
//           itemBuilder: (context, index) => PostCard(post: validPosts[index]),
//         );
//       },
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../auth/data/model/post_model.dart';
import '../widgets/post_card.dart';

class GenericDonorList extends StatelessWidget {
  const GenericDonorList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      // 🔹 লজিক: স্ট্যাটাস 'available' হতে হবে এবং expiryDate এখনকার সময়ের চেয়ে বেশি হতে হবে
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('status', isEqualTo: 'available')
          .where('expiryDate', isGreaterThan: Timestamp.now())
          .orderBy('expiryDate', descending: false) // যেটা আগে এক্সপায়ার হবে সেটা আগে দেখাবে
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }

        if (snapshot.hasError) {
          // 🛑 যদি এখানে "Loading" বা "Index Error" দেখায়, তবে কনসোলের লিঙ্কে ক্লিক করে Index Save করতে হবে
          debugPrint("Firestore Error: ${snapshot.error}");
          return const Center(child: Text("Database configuration in progress..."));
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(child: Text("No fresh food available at this moment."));
        }

        final List<PostModel> posts = docs.map((doc) => PostModel.fromSnapshot(doc)).toList();

        return ListView.separated(
          itemCount: posts.length,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) => PostCard(post: posts[index]),
        );
      },
    );
  }
}