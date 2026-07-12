import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/soft_card.dart';
import '../features/widgets/step_header.dart';
import '../features/report/report_draft_scope.dart';

class PrivacyConfidentialityScreen extends StatefulWidget {
  const PrivacyConfidentialityScreen({super.key});

  @override
  State<PrivacyConfidentialityScreen> createState() =>
      _PrivacyConfidentialityScreenState();
}

class _PrivacyConfidentialityScreenState
    extends State<PrivacyConfidentialityScreen> {
  bool _anonymous = true;
  bool _allowContact = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const StepHeader(title: 'Report Incident', step: 4, totalSteps: 5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text('Privacy & Confidentiality', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.lg),
            SoftCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_user_rounded,
                        color: AppColors.secondaryGreen, size: 20),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your identity is protected',
                            style: textTheme.titleSmall),
                        const SizedBox(height: 2),
                        Text('Only authorized admin can view your report.',
                            style: textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            _ToggleRow(
              title: 'Submit Anonymously',
              subtitle: 'Your name will not be visible to anyone.',
              value: _anonymous,
              onChanged: (v) => setState(() => _anonymous = v),
            ),
            const SizedBox(height: AppSpacing.lg),
            _ToggleRow(
              title: 'Allow admin to contact you',
              subtitle: 'For more details, if needed.',
              value: _allowContact,
              onChanged: (v) => setState(() => _allowContact = v),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding, 0, AppSpacing.screenPadding, AppSpacing.lg,
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
                  reportDraft.submitAnonymously = _anonymous;
                  reportDraft.allowAdminContact = _allowContact;
                  context.push(AppRoutes.reportSubmitted);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleSmall),
              const SizedBox(height: 2),
              Text(subtitle, style: textTheme.bodyMedium),
            ],
          ),
        ),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}
