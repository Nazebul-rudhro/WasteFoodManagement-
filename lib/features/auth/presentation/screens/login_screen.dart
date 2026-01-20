
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
import 'package:waste_food_management/features/auth/provider/generic_auth_provider.dart';
import 'package:waste_food_management/features/home/presentation/sections/base_screen.dart';
import '../../../../app/app_theme.dart';
import '../sections/show_aleart.dart';
import '../widgets/coustom_text_filed.dart';
import '../widgets/login_button.dart';
import '../widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool rememberMe = false;
  bool isLoading = false;



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


bool _isLoading = false;


  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
    });

    final auth = Provider.of<GenericAuthProvider>(context, listen: false);

    final error = await auth.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;
    Future.delayed(Duration(seconds: 1));

    if (error != null) {
      ShowAlertMessage(
        context: context,
        title: "Login Failed",
        message: error,
        isSuccess: false,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // ✅ ALWAYS go to role screen after login
    Navigator.pushReplacementNamed(context, RoleSelectionScreen.routeName);
  }



  void dusoise(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final double gap = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                    style: AppData.heading1,
                  ),
            
                  SizedBox(height: gap),
            
                  /// Email
                  CustomTextField(
                    controller: _emailController,
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
                    label: "Password",
                    hint: "Enter your password",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    validator: _validatePassword,
                  ),
            
                  SizedBox(height: gap),
            
                  /// Remember & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() => rememberMe = val ?? false);
                            },
                          ),
                          const Text("Remember me"),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPasswordScreen.routeName,
                          );
                        },
                        child: const Text("Forgot Password?"),
                      ),
                    ],
                  ),
            
                  SizedBox(height: gap),
            
                  /// Login Button
                  ///
                  ///
                  Visibility(
                    visible: !_isLoading,
                    child: LoginButton(
                      buttonName: "Login",
                      onPressed: _login,
                    ),
                  ),

                  Visibility(
                    visible: _isLoading,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  // LoginButton(
                  //   buttonName: "Login",
                  //   onPressed: _login,
                  // ),
            
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

                  /// Switch to Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.routeName);
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
