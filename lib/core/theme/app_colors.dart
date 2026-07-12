import 'package:flutter/material.dart';

/// CREW app color tokens.
/// Shared palette across Student, Admin, and Integration modules.
/// Admin module uses Green as its primary accent; other tokens stay
/// identical to the rest of the app so screens merge seamlessly.
class AppColors {
  AppColors._();

  // ---- Base brand tokens (shared across all 3 members) ----
  static const Color trustBlue = Color(0xFF2E5AAC); // Student accent
  static const Color safetyGreen = Color(0xFF2E9E6D); // Admin accent
  static const Color integrationPurple = Color(0xFF7C5CBF); // Integration accent

  static const Color warningAmber = Color(0xFFE8A33D);
  static const Color errorRed = Color(0xFFD64545);
  static const Color sosRed = Color(0xFFC62828);

  // ---- Admin-specific semantic aliases ----
  static const Color adminPrimary = safetyGreen;
  static const Color adminPrimaryDark = Color(0xFF1F7A54);
  static const Color adminPrimaryLight = Color(0xFFE3F4EC);

  // ---- Neutrals ----
  static const Color background = Color(0xFFF5F6F8); // light grey background
  static const Color surface = Color(0xFFFFFFFF); // white cards
  static const Color surfaceMuted = Color(0xFFF0F1F4);
  static const Color divider = Color(0xFFE4E6EA);

  static const Color textPrimary = Color(0xFF1B1D22);
  static const Color textSecondary = Color(0xFF6B7078);
  static const Color textOnDark = Color(0xFFFFFFFF);

  // ---- Status colors (complaint / report lifecycle) ----
  static const Color statusSubmitted = Color(0xFF6B7078); // grey
  static const Color statusUnderReview = warningAmber;
  static const Color statusResolved = safetyGreen;
  static const Color statusUrgent = errorRed;

  // ---- Shadows ----
  static const Color shadowColor = Color(0x1A1B1D22); // soft, low-opacity
}
