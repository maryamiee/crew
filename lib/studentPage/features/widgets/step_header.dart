import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// AppBar-like header showing "Step X of N" plus a slim progress bar,
/// used across the Report Incident flow for orientation.
class StepHeader extends StatelessWidget implements PreferredSizeWidget {
  const StepHeader({
    super.key,
    required this.title,
    required this.step,
    required this.totalSteps,
  });

  final String title;
  final int step;
  final int totalSteps;

  @override
  Size get preferredSize => const Size.fromHeight(78);

  @override
  Widget build(BuildContext context) {
    final progress = step / totalSteps;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 8, 20, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        'Step $step of $totalSteps',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: AppColors.divider,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
