import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/widgets/admin_logo.dart';
import 'admin_signup_screen.dart';
import 'admin_forgot_password_screen.dart';
import 'admin_shell.dart';

/// SCREEN 02 — Admin Login
/// Matches mockup: Welcome Back! title, Email + Password fields,
/// Remember me + Forgot Password row, Login button, 3-icon social row
/// (Google/Microsoft/Apple), reassurance footnote.
class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'admin@crew.com');
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: AuthService -> real admin authentication call goes here.
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AdminShell()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const Center(child: AdminLogo(size: 64)),
                const SizedBox(height: 24),
                const Text('Welcome Back! 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                const Text('Login to your admin account', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 28),
                const Text('Email', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.mail_outline_rounded)),
                ),
                const SizedBox(height: 16),
                const Text('Password', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  validator: (v) => (v == null || v.isEmpty) ? 'Enter your password' : null,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 22, height: 22,
                      child: Checkbox(
                        value: _rememberMe,
                        onChanged: (v) => setState(() => _rememberMe = v ?? false),
                        activeColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('Remember me', style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary)),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminForgotPasswordScreen())),
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                      : const Text('Login'),
                ),
                const SizedBox(height: 24),
                Row(children: const [
                  Expanded(child: Divider()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or continue with', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialIcon(icon: Icons.g_mobiledata_rounded, color: const Color(0xFFEA4335), onTap: _login),
                    const SizedBox(width: 16),
                    _SocialIcon(icon: Icons.window_rounded, color: const Color(0xFF00A4EF), onTap: _login),
                    const SizedBox(width: 16),
                    _SocialIcon(icon: Icons.apple_rounded, color: const Color(0xFF111111), onTap: _login),
                  ],
                ),
                const SizedBox(height: 28),
                const Center(
                  child: Text('Secure admin access to\nmanage your campus.',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 11.5, color: AppColors.textDisabled)),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AdminSignupScreen())),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: "Don't have an account? "),
                          TextSpan(text: 'Sign Up', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.icon, required this.color, required this.onTap});
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(28),
      onTap: onTap,
      child: Container(
        width: 52, height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
        ),
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}
