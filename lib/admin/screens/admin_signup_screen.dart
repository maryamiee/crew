import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import 'admin_shell.dart';

/// SCREEN 03 — Admin Sign Up
/// Matches mockup: Create Admin Account title, Full Name/Email/Password/
/// Confirm Password fields, live password-requirements checklist,
/// Sign Up button.
class AdminSignupScreen extends StatefulWidget {
  const AdminSignupScreen({super.key});

  @override
  State<AdminSignupScreen> createState() => _AdminSignupScreenState();
}

class _AdminSignupScreenState extends State<AdminSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscure = true;
  bool _isLoading = false;
  String _password = '';

  bool get _hasMinLength => _password.length >= 6;
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_password);
  bool get _hasSpecialChar => RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(_password);

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!(_hasMinLength && _hasUppercase && _hasSpecialChar)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password does not meet all requirements')));
      return;
    }
    setState(() => _isLoading = true);
    // TODO: AuthService -> create admin account call goes here.
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const AdminShell()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Create Admin Account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                const Text('Join CREW admin portal', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
                  decoration: const InputDecoration(hintText: 'Full Name', prefixIcon: Icon(Icons.person_outline_rounded)),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => (v == null || !v.contains('@')) ? 'Enter a valid email' : null,
                  decoration: const InputDecoration(hintText: 'Email', prefixIcon: Icon(Icons.mail_outline_rounded)),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  onChanged: (v) => setState(() => _password = v),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscure,
                  validator: (v) => (v != _passwordController.text) ? 'Passwords do not match' : null,
                  decoration: const InputDecoration(hintText: 'Confirm Password', prefixIcon: Icon(Icons.lock_outline_rounded)),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Password must contain:', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppColors.primaryDark)),
                      const SizedBox(height: 8),
                      _Rule(label: 'At least 6 characters', met: _hasMinLength),
                      _Rule(label: 'One uppercase letter (A–Z)', met: _hasUppercase),
                      _Rule(label: 'One special character (!@#\$%^&* etc.)', met: _hasSpecialChar),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: _isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
                      : const Text('Sign Up'),
                ),
                const SizedBox(height: 18),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(text: 'Login', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
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

class _Rule extends StatelessWidget {
  const _Rule({required this.label, required this.met});
  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        Icon(met ? Icons.check_circle_rounded : Icons.circle_outlined, size: 16, color: met ? AppColors.primary : AppColors.textDisabled),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12, color: met ? AppColors.primaryDark : AppColors.textSecondary, fontWeight: met ? FontWeight.w600 : FontWeight.w400)),
      ]),
    );
  }
}
