import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextTheme textThemeDark = TextTheme(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.0,
      color: AppColors.textPrimaryDark,
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.7,
      color: AppColors.textPrimaryDark,
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: AppColors.textPrimaryDark,
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: AppColors.textPrimaryDark,
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.textPrimaryDark,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryDark,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryDark,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2, // tracking-wider
      color: AppColors.textMutedDark,
    ),
  );

  static TextTheme textThemeLight = TextTheme(
    displayLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      letterSpacing: -1.0,
      color: AppColors.textPrimaryLight,
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 26,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.7,
      color: AppColors.textPrimaryLight,
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      color: AppColors.textPrimaryLight,
    ),
    headlineMedium: GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.3,
      color: AppColors.textPrimaryLight,
    ),
    titleLarge: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.2,
      color: AppColors.textPrimaryLight,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColors.textPrimaryLight,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondaryLight,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      color: AppColors.textMutedLight,
    ),
  );
}
