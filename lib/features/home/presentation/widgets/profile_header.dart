// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
//
// class ProfileHeader extends StatelessWidget {
//   const ProfileHeader({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<GenericAuthProvider>(
//       builder: (context, auth, _) {
//         final user = auth.user;
//         final role = auth.selectedRole ?? "Not Assigned";
//         // final name = auth.user?['businessOrFullName'] ?? "Donor Name";
//
//         return Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.green.shade50,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.green,
//                 child: const Icon(
//                   Icons.person,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     role.toString().toUpperCase(),
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     user?.email ?? "No email",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';

import '../../../auth/provider/generic_auth_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GenericAuthProvider>(
      builder: (context, auth, _) {
        // ফায়ারবেস অ্যাথ ইউজার
        final user = auth.user;
        // আমাদের সেভ করা প্রোফাইল ডাটা (এটার ভেতর নাম থাকে)
        final profile = auth.userData?['profile'];

        final String role = auth.selectedRole ?? "User";
        final String name = profile?['businessOrFullName'] ?? "Complete Profile";
        final String email = user?.email ?? "No email";

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.green.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              // প্রোফাইল ইমেজ বা আইকন
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColor.green,
                    child: Text(
                      name[0].toUpperCase(), // নামের প্রথম অক্ষর শো করবে
                      style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.verified, size: 14, color: Colors.blue),
                  )
                ],
              ),
              const SizedBox(width: 16),

              // ইউজার ইনফরমেশন
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),

                    // রোল ব্যাজ (Donor, Receiver, Volunteer)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColor.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        role.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}