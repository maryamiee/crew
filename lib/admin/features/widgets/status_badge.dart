import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum ReportStatus { pending, inProgress, resolved, rejected }

extension ReportStatusX on ReportStatus {
  String get label => switch (this) {
        ReportStatus.pending => 'Pending',
        ReportStatus.inProgress => 'In Progress',
        ReportStatus.resolved => 'Resolved',
        ReportStatus.rejected => 'Rejected',
      };
  Color get color => switch (this) {
        ReportStatus.pending => AppColors.statusPending,
        ReportStatus.inProgress => AppColors.statusInProgress,
        ReportStatus.resolved => AppColors.statusResolved,
        ReportStatus.rejected => AppColors.statusRejected,
      };
}

/// Small colored pill used everywhere a report/complaint status is shown
/// - Reports list, Report Details, Update Status.
class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});
  final ReportStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: status.color.withValues(alpha: 0.12), borderRadius: AppRadius.button),
      child: Text(status.label,
          style: TextStyle(color: status.color, fontSize: 11.5, fontWeight: FontWeight.w700)),
    );
  }
}
