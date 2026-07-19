import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';

/// SCREEN 10 — Add User (green Admin module)
class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _role;
  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty || _emailController.text.trim().isEmpty || _role == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill in name, email, and role')));
      return;
    }
    setState(() => _saving = true);
    // TODO: AdminUserService -> create user document in Firestore.
    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New User')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Center(
            child: Column(children: [
              Container(
                width: 84, height: 84,
                decoration: BoxDecoration(color: AppColors.surfaceMuted, shape: BoxShape.circle),
                child: const Icon(Icons.person_rounded, size: 40, color: AppColors.textDisabled),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(onPressed: () {}, child: const Text('Upload Photo')),
            ]),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outline_rounded))),
          const SizedBox(height: AppSpacing.md),
          TextField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline_rounded))),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            value: _role,
            decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.badge_outlined)),
            items: ['Student', 'Staff', 'Admin'].map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
            onChanged: (v) => setState(() => _role = v),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(controller: _phoneController, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone_outlined))),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saving ? null : _save,
              child: _saving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Add User'),
            ),
          ),
        ],
      ),
    );
  }
}
