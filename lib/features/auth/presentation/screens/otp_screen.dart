// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/otp_success.dart';
//
// import '../widgets/social_button.dart';
//
// class OTPScreen extends StatefulWidget {
//   static const String routeName = "/otp_screen";
//
//   final String email ="sakib@gmail.com.bd";
//
//   const OTPScreen({super.key,});
//
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> {
//   TextEditingController otpController = TextEditingController();
//   int _secondsRemaining = 120;
//   Timer? _timer;
//   bool canResend = true;
//
//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//
//   void startTimer() {
//     _secondsRemaining = 120;
//     canResend = false;
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsRemaining > 0) {
//         setState(() {
//           _secondsRemaining--;
//         });
//       } else {
//         setState(() {
//           canResend = false;
//         });
//         _timer?.cancel();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     otpController.dispose();
//     super.dispose();
//   }
//
//   void resendOTP() {
//     // TODO: API call to resend OTP
//     startTimer();
//   }
//
//   void verifyOTP() {
//     String otp = otpController.text;
//     // TODO: API call to verify OTP
//     Navigator.pushNamed(context, OTPSuccess.routeName);
//     print("Verifying OTP: $otp");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double HightScreen = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: HightScreen * 0.1,
//                 ),
//                 Text("Enter OTP", style: AppData.heading1,),
//                 SizedBox(
//                   height: HightScreen * 0.1,
//                 ),
//                 Text(
//                   "Your OTP has been sent to\n${widget.email}",
//                   textAlign: TextAlign.center,
//                   style: AppData.heading2,
//                 ),
//
//                 SizedBox(
//                   height: HightScreen * 0.1,
//                 ),
//
//                 // PinCodeTextField
//                 PinCodeTextField(
//                   appContext: context,
//                   controller: otpController,
//                   length: 6,
//                   onChanged: (value) {},
//                   onCompleted: (value) {
//                     print("OTP: $value");
//                   },
//                   pinTheme: PinTheme(
//                     shape: PinCodeFieldShape.box,
//                     borderRadius: BorderRadius.circular(8),
//                     fieldHeight: 60,
//                     fieldWidth: 50,
//                     activeColor: AppColor.lightGreen,
//                     inactiveColor: Colors.grey ,
//                     inactiveFillColor: AppColor.primary,
//                     selectedFillColor: Colors.white,
//                     activeFillColor: AppColor.lightGreen,
//                   ),
//                   keyboardType: TextInputType.number,
//                   animationType: AnimationType.fade,
//                   enableActiveFill: true,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Timer & Resend Option
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if (!canResend)
//                       RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: "Resend OTP in ",
//                               style: TextStyle(
//                                 color: AppColor.black,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             TextSpan(
//                               text: "$_secondsRemaining s",
//                               style: TextStyle(
//                                 color: AppColor.black
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                     // Text(
//                     //     "Resend OTP in $_secondsRemaining s",
//                     //     style: const TextStyle(color: Colors.grey),
//                     //   ),
//                     if (canResend)
//                       TextButton(
//                         onPressed: resendOTP,
//                         child: const Text("Resend OTP"),
//                       ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Verify Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColor.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12)
//                     ),
//                     onPressed: verifyOTP,
//                     child: Text(
//                       "Verify OTP",
//                       style: AppData.heading2.copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//              ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:waste_food_management/features/auth/presentation/widgets/login_button.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            const Text("Verification 📩", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Enter the OTP code sent to ${widget.email}", textAlign: TextAlign.center),
            const SizedBox(height: 40),

            // OTP Input Field
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              maxLength: 6,
              style: const TextStyle(fontSize: 24, letterSpacing: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: "000000",
                counterText: "",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 40),
            LoginButton(
              buttonName: "VERIFY OTP",
              onPressed: () {
                // OTP সঠিক হলে পাসওয়ার্ড রিসেট স্ক্রিনে নিয়ে যাবে
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}