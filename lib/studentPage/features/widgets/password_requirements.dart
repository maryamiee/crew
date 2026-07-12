import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../auth/auth_validators.dart';

/// Live password-rules checklist shown under the password field on
/// Signup — each rule turns green with a check as soon as it's
/// satisfied, matching the reference design.
class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Password must contain:',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          _Rule(label: 'At least 6 characters', met: AuthValidators.hasMinLength(password)),
          _Rule(label: 'One uppercase letter (A-Z)', met: AuthValidators.hasUppercase(password)),
          _Rule(label: 'One special character (!@#\$%^&* etc.)', met: AuthValidators.hasSpecialChar(password)),
        ],
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.label, required this.met});
  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: met ? AppColors.secondaryGreen : Colors.transparent,
              border: Border.all(
                color: met ? AppColors.secondaryGreen : AppColors.textTertiary,
                width: 1.4,
              ),
            ),
            child: met ? const Icon(Icons.check_rounded, size: 11, color: Colors.white) : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: met ? AppColors.secondaryGreen : AppColors.textSecondary,
                fontWeight: met ? FontWeight.w600 : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
