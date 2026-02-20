// // import 'package:flutter/material.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/otp_screen.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/otp_success.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
// // import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
// // import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// // import '../features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// // import '../features/home/presentation/screens/home_screen.dart';
// // import '../features/home/presentation/screens/generic_main_screen.dart';
// //
// // class AppRoutes {
// //   static Route smooth(Widget page) {
// //     return PageRouteBuilder(
// //       transitionDuration: const Duration(milliseconds: 350),
// //       reverseTransitionDuration: const Duration(milliseconds: 300),
// //       pageBuilder: (_, __, ___) => page,
// //       transitionsBuilder: (_, animation, __, child) {
// //         final slide = Tween(
// //           begin: const Offset(1.0, 0.0),
// //           end: Offset.zero,
// //         ).animate(
// //           CurvedAnimation(
// //             parent: animation,
// //             curve: Curves.easeOutCubic,
// //           ),
// //         );
// //
// //         final fade = Tween(begin: 0.0, end: 1.0).animate(animation);
// //
// //         return SlideTransition(
// //           position: slide,
// //           child: FadeTransition(
// //             opacity: fade,
// //             child: child,
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //
// //
// //
// //
// //
// //
// //   static final Map<String, WidgetBuilder> routes = {
// //
// //     // splashscreen route
// //     SplashScreenPage.routeName: (_) => const SplashScreenPage(),
// //     SplashScreenTwo.routeName: (_) => const SplashScreenTwo(),
// //     RoleSelectionScreen.routeName:(_) => const RoleSelectionScreen(),
// //
// //
// //     // Auth route
// //     LoginScreen.routeName: (_) => const LoginScreen(),
// //     SignUpScreen.routeName: (_) => SignUpScreen(),
// //     ForgotPasswordScreen.routeName: (_) => ForgotPasswordScreen(),
// //     OTPScreen.routeName: (_) => OTPScreen(),
// //     OTPSuccess.routeName: (_) => OTPSuccess(),
// //     DonorScreen.routeName: (_) => DonorScreen(),
// //     DonorNotificationScreen.routeName: (_) => DonorNotificationScreen(),
// //
// //
// //
// //
// //     // person information get
// //     GenericInformationFormScreen.routeName: (_) => GenericInformationFormScreen(),
// //
// //     GetInformationDetails.routeName: (_) => GetInformationDetails(),
// //     //donor screen
// //     DonorScreen.routeName: (_) => DonorScreen(),
// //     HomePageScreen.routeName: (_) => const HomePageScreen(),
// //
// //
// //
// //
// //
// //   //   receiver screen
// //     ReceiverScreen.routeName:(_) => ReceiverScreen(),
// //     ReceiverHomeScreen.routeName:(_) => ReceiverHomeScreen(),
// //
// //
// //
// //     //   Volunteer screen
// //     VolunteerScreen.routeName: (_) => VolunteerScreen(),
// //     VolunteerHomeScreen.routeName: (_) => VolunteerHomeScreen(),
// //
// //   };
// //
// //   static Route<dynamic> onGenerate(RouteSettings settings) {
// //     final builder = routes[settings.name];
// //     return MaterialPageRoute(builder: builder ?? (_) =>
// //     const Scaffold(
// //       body: Center(child: Text("Page Not Found"),),));
// //   }
// //
// // }
//
// import 'package:flutter/material.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/otp_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/otp_success.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
// import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
// import '../features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
// import '../features/home/presentation/screens/home_screen.dart';
// import '../features/home/presentation/screens/generic_main_screen.dart';
//
// class AppRoutes {
//   /// =========================================
//   /// Smooth PageRoute with slide + fade animation
//   /// =========================================
//   static Route smooth(Widget page) {
//     return PageRouteBuilder(
//       transitionDuration: const Duration(milliseconds: 500),
//       reverseTransitionDuration: const Duration(milliseconds: 450),
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         final curved = CurvedAnimation(
//           parent: animation,
//           curve: Curves.easeOutQuart,
//           reverseCurve: Curves.easeInQuart,
//         );
//
//         final slide = Tween<Offset>(
//           begin: const Offset(0.15, 0.0), // subtle slide
//           end: Offset.zero,
//         ).animate(curved);
//
//         final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
//           CurvedAnimation(
//             parent: animation,
//             curve: const Interval(0.2, 1.0),
//           ),
//         );
//
//         return SlideTransition(
//           position: slide,
//           child: FadeTransition(
//             opacity: fade,
//             child: child,
//           ),
//         );
//       },
//     );
//   }
//
//   /// =========================================
//   /// All named routes (context-free widgets)
//   /// =========================================
//   static final Map<String, Widget Function()> routes = {
//     // Splash Screens
//     SplashScreenPage.routeName: () => const SplashScreenPage(),
//     SplashScreenTwo.routeName: () => const SplashScreenTwo(),
//     RoleSelectionScreen.routeName: () => const RoleSelectionScreen(),
//
//     // Auth
//     LoginScreen.routeName: () => const LoginScreen(),
//     SignUpScreen.routeName: () => SignUpScreen(),
//     ForgotPasswordScreen.routeName: () => ForgotPasswordScreen(),
//     OTPScreen.routeName: () => OTPScreen(),
//     OTPSuccess.routeName: () => OTPSuccess(),
//
//     // Donor Screens
//     DonorScreen.routeName: () => DonorScreen(),
//     DonorNotificationScreen.routeName: () => DonorNotificationScreen(),
//
//     // Person info
//     GenericInformationFormScreen.routeName: () => GenericInformationFormScreen(),
//     GetInformationDetails.routeName: () => GetInformationDetails(),
//
//     // Home
//     HomePageScreen.routeName: () => const HomePageScreen(),
//
//     // Receiver Screens
//     ReceiverScreen.routeName: () => ReceiverScreen(),
//     ReceiverHomeScreen.routeName: () => ReceiverHomeScreen(),
//
//     // Volunteer Screens
//     VolunteerScreen.routeName: () => VolunteerScreen(),
//     VolunteerHomeScreen.routeName: () => VolunteerHomeScreen(),
//   };
//
//   /// =========================================
//   /// onGenerateRoute for MaterialApp
//   /// Named route + smooth animation support
//   /// =========================================
//   static Route<dynamic> onGenerate(RouteSettings settings) {
//     final builder = routes[settings.name];
//
//     if (builder != null) {
//       // Return smooth animated route
//       return smooth(builder());
//     }
//
//     // Fallback for unknown routes
//     return MaterialPageRoute(
//       builder: (_) => const Scaffold(
//         body: Center(child: Text("Page Not Found")),
//       ),
//     );
//   }
//
//   /// =========================================
//   /// Optional helper: pushReplacementNamed with smooth animation
//   /// Use like:
//   /// AppRoutes.pushReplacementNamed(context, SignUpScreen.routeName)
//   /// =========================================
//   static void pushReplacementNamed(BuildContext context, String routeName) {
//     final builder = routes[routeName];
//     if (builder != null) {
//       Navigator.pushReplacement(context, smooth(builder()));
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text("Page Not Found")),
//           ),
//         ),
//       );
//     }
//   }
//
//   /// Optional helper: pushNamed with smooth animation
//   static void pushNamed(BuildContext context, String routeName) {
//     final builder = routes[routeName];
//     if (builder != null) {
//       Navigator.push(context, smooth(builder()));
//     } else {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text("Page Not Found")),
//           ),
//         ),
//       );
//     }
//   }
//
//   /// Optional helper: pushAndRemoveUntil with smooth animation
//   static void pushAndRemoveUntil(BuildContext context, String routeName, bool Function(dynamic route) param2) {
//     final builder = routes[routeName];
//     if (builder != null) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         smooth(builder()),
//             (route) => false,
//       );
//     } else {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text("Page Not Found")),
//           ),
//         ),
//             (route) => false,
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:waste_food_management/features/auth/presentation/screens/forgot_password.dart';
import 'package:waste_food_management/features/auth/presentation/screens/generic_information_form_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/login_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/otp_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/otp_success.dart';
import 'package:waste_food_management/features/auth/presentation/screens/signup_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen2.dart';
import 'package:waste_food_management/features/auth/presentation/screens/select_role_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/donor_notification_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/donor/presentation/screens/get_information_details_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/receiver/presentation/screens/receiver_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_home_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/screens/volunteer_screen.dart';
import 'package:waste_food_management/features/home/presentation/screens/volunteer/presentation/section/volunteer_notification_section.dart';
import '../features/home/presentation/screens/donor/presentation/screens/donor_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/home/presentation/screens/generic_main_screen.dart';

class AppRoutes {
  /// =========================================
  /// Smooth PageRoute with slide + fade animation
  /// =========================================
  static Route smooth(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 450),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutQuart,
          reverseCurve: Curves.easeInQuart,
        );

        final slide = Tween<Offset>(
          begin: const Offset(0.15, 0.0), // subtle slide
          end: Offset.zero,
        ).animate(curved);

        final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.2, 1.0),
          ),
        );

        return SlideTransition(
          position: slide,
          child: FadeTransition(
            opacity: fade,
            child: child,
          ),
        );
      },
    );
  }

  /// =========================================
  /// Named routes (context-free widgets)
  /// =========================================
  static final Map<String, Widget Function()> routes = {
    // Splash Screens
    SplashScreenPage.routeName: () => const SplashScreenPage(),
    SplashScreenTwo.routeName: () => const SplashScreenTwo(),
    RoleSelectionScreen.routeName: () => const RoleSelectionScreen(),

    // Auth
    LoginScreen.routeName: () => const LoginScreen(),
    SignUpScreen.routeName: () => SignUpScreen(),
    ForgotPasswordScreen.routeName: () => ForgotPasswordScreen(),
    OTPScreen.routeName: () => OTPScreen(),
    OTPSuccess.routeName: () => OTPSuccess(),

    // Donor Screens
    DonorScreen.routeName: () => DonorScreen(),
    DonorNotificationScreen.routeName: () => DonorNotificationScreen(),

    // Person info
    GenericInformationFormScreen.routeName: () => GenericInformationFormScreen(),
    GetInformationDetails.routeName: () => GetInformationDetails(),

    // Home
    HomePageScreen.routeName: () => const HomePageScreen(),

    // Receiver Screens
    ReceiverScreen.routeName: () => ReceiverScreen(),
    ReceiverHomeScreen.routeName: () => ReceiverHomeScreen(),

    // Volunteer Screens
    VolunteerScreen.routeName: () => VolunteerScreen(),
    VolunteerHomeScreen.routeName: () => VolunteerHomeScreen(),


    VolunteerNotificationSection.routeName: () => VolunteerNotificationSection(),
  };

  /// =========================================
  /// onGenerateRoute for MaterialApp
  /// Named route + smooth animation support
  /// =========================================
  static Route<dynamic> onGenerate(RouteSettings settings) {
    final builder = routes[settings.name];

    if (builder != null) {
      // Return smooth animated route
      return smooth(builder());
    }

    // Fallback for unknown routes
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text("Page Not Found")),
      ),
    );
  }

  /// =========================================
  /// Helper: pushReplacementNamed with smooth animation
  /// =========================================
  static void pushReplacementNamed(BuildContext context, String routeName) {
    final builder = routes[routeName];
    if (builder != null) {
      Navigator.pushReplacement(context, smooth(builder()));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        ),
      );
    }
  }

  /// =========================================
  /// Helper: pushNamed with smooth animation
  /// =========================================
  static void pushNamed(BuildContext context, String routeName) {
    final builder = routes[routeName];
    if (builder != null) {
      Navigator.push(context, smooth(builder()));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        ),
      );
    }
  }

  /// =========================================
  /// Helper: pushAndRemoveUntil with smooth animation
  /// =========================================
  static void pushAndRemoveUntil(BuildContext context, String routeName) {
    final builder = routes[routeName];
    if (builder != null) {
      Navigator.pushAndRemoveUntil(
        context,
        smooth(builder()),
            (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Page Not Found")),
          ),
        ),
            (route) => false,
      );
    }
  }
}

