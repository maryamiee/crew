import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import '../features/models/report.dart';
import '../features/widgets/status_badge.dart';
import 'report_details_screen.dart';

/// SCREEN 06 — Reports Management (All Reports)
/// Matches mockup: search bar, filter chips (All/Pending/In Progress/
/// Resolved), report cards with colored icon avatar + status badge.
class ReportsManagementScreen extends StatefulWidget {
  const ReportsManagementScreen({super.key});

  @override
  State<ReportsManagementScreen> createState() => _ReportsManagementScreenState();
}

class _ReportsManagementScreenState extends State<ReportsManagementScreen> {
  ReportStatus? _filter;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder<List<AdminReport>>(
        valueListenable: AdminMockData.reports,
        builder: (context, reports, _) {
          final filtered = reports.where((r) {
            final matchesFilter = _filter == null || r.status == _filter;
            final matchesQuery = _query.isEmpty || r.title.toLowerCase().contains(_query.toLowerCase());
            return matchesFilter && matchesQuery;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
                child: Row(children: [
                  const Text('All Reports', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.notifications_none_rounded), onPressed: () {}),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(hintText: 'Search reports...', prefixIcon: Icon(Icons.search_rounded)),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  children: [
                    _FilterChip(label: 'All', selected: _filter == null, onTap: () => setState(() => _filter = null)),
                    ...ReportStatus.values.map((s) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: _FilterChip(label: s.label, selected: _filter == s, onTap: () => setState(() => _filter = s)),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: filtered.isEmpty
                    ? const Center(child: Text('No reports found', style: TextStyle(color: AppColors.textSecondary)))
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                        itemBuilder: (context, i) => _ReportRow(report: filtered[i]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.button,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.surfaceMuted,
          borderRadius: AppRadius.button,
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.report});
  final AdminReport report;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.card,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ReportDetailsScreen(report: report))),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
        child: Row(children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: report.iconColor.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(report.icon, color: report.iconColor, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(report.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(report.location, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                Text(report.date, style: const TextStyle(fontSize: 11, color: AppColors.textDisabled)),
              ],
            ),
          ),
          StatusBadge(status: report.status),
        ]),
      ),
    );
  }
}
