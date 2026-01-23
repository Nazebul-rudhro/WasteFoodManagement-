// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// // import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// // import '../../../../app/app_theme.dart';
// // import '../sections/show_aleart.dart';
// // import '../widgets/coustom_text_filed.dart';
// // import '../widgets/login_button.dart';
// // import '../widgets/social_button.dart';
// // import 'login_screen.dart';
// //
// // class SignUpScreen extends StatefulWidget {
// //   const SignUpScreen({super.key});
// //   static String routeName = "/signup";
// //
// //   @override
// //   State<SignUpScreen> createState() => _SignupFormState();
// // }
// //
// // class _SignupFormState extends State<SignUpScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final _emailController = TextEditingController();
// //   final _passwordController = TextEditingController();
// //   final _confirmPasswordController = TextEditingController();
// //
// //   bool _isLoading = false; // loader visibility toggle
// //
// //   String? _validateEmail(String? value) {
// //     if (value == null || value.isEmpty) return "Email is required";
// //     if (!value.contains("@") || !value.contains(".")) return "Enter a valid email";
// //     return null;
// //   }
// //
// //   String? _validatePassword(String? value) {
// //     if (value == null || value.isEmpty) return "Password is required";
// //     if (value.length < 6) return "Password must be at least 6 characters";
// //     return null;
// //   }
// //
// //   String? _validateConfirmPassword(String? value) {
// //     if (value == null || value.isEmpty) return "Confirm Password is required";
// //     if (value != _passwordController.text) return "Password does not match";
// //     return null;
// //   }
// //
// //   Future<void> _signup() async {
// //     if (!_formKey.currentState!.validate()) return;
// //
// //     setState(() {
// //       _isLoading = true; // show full screen loader
// //     });
// //
// //     final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
// //
// //     final error = await authProvider.signup(
// //       _emailController.text.trim(),
// //       _passwordController.text.trim(),
// //     );
// //
// //     // Wait 2 seconds to show loader
// //     await Future.delayed(const Duration(seconds: 1));
// //
// //     if (!mounted) return;
// //
// //     setState(() {
// //       _isLoading = false; // hide loader
// //     });
// //
// //     if (error == null) {
// //       // clear form after success
// //       _emailController.clear();
// //       _passwordController.clear();
// //       _confirmPasswordController.clear();
// //       // Success alert
// //       ShowAlertMessage(
// //         context: context,
// //         title: "Success",
// //         boldText: "Account Created!",
// //         message: "Your account has been successfully created.",
// //         isSuccess: true,
// //       );
// //
// //
// //     } else {
// //       // Error alert
// //       ShowAlertMessage(
// //         context: context,
// //         title: "Error",
// //         boldText: "Something went wrong",
// //         message: error,
// //         isSuccess: false,
// //       );
// //
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     _confirmPasswordController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final double gap = MediaQuery.of(context).size.height * 0.02;
// //
// //     return Stack(
// //       children: [
// //         Scaffold(
// //           body: SingleChildScrollView(
// //             child: SafeArea(
// //               child: BaseScreen(
// //                 child: Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       SizedBox(height: gap),
// //                       Text("Signup", style: AppData.heading1),
// //                       SizedBox(height: gap),
// //
// //                       CustomTextField(
// //                         controller: _emailController,
// //                         label: "Email",
// //                         hint: "Enter your email",
// //                         keyboardType: TextInputType.emailAddress,
// //                         prefixIcon: Icons.email,
// //                         validator: _validateEmail,
// //                       ),
// //                       SizedBox(height: gap),
// //
// //                       CustomTextField(
// //                         controller: _passwordController,
// //                         label: "Password",
// //                         hint: "Enter your password",
// //                         isPassword: true,
// //                         prefixIcon: Icons.lock,
// //                         validator: _validatePassword,
// //                         keyboardType: TextInputType.visiblePassword,
// //                       ),
// //                       SizedBox(height: gap),
// //
// //                       CustomTextField(
// //                         controller: _confirmPasswordController,
// //                         label: "Confirm Password",
// //                         hint: "Re-enter your password",
// //                         isPassword: true,
// //                         prefixIcon: Icons.lock_outline,
// //                         validator: _validateConfirmPassword,
// //                         keyboardType: TextInputType.visiblePassword,
// //                       ),
// //                       SizedBox(height: gap),
// //
// //                       LoginButton(
// //                         buttonName: "Signup",
// //                         onPressed: _isLoading ? null : _signup,
// //                       ),
// //                       SizedBox(height: gap * 1.5),
// //
// //                       Row(
// //                         children: const [
// //                           Expanded(child: Divider()),
// //                           Padding(
// //                             padding: EdgeInsets.symmetric(horizontal: 10),
// //                             child: Text("OR"),
// //                           ),
// //                           Expanded(child: Divider()),
// //                         ],
// //                       ),
// //                       SizedBox(height: gap),
// //
// //                       Center(child: Text("Continue with", style: AppData.heading3)),
// //                       SizedBox(height: gap),
// //
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           SocialButton(
// //                             label: "Gmail",
// //                             backgroundColor: Colors.red,
// //                             icon: Icons.email,
// //                             onPressed: () {},
// //                           ),
// //                           SocialButton(
// //                             label: "Facebook",
// //                             backgroundColor: Colors.blue,
// //                             icon: Icons.facebook,
// //                             onPressed: () {},
// //                           ),
// //                         ],
// //                       ),
// //                       SizedBox(height: gap * 1.5),
// //
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           const Text("Already have an account?"),
// //                           TextButton(
// //                             onPressed: () {
// //                               Navigator.pushReplacementNamed(context, LoginScreen.routeName);
// //                             },
// //                             child: const Text(
// //                               "Login",
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //
// //         // Full screen loader using Visibility
// //         Visibility(
// //           visible: _isLoading,
// //           child: Container(
// //             color: Colors.black.withOpacity(0.5),
// //             child: const Center(
// //               child: CircularProgressIndicator(
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
// import '../../../../app/app_theme.dart';
// import '../sections/show_aleart.dart';
// import '../widgets/coustom_text_filed.dart';
// import '../widgets/login_button.dart';
// import '../widgets/social_button.dart';
//
// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//   static String routeName = "/signup";
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//   TextEditingController();
//
//   // FocusNodes
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//   final FocusNode _confirmPasswordFocus = FocusNode();
//
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _emailFocus.dispose();
//     _passwordFocus.dispose();
//     _confirmPasswordFocus.dispose();
//     super.dispose();
//   }
//
//   // Validators
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return "Email is required";
//     if (!value.contains("@") || !value.contains(".")) return "Enter a valid email";
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
//     if (value == null || value.isEmpty) return "Confirm Password is required";
//     if (value != _passwordController.text) return "Password does not match";
//     return null;
//   }
//
//   Future<void> _signup() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     final authProvider =
//     Provider.of<GenericAuthProvider>(context, listen: false);
//
//     final error = await authProvider.signup(
//       _emailController.text.trim(),
//       _passwordController.text.trim(),
//     );
//
//     if (!mounted) return;
//
//     setState(() => _isLoading = false);
//
//     if (error == null) {
//       // Clear form
//       _emailController.clear();
//       _passwordController.clear();
//       _confirmPasswordController.clear();
//
//       ShowAlertMessage(
//         context: context,
//         title: "Success",
//         boldText: "Account Created!",
//         message: "Your account has been successfully created.",
//         isSuccess: true,
//       );
//
//       // Optionally navigate to login screen
//       Future.delayed(const Duration(seconds: 1), () {
//         Navigator.pushReplacementNamed(context, LoginScreen.routeName);
//       });
//     } else {
//       ShowAlertMessage(
//         context: context,
//         title: "Error",
//         boldText: "Something went wrong",
//         message: error,
//         isSuccess: false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double gap = MediaQuery.of(context).size.height * 0.02;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true, // keyboard safe
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: SafeArea(
//               child: BaseScreen(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: gap),
//                       Text("Signup", style: AppData.heading1),
//                       SizedBox(height: gap),
//
//                       // Email
//                       CustomTextField(
//                         controller: _emailController,
//                         focusNode: _emailFocus,
//                         label: "Email",
//                         hint: "Enter your email",
//                         keyboardType: TextInputType.emailAddress,
//                         prefixIcon: Icons.email,
//                         validator: _validateEmail,
//                       ),
//                       SizedBox(height: gap),
//
//                       // Password
//                       CustomTextField(
//                         controller: _passwordController,
//                         focusNode: _passwordFocus,
//                         label: "Password",
//                         hint: "Enter your password",
//                         isPassword: true,
//                         prefixIcon: Icons.lock,
//                         validator: _validatePassword,
//                         keyboardType: TextInputType.visiblePassword,
//                       ),
//                       SizedBox(height: gap),
//
//                       // Confirm Password
//                       CustomTextField(
//                         controller: _confirmPasswordController,
//                         focusNode: _confirmPasswordFocus,
//                         label: "Confirm Password",
//                         hint: "Re-enter your password",
//                         isPassword: true,
//                         prefixIcon: Icons.lock_outline,
//                         validator: _validateConfirmPassword,
//                         keyboardType: TextInputType.visiblePassword,
//                       ),
//                       SizedBox(height: gap),
//
//                       // Signup Button
//                       _isLoading
//                           ? const Center(
//                         child: CircularProgressIndicator(),
//                       )
//                           : LoginButton(
//                         buttonName: "Signup",
//                         onPressed: _signup,
//                       ),
//                       SizedBox(height: gap * 1.5),
//
//                       // Divider
//                       Row(
//                         children: const [
//                           Expanded(child: Divider()),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 10),
//                             child: Text("OR"),
//                           ),
//                           Expanded(child: Divider()),
//                         ],
//                       ),
//                       SizedBox(height: gap),
//
//                       // Social Login
//                       Center(
//                         child: Text("Continue with", style: AppData.heading3),
//                       ),
//                       SizedBox(height: gap),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           SocialButton(
//                             label: "Gmail",
//                             backgroundColor: Colors.red,
//                             icon: Icons.email,
//                             onPressed: () {},
//                           ),
//                           SocialButton(
//                             label: "Facebook",
//                             backgroundColor: Colors.blue,
//                             icon: Icons.facebook,
//                             onPressed: () {},
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: gap * 1.5),
//
//                       // Switch to Login
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Already have an account?"),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(
//                                   context, LoginScreen.routeName);
//                             },
//                             child: const Text(
//                               "Login",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: gap),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // Full screen loader
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.5),
//               child: const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../app/app_theme.dart';
import '../sections/show_aleart.dart';
import '../widgets/coustom_text_filed.dart';
import '../widgets/login_button.dart';
import '../widgets/social_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String routeName = "/signup";

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // FocusNodes
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isLoading = false;

  // ================= Validators =================
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!value.contains("@") || !value.contains(".")) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (value != _passwordController.text) {
      return "Password does not match";
    }
    return null;
  }

  // ================= Signup Logic =================
  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus(); // keyboard close

    setState(() => _isLoading = true);

    final authProvider =
    Provider.of<GenericAuthProvider>(context, listen: false);

    final error = await authProvider.signup(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (error == null) {
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      ShowAlertMessage(
        context: context,
        title: "Success",
        boldText: "Account Created!",
        message: "Your account has been successfully created.",
        isSuccess: true,
      );

      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.pushReplacementNamed(
              context, LoginScreen.routeName);
        }
      });
    } else {
      ShowAlertMessage(
        context: context,
        title: "Error",
        boldText: "Something went wrong",
        message: error,
        isSuccess: false,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double gap = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: BaseScreen(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: gap),
                      Text("Signup", style: AppData.heading1.copyWith(color: Colors.green)),
                      SizedBox(height: gap),

                      // Email
                      CustomTextField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        label: "Email",
                        hint: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: _validateEmail,
                      ),
                      SizedBox(height: gap),

                      // Password
                      CustomTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        label: "Password",
                        hint: "Enter your password",
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        validator: _validatePassword,
                      ),
                      SizedBox(height: gap),

                      // Confirm Password
                      CustomTextField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        label: "Confirm Password",
                        hint: "Re-enter your password",
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                        keyboardType: TextInputType.visiblePassword,
                        validator: _validateConfirmPassword,
                      ),
                      SizedBox(height: gap),

                      // Signup Button
                      LoginButton(
                        buttonName: "Signup",
                        onPressed: _isLoading ? null : _signup,
                      ),
                      SizedBox(height: gap * 1.5),

                      // Divider
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("OR"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: gap),

                      Center(
                        child:
                        Text("Continue with", style: AppData.heading3),
                      ),
                      SizedBox(height: gap),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialButton(
                            label: "Gmail",
                            backgroundColor: Colors.red,
                            icon: Icons.email,
                            onPressed: () {},
                          ),
                          SocialButton(
                            label: "Facebook",
                            backgroundColor: Colors.blue,
                            icon: Icons.facebook,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: gap * 1.5),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child:  Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: AppColor.lightGreen),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ===== Full Screen Loader (ONLY ONE) =====
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.45),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
