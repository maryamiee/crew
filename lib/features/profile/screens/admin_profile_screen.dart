import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class AdminProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;
  const AdminProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.adminPrimaryLight,
                  child: Icon(Icons.person_rounded, size: 40, color: AppColors.adminPrimary),
                ),
                const SizedBox(height: AppSpacing.md),
                Text('Dr. Farah Siddiqui', style: Theme.of(context).textTheme.titleLarge),
                const Text('Campus Safety Administrator',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Card(
            child: Column(
              children: [
                _ProfileTile(icon: Icons.mail_outline_rounded, label: 'Email', value: 'farah.siddiqui@university.edu'),
                const Divider(height: 1),
                _ProfileTile(icon: Icons.badge_outlined, label: 'Admin ID', value: 'ADM-0042'),
                const Divider(height: 1),
                _ProfileTile(icon: Icons.apartment_rounded, label: 'Department', value: 'Student Affairs'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications_outlined, color: AppColors.textSecondary),
                  title: const Text('Notification Preferences'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock_outline_rounded, color: AppColors.textSecondary),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help_outline_rounded, color: AppColors.textSecondary),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout_rounded, color: AppColors.errorRed),
              title: const Text('Log Out', style: TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w600)),
              onTap: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _ProfileTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.adminPrimary),
      title: Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      subtitle: Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}
