// import 'package:flutter/material.dart';
//
// import '../../../auth/data/model/post_model.dart';
//
// class PostCard extends StatelessWidget {
//   final PostModel post;
//   const PostCard({super.key, required this.post});
//
//   String _calculateTimeLeft(DateTime? expiry) {
//     if (expiry == null) return "N/A";
//     final diff = expiry.difference(DateTime.now());
//     if (diff.isNegative) return "Expired";
//     if (diff.inDays > 0) return "${diff.inDays}d left";
//     if (diff.inHours > 0) return "${diff.inHours}h left";
//     return "${diff.inMinutes}m left";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ইমেজ এবং স্ট্যাটাস ব্যাজ
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                 child: post.imageUrls.isNotEmpty
//                     ? Image.network(post.imageUrls.first, height: 180, width: double.infinity, fit: BoxFit.cover)
//                     : Container(height: 180, color: Colors.grey[200], child: const Icon(Icons.fastfood, size: 50)),
//               ),
//               Positioned(
//                 top: 10, left: 10,
//                 child: _buildBadge("⚡ ${_calculateTimeLeft(post.expiryDate)}", Colors.redAccent),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(post.foodName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 _infoRow(Icons.scale_outlined, "Quantity: ${post.quantity}"),
//                 _infoRow(Icons.people_outline, "Serves: ${post.estimatePersons} people"),
//                 _infoRow(Icons.location_on_outlined, "Location: ${post.pickupAddress}"),
//                 const Divider(),
//                 Text("Note: ${post.description}", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
//       child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: Colors.grey),
//           const SizedBox(width: 8),
//           Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import '../../../auth/data/model/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  String _calculateTimeLeft(DateTime? expiry) {
    if (expiry == null) return "N/A";
    final diff = expiry.difference(DateTime.now());
    if (diff.isNegative) return "Expired";
    if (diff.inDays > 0) return "${diff.inDays}d left";
    if (diff.inHours > 0) return "${diff.inHours}h left";
    return "${diff.inMinutes}m left";
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 0 : 4,
      // 🟢 'backgroundColor' এর বদলে শুধু 'color' ব্যবহার করুন
      color: isDark ? Colors.grey[900] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isDark ? Colors.white10 : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: post.imageUrls.isNotEmpty
                    ? Image.network(
                  post.imageUrls.first,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: isDark ? Colors.white10 : Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                  ),
                )
                    : Container(
                  height: 180,
                  color: isDark ? Colors.white10 : Colors.grey[200],
                  child: Icon(Icons.fastfood, size: 50, color: AppColor.green.withOpacity(0.5)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: _buildBadge(
                  "⚡ ${_calculateTimeLeft(post.expiryDate)}",
                  _calculateTimeLeft(post.expiryDate) == "Expired"
                      ? Colors.redAccent
                      : AppColor.green,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.foodName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                _infoRow(Icons.scale_outlined, "Quantity: ${post.quantity}", isDark),
                _infoRow(Icons.people_outline, "Serves: ${post.estimatePersons} people", isDark),
                _infoRow(Icons.location_on_outlined, "Location: ${post.pickupAddress}", isDark),
                const SizedBox(height: 8),
                Divider(color: isDark ? Colors.white10 : Colors.grey[200]),
                const SizedBox(height: 4),
                Text(
                  "Note: ${post.description}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.grey[600],
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColor.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}