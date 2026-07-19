import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';

/// SCREEN 11 — Emergency Alerts (green Admin module)
/// Live SOS feed — active alert banner up top, history below.
class EmergencyAlertsScreen extends StatelessWidget {
  const EmergencyAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Alerts')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.error, borderRadius: AppRadius.card),
            child: Row(children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Active Alert',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  const Text('Fire Emergency',
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700)),
                  Text('Main Block', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13)),
                ]),
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.error),
                onPressed: () {},
                child: const Text('View'),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Text('Recent Alerts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.md),
          _AlertTile(icon: Icons.local_fire_department_rounded, title: 'Fire Drill', place: 'Main Block', time: 'May 25, 2024 · 10:30 AM'),
          _AlertTile(icon: Icons.medical_services_rounded, title: 'Medical Emergency', place: 'Hostel Block', time: 'May 24, 2024 · 09:15 AM'),
          _AlertTile(icon: Icons.security_rounded, title: 'Security Alert', place: 'Parking Area', time: 'May 23, 2024 · 08:20 PM'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_alert_rounded),
        label: const Text('Create Alert'),
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.icon, required this.title, required this.place, required this.time});
  final IconData icon;
  final String title, place, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.error, size: 20),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
            Text(place, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ]),
        ),
        Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ]),
    );
  }
}
