import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';

/// Analytics — deeper reporting view, reachable from the "More" tab.
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('This Month', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: AppSpacing.md),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _MiniStat(label: 'Total', value: '320', color: AppColors.primary),
                _MiniStat(label: 'Resolved', value: '196', color: AppColors.statusResolved),
                _MiniStat(label: 'Pending', value: '112', color: AppColors.statusPending),
              ]),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('Complaints by Category', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: AppSpacing.sm),
          ...const [
            ('Bullying', 0.35, AppColors.primary),
            ('Harassment', 0.25, AppColors.info),
            ('Infrastructure', 0.20, AppColors.warning),
            ('Safety', 0.15, AppColors.error),
            ('Other', 0.05, AppColors.textDisabled),
          ].map((e) => _BarRow(label: e.$1, value: e.$2, color: e.$3)),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.color});
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
      Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    ]);
  }
}

class _BarRow extends StatelessWidget {
  const _BarRow({required this.label, required this.value, required this.color});
  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
          Text('${(value * 100).round()}%', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600)),
        ]),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(value: value, minHeight: 6, backgroundColor: AppColors.surfaceMuted, valueColor: AlwaysStoppedAnimation(color)),
        ),
      ]),
    );
  }
}
