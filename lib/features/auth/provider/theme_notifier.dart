// import 'package:flutter/material.dart';
//
// class ThemeNotifier extends ChangeNotifier {
//   // ডিফল্ট থিম মোড
//   ThemeMode _themeMode = ThemeMode.light;
//
//   ThemeMode get themeMode => _themeMode;
//
//   // এটি না থাকলে এরর দিবে। এখন এটি চেক করবে থিম ডার্ক কি না।
//   bool get isDark => _themeMode == ThemeMode.dark;
//
//   // থিম পরিবর্তন করার মেথড
//   void toggleTheme(bool isDarkMode) {
//     _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
//     notifyListeners(); // এটি পুরো অ্যাপকে রিফ্রেশ করবে
//   }
// }



import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}