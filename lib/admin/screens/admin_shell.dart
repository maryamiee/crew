import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import 'admin_dashboard_screen.dart';
import 'reports_management_screen.dart';
import 'students_list_screen.dart';
import 'emergency_alerts_screen.dart';
import 'analytics_screen.dart';
import 'admin_profile_screen.dart';
import 'admin_login_screen.dart';

/// Root shell for the green Admin module — persistent bottom navigation
/// (Dashboard / Reports / Users / Alerts / More), matching the mockup.
/// "More" opens a sheet linking to Analytics and Profile, keeping the
/// bottom bar itself to 5 items as shown.
class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;

  final _pages = const [
    AdminDashboardScreen(),
    ReportsManagementScreen(),
    StudentsListScreen(),
    EmergencyAlertsScreen(),
  ];

  void _openMore() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (sheetContext) => SafeArea(
        child: Wrap(children: [
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded, color: AppColors.primary),
            title: const Text('Analytics'),
            onTap: () {
              Navigator.pop(sheetContext);
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(sheetContext);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AdminProfileScreen(onLogout: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                    (route) => false,
                  );
                }),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.error),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(sheetContext);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                (route) => false,
              );
            },
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (i) {
          if (i == 4) {
            _openMore();
          } else {
            setState(() => _index = i);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.description_rounded), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Users'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active_rounded), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz_rounded), label: 'More'),
        ],
      ),
    );
  }
}
