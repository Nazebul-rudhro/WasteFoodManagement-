import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../provider/receiver_provider.dart';

class ReceiverAllPost extends StatefulWidget {
  const ReceiverAllPost({super.key});

  @override
  State<ReceiverAllPost> createState() => _ReceiverAllPostState();
}

class _ReceiverAllPostState extends State<ReceiverAllPost> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<ReceiverProvider>();
    provider.fetchAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.green,
        title: const Text(
          "All Food List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: BaseScreen(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  "কোনো খাবারের পোস্ট পাওয়া যায়নি",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              );
            }

            final posts = snapshot.data!.docs
                .map((doc) => PostModel.fromSnapshot(doc))
                .toList();

            return GridView.builder(
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemBuilder: (context, index) {
                final post = posts[index];
                final alreadyRequested = provider.myRequests.contains(post.postId);
                final isLoading = provider.isRequesting[post.postId] ?? false;

                return _buildPostCard(context, post, alreadyRequested, isLoading, provider);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post, bool alreadyRequested, bool isLoading, ReceiverProvider provider) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 110,
              width: double.infinity,
              color: Colors.grey[200],
              child: post.imageUrls.isNotEmpty
                  ? Image.network(post.imageUrls.first, fit: BoxFit.cover)
                  : const Center(
                child: Icon(Icons.fastfood, color: Colors.grey, size: 40),
              ),
            ),
          ),

          // Text info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.foodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  "Qty: ${post.quantity}",
                  style: const TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.grey),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        post.pickupAddress,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: Colors.grey),
                    const SizedBox(width: 3),
                    Text(
                      post.pickupTime,
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Button with per-post circular loading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alreadyRequested || isLoading ? Colors.grey : AppColor.green,
                  foregroundColor: alreadyRequested || isLoading ? AppColor.black : AppColor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: alreadyRequested || isLoading
                    ? null
                    : () async {
                  provider.setRequesting(post.postId, true); // start per-post loading
                  try {
                    await provider.sendRequest(post.postId, post.donorId);
                    provider.myRequests.add(post.postId);
                  } finally {
                    provider.setRequesting(post.postId, false); // stop per-post loading
                  }
                },
                child: isLoading
                    ?  SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(color: AppColor.green, strokeWidth: 2),
                )
                    : Text(alreadyRequested ? "Pending" : "Available", style: const TextStyle(fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
