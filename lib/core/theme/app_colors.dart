import 'package:flutter/material.dart';

/// Corp Dieck SaaS / Startup Grade Color Palette
class AppColors {
  // Backgrounds (Dark Mode First - SaaS Aesthetic)
  static const Color darkBackground = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceCard = Color(0xFF1F2937);
  static const Color darkBorder = Color(0x1AFFFFFF); // 10% white border

  // Light Mode Defaults
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceCard = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0x0F000000); // 6% black border

  // Brand Accents
  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryBlueGlow = Color(0xFF3B82F6);
  static const Color accentCyan = Color(0xFF06B6D4);
  static const Color accentIndigo = Color(0xFF6366F1);
  static const Color accentPurple = Color(0xFF8B5CF6);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color successBg = Color(0x1F10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningBg = Color(0x1FF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color errorBg = Color(0x1FEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Text Neutral Colors
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);
  static const Color textMutedDark = Color(0xFF6B7280);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Glassmorphism & Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradientDark = LinearGradient(
    colors: [Color(0x26FFFFFF), Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
