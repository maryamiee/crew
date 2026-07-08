import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';

class StudentEntry {
  final String name;
  final String id;
  final String department;
  const StudentEntry({required this.name, required this.id, required this.department});

  static List<StudentEntry> demoList() => const [
        StudentEntry(name: 'Ahmed Raza', id: 'STD-2201', department: 'Computer Science'),
        StudentEntry(name: 'Sana Malik', id: 'STD-2078', department: 'Business Administration'),
        StudentEntry(name: 'Bilal Khan', id: 'STD-1994', department: 'Electrical Engineering'),
        StudentEntry(name: 'Hina Farooq', id: 'STD-2150', department: 'Psychology'),
        StudentEntry(name: 'Usman Tariq', id: 'STD-2033', department: 'Computer Science'),
      ];
}

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final all = StudentEntry.demoList();
    final filtered = all
        .where((s) => s.name.toLowerCase().contains(_query.toLowerCase()) ||
            s.id.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Students')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Search by name or ID',
                prefixIcon: Icon(Icons.search_rounded),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
              itemBuilder: (context, i) {
                final s = filtered[i];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.adminPrimaryLight,
                      child: Text(s.name[0], style: const TextStyle(color: AppColors.adminPrimary, fontWeight: FontWeight.w600)),
                    ),
                    title: Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${s.id} · ${s.department}', style: const TextStyle(fontSize: 12)),
                    trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
