import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_radius.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/step_header.dart';
import '../features/report/report_draft_scope.dart';

class UploadEvidenceScreen extends StatefulWidget {
  const UploadEvidenceScreen({super.key});

  @override
  State<UploadEvidenceScreen> createState() => _UploadEvidenceScreenState();
}

class _UploadEvidenceScreenState extends State<UploadEvidenceScreen> {
  final List<String> _files = [
    'evidence_1.jpg',
    'evidence_2.jpg',
    'evidence_3.jpg',
  ];

  void _addMock() =>
      setState(() => _files.add('evidence_${_files.length + 1}.jpg'));
  void _remove(int i) => setState(() => _files.removeAt(i));

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const StepHeader(
        title: 'Report Incident',
        step: 2,
        totalSteps: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Upload Evidence (Optional)', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Add photos, videos or documents.',
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            InkWell(
              onTap: _addMock,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: const DottedUploadBox(),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_files.isNotEmpty)
              SizedBox(
                height: 84,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _files.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, i) =>
                      _ThumbTile(name: _files[i], onRemove: () => _remove(i)),
                ),
              ),
            const SizedBox(height: AppSpacing.lg),
            SoftLinkTile(
              icon: Icons.description_outlined,
              label: 'Add Document',
              onTap: _addMock,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          0,
          AppSpacing.screenPadding,
          AppSpacing.lg,
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.maybePop(context),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: PrimaryButton(
                label: 'Next',
                onPressed: () {
                  reportDraft.evidenceFileNames
                    ..clear()
                    ..addAll(_files);
                  context.push(AppRoutes.privacyConfidentiality);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedUploadBox extends StatelessWidget {
  const DottedUploadBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.inputBorder,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.file_upload_outlined,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 10),
          Text('Tap to Upload', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 2),
          Text(
            'or add from gallery',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ThumbTile extends StatelessWidget {
  const _ThumbTile({required this.name, required this.onRemove});
  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            gradient: AppColors.heroGradient,
          ),
          child: const Icon(Icons.image_rounded, color: Colors.white70),
        ),
        Positioned(
          top: -6,
          right: -6,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.errorRed,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SoftLinkTile extends StatelessWidget {
  const SoftLinkTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
