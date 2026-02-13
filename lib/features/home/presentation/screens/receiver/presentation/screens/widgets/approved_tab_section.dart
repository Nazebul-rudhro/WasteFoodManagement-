import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // এই ইমপোর্টটি মিসিং ছিল
import '../../provider/receiver_provider.dart';

class ApprovedTab extends StatelessWidget {
  const ApprovedTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer এর আগে অবশ্যই provider প্যাকেজ ইমপোর্ট থাকতে হবে
    return Consumer<ReceiverProvider>(
      builder: (context, provider, child) {
        final posts = provider.approvedPosts;

        if (posts.isEmpty) {
          return const Center(
            child: Text(
              "No approved food found",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return Card(
              color: Colors.green.shade50,
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 55,
                    height: 55,
                    color: Colors.white,
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(
                      post.imageUrls.first,
                      fit: BoxFit.cover,
                      // ইমেজ লোড হতে সমস্যা হলে এরর হ্যান্ডলিং
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.fastfood, color: Colors.green),
                    )
                        : const Icon(Icons.check_circle, color: Colors.green, size: 30),
                  ),
                ),
                title: Text(
                  post.foodName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Qty: ${post.quantity}"),
                      Text("Pickup: ${post.pickupTime}", style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "APPROVED",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}