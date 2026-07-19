import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static const List<_PolicySection> _sections = [
    _PolicySection(
      'Information We Collect',
      'We collect the information you provide when creating an account '
          'or submitting a report — such as your name, department, email, '
          'and any details or evidence attached to a report. If you submit '
          'anonymously, identifying information is not stored with the '
          'report.',
    ),
    _PolicySection(
      'How We Use Your Information',
      'Your information is used to process and follow up on reports, '
          'send you status updates, and improve campus safety response. '
          'We do not sell or share your personal data with third parties.',
    ),
    _PolicySection(
      'Anonymous Reporting',
      'When you choose anonymous reporting, your identity is not linked '
          'to the report in a way that\'s visible to admins. Some metadata '
          'may still be retained for abuse prevention.',
    ),
    _PolicySection(
      'Data Security',
      'Reports and account data are stored securely and access is '
          'restricted to authorized campus administrators handling your '
          'case.',
    ),
    _PolicySection(
      'Your Rights',
      'You can review, update, or request deletion of your account '
          'information at any time from Settings. Deleting your account '
          'removes personally identifiable data associated with it.',
    ),
    _PolicySection(
      'Changes to This Policy',
      'We may update this policy as the app evolves. Significant '
          'changes will be communicated through in-app notifications.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const Text(
            'Last updated: July 1, 2026',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final section in _sections) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    section.body,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PolicySection {
  final String title;
  final String body;
  const _PolicySection(this.title, this.body);
}
