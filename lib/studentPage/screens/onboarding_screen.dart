import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/primary_button.dart';

class OnboardingPage {
  const OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
  });
  final String title;
  final String description;
  final IconData icon;
}

const _pages = [
  OnboardingPage(
    title: 'Your Safety\nOur Priority',
    description:
        'Report anonymously, stay protected, and help us build a better campus.',
    icon: Icons.shield_rounded,
  ),
  OnboardingPage(
    title: 'Speak Up\nWithout Fear',
    description:
        'Your identity stays hidden. Only authorized admins can see your reports.',
    icon: Icons.record_voice_over_rounded,
  ),
  OnboardingPage(
    title: 'Help When\nYou Need It',
    description:
        'One tap sends an emergency alert with your live location, instantly.',
    icon: Icons.bolt_rounded,
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: TextButton(
                  onPressed: () => context.go(AppRoutes.login),
                  child: const Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.screenPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(page.title, style: textTheme.headlineLarge),
                        const SizedBox(height: AppSpacing.md),
                        Text(page.description, style: textTheme.bodyLarge),
                        const SizedBox(height: AppSpacing.xxxl),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withValues(alpha: 0.06),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Center(
                              child: Icon(
                                page.icon,
                                size: 96,
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (i) {
                      final active = i == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primaryBlue
                              : AppColors.divider,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: _index == _pages.length - 1 ? 'Get Started' : 'Next',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _next,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
