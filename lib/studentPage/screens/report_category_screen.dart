import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/category_tile.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/step_header.dart';
import '../features/report/report_draft.dart';
import '../features/report/report_draft_scope.dart';

class ReportCategoryScreen extends StatefulWidget {
  const ReportCategoryScreen({super.key});

  @override
  State<ReportCategoryScreen> createState() => _ReportCategoryScreenState();
}

class _ReportCategoryScreenState extends State<ReportCategoryScreen> {
  String? _selected = reportDraft.category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StepHeader(
        title: 'Report Incident',
        step: 1,
        totalSteps: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Select Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: GridView.builder(
                itemCount: reportCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, i) {
                  final cat = reportCategories[i];
                  return CategoryTile(
                    icon: cat.icon,
                    label: cat.label,
                    selected: _selected == cat.label,
                    onTap: () => setState(() => _selected = cat.label),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: PrimaryButton(
                label: 'Next',
                icon: Icons.arrow_forward_rounded,
                onPressed: _selected == null
                    ? null
                    : () {
                        reportDraft.setCategory(_selected!);
                        context.push(AppRoutes.reportDetails);
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
