import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

/// Shared pill-shaped CTA used across every CREW screen.
/// Handles loading state + light haptic feedback on tap so we don't
/// re-implement this logic per screen.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
      ),
      onPressed: isLoading
          ? null
          : () {
              HapticFeedback.lightImpact();
              onPressed?.call();
            },
      child: isLoading
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, size: 18),
                ],
              ],
            ),
    );

    return expand ? SizedBox(width: double.infinity, child: child) : child;
  }
}
