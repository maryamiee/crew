import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../core/widgets/status_chip.dart';
import '../../complaints/models/complaint.dart';

class AdminDashboardScreen extends StatelessWidget {
  final void Function(Complaint) onOpenComplaint;
  const AdminDashboardScreen({super.key, required this.onOpenComplaint});

  @override
  Widget build(BuildContext context) {
    final complaints = Complaint.demoList();
    final recent = complaints.take(3).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text('Overview', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 1.35,
            children: const [
              StatCard(
                label: 'Open Complaints',
                value: '18',
                icon: Icons.report_gmailerrorred_rounded,
                color: AppColors.warningAmber,
                trend: '+3 today',
              ),
              StatCard(
                label: 'Resolved (This Month)',
                value: '54',
                icon: Icons.check_circle_outline_rounded,
                color: AppColors.safetyGreen,
                trend: '+12% vs last month',
              ),
              StatCard(
                label: 'Active Students',
                value: '1,204',
                icon: Icons.people_alt_outlined,
                color: AppColors.trustBlue,
              ),
              StatCard(
                label: 'Emergency Alerts',
                value: '2',
                icon: Icons.emergency_outlined,
                color: AppColors.sosRed,
                trend: 'Needs attention',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Complaints', style: Theme.of(context).textTheme.titleLarge),
              TextButton(onPressed: () {}, child: const Text('View all')),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...recent.map((c) => _ComplaintPreviewCard(
                complaint: c,
                onTap: () => onOpenComplaint(c),
              )),
        ],
      ),
    );
  }
}

class _ComplaintPreviewCard extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onTap;
  const _ComplaintPreviewCard({required this.complaint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.adminPrimaryLight,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Icon(Icons.description_outlined, color: AppColors.adminPrimary),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(complaint.category,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(complaint.displayName,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              StatusChip(status: complaint.status),
            ],
          ),
        ),
      ),
    );
  }
}
