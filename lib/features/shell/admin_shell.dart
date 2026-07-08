import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../complaints/models/complaint.dart';
import '../complaints/screens/complaint_details_screen.dart';
import '../complaints/screens/complaints_list_screen.dart';
import '../complaints/screens/update_status_screen.dart';
import '../dashboard/screens/admin_dashboard_screen.dart';
import '../alerts/screens/emergency_alerts_screen.dart';
import '../students/screens/students_list_screen.dart';
import '../analytics/screens/analytics_screen.dart';
import '../profile/screens/admin_profile_screen.dart';
import '../auth/screens/admin_login_screen.dart';

/// Top-level shell for the Admin module. Uses NavigationRail (wider,
/// desktop/tablet-friendly) instead of the Student module's bottom nav,
/// as specified in the team handoff doc — while reusing the same
/// theme tokens, cards, and button styles.
class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  bool _loggedIn = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    if (!_loggedIn) {
      return AdminLoginScreen(onLoginSuccess: () => setState(() => _loggedIn = true));
    }

    final destinations = const [
      NavigationRailDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard_rounded), label: Text('Dashboard')),
      NavigationRailDestination(icon: Icon(Icons.description_outlined), selectedIcon: Icon(Icons.description_rounded), label: Text('Complaints')),
      NavigationRailDestination(icon: Icon(Icons.emergency_outlined), selectedIcon: Icon(Icons.emergency_rounded), label: Text('Alerts')),
      NavigationRailDestination(icon: Icon(Icons.people_alt_outlined), selectedIcon: Icon(Icons.people_alt_rounded), label: Text('Students')),
      NavigationRailDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart_rounded), label: Text('Analytics')),
      NavigationRailDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: Text('Profile')),
    ];

    final pages = [
      AdminDashboardScreen(onOpenComplaint: (c) => _openComplaint(context, c)),
      ComplaintsListScreen(onOpenComplaint: (c) => _openComplaint(context, c)),
      const EmergencyAlertsScreen(),
      const StudentsListScreen(),
      const AnalyticsScreen(),
      AdminProfileScreen(onLogout: () => setState(() => _loggedIn = false)),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            labelType: NavigationRailLabelType.all,
            destinations: destinations,
          ),
          const VerticalDivider(width: 1, color: AppColors.divider),
          Expanded(child: pages[_index]),
        ],
      ),
    );
  }

  void _openComplaint(BuildContext context, Complaint complaint) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ComplaintDetailsScreen(
          complaint: complaint,
          onUpdateStatus: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => UpdateStatusScreen(
                  complaint: complaint,
                  onSave: (status, remarks) {
                    // TODO: persist to Firestore once project is connected
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
