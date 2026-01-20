// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_home_screen.dart';
// import '../../../../app/app_theme.dart';
// import '../../provider/auth_provider.dart';
// import '../widgets/coustom_text_filed.dart';
// import '../widgets/login_button.dart';
// import '../widgets/social_button.dart';
//
// enum AuthFormType { login, signup }
//
// class GenericLoginSignupForm extends StatefulWidget {
//   final AuthFormType type;
//
//   const GenericLoginSignupForm({super.key, required this.type});
//
//   @override
//   State<GenericLoginSignupForm> createState() =>
//       _GenericLoginSignupFormState();
// }
//
// class _GenericLoginSignupFormState extends State<GenericLoginSignupForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool rememberMe = false;
//   bool isLoading = false;
//
//   bool get isLogin => widget.type == AuthFormType.login;
//   bool get isSignUp => widget.type == AuthFormType.signup;
//
//   // Validators
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return "Email is required";
//     if (!value.contains("@")) return "Enter a valid email";
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return "Password is required";
//     if (value.length < 6) return "Password must be at least 6 characters";
//     return null;
//   }
//
//   String? _validateConfirmPassword(String? value) {
//     if (!isLogin && value != _passwordController.text) {
//       return "Password does not match";
//     }
//     return null;
//   }
//
//
//
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final double gap = MediaQuery.of(context).size.height * 0.02;
//
//     return Form(
//       key: _formKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: gap),
//
//           /// Title
//           Text(
//             isLogin ? "Login" : "Signup",
//             style: AppData.heading1,
//           ),
//
//           SizedBox(height: gap),
//
//           /// Email
//           CustomTextField(
//             controller: _emailController,
//             label: "Email",
//             hint: "Enter your email",
//             keyboardType: TextInputType.emailAddress,
//             prefixIcon: Icons.email,
//             validator: _validateEmail,
//           ),
//
//           SizedBox(height: gap),
//
//           /// Password
//           CustomTextField(
//             controller: _passwordController,
//             label: "Password",
//             hint: "Enter your password",
//             isPassword: true,
//             keyboardType: TextInputType.visiblePassword,
//             prefixIcon: Icons.lock,
//             validator: _validatePassword,
//           ),
//
//           /// Confirm Password (Signup only)
//           if (!isLogin) ...[
//             SizedBox(height: gap),
//             CustomTextField(
//               controller: _confirmPasswordController,
//               label: "Confirm Password",
//               hint: "Re-enter your password",
//               isPassword: true,
//               keyboardType: TextInputType.visiblePassword,
//               prefixIcon: Icons.lock_outline,
//               validator: _validateConfirmPassword,
//             ),
//           ],
//
//           SizedBox(height: gap),
//
//           /// Remember & Forgot Password (Login only)
//           if (isLogin)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: rememberMe,
//                       onChanged: (val) {
//                         setState(() => rememberMe = val ?? false);
//                       },
//                     ),
//                     const Text("Remember me"),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(
//                       context,
//                       ForgotPasswordScreen.routeName,
//                     );
//                   },
//                   child: const Text("Forgot Password?"),
//                 ),
//               ],
//             ),
//
//           SizedBox(height: gap),
//
//           /// Action Button
//           LoginButton(
//             buttonName: isLogin ? "Login" : "Signup",
//             onPressed: isLoading ? null : _submit,
//           ),
//
//           SizedBox(height: gap * 1.5),
//
//           /// Divider
//           Row(
//             children: const [
//               Expanded(child: Divider(thickness: 1)),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Text("OR"),
//               ),
//               Expanded(child: Divider(thickness: 1)),
//             ],
//           ),
//
//           SizedBox(height: gap),
//
//           /// Social Login
//           Center(
//             child: Text(
//               "Continue with",
//               style: AppData.heading3,
//             ),
//           ),
//
//           SizedBox(height: gap),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               SocialButton(
//                 label: "Gmail",
//                 backgroundColor: Colors.red,
//                 icon: Icons.email,
//                 onPressed: () {},
//               ),
//               SocialButton(
//                 label: "Facebook",
//                 backgroundColor: Colors.blue,
//                 icon: Icons.facebook,
//                 onPressed: () {},
//               ),
//             ],
//           ),
//
//           SizedBox(height: gap * 1.5),
//
//           /// Switch Login / Signup
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(isLogin
//                   ? "Don’t have an account?"
//                   : "Already have an account?"),
//               TextButton(
//                 onPressed: () {
//                   if (isLogin) {
//                     Navigator.pushReplacementNamed(
//                         context, SignUpScreen.routeName);
//                   } else {
//                     Navigator.pushReplacementNamed(
//                         context, LoginScreen.routeName);
//                   }
//                 },
//                 child: Text(
//                   isLogin ? "Signup" : "Login",
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
