import 'package:flutter/material.dart';
import '../../../auth/data/model/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: post.imageUrls.isNotEmpty
                ? Image.network(
              post.imageUrls.first,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _imagePlaceholder(),
            )
                : _imagePlaceholder(),
          ),

          // 🔹 Details Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food name
                Text(
                  post.foodName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Info row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoItem(
                      icon: Icons.inventory_2_outlined,
                      text: post.quantity,
                    ),
                    _infoItem(
                      icon: Icons.schedule_outlined,
                      text: post.pickupTime,
                    ),
                    _infoItem(
                      icon: Icons.location_on_outlined,
                      text: post.pickupAddress,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Description
                Text(
                  post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 12),

                // Status chip
                Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(
                      post.status.toUpperCase(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: post.status == 'available'
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable info widget
  Widget _infoItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // 🔹 Image placeholder
  Widget _imagePlaceholder() {
    return Container(
      height: 160,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image_not_supported,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}

