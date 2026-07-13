import 'package:flutter/material.dart';

/// CREW design system — color tokens.
/// Never use raw hex values anywhere else in the app; always reference these.
class AppColors {
  AppColors._();

  static const Color primaryBlue = Color(0xFF2563EB);
  static const Color primaryBlueDark = Color(0xFF1D4ED8);
  static const Color primaryBlueLight = Color(0xFF60A5FA);

  static const Color secondaryGreen = Color(0xFF10B981);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color errorRedDark = Color(0xFFDC2626);

  static const Color background = Color(0xFFF3F6FB);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);

  static const Color divider = Color(0xFFE5E7EB);
  static const Color inputFill = Color(0xFFF9FAFB);
  static const Color inputBorder = Color(0xFFE2E8F0);

  static const Color chipUnselectedBg = Color(0xFFFFFFFF);
  static const Color chipUnselectedBorder = Color(0xFFE5E7EB);

  // Status colors
  static const Color statusSubmitted = Color(0xFF2563EB);
  static const Color statusUnderReview = Color(0xFFF59E0B);
  static const Color statusResolved = Color(0xFF10B981);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, primaryBlueDark],
  );

  static const LinearGradient sosGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
  );

  static Color withOpacityToken(Color color, double opacity) =>
      color.withValues(alpha: opacity);
}
