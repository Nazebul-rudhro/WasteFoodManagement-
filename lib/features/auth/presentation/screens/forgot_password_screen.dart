// import 'package:flutter/material.dart';
// import 'package:waste_food_management/core/constants/app_image.dart';
//
// import '../sections/custom_message.dart';
//
// class OTPSuccess extends StatelessWidget {
//   const OTPSuccess({super.key});
//
//   static const String routeName = "/Success";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//             child: CustomMessage(
//               img: AppImage.doneIcon,
//               title: "OTP Successful!",
//               message:
//               "Your Phone number has been registered\nchanged successfully",
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//



import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';
import '../widgets/coustom_text_filed.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(title: const Text("New Password"), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            CustomTextField(
              controller: _passController,
              label: "New Password",
              hint: "********",
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _confirmPassController,
              label: "Confirm Password",
              hint: "********",
              isPassword: true,
              prefixIcon: Icons.lock_reset,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 40),
            LoginButton(
              buttonName: "CHANGE PASSWORD",
              onPressed: () {
                // পাসওয়ার্ড ম্যাচ করলে সাকসেস মেসেজ দেখিয়ে লগইন স্ক্রিনে পাঠিয়ে দিবে
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password changed successfully!"), backgroundColor: AppColor.green),
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}