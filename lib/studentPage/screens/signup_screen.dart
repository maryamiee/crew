import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/auth_validators.dart';
import '../features/auth/current_user.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/campus_illustration.dart';
import '../features/widgets/auth_text_field.dart';
import '../features/widgets/password_requirements.dart';

/// SCREEN — Create Account (Sign Up)
/// Students can register with a University Email OR a Registration
/// Number (SP24-BSE-000 format) — the two are alternatives, separated
/// by an "or" divider, matching the reference design. Full Name is
/// always required and is what powers the Dashboard greeting after
/// signup completes.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _regNoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  String _password = '';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _regNoController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validateIdentityBlock() {
    final email = _emailController.text.trim();
    final regNo = _regNoController.text.trim();
    if (email.isEmpty && regNo.isEmpty) {
      return 'Enter your university email or registration number';
    }
    if (email.isNotEmpty && !AuthValidators.emailFormat.hasMatch(email)) {
      return 'Enter a valid university email';
    }
    if (regNo.isNotEmpty && !AuthValidators.regNoFormat.hasMatch(regNo.toUpperCase())) {
      return 'Registration number format should look like SP24-BSE-000';
    }
    return null;
  }

  Future<void> _handleSignup() async {
    final identityError = _validateIdentityBlock();
    final formValid = _formKey.currentState!.validate();
    if (!formValid || identityError != null) {
      if (identityError != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(identityError)));
      }
      return;
    }
    setState(() => _isLoading = true);
    // TODO: AuthService -> Firebase Auth createUserWithEmailAndPassword / backend registration.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final identifier = _emailController.text.trim().isNotEmpty
        ? _emailController.text.trim()
        : _regNoController.text.trim().toUpperCase();

    CurrentUser.signIn(name: _nameController.text.trim(), identifier: identifier);
    context.go(
      AppRoutes.authSuccess,
      extra: {'name': _nameController.text.trim(), 'isSignup': true},
    ); // Full Name now flows straight into the premium welcome moment, then Dashboard.
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
                      Text('Create Account', style: textTheme.headlineMedium),
                      const SizedBox(height: 4),
                      Text('Join CREW and help build a safer campus',
                          style: textTheme.bodyMedium),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                const CampusIllustration(height: 170),
                const SizedBox(height: AppSpacing.xl),
                AuthTextField(
                  controller: _nameController,
                  hint: 'Full Name',
                  icon: Icons.person_outline_rounded,
                  textCapitalization: TextCapitalization.words,
                  validator: AuthValidators.fullName,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _emailController,
                  hint: 'University Email',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text('or', style: textTheme.bodySmall),
                  ),
                  const Expanded(child: Divider()),
                ]),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _regNoController,
                  hint: 'Registration Number',
                  icon: Icons.badge_outlined,
                  textCapitalization: TextCapitalization.characters,
                  highlighted: true,
                  onChanged: (_) => setState(() {}),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Center(
                      widthFactor: 1,
                      child: Text('Format: SP24-BSE-000',
                          style: textTheme.labelSmall?.copyWith(color: AppColors.primaryBlue)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: _obscurePassword,
                  onChanged: (v) => setState(() => _password = v),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20, color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthTextField(
                  controller: _confirmController,
                  hint: 'Confirm Password',
                  icon: Icons.lock_outline_rounded,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20, color: AppColors.textSecondary,
                    ),
                    onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (v) => AuthValidators.confirmPassword(v, _passwordController.text),
                ),
                const SizedBox(height: AppSpacing.md),
                PasswordRequirements(password: _password),
                const SizedBox(height: AppSpacing.xl),
                PrimaryButton(label: 'Sign Up', isLoading: _isLoading, onPressed: _handleSignup),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ', style: textTheme.bodyMedium),
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Text('Login',
                          style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
