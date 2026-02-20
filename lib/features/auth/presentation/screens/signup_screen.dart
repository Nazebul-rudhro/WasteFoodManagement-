// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
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
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   // FocusNodes
//   final _emailFocus = FocusNode();
//   final _passwordFocus = FocusNode();
//   final _confirmPasswordFocus = FocusNode();
//
//   bool _isLoading = false;
//
//   // ================= Validators =================
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return "Email is required";
//     if (!value.contains("@") || !value.contains(".")) {
//       return "Enter a valid email";
//     }
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return "Password is required";
//     if (value.length < 6) {
//       return "Password must be at least 6 characters";
//     }
//     return null;
//   }
//
//   String? _validateConfirmPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Confirm Password is required";
//     }
//     if (value != _passwordController.text) {
//       return "Password does not match";
//     }
//     return null;
//   }
//
//   // ================= Signup Logic =================
//   Future<void> _signup() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     FocusScope.of(context).unfocus(); // keyboard close
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
//       Future.delayed(const Duration(seconds: 1), () {
//         if (mounted) {
//           Navigator.pushReplacementNamed(
//               context, LoginScreen.routeName);
//         }
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
//   @override
//   Widget build(BuildContext context) {
//     final double gap = MediaQuery.of(context).size.height * 0.02;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
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
//                       Text("Signup", style: AppData.heading1.copyWith(color: Colors.green)),
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
//                         keyboardType: TextInputType.visiblePassword,
//                         validator: _validatePassword,
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
//                         keyboardType: TextInputType.visiblePassword,
//                         validator: _validateConfirmPassword,
//                       ),
//                       SizedBox(height: gap),
//
//                       // Signup Button
//                       LoginButton(
//                         buttonName: "Signup",
//                         onPressed: _isLoading ? null : _signup,
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
//                       Center(
//                         child:
//                         Text("Continue with", style: AppData.heading3),
//                       ),
//                       SizedBox(height: gap),
//
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
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Already have an account?"),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pushReplacementNamed(
//                                   context, LoginScreen.routeName);
//                             },
//                             child:  Text(
//                               "Login",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, color: AppColor.lightGreen),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // ===== Full Screen Loader (ONLY ONE) =====
//           if (_isLoading)
//             Container(
//               color: Colors.black.withOpacity(0.45),
//               child:  Center(
//                 child: CircularProgressIndicator(
//                   color: AppColor.green,
//                 ),
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
import '../widgets/coustom_text_filed.dart'; // Ensure path is correct
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _isLoading = false;

  // Validators
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final email = value.trim().toLowerCase();
    if (!email.endsWith("@gmail.com")) return "Only @gmail.com is allowed";
    final emailRegex = RegExp(r'^[\w-\.]+@gmail\.com$');
    if (!emailRegex.hasMatch(email)) return "Enter a valid Gmail address";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    final strongRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!strongRegex.hasMatch(value)) return "Need A-Z, a-z, 0-9 & special char";
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return "Confirm your password";
    if (value != _passwordController.text) return "Passwords do not match";
    return null;
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    final authProvider = Provider.of<GenericAuthProvider>(context, listen: false);
    final error = await authProvider.signup(
      _emailController.text.trim().toLowerCase(),
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
        message: "You can now log in.",
        isSuccess: true,
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    } else {
      ShowAlertMessage(context: context, title: "Error", boldText: "Failed", message: error, isSuccess: false);
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
                      Text("Signup", style: AppData.heading1.copyWith(color: AppColor.green)),
                      const Text("Create a secure account", style: TextStyle(color: Colors.grey)),
                      SizedBox(height: gap * 1.5),

                      CustomTextField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        label: "Email",
                        hint: "name@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email,
                        validator: _validateEmail,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                      ),
                      SizedBox(height: gap),

                      CustomTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        label: "Password",
                        hint: "Strong Password (Min 8)",
                        isPassword: true,
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        validator: _validatePassword,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmPasswordFocus),
                      ),
                      SizedBox(height: gap),

                      CustomTextField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        label: "Confirm Password",
                        hint: "Repeat password",
                        isPassword: true,
                        prefixIcon: Icons.lock_reset,
                        keyboardType: TextInputType.visiblePassword,
                        validator: _validateConfirmPassword,
                        onFieldSubmitted: (_) => _signup(),
                      ),
                      SizedBox(height: gap * 1.5),

                      LoginButton(buttonName: "Create Account", onPressed: _isLoading ? null : _signup),

                      SizedBox(height: gap * 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, LoginScreen.routeName),
                            child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.lightGreen)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child:  Center(child: CircularProgressIndicator(color: AppColor.green)),
            ),
        ],
      ),
    );
  }
}