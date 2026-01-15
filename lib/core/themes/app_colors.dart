import 'package:flutter/material.dart';

class AppColors {
  // Primary & Brand Colors
  static const Color primary = Color(0xFF0F488E); // dark blue
  static const Color secondary = Color(0xFF00F488E); // green accent

  // Text Colors
  static const Color textPrimary = Color(0xFF0F274A); // dark gray / almost black
  static const Color textSecondary = Color(0xFF0F274A); // muted dark
  static const Color textMuted = Color(0xFF0F274A); // 60% opacity use where needed

  // Background
  static const Color background = Color(0xFFF1F9FF);
  static const Color white = Colors.white;

  // Border / Divider
  static const Color border = Color(0xFF0F488E);
  static const Color borderLight = Color(0xFF0F274A); // subtle borders

  // Success / Checkmark
  static const Color success = Colors.green;

  // Shadow
  static Color shadow = Colors.black.withOpacity(0.08);
}
