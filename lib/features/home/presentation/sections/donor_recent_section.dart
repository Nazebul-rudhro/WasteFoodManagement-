import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../auth/data/model/post_model.dart';

class DonorRecentSection extends StatelessWidget {
  final VoidCallback onActionTap;

  const DonorRecentSection({super.key, required this.onActionTap});

  /// 🔹 Firestore stream for recent posts
  Stream<List<PostModel>> getRecentPosts() {
    return FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .limit(4)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => PostModel.fromSnapshot(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Donations",
              style: AppData.heading2,
            ),
            GestureDetector(
              onTap: onActionTap,
              child: Text(
                "See All",
                style: AppData.heading2.copyWith(color: AppColor.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// 🔹 Donation Grid
        StreamBuilder<List<PostModel>>(
          stream: getRecentPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "No recent donations",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }

            final posts = snapshot.data!;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.82,
              ),
              itemBuilder: (context, index) {
                return _buildPostCard(posts[index]);
              },
            );
          },
        ),
      ],
    );
  }

  /// 🔹 Post Card UI
  Widget _buildPostCard(PostModel post) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: post.imageUrls.isNotEmpty
                  ? Image.network(
                post.imageUrls.first,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
                  : _imagePlaceholder(),
            ),
          ),

          /// Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.foodName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Qty: ${post.quantity}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 📍 Address (Left)
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              post.pickupAddress,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 6),

                    /// ⏰ Pickup Time (Right)
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 12,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          post.pickupTime.isNotEmpty ? post.pickupTime : 'N/A',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey[100],
      child: const Center(
        child: Icon(Icons.fastfood, color: Colors.grey),
      ),
    );
  }
}
