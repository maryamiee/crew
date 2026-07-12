import 'package:crew/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CrewApp());
}

class CrewApp extends StatelessWidget {
  const CrewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CREW — Campus Reporting & Emergency Workflow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const Scaffold(body: Center(child: Text('CREW'))),
    );
  }
}
