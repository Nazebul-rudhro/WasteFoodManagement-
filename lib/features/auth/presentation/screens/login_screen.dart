// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:waste_food_management/core/constants/app_colors.dart';
// import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import '../../../../app/app_theme.dart';
// import '../../../home/presentation/sections/base_screen.dart';
// import '../sections/show_aleart.dart';
// import '../widgets/coustom_text_filed.dart';
// import '../widgets/login_button.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   static String routeName = "/login";
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FocusNode _emailFocus = FocusNode();
//   final FocusNode _passwordFocus = FocusNode();
//
//   bool rememberMe = false;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCredentials();
//   }
//
//   Future<void> _loadSavedCredentials() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       setState(() {
//         _emailController.text = prefs.getString('saved_email') ?? '';
//         _passwordController.text = prefs.getString('saved_password') ?? '';
//         rememberMe = prefs.getBool('remember_me') ?? false;
//       });
//     } catch (e) {
//       debugPrint("Error loading credentials: $e");
//     }
//   }
//
//   Future<void> _handleRememberMe() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (rememberMe) {
//       await prefs.setString('saved_email', _emailController.text.trim());
//       await prefs.setString('saved_password', _passwordController.text.trim());
//       await prefs.setBool('remember_me', true);
//     } else {
//       await prefs.remove('saved_email');
//       await prefs.remove('saved_password');
//       await prefs.setBool('remember_me', false);
//     }
//   }
//
//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) return "Email is required";
//     final email = value.trim().toLowerCase();
//     if (!email.endsWith("@gmail.com")) return "Only @gmail.com is allowed";
//     return null;
//   }
//
//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) return "Password is required";
//     if (value.length < 8) return "Password must be at least 8 characters";
//     return null;
//   }
//
//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;
//     FocusScope.of(context).unfocus();
//     setState(() => _isLoading = true);
//
//     await _handleRememberMe();
//
//     final auth = Provider.of<GenericAuthProvider>(context, listen: false);
//     final error = await auth.login(
//       _emailController.text.trim().toLowerCase(),
//       _passwordController.text.trim(),
//     );
//
//     if (!mounted) return;
//
//     if (error != null) {
//       setState(() => _isLoading = false);
//       ShowAlertMessage(
//         context: context,
//         title: "Login Error",
//         boldText: "Failed",
//         message: error,
//         isSuccess: false,
//       );
//       return;
//     }
//
//     await auth.loadUserRole();
//     if (!mounted) return;
//
//     final role = auth.selectedRole?.toLowerCase();
//     final isComplete = await auth.isProfileCompleted();
//
//     setState(() => _isLoading = false);
//     _navigateToHome(role, isComplete);
//   }
//
//   void _navigateToHome(String? role, bool isProfileComplete) {
//     String route = RoleSelectionScreen.routeName;
//     if (role != null && role.isNotEmpty) {
//       if (!isProfileComplete) {
//         route = GenericInformationFormScreen.routeName;
//       } else {
//         switch (role) {
//           case 'donor':
//             route = DonorScreen.routeName;
//             break;
//           case 'receiver':
//             route = ReceiverScreen.routeName;
//             break;
//           case 'volunteer':
//             route = VolunteerScreen.routeName;
//             break;
//         }
//       }
//     }
//     Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.white,
//           // কিবোর্ড ওপেন হলে যাতে লেআউট না ভাঙে
//           resizeToAvoidBottomInset: false,
//           body: SafeArea(
//             child: BaseScreen(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 40),
//                       Text(
//                         "Login",
//                         style: AppData.heading1.copyWith(
//                           color: AppColor.green,
//                           fontSize: 32,
//                         ),
//                       ),
//                       const Text(
//                         "Secure login to your account",
//                         style: TextStyle(color: Colors.grey, fontSize: 16),
//                       ),
//                       const SizedBox(height: 40),
//
//                       CustomTextField(
//                         controller: _emailController,
//                         focusNode: _emailFocus,
//                         label: "Email",
//                         hint: "name@gmail.com",
//                         keyboardType: TextInputType.emailAddress,
//                         prefixIcon: Icons.email_outlined,
//                         validator: _validateEmail,
//                         onFieldSubmitted: (_) =>
//                             FocusScope.of(context).requestFocus(_passwordFocus),
//                       ),
//                       const SizedBox(height: 20),
//
//                       CustomTextField(
//                         controller: _passwordController,
//                         focusNode: _passwordFocus,
//                         label: "Password",
//                         hint: "Enter password",
//                         isPassword: true,
//                         prefixIcon: Icons.lock_outline,
//                         validator: _validatePassword,
//                         onFieldSubmitted: (_) => _login(),
//                         keyboardType: TextInputType.visiblePassword,
//                       ),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: rememberMe,
//                                 activeColor: AppColor.green,
//                                 onChanged: (val) =>
//                                     setState(() => rememberMe = val ?? false),
//                               ),
//                               const Text(
//                                 "Remember me",
//                                 style: TextStyle(fontSize: 13),
//                               ),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pushNamed(
//                               context,
//                               ForgotPasswordScreen.routeName,
//                             ),
//                             child: const Text(
//                               "Forgot Password?",
//                               style: TextStyle(
//                                 color: AppColor.green,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//
//                       LoginButton(
//                         buttonName: "Login",
//                         onPressed: _isLoading ? null : _login,
//                       ),
//
//                       const SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text("Don't have an account?"),
//                           TextButton(
//                             onPressed: () => Navigator.pushReplacementNamed(
//                               context,
//                               SignUpScreen.routeName,
//                             ),
//                             child: const Text(
//                               "SignUp",
//                               style: TextStyle(
//                                 color: AppColor.green,
//                                 fontWeight: FontWeight.bold,
//                               ),
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
//         ),
//
//         // --- 🔹 ফিক্সড লোডার ওভারলে ---
//         if (_isLoading)
//           Container(
//             // এবার এটা নিশ্চিতভাবেই পুরো স্ক্রিন কালো করবে
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.black.withOpacity(0.55),
//             child: AbsorbPointer(
//               child: Center(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     // 🔹 এটি বক্সটিকে ছোট (Wrap Content) রাখবে
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const CircularProgressIndicator(
//                         color: AppColor.green,
//                         strokeWidth: 5,
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Authenticating...",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                           decoration: TextDecoration.none, // টেক্সট এর নিচের দাগ সরানোর জন্য
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocus.dispose();
//     _passwordFocus.dispose();
//     super.dispose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waste_food_management/core/constants/app_colors.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import '../../../../app/app_theme.dart';
import '../../../home/presentation/sections/base_screen.dart';
import '../sections/show_aleart.dart';
import '../widgets/coustom_text_filed.dart';
import '../widgets/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  // 🔹 SharedPreferences থেকে সেভ করা ইমেইল-পাসওয়ার্ড লোড করা
  Future<void> _loadSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        _emailController.text = prefs.getString('saved_email') ?? '';
        _passwordController.text = prefs.getString('saved_password') ?? '';
        rememberMe = prefs.getBool('remember_me') ?? false;
      });
    } catch (e) {
      debugPrint("Error loading credentials: $e");
    }
  }

  // 🔹 Remember Me লজিক সেভ করা
  Future<void> _handleRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setString('saved_email', _emailController.text.trim());
      await prefs.setString('saved_password', _passwordController.text.trim());
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_me', false);
    }
  }

  // 🔹 ভ্যালিডেশন
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final email = value.trim().toLowerCase();
    final bool emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) return "Please enter a valid email";
    if (!email.endsWith("@gmail.com")) return "Only @gmail.com is allowed";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 8) return "Password must be at least 8 characters";
    return null;
  }

  // 🔹 মেইন লগইন লজিক
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus(); // কিবোর্ড ক্লোজ করা
    setState(() => _isLoading = true);

    await _handleRememberMe();

    final auth = Provider.of<GenericAuthProvider>(context, listen: false);

    // ১. প্রোভাইডারের মাধ্যমে লগইন করা
    final error = await auth.login(
      _emailController.text.trim().toLowerCase(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (error != null) {
      setState(() => _isLoading = false);
      ShowAlertMessage(
        context: context,
        title: "Login Error",
        boldText: "Failed",
        message: error,
        isSuccess: false,
      );
      return;
    }

    // ২. লগইন সফল হলে ইউজারের ডাটা এবং রোল ফেচ করা
    await auth.fetchUserData();

    if (!mounted) return;

    final role = auth.selectedRole?.toLowerCase();
    final isComplete = await auth.isProfileCompleted();

    setState(() => _isLoading = false);
    _navigateToHome(role, isComplete);
  }

  void _navigateToHome(String? role, bool isProfileComplete) {
    String route = RoleSelectionScreen.routeName;

    if (role != null && role.isNotEmpty) {
      if (!isProfileComplete) {
        route = GenericInformationFormScreen.routeName;
      } else {
        switch (role) {
          case 'donor':
            route = DonorScreen.routeName;
            break;
          case 'receiver':
            route = ReceiverScreen.routeName;
            break;
          case 'volunteer':
            route = VolunteerScreen.routeName;
            break;
        }
      }
    }
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true, // কিবোর্ড আসলে স্ক্রিন অ্যাডজাস্ট হবে
          body: SafeArea(
            child: BaseScreen(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        "Login",
                        style: AppData.heading1.copyWith(
                          color: AppColor.green,
                          fontSize: 32,
                        ),
                      ),
                      const Text(
                        "Secure login to your account",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 40),

                      CustomTextField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        label: "Email",
                        hint: "name@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: _validateEmail,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_passwordFocus),
                      ),
                      const SizedBox(height: 20),

                      CustomTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        label: "Password",
                        hint: "Enter password",
                        isPassword: true,
                        prefixIcon: Icons.lock_outline,
                        validator: _validatePassword,
                        onFieldSubmitted: (_) => _login(),
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                child: Checkbox(
                                  value: rememberMe,
                                  activeColor: AppColor.green,
                                  onChanged: (val) =>
                                      setState(() => rememberMe = val ?? false),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Remember me",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              ForgotPasswordScreen.routeName,
                            ),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: AppColor.green,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      LoginButton(
                        buttonName: "Login",
                        onPressed: _isLoading ? null : _login,
                      ),

                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              SignUpScreen.routeName,
                            ),
                            child: const Text(
                              "SignUp",
                              style: TextStyle(
                                color: AppColor.green,
                                fontWeight: FontWeight.bold,
                              ),
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
        ),

        // --- 🔹 লোডার ওভারলে (যাতে ক্লিক বন্ধ থাকে) ---
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.55),
            child: Center(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColor.green,
                        strokeWidth: 4,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Authenticating...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}