import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/status_chip.dart';
import '../models/complaint.dart';

class UpdateStatusScreen extends StatefulWidget {
  final Complaint complaint;
  final void Function(ReportStatus status, String remarks) onSave;

  const UpdateStatusScreen({super.key, required this.complaint, required this.onSave});

  @override
  State<UpdateStatusScreen> createState() => _UpdateStatusScreenState();
}

class _UpdateStatusScreenState extends State<UpdateStatusScreen> {
  late ReportStatus _selected = widget.complaint.status;
  final _remarksController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _isSaving = true);
    // TODO: replace with Firestore update once project is connected
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isSaving = false);
    widget.onSave(_selected, _remarksController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Update Status')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Complaint ${widget.complaint.id}', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.md),
          Text('New Status', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: ReportStatus.values.map((s) {
              final selected = _selected == s;
              return GestureDetector(
                onTap: () => setState(() => _selected = s),
                child: AnimatedContainer(
                  duration: AppDuration.fast,
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: selected ? s.color.withValues(alpha: 0.15) : AppColors.surface,
                    border: Border.all(color: selected ? s.color : AppColors.divider, width: selected ? 1.5 : 1),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (selected) Icon(Icons.check_circle, size: 16, color: s.color),
                      if (selected) const SizedBox(width: 6),
                      Text(s.label, style: TextStyle(color: selected ? s.color : AppColors.textSecondary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Remarks (visible to student)', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          TextField(
            controller: _remarksController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'e.g. Report reviewed, action taken with the involved parties...',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          PrimaryButton(label: 'Save Update', isLoading: _isSaving, onPressed: _save),
        ],
      ),
    );
  }
}
