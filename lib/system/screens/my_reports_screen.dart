import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/status_chip.dart';
import '../models/profile_user.dart';

class MyReportsScreen extends StatelessWidget {
  const MyReportsScreen({super.key});

  // TODO: replace with the signed-in student's reports once the
  // Report module exposes a shared data source (see features/report/).
  static const List<ReportSummary> _reports = [
    ReportSummary(
      id: 'RPT-1042',
      category: 'Facilities · Broken hallway light',
      date: 'Jul 10, 2026',
      status: 'underReview',
    ),
    ReportSummary(
      id: 'RPT-1031',
      category: 'IT · Wi-Fi outage, Library',
      date: 'Jul 4, 2026',
      status: 'resolved',
    ),
    ReportSummary(
      id: 'RPT-1020',
      category: 'Safety · Unsecured side gate',
      date: 'Jun 27, 2026',
      status: 'urgent',
    ),
    ReportSummary(
      id: 'RPT-1004',
      category: 'Facilities · Leaking tap, Block B',
      date: 'Jun 15, 2026',
      status: 'submitted',
    ),
  ];

  ReportStatus _statusFrom(String value) {
    switch (value) {
      case 'underReview':
        return ReportStatus.underReview;
      case 'resolved':
        return ReportStatus.resolved;
      case 'urgent':
        return ReportStatus.urgent;
      case 'submitted':
      default:
        return ReportStatus.submitted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('My Reports')),
      body: _reports.isEmpty
          ? const Center(
              child: Text(
                'You haven\'t submitted any reports yet',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            )
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: _reports.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) {
                final r = _reports[i];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r.id,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              r.category,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              r.date,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      StatusChip(status: _statusFrom(r.status)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
