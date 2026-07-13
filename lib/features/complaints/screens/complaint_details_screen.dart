import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/status_chip.dart';
import '../models/complaint.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onUpdateStatus;

  const ComplaintDetailsScreen({
    super.key,
    required this.complaint,
    required this.onUpdateStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text(complaint.id)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        complaint.category,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      StatusChip(status: complaint.status),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    complaint.description,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // --- Reporter identity block ---
          // PRIVACY RULE: never render studentName/studentId when isAnonymous
          // is true. Only complaint.displayName (which already enforces
          // this) is used below.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.adminPrimaryLight,
                    child: Icon(
                      complaint.isAnonymous
                          ? Icons.visibility_off_rounded
                          : Icons.person_rounded,
                      color: AppColors.adminPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaint.displayName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          complaint.isAnonymous
                              ? 'Identity protected by anonymous reporting'
                              : 'Submitted ${_timeAgo(complaint.submittedAt)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          if (complaint.evidenceUrls.isNotEmpty) ...[
            Text('Evidence', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: complaint.evidenceUrls.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: AppSpacing.sm),
                itemBuilder: (context, i) => Container(
                  width: 90,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_outlined,
                    color: AppColors.textSecondary,
                    size: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          if (complaint.adminRemarks != null) ...[
            Text(
              'Admin Remarks',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(complaint.adminRemarks!),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],

          PrimaryButton(label: 'Update Status', onPressed: onUpdateStatus),
        ],
      ),
    );
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
