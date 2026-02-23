// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// //
// // class AppData{
// //   static const Color primaryColor = Color(0xFF0D99FF);
// //   static const Color secondaryColor = Color(0xFFAAAAAA);
// //
// //
// //   // App Theme Data
// //   // static ThemeData get lightTheme{
// //   //   return ThemeData(
// //   //     brightness: Brightness.light
// //   //   );
// //   // }
// //   // static ThemeData get darkTheme{
// //   //   return ThemeData(
// //   //     brightness: Brightness.dark
// //   //   );
// //   // }
// //
// //   static ThemeData themeData = ThemeData(
// //     primaryColor: primaryColor,
// //     scaffoldBackgroundColor: Colors.white,
// //     textTheme:  TextTheme(
// //       headlineSmall: heading3,
// //       headlineMedium: heading2,
// //       headlineLarge: heading1
// //     )
// //   );
// //
// //
// // //   Custom Text Styles
// //
// //   static final TextStyle heading1 = GoogleFonts.roboto(
// //     textStyle: const TextStyle(
// //       fontSize: 28,
// //       fontWeight: FontWeight.bold,
// //       color: Colors.black,
// //       fontStyle: FontStyle.normal, // অথবা FontStyle.italic
// //     ),
// //   );
// //
// //   static final TextStyle heading2 = GoogleFonts.roboto(
// //     textStyle: TextStyle(
// //         fontSize: 18,
// //         fontWeight: FontWeight.w600,
// //         color: Colors.black87
// //     ),
// //   );
// //
// //   static TextStyle heading3 = GoogleFonts.roboto(
// //     textStyle: TextStyle(
// //         fontSize: 15,
// //         color: Colors.black54
// //     ),
// //   );
// //
// //
// //
// //
// //
// // }
//
//
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class AppData {
//   // ১. অ্যাপের কালার প্যালেট
//   static const Color primaryColor = Color(0xFF0D99FF);
//   static const Color secondaryColor = Color(0xFFAAAAAA);
//
//   // ২. লাইট থিম কনফিগারেশন
//   static ThemeData get lightTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       primaryColor: primaryColor,
//       scaffoldBackgroundColor: Colors.white,
//       textTheme: TextTheme(
//         headlineSmall: heading3,
//         headlineMedium: heading2,
//         headlineLarge: heading1,
//       ),
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: primaryColor,
//         brightness: Brightness.light,
//       ),
//     );
//   }
//
//   // ৩. ডার্ক থিম কনফিগারেশন
//   static ThemeData get darkTheme {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       primaryColor: primaryColor,
//       scaffoldBackgroundColor: const Color(0xFF121212), // স্ট্যান্ডার্ড ডার্ক ব্যাকগ্রাউন্ড
//       textTheme: TextTheme(
//         headlineSmall: heading3.copyWith(color: Colors.white70),
//         headlineMedium: heading2.copyWith(color: Colors.white),
//         headlineLarge: heading1.copyWith(color: Colors.white),
//       ),
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: primaryColor,
//         brightness: Brightness.dark,
//       ),
//     );
//   }
//
//   // ৪. কাস্টম টেক্সট স্টাইলসমূহ
//   static final TextStyle heading1 = GoogleFonts.roboto(
//     textStyle: const TextStyle(
//       fontSize: 28,
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//       fontStyle: FontStyle.normal,
//     ),
//   );
//
//   static final TextStyle heading2 = GoogleFonts.roboto(
//     textStyle: const TextStyle(
//       fontSize: 18,
//       fontWeight: FontWeight.w600,
//       color: Colors.black87,
//     ),
//   );
//
//   static final TextStyle heading3 = GoogleFonts.roboto(
//     textStyle: const TextStyle(
//       fontSize: 15,
//       color: Colors.black54,
//     ),
//   );
//
//   // আপনার আগের থিম ভ্যারিয়েবলটি যাতে অন্য কোথাও এরর না দেয়
//   static ThemeData themeData = lightTheme;
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';

class AppData {
  // লাইট থিম কনফিগারেশন
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: AppColor.white,
      appBarTheme: const AppBarTheme(backgroundColor: AppColor.white, foregroundColor: AppColor.black),
      dividerColor: AppColor.lightgray,
      textTheme: TextTheme(
        headlineLarge: heading1.copyWith(color: AppColor.black),
        headlineMedium: heading2.copyWith(color: AppColor.black),
        headlineSmall: heading3.copyWith(color: AppColor.gray),
      ),
    );
  }

  // ডার্ক থিম কনফিগারেশন
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColor.primary,
      scaffoldBackgroundColor: const Color(0xFF121212), // স্ট্যান্ডার্ড ডার্ক
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF121212), foregroundColor: AppColor.white),
      dividerColor: AppColor.gray,
      textTheme: TextTheme(
        headlineLarge: heading1.copyWith(color: AppColor.white),
        headlineMedium: heading2.copyWith(color: AppColor.white),
        headlineSmall: heading3.copyWith(color: AppColor.lightgray),
      ),
    );
  }

  // কাস্টম টেক্সট স্টাইল (আপনার আগের কোড অনুযায়ী)
  static final TextStyle heading1 = GoogleFonts.roboto(
    fontSize: 28, fontWeight: FontWeight.bold,
  );

  static final TextStyle heading2 = GoogleFonts.roboto(
    fontSize: 18, fontWeight: FontWeight.w600,
  );

  static final TextStyle heading3 = GoogleFonts.roboto(
    fontSize: 15,
  );
}