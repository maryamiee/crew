import 'package:flutter/material.dart';

/// CREW Admin Portal palette — Green, per the mockup ("Powerful. Secure.
/// Reliable. For a Safer Campus."). Kept in its own namespace from the
/// Student module's blue palette and the Coordinator module's purple
/// palette so all 3 can exist in one app without collisions.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1E9E5C);
  static const Color primaryDark = Color(0xFF15803D);
  static const Color primaryLight = Color(0xFFE3F7EC);

  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF2563EB);

  static const Color background = Color(0xFFF6F8F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF0F3F1);
  static const Color divider = Color(0xFFE4E9E6);

  static const Color textPrimary = Color(0xFF0F1B14);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFFA0AEC0);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Status colors (complaint lifecycle)
  static const Color statusPending = warning;
  static const Color statusInProgress = Color(0xFF2563EB);
  static const Color statusResolved = primary;
  static const Color statusRejected = error;

  static const Color shadow = Color(0x14000000);
}
