import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // no instance

  // 🌟 BRAND COLORS
  static const Color primary = Color(0xFFFFB300); // amber
  static const Color secondary = Color(0xFF2C2C2C);

  // 🧱 BACKGROUND
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFFF9F9F9);

  // 📝 TEXT
  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFF9E9E9E);

  // 🎨 UI ELEMENTS
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // 🔘 BUTTONS
  static const Color buttonPrimary = primary;
  static const Color buttonText = Colors.white;

  // 🚦 STATUS
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);

  // 🌫 OVERLAY
  static const Color overlay = Color(0x66000000);

  static const Color lightGold = Color(0xFFF8EBDC);
  static const Color darkGold1 = Color(0xFFCFA349);
  static const Color darkGold2 = Color(0xFFA6781F);
  static const Color mainBlue = Color(0xFF1A2435);
  static const Color lightBlue = Color(0xFF46546F);
  static const Color lightBlue2 = Color(0xFF2B374D);


  static const LinearGradient goldBtnGradient =
  LinearGradient(
    colors: [
      darkGold1,
      darkGold2,
    ],
  );
}
