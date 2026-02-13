// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../provider/receiver_provider.dart';
//
// class PendingTab extends StatefulWidget {
//   const PendingTab({super.key});
//
//   @override
//   State<PendingTab> createState() => _PendingTabState();
// }
//
// class _PendingTabState extends State<PendingTab> {
//   @override
//   void initState() {
//     super.initState();
//     // স্ক্রিন লোড হওয়ার সময় ডেটা রিফ্রেশ করা
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ReceiverProvider>().fetchAllPosts();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: Colors.green));
//         }
//
//         final posts = provider.pendingPosts;
//
//         if (posts.isEmpty) {
//           return const Center(
//             child: Text(
//               "আপনি এখনও কোনো রিকোয়েস্ট করেননি",
//               style: TextStyle(color: Colors.grey),
//             ),
//           );
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               elevation: 2,
//               child: ListTile(
//                 contentPadding: const EdgeInsets.all(10),
//                 leading: ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     width: 60,
//                     height: 60,
//                     color: Colors.grey[200],
//                     child: post.imageUrls.isNotEmpty
//                         ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
//                         : const Icon(Icons.fastfood, color: Colors.grey),
//                   ),
//                 ),
//                 title: Text(
//                   post.foodName,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 4),
//                     Text("Qty: ${post.quantity}"),
//                     Text("Address: ${post.pickupAddress}", maxLines: 1, overflow: TextOverflow.ellipsis),
//                   ],
//                 ),
//                 trailing: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: const Text(
//                         "PENDING",
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/receiver_provider.dart';

class PendingTab extends StatefulWidget {
  const PendingTab({super.key});

  @override
  State<PendingTab> createState() => _PendingTabState();
}

class _PendingTabState extends State<PendingTab> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) return const Center(child: CircularProgressIndicator(color: Colors.green));

        final posts = provider.pendingPosts;

        if (posts.isEmpty) return const Center(child: Text("No pending requests found", style: TextStyle(color: Colors.grey)));

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 60, height: 60, color: Colors.grey[200],
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(post.imageUrls.first, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: Colors.grey))
                        : const Icon(Icons.fastfood, color: Colors.grey),
                  ),
                ),
                title: Text(post.foodName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Qty: ${post.quantity}\nAddr: ${post.pickupAddress}", maxLines: 2),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                  child: const Text("PENDING", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
              ),
            );
          },
        );
      },
    );
  }
}