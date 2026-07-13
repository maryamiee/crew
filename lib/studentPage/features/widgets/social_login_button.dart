import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

enum SocialProvider { google, facebook, apple, github, linkedin }

extension SocialProviderX on SocialProvider {
  String get label => switch (this) {
        SocialProvider.google => 'Google',
        SocialProvider.facebook => 'Facebook',
        SocialProvider.apple => 'Apple',
        SocialProvider.github => 'GitHub',
        SocialProvider.linkedin => 'LinkedIn',
      };

  IconData get icon => switch (this) {
        SocialProvider.google => Icons.g_mobiledata_rounded, // stand-in; swap for brand SVG asset
        SocialProvider.facebook => Icons.facebook_rounded,
        SocialProvider.apple => Icons.apple_rounded,
        SocialProvider.github => Icons.code_rounded,
        SocialProvider.linkedin => Icons.business_center_rounded,
      };

  Color get brandColor => switch (this) {
        SocialProvider.google => const Color(0xFFEA4335),
        SocialProvider.facebook => const Color(0xFF1877F2),
        SocialProvider.apple => const Color(0xFF111111),
        SocialProvider.github => const Color(0xFF171515),
        SocialProvider.linkedin => const Color(0xFF0A66C2),
      };
}

/// Outlined social-login button — used in a 2-column grid (Google,
/// Facebook, Apple, GitHub) with LinkedIn full-width beneath, matching
/// the reference design. Wire onPressed to the actual OAuth SDK later;
/// currently a TODO stub so the UI is complete and demo-able without
/// real credentials configured.
class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.provider,
    required this.onPressed,
    this.expand = false,
  });

  final SocialProvider provider;
  final VoidCallback onPressed;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: AppColors.divider),
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(provider.icon, size: 20, color: provider.brandColor),
          const SizedBox(width: 8),
          Text(provider.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
