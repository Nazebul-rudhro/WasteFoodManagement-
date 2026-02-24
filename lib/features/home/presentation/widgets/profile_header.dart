import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart'; // পাথ নিশ্চিত করে নিন
import '../../../auth/provider/generic_auth_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // ডার্ক মোড চেক
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<GenericAuthProvider>(
      builder: (context, auth, _) {
        final user = auth.user;
        final profile = auth.userData?['profile'];

        final String role = auth.selectedRole ?? "User";
        final String name = profile?['contactPerson'] ?? "Complete Profile";
        final String email = user?.email ?? "No email";

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            // ডার্ক মোডে ব্যাকগ্রাউন্ড কালার একটু গাঢ় হবে
            color: isDark
                ? AppColor.green.withOpacity(0.05)
                : AppColor.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: isDark
                    ? AppColor.green.withOpacity(0.2)
                    : AppColor.green.withOpacity(0.2)
            ),
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
                      name.isNotEmpty ? name[0].toUpperCase() : "?",
                      style: const TextStyle(
                          fontSize: 24,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: isDark ? AppColor.black : AppColor.white,
                    child: const Icon(Icons.verified, size: 14, color: Colors.blue),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // ডার্ক মোডে সাদা, লাইট মোডে কালো টেক্সট
                        color: isDark ? AppColor.white : AppColor.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppColor.mediumtgray : Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),

                    // রোল ব্যাজ
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: AppColor.green,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            if(!isDark)
                              BoxShadow(
                                color: AppColor.green.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                          ]
                      ),
                      child: Text(
                        role.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
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