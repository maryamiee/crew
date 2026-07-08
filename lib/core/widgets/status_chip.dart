import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

enum ReportStatus { submitted, underReview, resolved, urgent }

extension ReportStatusX on ReportStatus {
  String get label {
    switch (this) {
      case ReportStatus.submitted:
        return 'Submitted';
      case ReportStatus.underReview:
        return 'Under Review';
      case ReportStatus.resolved:
        return 'Resolved';
      case ReportStatus.urgent:
        return 'Urgent';
    }
  }

  Color get color {
    switch (this) {
      case ReportStatus.submitted:
        return AppColors.statusSubmitted;
      case ReportStatus.underReview:
        return AppColors.statusUnderReview;
      case ReportStatus.resolved:
        return AppColors.statusResolved;
      case ReportStatus.urgent:
        return AppColors.statusUrgent;
    }
  }
}

/// Small pill chip showing complaint/report status. Reused on
/// Complaints List, Complaint Details, and Update Status screens.
class StatusChip extends StatelessWidget {
  final ReportStatus status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 2, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}
