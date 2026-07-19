import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import 'admin_login_screen.dart';

/// SCREEN 12 — Admin Profile (green Admin module)
class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key, this.onLogout});
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primary,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(radius: 40, backgroundColor: Colors.white, child: Icon(Icons.person_rounded, size: 44, color: AppColors.primary)),
                      const SizedBox(height: 10),
                      const Text('Maryam Khan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                      Text('Super Admin', style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppSpacing.md),
              _Tile(icon: Icons.person_outline_rounded, label: 'Personal Information'),
              _Tile(icon: Icons.lock_outline_rounded, label: 'Change Password'),
              _Tile(icon: Icons.notifications_outlined, label: 'Notification Settings'),
              _Tile(icon: Icons.shield_outlined, label: 'Privacy & Security'),
              _Tile(icon: Icons.settings_outlined, label: 'App Settings'),
              _Tile(
                icon: Icons.logout_rounded,
                label: 'Logout',
                isDestructive: true,
                onTap: () {
                  onLogout?.call();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.icon, required this.label, this.isDestructive = false, this.onTap});
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primary),
      title: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: isDestructive ? null : const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
      onTap: onTap ?? () {},
    );
  }
}
