import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1A73E8);
  static const Color secondary = Color(0xFF0F172A);
  static const Color accent = Color(0xFF10B981);
  static const Color background = Color(0xFFF8FAFC);
  static const Color text = Color(0xFF1E293B);
  static const Color textLight = Color(0xFF64748B);
  static const Color white = Colors.white;
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    height: 1.2,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    height: 1.3,
  );

  static const TextStyle heading3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
    height: 1.4,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    height: 1.6,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 0.5,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}