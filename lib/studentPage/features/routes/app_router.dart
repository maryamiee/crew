import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../screens/splash_screen.dart';
import '../../screens/onboarding_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/signup_screen.dart';
import '../../screens/forgot_password_screen.dart';
import '../../screens/auth_success_screen.dart';
import '../../screens/report_category_screen.dart';
import '../../screens/report_details_screen.dart';
import '../../screens/upload_evidence_screen.dart';
import '../../screens/privacy_confidentiality_screen.dart';
import '../../screens/report_submitted_screen.dart';
import '../../screens/emergency_sos_screen.dart';
import '../../screens/dashboard_screen.dart';

class AppRoutes {
  AppRoutes._();
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signup = '/signup';
  static const forgotPassword = '/forgot-password';
  static const authSuccess = '/auth-success';
  static const dashboard = '/dashboard';
  static const reportCategory = '/report/category';
  static const reportDetails = '/report/details';
  static const uploadEvidence = '/report/evidence';
  static const privacyConfidentiality = '/report/privacy';
  static const reportSubmitted = '/report/submitted';
  static const emergencySos = '/sos';
}

/// Shared fade + gentle-slide-up transition — used for the auth-success
/// hop and the final landing on Dashboard, so moving from "you just
/// logged in" to "here's your app" feels like one continuous, premium
/// motion instead of a hard cut.
CustomTransitionPage<void> _fadeSlidePage(Widget child) {
  return CustomTransitionPage<void>(
    child: child,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 320),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.authSuccess,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _fadeSlidePage(
          AuthSuccessScreen(
            name: (extra?['name'] as String?) ?? 'Student',
            isSignup: (extra?['isSignup'] as bool?) ?? false,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.dashboard,
      pageBuilder: (context, state) => _fadeSlidePage(const DashboardScreen()),
    ),
    GoRoute(
      path: AppRoutes.reportCategory,
      builder: (context, state) => const ReportCategoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.reportDetails,
      builder: (context, state) => const ReportDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.uploadEvidence,
      builder: (context, state) => const UploadEvidenceScreen(),
    ),
    GoRoute(
      path: AppRoutes.privacyConfidentiality,
      builder: (context, state) => const PrivacyConfidentialityScreen(),
    ),
    GoRoute(
      path: AppRoutes.reportSubmitted,
      builder: (context, state) => const ReportSubmittedScreen(),
    ),
    GoRoute(
      path: AppRoutes.emergencySos,
      builder: (context, state) => const EmergencySosScreen(),
    ),
  ],
);
