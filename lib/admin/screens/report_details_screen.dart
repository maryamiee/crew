import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import '../features/models/report.dart';
import '../features/widgets/status_badge.dart';
import 'update_status_screen.dart';

/// SCREEN 07 — Report Details
/// Matches mockup: report ID + status, title, location, date, Reported
/// By (Anonymous badge respected), Description, Evidence thumbnails,
/// Assign / Update Status / More actions, Add Note.
class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key, required this.report});
  final AdminReport report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Details'), leading: const BackButton(), actions: [
        IconButton(icon: const Icon(Icons.more_vert_rounded), onPressed: () {}),
      ]),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Row(children: [
              Text('#${report.id}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              const Spacer(),
              StatusBadge(status: report.status),
            ]),
            const SizedBox(height: AppSpacing.sm),
            Text(report.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: AppSpacing.sm),
            Row(children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(report.location, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ]),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text(report.date, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ]),
            const SizedBox(height: AppSpacing.lg),

            const Text('Reported By', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Row(children: [
              Text(report.reportedBy, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary)),
              if (report.isAnonymous) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: AppRadius.button),
                  child: const Text('Anonymous', style: TextStyle(fontSize: 10.5, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
                ),
              ],
            ]),
            const SizedBox(height: AppSpacing.lg),

            const Text('Description', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            Text(report.description, style: const TextStyle(fontSize: 13.5, color: AppColors.textSecondary, height: 1.5)),
            const SizedBox(height: AppSpacing.lg),

            if (report.evidenceCount > 0) ...[
              const Text('Evidence', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              SizedBox(
                height: 64,
                child: Row(children: [
                  for (int i = 0; i < (report.evidenceCount > 3 ? 3 : report.evidenceCount); i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Container(
                        width: 64, height: 64,
                        decoration: BoxDecoration(color: AppColors.surfaceMuted, borderRadius: AppRadius.card),
                        child: const Icon(Icons.image_rounded, color: AppColors.textDisabled),
                      ),
                    ),
                  if (report.evidenceCount > 3)
                    Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: AppRadius.card),
                      alignment: Alignment.center,
                      child: Text('+${report.evidenceCount - 3}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ),
                ]),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],

            const Text('Actions', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: OutlinedButton(onPressed: () {}, child: const Text('Assign'))),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdateStatusScreen(report: report))),
                  child: const Text('Update Status'),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52)), child: const Icon(Icons.more_horiz_rounded)),
            ]),
            const SizedBox(height: AppSpacing.md),
            ElevatedButton(onPressed: () {}, child: const Text('Add Note')),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
