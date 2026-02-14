import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // FocusNodes
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Validators
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!value.contains("@")) return "Enter a valid email";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  // Login Function
  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final auth = Provider.of<GenericAuthProvider>(context, listen: false);

    final error = await auth.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (error != null) {
      ShowAlertMessage(
        context: context,
        title: "Failed",
        boldText: "Login failed!",
        message: error,
        isSuccess: false,
      );
      setState(() => _isLoading = false);
      return;
    }

    // Load user role & profile status
    await auth.loadUserRole();
    if (!mounted) return;
    final String? role = auth.selectedRole?.toLowerCase();
    final bool isProfileComplete = await auth.isProfileCompleted();

    // Navigation Logic with pushNamedAndRemoveUntil
    if (role == null || role.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoleSelectionScreen.routeName,
            (route) => false,
      );
    } else if (!isProfileComplete) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        GenericInformationFormScreen.routeName,
            (route) => false,
      );
    } else {
      String targetRoute;
      switch (role) {
        case 'donor':
          targetRoute = DonorScreen.routeName;
          break;
        case 'receiver':
          targetRoute = ReceiverScreen.routeName;
          break;
        case 'volunteer':
          targetRoute = VolunteerScreen.routeName;
          break;
        default:
          targetRoute = RoleSelectionScreen.routeName;
      }

      Navigator.pushNamedAndRemoveUntil(context, targetRoute, (route) => false);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final double gap = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BaseScreen(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: gap),

                  /// Title
                  Text(
                    "Login",
                    style: AppData.heading1.copyWith(color: AppColor.lightGreen),
                  ),
                  SizedBox(height: gap),

                  /// Email
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

                  /// Password
                  CustomTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    label: "Password",
                    hint: "Enter your password",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: gap),

                  /// Remember me & Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                                  if (states.contains(MaterialState.selected)) {
                                    return AppColor.lightGreen; // clicked
                                  }
                                  return AppColor.lightGreen.withOpacity(0.3); // normal
                                }),
                            onChanged: (val) =>
                                setState(() => rememberMe = val ?? false),
                          ),
                          const Text("Remember me"),
                        ],
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                            context, ForgotPasswordScreen.routeName),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: AppColor.lightGreen),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: gap),

                  /// Login Button / Loading Indicator
                  _isLoading
                      ?  Center(child: CircularProgressIndicator(color: AppColor.green,))
                      : LoginButton(buttonName: "Login", onPressed: _login),
                  SizedBox(height: gap * 1.5),

                  /// Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  SizedBox(height: gap),

                  /// Social Login
                  Center(
                    child: Text(
                      "Continue with",
                      style: AppData.heading3,
                    ),
                  ),
                  SizedBox(height: gap),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialButton(
                        label: "Gmail",
                        backgroundColor: AppColor.darkRed,
                        icon: Icons.email,
                        onPressed: () {},
                      ),
                      SocialButton(
                        label: "Facebook",
                        backgroundColor: AppColor.primary,
                        icon: Icons.facebook,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: gap * 1.5),

                  /// Switch to SignUp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, SignUpScreen.routeName),
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: AppColor.lightGreen,
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
    );
  }
}
