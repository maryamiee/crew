import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();
  static const double xs = 4, sm = 8, md = 12, lg = 16, xl = 24, xxl = 32, xxxl = 48;
}

class AppRadius {
  AppRadius._();
  static const double sm = 8, md = 14, lg = 20, pill = 100;
  static BorderRadius get card => BorderRadius.circular(md);
  static BorderRadius get button => BorderRadius.circular(pill);
}

class AppElevation {
  AppElevation._();
  static List<BoxShadow> card = [
    const BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, 6)),
  ];
}
