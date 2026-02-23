// // // import 'package:flutter/cupertino.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:waste_food_management/app/app_routes.dart';
// // // import 'package:waste_food_management/app/app_theme.dart';
// // // import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
// // //
// // // class WasteFoodManagementApp extends StatefulWidget{
// // //   const WasteFoodManagementApp({super.key});
// // //
// // //   @override
// // //   State<StatefulWidget> createState() {
// // //     return _WasteFoodManagementAppState();
// // //   }
// // //
// // // }
// // //
// // // class _WasteFoodManagementAppState  extends State<WasteFoodManagementApp>{
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       initialRoute: SplashScreenPage.routeName,
// // //       onGenerateRoute: AppRoutes.onGenerate,
// // //       theme: ThemeData(
// // //         textTheme: GoogleFonts.robotoTextTheme(
// // //           Theme.of(context).textTheme,
// // //         ),
// // //       ),
// // //       darkTheme: AppData.themeData,
// // //       themeMode: ThemeMode.light,
// // //
// // //     );
// // //   }
// // // }
// //
// //
// //
// //
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:provider/provider.dart';
// //
// // // তোমার পাথগুলো প্রোজেক্ট অনুযায়ী চেক করে নিও
// // import 'package:waste_food_management/app/app_routes.dart';
// // import 'package:waste_food_management/app/app_theme.dart'; // AppData এখান থেকে আসবে
// // import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
// // import 'package:waste_food_management/features/auth/provider/theme_notifier.dart';
// //
// // class WasteFoodManagementApp extends StatelessWidget {
// //   const WasteFoodManagementApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // প্রফেশনাল অ্যাপ্রোচ: Consumer পুরো অ্যাপের থিম স্টেট মনিটর করে
// //     return Consumer<ThemeNotifier>(
// //       builder: (context, themeNotifier, child) {
// //         return MaterialApp(
// //           debugShowCheckedModeBanner: false,
// //           title: 'Waste Food Management',
// //
// //           // থিম কনফিগারেশন (তোমার AppData থেকে লাইট ও ডার্ক থিম নিচ্ছে)
// //           theme: AppData.lightTheme,
// //           darkTheme: AppData.darkTheme,
// //
// //           // থিম মোড এখন ডাইনামিক (সিস্টেমের ওপর নির্ভর করবে না, ইউজারের চয়েজে চলবে)
// //           themeMode: themeNotifier.themeMode,
// //
// //           // রাউটিং সেটআপ
// //           initialRoute: SplashScreenPage.routeName,
// //           onGenerateRoute: AppRoutes.onGenerate,
// //
// //           // ফন্ট এবং গ্লোবাল স্টাইল হ্যান্ডলার
// //           builder: (context, child) {
// //             return Theme(
// //               data: Theme.of(context).copyWith(
// //                 textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
// //               ),
// //               child: child!,
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:waste_food_management/app/app_routes.dart';
// import 'package:waste_food_management/app/app_theme.dart';
// import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
// import 'package:waste_food_management/features/auth/provider/theme_notifier.dart';
//
// class WasteFoodManagementApp extends StatelessWidget {
//   const WasteFoodManagementApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // context.watch ব্যবহার করা সবচেয়ে ইউজার ফ্রেন্ডলি কারণ এটি রিয়েল টাইম আপডেট দেয়
//     final themeNotifier = context.watch<ThemeNotifier>();
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Waste Food Management',
//
//       // আপনার AppData থেকে থিম লোড হচ্ছে
//       theme: AppData.lightTheme,
//       darkTheme: AppData.darkTheme,
//       themeMode: themeNotifier.themeMode,
//
//       initialRoute: SplashScreenPage.routeName,
//       onGenerateRoute: AppRoutes.onGenerate,
//
//       // সিস্টেম ফন্ট স্কেলিং ঠিক রাখা (User Friendly)
//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
//           child: child!,
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waste_food_management/app/app_routes.dart';
import 'package:waste_food_management/app/app_theme.dart';
import 'package:waste_food_management/features/auth/presentation/screens/splash_screen.dart';
import 'package:waste_food_management/features/auth/provider/theme_notifier.dart';

class WasteFoodManagementApp extends StatelessWidget {
  const WasteFoodManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch ব্যবহার করলে থিম পরিবর্তনের সাথে সাথে অ্যাপ আপডেট হবে
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Food Management',

      // আপনার AppData থেকে থিম লোড হচ্ছে
      theme: AppData.lightTheme,
      darkTheme: AppData.darkTheme,
      themeMode: themeNotifier.themeMode,

      initialRoute: SplashScreenPage.routeName,
      onGenerateRoute: AppRoutes.onGenerate,

      // ইউজার ফ্রেন্ডলি ফন্ট স্কেলিং
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}