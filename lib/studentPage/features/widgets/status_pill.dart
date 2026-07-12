import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

enum ReportStatus { submitted, underReview, resolved }

extension ReportStatusX on ReportStatus {
  String get label => switch (this) {
        ReportStatus.submitted => 'Submitted',
        ReportStatus.underReview => 'Under Review',
        ReportStatus.resolved => 'Resolved',
      };

  Color get color => switch (this) {
        ReportStatus.submitted => AppColors.statusSubmitted,
        ReportStatus.underReview => AppColors.statusUnderReview,
        ReportStatus.resolved => AppColors.statusResolved,
      };
}

/// Small rounded badge showing a complaint's current status.
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.status});
  final ReportStatus status;

  @override
  Widget build(BuildContext context) {
    final color = status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        status.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
