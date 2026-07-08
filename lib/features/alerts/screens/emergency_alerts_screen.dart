import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/primary_button.dart';

class SosAlert {
  final String id;
  final DateTime triggeredAt;
  final String location;
  final bool resolved;

  const SosAlert({
    required this.id,
    required this.triggeredAt,
    required this.location,
    this.resolved = false,
  });

  static List<SosAlert> demoList() => [
        SosAlert(id: 'SOS-118', triggeredAt: DateTime.now().subtract(const Duration(minutes: 4)), location: 'Near Block C, Library'),
        SosAlert(id: 'SOS-117', triggeredAt: DateTime.now().subtract(const Duration(minutes: 40)), location: 'Main Gate'),
        SosAlert(id: 'SOS-112', triggeredAt: DateTime.now().subtract(const Duration(hours: 5)), location: 'Sports Complex', resolved: true),
      ];
}

/// Emergency Alerts screen. Student identity is intentionally NOT shown
/// here beyond location + timestamp, consistent with the app's privacy
/// posture — admins dispatch help based on location, not identity, unless
/// the underlying report is non-anonymous.
class EmergencyAlertsScreen extends StatelessWidget {
  const EmergencyAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = SosAlert.demoList();
    final active = alerts.where((a) => !a.resolved).toList();
    final past = alerts.where((a) => a.resolved).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Emergency Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          if (active.isNotEmpty) ...[
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: AppColors.sosRed, shape: BoxShape.circle),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text('Active (${active.length})', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ...active.map((a) => _AlertCard(alert: a)),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text('Past Alerts', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          ...past.map((a) => _AlertCard(alert: a)),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  final SosAlert alert;
  const _AlertCard({required this.alert});

  @override
  Widget build(BuildContext context) {
    final isActive = !alert.resolved;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isActive ? AppColors.errorRed.withValues(alpha: 0.06) : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: isActive ? AppColors.errorRed.withValues(alpha: 0.3) : AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.emergency_rounded, color: isActive ? AppColors.sosRed : AppColors.textSecondary, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Text(alert.id, style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
              Text(_timeAgo(alert.triggeredAt), style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(alert.location, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(label: 'Dispatch Help', color: AppColors.sosRed, onPressed: () {}),
          ],
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
