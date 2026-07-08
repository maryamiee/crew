/// Shared spacing / radius / elevation / duration scale.
/// Keep these identical to Member 1's tokens so the whole app feels
/// like one product once modules are merged.
class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  AppRadius._();
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 20;
  static const double pill = 100; // buttons
}

class AppElevation {
  AppElevation._();
  static const double card = 2;
  static const double raised = 6;
}

class AppDuration {
  AppDuration._();
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
}
