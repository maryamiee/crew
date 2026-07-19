import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import '../features/models/report.dart';
import '../features/widgets/status_badge.dart';

/// SCREEN 08 — Update Status
/// Matches mockup: report ID, current status, radio list of statuses
/// with descriptions, Add Remark textarea, Update Status button.
class UpdateStatusScreen extends StatefulWidget {
  const UpdateStatusScreen({super.key, required this.report});
  final AdminReport report;

  @override
  State<UpdateStatusScreen> createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  late ReportStatus _selected = widget.report.status;
  final _remarkController = TextEditingController();

  static const _descriptions = {
    ReportStatus.pending: 'Report is received',
    ReportStatus.inProgress: 'Investigation in progress',
    ReportStatus.resolved: 'Issue has been resolved',
    ReportStatus.rejected: 'Report is not valid',
  };

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  void _update() {
    AdminMockData.updateStatus(widget.report.id, _selected, remark: _remarkController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Status'), leading: const BackButton()),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text('Report ID: ${widget.report.id}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.md),
            Row(children: [
              const Text('Current Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const Spacer(),
              StatusBadge(status: widget.report.status),
            ]),
            const SizedBox(height: AppSpacing.lg),
            const Text('Select New Status', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            ...ReportStatus.values.map((s) => _StatusOption(
                  status: s,
                  description: _descriptions[s]!,
                  selected: _selected == s,
                  onTap: () => setState(() => _selected = s),
                )),
            const SizedBox(height: AppSpacing.lg),
            const Text('Add Remark (Optional)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 8),
            TextField(
              controller: _remarkController,
              maxLines: 4,
              decoration: const InputDecoration(hintText: 'Write your remark here...'),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(onPressed: _update, child: const Text('Update Status')),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}

class _StatusOption extends StatelessWidget {
  const _StatusOption({required this.status, required this.description, required this.selected, required this.onTap});
  final ReportStatus status;
  final String description;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppRadius.card,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? status.color.withValues(alpha: 0.06) : AppColors.surface,
          borderRadius: AppRadius.card,
          border: Border.all(color: selected ? status.color : AppColors.divider, width: selected ? 1.5 : 1),
          boxShadow: AppElevation.card,
        ),
        child: Row(children: [
          Icon(selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded, color: selected ? status.color : AppColors.textDisabled),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text(description, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
