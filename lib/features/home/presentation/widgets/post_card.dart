//
//
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Card(
//       elevation: isDark ? 0 : 4,
//       // 🟢 'backgroundColor' এর বদলে শুধু 'color' ব্যবহার করুন
//       color: isDark ? Colors.grey[900] : Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//         side: BorderSide(
//           color: isDark ? Colors.white10 : Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                 child: post.imageUrls.isNotEmpty
//                     ? Image.network(
//                   post.imageUrls.first,
//                   height: 180,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     height: 180,
//                     color: isDark ? Colors.white10 : Colors.grey[200],
//                     child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
//                   ),
//                 )
//                     : Container(
//                   height: 180,
//                   color: isDark ? Colors.white10 : Colors.grey[200],
//                   child: Icon(Icons.fastfood, size: 50, color: AppColor.green.withOpacity(0.5)),
//                 ),
//               ),
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: _buildBadge(
//                   "⚡ ${_calculateTimeLeft(post.expiryDate)}",
//                   _calculateTimeLeft(post.expiryDate) == "Expired"
//                       ? Colors.redAccent
//                       : AppColor.green,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post.foodName,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: isDark ? Colors.white : Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 _infoRow(Icons.scale_outlined, "Quantity: ${post.quantity}", isDark),
//                 _infoRow(Icons.people_outline, "Serves: ${post.estimatePersons} people", isDark),
//                 _infoRow(Icons.location_on_outlined, "Location: ${post.pickupAddress}", isDark),
//                 const SizedBox(height: 8),
//                 Divider(color: isDark ? Colors.white10 : Colors.grey[200]),
//                 const SizedBox(height: 4),
//                 Text(
//                   "Note: ${post.description}",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: isDark ? Colors.white54 : Colors.grey[600],
//                     fontSize: 13,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
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
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text, bool isDark) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: AppColor.green),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: isDark ? Colors.white70 : Colors.black54,
//               ),
//             ),
//           ),
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
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.width < 360; // ছোট ফোনের জন্য চেক

    final bool isVeg = (post.foodType ?? "").toLowerCase().contains("veg");
    final Color typeColor = isVeg ? Colors.green : Colors.redAccent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: isDark ? 0 : 3,
        clipBehavior: Clip.antiAlias,
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: isDark ? Colors.white10 : Colors.grey.shade100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // কন্টেন্ট অনুযায়ী হাইট নিবে
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- ইমেজ সেকশন (রেসপন্সিভ হাইট) ---
            Stack(
              children: [
                _buildImage(isSmallScreen ? 160 : 190, isDark),

                // বাম পাশের ব্যাজ
                Positioned(
                  top: 8, left: 8,
                  child: _buildBadge("⌛ ${_calculateTimeLeft(post.expiryDate)}", Colors.black87, isSmallScreen),
                ),

                // ডান পাশের ব্যাজ
                Positioned(
                  top: 8, right: 8,
                  child: _buildBadge(post.foodCondition ?? "Fresh", AppColor.green, isSmallScreen),
                ),
              ],
            ),

            // --- ডিটেইলস সেকশন ---
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 10 : 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // টাইটেল এবং টাইপ ট্যাগ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          post.foodName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      _buildTypeTag(post.foodType ?? "Food", typeColor, isSmallScreen),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // কোয়ান্টিটি এবং সার্ভিং (ছোট স্ক্রিনে পাশাপাশি সুন্দর দেখাবে)
                  Row(
                    children: [
                      Expanded(child: _infoItem(Icons.inventory_2_outlined, post.quantity, isDark, isSmallScreen)),
                      Expanded(child: _infoItem(Icons.people_outline, "${post.estimatePersons} prs", isDark, isSmallScreen)),
                    ],
                  ),

                  const SizedBox(height: 6),
                  _infoItem(Icons.location_on_outlined, post.pickupAddress, isDark, isSmallScreen),

                  const SizedBox(height: 6),
                  _infoItem(Icons.schedule_outlined, "Pickup: ${post.pickupTime}", isDark, isSmallScreen),

                  const Divider(height: 16, thickness: 0.5),

                  // নোট বা ডেসক্রিপশন
                  Text(
                    "Note: ${post.description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey[600],
                        fontSize: isSmallScreen ? 11 : 12,
                        height: 1.3
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double height, bool isDark) {
    return post.imageUrls.isNotEmpty
        ? Image.network(
      post.imageUrls.first,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(height, isDark),
    )
        : _placeholder(height, isDark);
  }

  Widget _infoItem(IconData icon, String text, bool isDark, bool isSmall) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: isSmall ? 13 : 15, color: AppColor.green),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: isSmall ? 11 : 13,
                color: isDark ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color, bool isSmall) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 6 : 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.9), borderRadius: BorderRadius.circular(6)),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: isSmall ? 8 : 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTypeTag(String text, Color color, bool isSmall) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: isSmall ? 9 : 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _placeholder(double height, bool isDark) {
    return Container(
      height: height, width: double.infinity,
      color: isDark ? Colors.white10 : Colors.grey[100],
      child: const Icon(Icons.fastfood_outlined, size: 30, color: Colors.grey),
    );
  }
}