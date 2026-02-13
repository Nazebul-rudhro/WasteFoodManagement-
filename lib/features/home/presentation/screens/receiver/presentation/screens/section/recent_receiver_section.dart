import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/section/receiver_all_post.dart';
import '../../../../../../../../app/app_theme.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../auth/data/model/post_model.dart';
import '../../../../donor/presentation/screens/food_donation_list_screen.dart';
import '../../provider/receiver_provider.dart';

class ReceiverRecentSection extends StatelessWidget {
  const ReceiverRecentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReceiverProvider>();
    final recentPosts = provider.allPosts.take(4).toList();

    if (recentPosts.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text("No recent donations", style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Donations", style: AppData.heading2),
            GestureDetector(
              onTap: () {
                Navigator.push(context, AppRoutes.smooth(ReceiverAllPost()));
              },
              child: Text(
                "See All",
                style: AppData.heading2.copyWith(color: AppColor.green),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        /// 2x2 Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentPosts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final post = recentPosts[index];
            final alreadyRequested = provider.myRequests.contains(post.postId);
            final isLoading = provider.isRequesting[post.postId] ?? false;

            return _buildPostCard(context, post, alreadyRequested, isLoading);
          },
        ),
      ],
    );
  }

  Widget _buildPostCard(BuildContext context, PostModel post, bool alreadyRequested, bool isLoading) {
    final provider = context.read<ReceiverProvider>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: post.imageUrls.isNotEmpty
                  ? DecorationImage(
                image: NetworkImage(post.imageUrls.first),
                fit: BoxFit.cover,
              )
                  : null,
              color: Colors.grey[200],
            ),
            child: post.imageUrls.isEmpty
                ? const Center(child: Icon(Icons.fastfood, color: Colors.grey))
                : null,
          ),

          /// Text Info
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(width: 2),
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
                    const SizedBox(width: 2),
                    Text(post.pickupTime, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),

          /// Available Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: alreadyRequested || isLoading ? Colors.grey : AppColor.green,
                  foregroundColor:  alreadyRequested || isLoading ? Colors.black : AppColor.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                ),
                onPressed: alreadyRequested || isLoading
                    ? null
                    : () async {
                  provider.setRequesting(post.postId, true);
                  try {
                    await provider.sendRequest(post.postId, post.donorId);
                  } finally {
                    provider.setRequesting(post.postId, false);
                  }
                },
                child: isLoading
                    ?  SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: AppColor.green,
                    strokeWidth: 2,
                  ),
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
