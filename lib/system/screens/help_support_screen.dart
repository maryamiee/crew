import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../widgets/profile_menu_tile.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  static const List<_Faq> _faqs = [
    _Faq(
      'How do I submit a report?',
      'Go to the Dashboard, tap "Report an Issue," choose a category, '
          'add details and evidence, then submit. You can track it anytime '
          'from My Reports.',
    ),
    _Faq(
      'Is my report anonymous?',
      'You can choose to submit anonymously from the Privacy & '
          'Confidentiality step during report creation. Your identity is '
          'only visible to campus admins if you opt in to follow-up.',
    ),
    _Faq(
      'How long does it take to resolve a report?',
      'Most reports move to "Under Review" within 24 hours. Resolution '
          'time depends on the category and severity — you\'ll get a '
          'notification at every status change.',
    ),
    _Faq(
      'How do I use the Emergency SOS button?',
      'The SOS button on your Dashboard alerts campus security '
          'immediately with your location. Use it only for genuine '
          'emergencies.',
    ),
    _Faq(
      'Can I edit a report after submitting it?',
      'Once submitted, reports can\'t be edited to preserve an accurate '
          'timeline, but you can add follow-up comments from the report '
          'details screen.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          ProfileSectionCard(
            title: 'CONTACT US',
            children: [
              ProfileMenuTile(
                icon: Icons.mail_outline_rounded,
                title: 'Email Support',
                subtitle: 'support@crewapp.edu',
                onTap: () => _showComingSoon(context),
              ),
              const Divider(height: AppSpacing.lg),
              ProfileMenuTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Live Chat',
                subtitle: 'Available 9 AM – 6 PM, Mon–Fri',
                onTap: () => _showComingSoon(context),
              ),
              const Divider(height: AppSpacing.lg),
              ProfileMenuTile(
                icon: Icons.call_outlined,
                title: 'Campus Security Hotline',
                subtitle: '+92 300 0000000',
                onTap: () => _showComingSoon(context),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: AppSpacing.sm),
            child: Text(
              'FREQUENTLY ASKED QUESTIONS',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: _faqs
                    .map(
                      (faq) => ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        childrenPadding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          0,
                          AppSpacing.md,
                          AppSpacing.md,
                        ),
                        iconColor: AppColors.integrationPurple,
                        collapsedIconColor: AppColors.textSecondary,
                        title: Text(
                          faq.question,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              faq.answer,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('This will open once support is connected.')),
    );
  }
}

class _Faq {
  final String question;
  final String answer;
  const _Faq(this.question, this.answer);
}
