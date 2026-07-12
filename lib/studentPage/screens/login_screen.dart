import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/auth_validators.dart';
import '../features/auth/current_user.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/animated_crew_logo.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/auth_text_field.dart';
import '../features/widgets/social_login_button.dart';

/// SCREEN — Login
/// Students sign in with either their University Email or Registration
/// Number (SP24-BSE-000 format) in one combined field, plus social
/// login options. Matches the reference design's light, friendly layout.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _deriveDisplayName(String identifier) {
    if (identifier.contains('@')) {
      final namePart = identifier.split('@').first.replaceAll('.', ' ');
      if (namePart.isEmpty) return 'Student';
      return namePart
          .split(' ')
          .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ');
    }
    return 'Student'; // Registration-number logins have no name until we hit a real backend.
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: AuthService -> Firebase Auth / backend sign-in call goes here.
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isLoading = false);
    final name = _deriveDisplayName(_identifierController.text.trim());
    CurrentUser.signIn(
      name: name,
      identifier: _identifierController.text.trim(),
    );
    context.go(AppRoutes.authSuccess, extra: {'name': name, 'isSignup': false});
  }

  void _handleSocialLogin(SocialProvider provider) {
    // TODO: wire real OAuth SDK per provider (google_sign_in, sign_in_with_apple, etc.)
    CurrentUser.signIn(name: 'Student', identifier: provider.label);
    context.go(AppRoutes.authSuccess,
        extra: {'name': 'Student', 'isSignup': false});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    const AnimatedCrewLogo(size: 72),
                    const SizedBox(height: AppSpacing.md),
                    Text('CREW', style: textTheme.headlineMedium),
                    const SizedBox(height: 2),
                    Text('Campus Reporting &\nEmergency Workflow',
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall),
                    const SizedBox(height: AppSpacing.xl),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(children: [
                        Text('Welcome Back! ', style: textTheme.headlineSmall),
                        const Text('👋', style: TextStyle(fontSize: 20)),
                      ]),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Login to continue your journey',
                          style: textTheme.bodyMedium),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AuthTextField(
                      controller: _identifierController,
                      hint: 'University Email / Registration No.',
                      icon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: AuthValidators.loginIdentifier,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AuthTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline_rounded,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (v) => (v == null || v.isEmpty)
                          ? 'Enter your password'
                          : null,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push(AppRoutes.forgotPassword),
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    PrimaryButton(
                        label: 'Login',
                        isLoading: _isLoading,
                        onPressed: _handleLogin),
                    const SizedBox(height: AppSpacing.xl),
                    Row(children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md),
                        child: Text('or continue with',
                            style: textTheme.bodySmall),
                      ),
                      const Expanded(child: Divider()),
                    ]),
                    const SizedBox(height: AppSpacing.lg),
                    Row(children: [
                      Expanded(
                        child: SocialLoginButton(
                          provider: SocialProvider.google,
                          onPressed: () =>
                              _handleSocialLogin(SocialProvider.google),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: SocialLoginButton(
                          provider: SocialProvider.facebook,
                          onPressed: () =>
                              _handleSocialLogin(SocialProvider.facebook),
                        ),
                      ),
                    ]),
                    const SizedBox(height: AppSpacing.md),
                    Row(children: [
                      Expanded(
                        child: SocialLoginButton(
                          provider: SocialProvider.apple,
                          onPressed: () =>
                              _handleSocialLogin(SocialProvider.apple),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: SocialLoginButton(
                          provider: SocialProvider.github,
                          onPressed: () =>
                              _handleSocialLogin(SocialProvider.github),
                        ),
                      ),
                    ]),
                    const SizedBox(height: AppSpacing.md),
                    SocialLoginButton(
                      provider: SocialProvider.linkedin,
                      expand: true,
                      onPressed: () =>
                          _handleSocialLogin(SocialProvider.linkedin),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: textTheme.bodyMedium),
                        GestureDetector(
                          onTap: () => context.push(AppRoutes.signup),
                          child: Text('Sign Up',
                              style: textTheme.bodyMedium?.copyWith(
                                  color: AppColors.primaryBlue,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
            // Decorative faint skyline at the very bottom — echoes the
            // reference design's campus illustration without needing a
            // shipped image asset.
            const Positioned(
              left: 0,
              right: 0,
              bottom: -8,
              child: IgnorePointer(
                child: Opacity(
                  opacity: 0.08,
                  child: Icon(Icons.account_balance_rounded,
                      size: 120, color: AppColors.primaryBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
