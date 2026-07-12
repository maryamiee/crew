import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/admin_shell.dart';

/// Standalone entry point so you can run and test your Admin module
/// on its own before merging into the shared crew_app project.
/// When you get Member 1's project, you'll instead add AdminShell
/// as a route inside their GoRouter setup — see README.md.
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
      home: const AdminShell(),
    );
  }
}
