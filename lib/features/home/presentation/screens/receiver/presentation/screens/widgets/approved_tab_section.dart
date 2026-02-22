//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../../../core/constants/app_colors.dart';
// import '../../provider/receiver_provider.dart';
//
// class ApprovedTab extends StatelessWidget {
//   const ApprovedTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.green));
//         }
//
//         final requests = provider.approvedPosts;
//
//         if (requests.isEmpty) {
//           return _buildEmptyState("No approved donations yet");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final post = requests[index];
//
//             // 🔹 সরাসরি requests কালেকশনের ডাটা
//             final String donorStatus = post.status.toLowerCase(); // delivered, approved
//             final String dStatus = post.deliveryStatus.toLowerCase(); // pending, ongoing, completed
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   Shadows.softShadow, // আপনার কাস্টম শ্যাডো থাকলে সেটি দিন বা নিচেরটা রাখুন
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildLeadingImage(post.imageUrls, dStatus),
//                     const SizedBox(width: 15),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   post.foodName,
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                                 ),
//                               ),
//                               // ✅ Donor Status ব্যাজ (সরাসরি status ফিল্ডের ডাটা)
//                               Row(
//                                 children: [
//                                   const Text(
//                                     "Donor Status: ",
//                                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey),
//                                   ),
//                                   _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//
//                           // 🔹 Donor Info
//                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5)}..."),
//
//                           // 🔹 Delivery Status Row (Pending এবং Delivered কালার হ্যান্ডেল করা হয়েছে)
//                           _infoRow(
//                             _getStatusIcon(dStatus),
//                             "Delivery: ${dStatus.toUpperCase()}",
//                             color: _getStatusColor(dStatus),
//                             isBold: true,
//                           ),
//
//                           const SizedBox(height: 5),
//                           _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
//                           _infoRow(Icons.location_on_outlined, post.pickupAddress),
//                         ],
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
//
//   // --- Helpers ---
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'delivered':
//       case 'completed':
//         return Colors.green; // ডেলিভারি হলে সবুজ
//       case 'ongoing':
//         return Colors.orange; // রাস্তায় থাকলে কমলা
//       case 'pending':
//         return Colors.blueGrey; // পেন্ডিং থাকলে নীলচে ধূসর (যাতে আলাদা বোঝা যায়)
//       case 'approved':
//         return Colors.blue;
//       default:
//         return AppColor.green;
//     }
//   }
//
//   IconData _getStatusIcon(String status) {
//     if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
//     if (status == "ongoing") return Icons.motorcycle;
//     return Icons.timer_outlined; // Pending এর জন্য টাইমার আইকন
//   }
//
//   Widget _buildBadge(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.12),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
//       ),
//     );
//   }
//
//   Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: color ?? Colors.grey.shade600,
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeadingImage(List<String> urls, String status) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Stack(
//         children: [
//           Container(
//             width: 80, height: 80, color: Colors.grey.shade100,
//             child: urls.isNotEmpty
//                 ? Image.network(
//               urls.first,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
//             )
//                 : const Icon(Icons.fastfood, color: Colors.grey),
//           ),
//           if (status == "ongoing")
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.2),
//                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String msg) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
//           const SizedBox(height: 10),
//           Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
//         ],
//       ),
//     );
//   }
// }
//
// // শ্যাডো এর জন্য একটি সিম্পল ক্লাস (যদি না থাকে)
// class Shadows {
//   static BoxShadow softShadow = BoxShadow(
//     color: Colors.black.withOpacity(0.04),
//     blurRadius: 10,
//     offset: const Offset(0, 4),
//   );
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../provider/receiver_provider.dart';

class ApprovedTab extends StatelessWidget {
  const ApprovedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.green));
        }

        // provider theke sorting kora list-ti eikhane ashbe
        final requests = provider.approvedPosts;

        if (requests.isEmpty) {
          return _buildEmptyState("No approved donations yet");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final post = requests[index];

            final String donorStatus = post.status.toLowerCase();
            final String dStatus = post.deliveryStatus.toLowerCase();

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLeadingImage(post.imageUrls, dStatus),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  post.foodName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                              ),
                              _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // ১. ডেলিভারি স্ট্যাটাস (Sorting validation er jonno priority dewa hoyeche)
                          _infoRow(
                            _getStatusIcon(dStatus),
                            "Delivery: ${dStatus.toUpperCase()}",
                            color: _getStatusColor(dStatus),
                            isBold: true,
                          ),

                          const SizedBox(height: 5),

                          // ২. ডোনার আইডি এবং অন্যান্য ডিটেইলস
                          _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5).toUpperCase()}..."),
                          _infoRow(Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
                          _infoRow(Icons.location_on_outlined, post.pickupAddress),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- Helpers ---

  Color _getStatusColor(String status) {
    switch (status) {
      case 'delivered':
      case 'completed':
        return Colors.green;
      case 'ongoing':
        return Colors.orange;
      case 'pending':
        return Colors.blueGrey;
      case 'approved':
        return Colors.blue;
      default:
        return AppColor.green;
    }
  }

  IconData _getStatusIcon(String status) {
    if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
    if (status == "ongoing") return Icons.motorcycle;
    return Icons.timer_outlined;
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 9),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color ?? AppColor.green.withOpacity(0.7)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: color ?? Colors.grey.shade600,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingImage(List<String> urls, String status) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: 80, height: 80, color: Colors.grey.shade100,
            child: urls.isNotEmpty
                ? Image.network(
              urls.first,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.fastfood, color: Colors.grey),
            )
                : const Icon(Icons.fastfood, color: Colors.grey),
          ),
          if (status == "ongoing")
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_turned_in_outlined, size: 50, color: Colors.grey.shade300),
          const SizedBox(height: 10),
          Text(msg, style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
        ],
      ),
    );
  }
}