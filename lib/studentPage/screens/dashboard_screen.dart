import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/current_user.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_radius.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/soft_card.dart';
import '../features/widgets/status_pill.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPadding, AppSpacing.md, AppSpacing.screenPadding, AppSpacing.xxxl,
          ),
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,', style: textTheme.bodyMedium),
                      Row(
                        children: [
                          ValueListenableBuilder<String>(
                            valueListenable: CurrentUser.name,
                            builder: (context, name, _) =>
                                Text(name, style: textTheme.headlineSmall),
                          ),
                          const SizedBox(width: 6),
                          const Text('👋', style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryBlueLight,
                  child: Icon(Icons.person_rounded, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            InkWell(
              borderRadius: BorderRadius.circular(AppRadius.lg),
              onTap: () => context.push(AppRoutes.emergencySos),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: AppColors.sosGradient,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Emergency SOS',
                              style: textTheme.titleMedium?.copyWith(color: Colors.white)),
                          const SizedBox(height: 2),
                          Text('Tap to alert admin',
                              style: textTheme.bodySmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85))),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text('SOS',
                          style: textTheme.labelLarge?.copyWith(color: AppColors.errorRed)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('Quick Actions', style: textTheme.titleMedium),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                _QuickAction(
                  icon: Icons.campaign_rounded,
                  label: 'Report\nIncident',
                  onTap: () => context.push(AppRoutes.reportCategory),
                ),
                const SizedBox(width: AppSpacing.md),
                const _QuickAction(icon: Icons.construction_rounded, label: 'Campus\nIssues'),
                const SizedBox(width: AppSpacing.md),
                const _QuickAction(icon: Icons.assignment_rounded, label: 'My\nReports'),
                const SizedBox(width: AppSpacing.md),
                const _QuickAction(icon: Icons.notifications_rounded, label: 'Notifi-\ncations'),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Reports', style: textTheme.titleMedium),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const _ReportRow(
              icon: Icons.groups_rounded,
              iconColor: AppColors.errorRed,
              title: 'Bullying Incident',
              date: 'May 25, 2024',
              status: ReportStatus.underReview,
            ),
            const SizedBox(height: AppSpacing.sm),
            const _ReportRow(
              icon: Icons.diversity_3_rounded,
              iconColor: AppColors.warningAmber,
              title: 'Harassment Case',
              date: 'May 23, 2024',
              status: ReportStatus.underReview,
            ),
            const SizedBox(height: AppSpacing.sm),
            const _ReportRow(
              icon: Icons.shield_rounded,
              iconColor: AppColors.secondaryGreen,
              title: 'Cyber Bullying',
              date: 'May 20, 2024',
              status: ReportStatus.resolved,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (i) {
          setState(() => _navIndex = i);
          if (i == 2) context.push(AppRoutes.emergencySos);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Reports'),
          BottomNavigationBarItem(icon: Icon(Icons.emergency_share_rounded), label: 'SOS'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_rounded), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SoftCard(
        onTap: onTap ?? () {},
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.status,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String date;
  final ReportStatus status;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: () {},
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(date, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          StatusPill(status: status),
        ],
      ),
    );
  }
}
