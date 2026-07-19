import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/widgets/admin_logo.dart';
import 'admin_login_screen.dart';

/// SCREEN 01 — Admin Splash
/// Matches mockup: shield-with-person icon, CREW Admin Portal title,
/// tagline, decorative building illustration, dot indicator, green wave.
class AdminSplashScreen extends StatefulWidget {
  const AdminSplashScreen({super.key});

  @override
  State<AdminSplashScreen> createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0, right: 0, bottom: 0,
            child: ClipPath(
              clipper: _WaveClipper(),
              child: Container(height: 120, color: AppColors.primary.withValues(alpha: 0.15)),
            ),
          ),
          Positioned(
            left: 0, right: 0, bottom: -10,
            child: ClipPath(
              clipper: _WaveClipper(offset: 18),
              child: Container(height: 90, color: AppColors.primary.withValues(alpha: 0.25)),
            ),
          ),
          SafeArea(
            child: FadeTransition(
              opacity: _controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  const AdminLogo(size: 96),
                  const SizedBox(height: 20),
                  const Text('CREW', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  const Text('Admin Portal', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  const SizedBox(height: 12),
                  const Text('Campus Reporting &\nEmergency Workflow',
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 32),
                  Container(
                    width: 220, height: 120,
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.account_balance_rounded, size: 56, color: AppColors.primary),
                  ),
                  const SizedBox(height: 28),
                  const Text('Powerful. Secure. Reliable.',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  const Text('For a Safer Campus.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == 0 ? 20 : 6, height: 6,
                      decoration: BoxDecoration(
                        color: i == 0 ? AppColors.primary : AppColors.divider,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    )),
                  ),
                  const Spacer(flex: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
                      ),
                      child: const Text('Get Started'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  final double offset;
  _WaveClipper({this.offset = 0});
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height * 0.4 + offset);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.1 + offset, size.width * 0.5, size.height * 0.35 + offset);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.6 + offset, size.width, size.height * 0.2 + offset);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
