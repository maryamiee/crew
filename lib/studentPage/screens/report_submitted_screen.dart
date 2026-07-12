import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';
import '../features/widgets/soft_card.dart';

class ReportSubmittedScreen extends StatefulWidget {
  const ReportSubmittedScreen({super.key});

  @override
  State<ReportSubmittedScreen> createState() => _ReportSubmittedScreenState();
}

class _ReportSubmittedScreenState extends State<ReportSubmittedScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scale,
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('Report Submitted\nSuccessfully!',
                  textAlign: TextAlign.center, style: textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your report has been submitted and is under review.',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.xxl),
              SoftCard(
                child: Column(
                  children: [
                    Text('Report ID', style: textTheme.bodySmall),
                    const SizedBox(height: 4),
                    Text('CRW-2024-0525-001',
                        style: textTheme.titleLarge?.copyWith(
                          color: AppColors.primaryBlue,
                          letterSpacing: 0.5,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),
              PrimaryButton(
                label: 'Go to My Reports',
                onPressed: () => context.go(AppRoutes.dashboard),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.go(AppRoutes.dashboard),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
