import 'package:flutter/material.dart';
import '../features/auth/auth_validators.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_radius.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/auth_text_field.dart';

enum _ResetMethod { email, registrationNo }

/// SCREEN — Forgot Password
/// A segmented Email / Registration No. toggle switches which identifier
/// the reset link is sent to, matching the reference design.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  _ResetMethod _method = _ResetMethod.email;
  bool _isLoading = false;
  bool _sent = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: AuthService -> Firebase Auth sendPasswordResetEmail / backend reset flow.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.sm),
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                ),
                Center(
                  child: Column(
                    children: [
                      Text('Forgot Password?', style: textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text(
                        'No worries! Enter your email or registration\nnumber and we\'ll send you a reset link.',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.06),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_reset_rounded, size: 64, color: AppColors.primaryBlue),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                if (!_sent) ...[
                  // Segmented Email / Registration No. toggle
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.inputFill,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Row(children: [
                      Expanded(
                        child: _SegmentButton(
                          label: 'Email',
                          selected: _method == _ResetMethod.email,
                          onTap: () => setState(() {
                            _method = _ResetMethod.email;
                            _controller.clear();
                          }),
                        ),
                      ),
                      Expanded(
                        child: _SegmentButton(
                          label: 'Registration No.',
                          selected: _method == _ResetMethod.registrationNo,
                          onTap: () => setState(() {
                            _method = _ResetMethod.registrationNo;
                            _controller.clear();
                          }),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AuthTextField(
                    controller: _controller,
                    hint: _method == _ResetMethod.email
                        ? 'Enter your university email'
                        : 'e.g. SP24-BSE-000',
                    icon: _method == _ResetMethod.email
                        ? Icons.mail_outline_rounded
                        : Icons.badge_outlined,
                    keyboardType: _method == _ResetMethod.email
                        ? TextInputType.emailAddress
                        : TextInputType.text,
                    textCapitalization: _method == _ResetMethod.registrationNo
                        ? TextCapitalization.characters
                        : TextCapitalization.none,
                    validator: _method == _ResetMethod.email
                        ? AuthValidators.email
                        : AuthValidators.registrationNumber,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Send Reset Link',
                    isLoading: _isLoading,
                    onPressed: _handleSubmit,
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: AppColors.secondaryGreen.withValues(alpha: 0.25)),
                    ),
                    child: Row(children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.secondaryGreen),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Reset link sent to ${_controller.text}. Check your inbox.',
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: 'Back to Login',
                    onPressed: () => Navigator.maybePop(context),
                  ),
                ],

                const SizedBox(height: AppSpacing.xl),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryGreen.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(children: [
                    const Icon(Icons.shield_outlined, color: AppColors.secondaryGreen, size: 20),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        'For security reasons, we will send password reset instructions to your registered email.',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: AppSpacing.lg),
                if (!_sent)
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.maybePop(context),
                      child: const Text('Back to Login'),
                    ),
                  ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: selected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
