import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../widgets/profile_menu_tile.dart';

class AboutCrewScreen extends StatelessWidget {
  const AboutCrewScreen({super.key});

  static const String _appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('About CREW')),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: AppColors.integrationPurple.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: const Icon(
                    Icons.shield_moon_rounded,
                    size: 40,
                    color: AppColors.integrationPurple,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'CREW',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Campus Reporting & Emergency Watch',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version $_appVersion',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          ProfileSectionCard(
            title: 'OUR MISSION',
            children: const [
              Text(
                'CREW helps students report campus safety issues, '
                'facilities problems, and emergencies quickly and '
                'confidentially — connecting the campus community with '
                'the admin team that keeps it safe.',
                style: TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileSectionCard(
            title: 'THE TEAM',
            children: const [
              _TeamMemberRow(name: 'Ibtesam', role: 'Student Core & Auth'),
              SizedBox(height: AppSpacing.sm),
              _TeamMemberRow(name: 'Maryam', role: 'Admin Module'),
              SizedBox(height: AppSpacing.sm),
              _TeamMemberRow(name: 'Ayesha', role: 'Integration & Profile'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ProfileSectionCard(
            children: [
              ProfileMenuTile(
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Terms of Service coming soon')),
                ),
              ),
              const Divider(height: AppSpacing.lg),
              ProfileMenuTile(
                icon: Icons.star_border_rounded,
                title: 'Rate the App',
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thanks for your support!')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TeamMemberRow extends StatelessWidget {
  final String name;
  final String role;
  const _TeamMemberRow({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.integrationPurple.withValues(alpha: 0.15),
          child: Text(
            name[0],
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.integrationPurple,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            '· $role',
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
