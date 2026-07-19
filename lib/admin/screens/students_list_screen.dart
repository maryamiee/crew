import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import 'add_user_screen.dart';

/// SCREEN 09 — Users Management (green Admin module)
/// Searchable, role-filterable student/staff/admin directory.
class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  String _roleFilter = 'All Roles';

  final _users = const [
    (name: 'Ayesha Khan', role: 'Student', email: 'ayesha@university.edu'),
    (name: 'Ali Raza', role: 'Student', email: 'ali@university.edu'),
    (name: 'Sara Ahmed', role: 'Student', email: 'sara@university.edu'),
    (name: 'John Smith', role: 'Staff', email: 'john@university.edu'),
    (name: 'Fatima Noor', role: 'Admin', email: 'fatima@university.edu'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _roleFilter == 'All Roles'
        ? _users
        : _users.where((u) => u.role == _roleFilter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    filled: true, fillColor: AppColors.surfaceMuted,
                    border: OutlineInputBorder(borderRadius: AppRadius.card, borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              DropdownButton<String>(
                value: _roleFilter,
                underline: const SizedBox(),
                items: ['All Roles', 'Student', 'Staff', 'Admin']
                    .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                    .toList(),
                onChanged: (v) => setState(() => _roleFilter = v!),
              ),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final u = filtered[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
                  child: Row(children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryLight,
                      child: Text(u.name[0], style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(u.name, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                        Text('${u.role} · ${u.email}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                      ]),
                    ),
                    const Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
                  ]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddUserScreen())),
                icon: const Icon(Icons.person_add_rounded),
                label: const Text('Add User'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
