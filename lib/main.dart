import 'package:flutter/material.dart';
import 'admin/features/theme/app_theme.dart';
import 'admin/screens/admin_splash_screen.dart';

/// Standalone entry point so you can run and test the (updated, final)
/// Admin module on its own before wiring it into the shared/unified
/// crew app entry point alongside Student and Coordinator.
/// Starts at the Admin Splash screen -> Login -> AdminShell (bottom-nav
/// Dashboard/Reports/Users/Alerts/More flow).
void main() {
  runApp(const CrewAdminApp());
}

class CrewAdminApp extends StatelessWidget {
  const CrewAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CREW Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.adminTheme,
      home: const AdminSplashScreen(),
    );
  }
}
