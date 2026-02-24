// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
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
//         // provider theke sorting kora list-ti eikhane ashbe
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
//             final String donorStatus = post.status.toLowerCase();
//             final String dStatus = post.deliveryStatus.toLowerCase();
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
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
//                               _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//
//                           // ১. ডেলিভারি স্ট্যাটাস (Sorting validation er jonno priority dewa hoyeche)
//                           _infoRow(
//                             _getStatusIcon(dStatus),
//                             "Delivery: ${dStatus.toUpperCase()}",
//                             color: _getStatusColor(dStatus),
//                             isBold: true,
//                           ),
//
//                           const SizedBox(height: 5),
//
//                           // ২. ডোনার আইডি এবং অন্যান্য ডিটেইলস
//                           _infoRow(Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5).toUpperCase()}..."),
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
//         return Colors.green;
//       case 'ongoing':
//         return Colors.orange;
//       case 'pending':
//         return Colors.blueGrey;
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
//     return Icons.timer_outlined;
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
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Consumer<ReceiverProvider>(
//       builder: (context, provider, _) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator(color: AppColor.primary));
//         }
//
//         final requests = provider.approvedPosts;
//
//         if (requests.isEmpty) {
//           return _buildEmptyState(context, "No approved donations yet");
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.all(12),
//           physics: const BouncingScrollPhysics(),
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final post = requests[index];
//             final String donorStatus = post.status.toLowerCase();
//             final String dStatus = post.deliveryStatus.toLowerCase();
//
//             return Container(
//               margin: const EdgeInsets.only(bottom: 15),
//               decoration: BoxDecoration(
//                 // Adaptive background for Night Mode
//                 color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
//                 borderRadius: BorderRadius.circular(16),
//                 border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
//                 boxShadow: isDark ? [] : [
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
//                     _buildLeadingImage(post.imageUrls, dStatus, isDark),
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
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                     color: isDark ? AppColor.white : AppColor.black,
//                                   ),
//                                 ),
//                               ),
//                               _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//
//                           // 1. Delivery Status with Dynamic Colors
//                           _infoRow(
//                             context,
//                             _getStatusIcon(dStatus),
//                             "Delivery: ${dStatus.toUpperCase()}",
//                             color: _getStatusColor(dStatus),
//                             isBold: true,
//                           ),
//
//                           const SizedBox(height: 5),
//
//                           // 2. Donor ID & Details
//                           _infoRow(context, Icons.person_outline, "Donor ID: ${post.donorId.substring(0, 5).toUpperCase()}..."),
//                           _infoRow(context, Icons.access_time_rounded, "Pickup: ${post.pickupTime}"),
//                           _infoRow(context, Icons.location_on_outlined, post.pickupAddress),
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
//         return Colors.green;
//       case 'ongoing':
//         return Colors.orange;
//       case 'pending':
//         return Colors.blueGrey;
//       case 'approved':
//         return Colors.blue;
//       default:
//         return AppColor.primary;
//     }
//   }
//
//   IconData _getStatusIcon(String status) {
//     if (status == "completed" || status == "delivered") return Icons.check_circle_outline;
//     if (status == "ongoing") return Icons.motorcycle;
//     return Icons.timer_outlined;
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
//   Widget _infoRow(BuildContext context, IconData icon, String text, {Color? color, bool isBold = false}) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 5),
//       child: Row(
//         children: [
//           Icon(icon, size: 14, color: color ?? AppColor.primary.withOpacity(0.7)),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               text,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: color ?? (isDark ? AppColor.white.withOpacity(0.6) : Colors.grey.shade600),
//                 fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeadingImage(List<String> urls, String status, bool isDark) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: Stack(
//         children: [
//           Container(
//             width: 80, height: 80,
//             color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
//             child: urls.isNotEmpty
//                 ? Image.network(
//               urls.first,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : Colors.grey),
//             )
//                 : Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : Colors.grey),
//           ),
//           if (status == "ongoing")
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.3),
//                 child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context, String msg) {
//     final bool isDark = Theme.of(context).brightness == Brightness.dark;
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//               Icons.assignment_turned_in_outlined,
//               size: 50,
//               color: isDark ? AppColor.gray.withOpacity(0.5) : Colors.grey.shade300
//           ),
//           const SizedBox(height: 10),
//           Text(
//               msg,
//               style: TextStyle(
//                   color: isDark ? AppColor.white.withOpacity(0.5) : Colors.grey.shade500,
//                   fontSize: 14
//               )
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/constants/app_colors.dart';
import '../../provider/receiver_provider.dart';

class ApprovedTab extends StatelessWidget {
  const ApprovedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<ReceiverProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColor.primary));
        }

        final requests = provider.approvedPosts;

        if (requests.isEmpty) {
          return _buildEmptyState(context, "No approved donations yet");
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          physics: const BouncingScrollPhysics(),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final post = requests[index];

            // ✅ Null safety handling for status strings
            final String donorStatus = (post.status ?? 'pending').toLowerCase();
            final String dStatus = (post.deliveryStatus ?? 'pending').toLowerCase();

            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: isDark ? AppColor.gray.withOpacity(0.1) : AppColor.white,
                borderRadius: BorderRadius.circular(16),
                border: isDark ? Border.all(color: AppColor.gray.withOpacity(0.2), width: 0.5) : null,
                boxShadow: isDark ? [] : [
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
                    _buildLeadingImage(post.imageUrls ?? [], dStatus, isDark),
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
                                  post.foodName ?? "Unknown Item",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: isDark ? AppColor.white : AppColor.black,
                                  ),
                                ),
                              ),
                              _buildBadge(donorStatus.toUpperCase(), _getStatusColor(donorStatus)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          _infoRow(
                            context,
                            _getStatusIcon(dStatus),
                            "Delivery: ${dStatus.toUpperCase()}",
                            color: _getStatusColor(dStatus),
                            isBold: true,
                          ),

                          const SizedBox(height: 5),

                          // ✅ Donor ID substring safe handling
                          _infoRow(
                              context,
                              Icons.person_outline,
                              "Donor ID: ${post.donorId != null && post.donorId!.length > 5 ? post.donorId!.substring(0, 5).toUpperCase() : 'N/A'}..."
                          ),
                          _infoRow(context, Icons.access_time_rounded, "Pickup: ${post.pickupTime ?? 'Not set'}"),
                          _infoRow(context, Icons.location_on_outlined, post.pickupAddress ?? "No address"),
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
        return AppColor.primary;
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

  Widget _infoRow(BuildContext context, IconData icon, String text, {Color? color, bool isBold = false}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color ?? AppColor.primary.withOpacity(0.7)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: color ?? (isDark ? AppColor.white.withOpacity(0.6) : Colors.grey.shade600),
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingImage(List<String>? urls, String status, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Container(
            width: 80, height: 80,
            color: isDark ? AppColor.gray.withOpacity(0.2) : AppColor.lightGray,
            child: (urls != null && urls.isNotEmpty)
                ? Image.network(
              urls.first,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : Colors.grey),
            )
                : Icon(Icons.fastfood, color: isDark ? AppColor.white.withOpacity(0.2) : Colors.grey),
          ),
          if (status == "ongoing")
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: const Icon(Icons.delivery_dining, color: Colors.white, size: 25),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String msg) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              Icons.assignment_turned_in_outlined,
              size: 50,
              color: isDark ? AppColor.gray.withOpacity(0.5) : Colors.grey.shade300
          ),
          const SizedBox(height: 10),
          Text(
              msg,
              style: TextStyle(
                  color: isDark ? AppColor.white.withOpacity(0.5) : Colors.grey.shade500,
                  fontSize: 14
              )
          ),
        ],
      ),
    );
  }
}