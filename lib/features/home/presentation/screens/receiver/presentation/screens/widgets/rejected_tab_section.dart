import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // নিশ্চিত করুন এই ইমপোর্টটি আছে
import '../../provider/receiver_provider.dart';

class RejectedTab extends StatefulWidget {
  const RejectedTab({super.key});

  @override
  State<RejectedTab> createState() => _RejectedTabState();
}

class _RejectedTabState extends State<RejectedTab> {
  @override
  void initState() {
    super.initState();
    // স্ক্রিন লোড হওয়ার সময় ডাটা রিফ্রেশ করার জন্য
    Future.microtask(() => context.read<ReceiverProvider>().fetchAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiverProvider>(
      builder: (context, provider, child) {
        final posts = provider.rejectedPosts;

        if (posts.isEmpty) {
          return const Center(
            child: Text(
              "No rejected requests found",
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
              color: Colors.red.shade50, // রিজেক্টেড এর জন্য হালকা লাল ব্যাকগ্রাউন্ড
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.red.shade100),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.white,
                    child: post.imageUrls.isNotEmpty
                        ? Image.network(
                      post.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, color: Colors.red),
                    )
                        : const Icon(Icons.cancel, color: Colors.red, size: 30),
                  ),
                ),
                title: Text(
                  post.foodName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "This request was declined by the donor.",
                    style: TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "REJECTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
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