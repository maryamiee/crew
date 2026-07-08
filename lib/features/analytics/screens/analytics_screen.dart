import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/stat_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  // Demo weekly data for the simple bar chart (reports received per week)
  static const _weeklyData = [8.0, 14.0, 10.0, 18.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Analytics · This Month')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.35,
            children: const [
              StatCard(label: 'Total Reports', value: '50', icon: Icons.description_outlined, color: AppColors.trustBlue),
              StatCard(label: 'Resolution Rate', value: '87%', icon: Icons.trending_up_rounded, color: AppColors.safetyGreen),
              StatCard(label: 'Avg. Response Time', value: '3.2h', icon: Icons.timer_outlined, color: AppColors.warningAmber),
              StatCard(label: 'Repeat Reports', value: '4', icon: Icons.repeat_rounded, color: AppColors.errorRed),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Reports Received by Week', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SizedBox(
                height: 160,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(_weeklyData.length, (i) {
                    final heightFactor = _weeklyData[i] / 20.0;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_weeklyData[i].toInt().toString(),
                            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: AppDuration.slow,
                          curve: Curves.easeOutCubic,
                          width: 32,
                          height: 110 * heightFactor.clamp(0.1, 1.0),
                          decoration: BoxDecoration(
                            color: AppColors.adminPrimary,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('W${i + 1}', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Top Categories', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: const [
                  _CategoryRow(label: 'Harassment', percent: 0.32, color: AppColors.errorRed),
                  SizedBox(height: AppSpacing.sm),
                  _CategoryRow(label: 'Facility Issues', percent: 0.28, color: AppColors.trustBlue),
                  SizedBox(height: AppSpacing.sm),
                  _CategoryRow(label: 'Theft', percent: 0.20, color: AppColors.warningAmber),
                  SizedBox(height: AppSpacing.sm),
                  _CategoryRow(label: 'Bullying', percent: 0.20, color: AppColors.safetyGreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String label;
  final double percent;
  final Color color;
  const _CategoryRow({required this.label, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Text('${(percent * 100).toInt()}%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 6,
            backgroundColor: AppColors.surfaceMuted,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}
