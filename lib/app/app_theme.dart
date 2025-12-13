import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static const Color primaryColor = Color(0xFF0D99FF);
  static const Color secondaryColor = Color(0xFFAAAAAA);


  // App Theme Data
  // static ThemeData get lightTheme{
  //   return ThemeData(
  //     brightness: Brightness.light
  //   );
  // }
  // static ThemeData get darkTheme{
  //   return ThemeData(
  //     brightness: Brightness.dark
  //   );
  // }

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme:  TextTheme(
      headlineSmall: heading3,
      headlineMedium: heading2,
      headlineLarge: heading1
    )
  );


//   Custom Text Styles

  static final TextStyle heading1 = GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontStyle: FontStyle.normal, // অথবা FontStyle.italic
    ),
  );

  static final TextStyle heading2 = GoogleFonts.roboto(
    textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87
    ),
  );

  static TextStyle heading3 = GoogleFonts.roboto(
    textStyle: TextStyle(
        fontSize: 14,
        color: Colors.black54
    ),
  );





}