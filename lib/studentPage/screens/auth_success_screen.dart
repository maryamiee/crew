import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/routes/app_router.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_spacing.dart';
import '../features/widgets/crew_logo.dart';

/// SCREEN — Auth Success (transient, ~1.6s)
///
/// Shown immediately after a successful Login or Signup, before landing
/// on the Dashboard. A single AnimationController drives every element
/// via staggered Intervals — deliberately ONE controller (not several)
/// to avoid ticker-provider bugs like the one in AnimatedCrewLogo.
///
/// Sequence: logo scales in with a soft elastic pop -> an expanding ring
/// pulses outward once -> welcome text fades up -> a thin progress bar
/// fills -> auto-navigates to Dashboard with a fade+slide transition
/// (see app_router.dart's CustomTransitionPage for the dashboard route).
class AuthSuccessScreen extends StatefulWidget {
  const AuthSuccessScreen({super.key, required this.name, required this.isSignup});

  final String name;
  final bool isSignup;

  @override
  State<AuthSuccessScreen> createState() => _AuthSuccessScreenState();
}

class _AuthSuccessScreenState extends State<AuthSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _ringScale;
  late final Animation<double> _ringFade;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _logoScale = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.42, curve: Curves.easeOutBack)),
    );
    _logoFade = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.30, curve: Curves.easeOut));

    _ringScale = Tween<double>(begin: 0.7, end: 1.9).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.10, 0.65, curve: Curves.easeOut)),
    );
    _ringFade = Tween<double>(begin: 0.35, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.10, 0.65, curve: Curves.easeOut)),
    );

    _textFade = CurvedAnimation(parent: _controller, curve: const Interval(0.40, 0.70, curve: Curves.easeOut));
    _textSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.40, 0.70, curve: Curves.easeOut)),
    );

    _progress = CurvedAnimation(parent: _controller, curve: const Interval(0.55, 1.0, curve: Curves.easeInOut));

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Small settle buffer so the filled progress bar is visible for a
        // beat before the screen changes — keeps the whole thing feeling
        // like ~1.5-1.8s total, not an abrupt cutoff.
        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) context.go(AppRoutes.dashboard);
        });
      }
    });
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SizedBox(
                    width: 160,
                    height: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform.scale(
                          scale: _ringScale.value,
                          child: Opacity(
                            opacity: _ringFade.value,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primaryBlue, width: 2),
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: _logoFade.value,
                          child: Transform.scale(
                            scale: _logoScale.value,
                            child: const CrewLogo(size: 96),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              FadeTransition(
                opacity: _textFade,
                child: SlideTransition(
                  position: _textSlide,
                  child: Column(
                    children: [
                      Text(
                        widget.isSignup
                            ? 'Welcome to CREW, ${widget.name}!'
                            : 'Welcome back, ${widget.name}!',
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Setting up your safe space...',
                        style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              SizedBox(
                width: 120,
                child: AnimatedBuilder(
                  animation: _progress,
                  builder: (context, child) => ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: _progress.value,
                      minHeight: 4,
                      backgroundColor: AppColors.inputFill,
                      valueColor: const AlwaysStoppedAnimation(AppColors.primaryBlue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
