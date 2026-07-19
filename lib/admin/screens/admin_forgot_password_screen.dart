import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';

/// SCREEN 04 — Forgot Password
/// Matches mockup: Reset Password title, shield+lock+paper-plane
/// illustration, Email field, Send Reset Link button, Back to Login.
class AdminForgotPasswordScreen extends StatefulWidget {
  const AdminForgotPasswordScreen({super.key});

  @override
  State<AdminForgotPasswordScreen> createState() => _AdminForgotPasswordScreenState();
}

class _AdminForgotPasswordScreenState extends State<AdminForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'maryam@crew.com');
  bool _isLoading = false;
  bool _sent = false;

  Future<void> _sendLink() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    // TODO: AuthService -> send password reset email.
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _sent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Reset Password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 8),
                const Text("No worries! Enter your email and\nwe'll send you reset instructions.",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 28),
                Container(
                  width: 160, height: 160,
                  decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                  child: Stack(alignment: Alignment.center, children: [
                    Icon(Icons.shield_rounded, size: 76, color: AppColors.primary.withValues(alpha: 0.9)),
                    const Icon(Icons.lock_rounded, size: 30, color: Colors.white),
                    const Positioned(right: 20, bottom: 30, child: Icon(Icons.send_rounded, size: 20, color: AppColors.primary)),
                  ]),
                ),
                const SizedBox(height: 28),
                if (!_sent) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                    decoration: const InputDecoration(prefixIcon: Icon(Icons.mail_outline_rounded)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _sendLink,
                    child: _isLoading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                        : const Text('Send Reset Link'),
                  ),
                ] else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                    child: Row(children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.primary),
                      const SizedBox(width: 12),
                      Expanded(child: Text('Reset link sent to ${_emailController.text}', style: const TextStyle(fontSize: 13, color: AppColors.textPrimary))),
                    ]),
                  ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
