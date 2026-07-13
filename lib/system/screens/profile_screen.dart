import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../models/profile_user.dart';
import '../widgets/profile_menu_tile.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import 'notifications_screen.dart';
import 'my_reports_screen.dart';
import 'help_support_screen.dart';
import 'about_crew_screen.dart';
import 'privacy_policy_screen.dart';

/// Entry point of the Profile & Integration module.
/// Everything below is wired to a real screen — nothing is a dead tap.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ProfileUserStore.current;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
            onPressed: () => _push(context, const NotificationsScreen()),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.integrationPurple,
        onRefresh: () async => setState(() {}),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl,
          ),
          children: [
            _ProfileHeader(user: user),
            const SizedBox(height: AppSpacing.lg),
            ProfileSectionCard(
              title: 'ACCOUNT',
              children: [
                ProfileMenuTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Name, department, contact info',
                  onTap: () async {
                    await _push(context, const EditProfileScreen());
                    if (mounted) setState(() {});
                  },
                ),
                const Divider(height: AppSpacing.lg),
                ProfileMenuTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'Password, notifications, security',
                  onTap: () => _push(context, const SettingsScreen()),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ProfileSectionCard(
              title: 'ACTIVITY',
              children: [
                ProfileMenuTile(
                  icon: Icons.description_outlined,
                  title: 'My Reports',
                  subtitle: 'Track the status of your submissions',
                  onTap: () => _push(context, const MyReportsScreen()),
                ),
                const Divider(height: AppSpacing.lg),
                ProfileMenuTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Updates on your reports and alerts',
                  onTap: () => _push(context, const NotificationsScreen()),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ProfileSectionCard(
              title: 'SUPPORT',
              children: [
                ProfileMenuTile(
                  icon: Icons.gpp_good_outlined,
                  title: 'Privacy Policy',
                  onTap: () => _push(context, const PrivacyPolicyScreen()),
                ),
                const Divider(height: AppSpacing.lg),
                ProfileMenuTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: () => _push(context, const HelpSupportScreen()),
                ),
                const Divider(height: AppSpacing.lg),
                ProfileMenuTile(
                  icon: Icons.info_outline_rounded,
                  title: 'About CREW',
                  onTap: () => _push(context, const AboutCrewScreen()),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            ProfileSectionCard(
              children: [
                ProfileMenuTile(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  iconColor: AppColors.errorRed,
                  onTap: () => _confirmLogout(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _push(BuildContext context, Widget screen) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        title: const Text('Log out?'),
        content: const Text('You will need to sign in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              // TODO: clear auth session / token once auth module is wired.
            },
            child: const Text(
              'Log out',
              style: TextStyle(color: AppColors.errorRed),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final ProfileUser user;
  const _ProfileHeader({required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.integrationPurple.withValues(
                  alpha: 0.15,
                ),
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Text(
                        user.name.isNotEmpty
                            ? user.name.trim()[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.integrationPurple,
                        ),
                      )
                    : null,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.integrationPurple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.department,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            user.email,
            style: const TextStyle(
              fontSize: 12.5,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
