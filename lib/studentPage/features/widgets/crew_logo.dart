import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// The CREW brand mark: a shield (protection) with a speech bubble
/// (voice/reporting) cut out of it. Used on splash, app bar, and
/// anywhere the brand needs to appear.
///
/// Rendered as pure vector (CustomPainter) so it scales crisply at
/// any size without shipping a raster asset.
class CrewLogo extends StatelessWidget {
  const CrewLogo({
    super.key,
    this.size = 64,
    this.showBackgroundGlow = true,
  });

  final double size;
  final bool showBackgroundGlow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CrewLogoPainter(showGlow: showBackgroundGlow),
      ),
    );
  }
}

class _CrewLogoPainter extends CustomPainter {
  _CrewLogoPainter({required this.showGlow});
  final bool showGlow;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);

    if (showGlow) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.primaryBlue.withValues(alpha: 0.18),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: w * 0.62));
      canvas.drawCircle(center, w * 0.62, glowPaint);
    }

    // Shield shape.
    final shieldPath = Path();
    shieldPath.moveTo(w * 0.5, h * 0.04);
    shieldPath.cubicTo(
      w * 0.62,
      h * 0.12,
      w * 0.78,
      h * 0.16,
      w * 0.90,
      h * 0.18,
    );
    shieldPath.lineTo(w * 0.90, h * 0.46);
    shieldPath.cubicTo(
      w * 0.90,
      h * 0.72,
      w * 0.74,
      h * 0.90,
      w * 0.5,
      h * 0.98,
    );
    shieldPath.cubicTo(
      w * 0.26,
      h * 0.90,
      w * 0.10,
      h * 0.72,
      w * 0.10,
      h * 0.46,
    );
    shieldPath.lineTo(w * 0.10, h * 0.18);
    shieldPath.cubicTo(
      w * 0.22,
      h * 0.16,
      w * 0.38,
      h * 0.12,
      w * 0.5,
      h * 0.04,
    );
    shieldPath.close();

    final shieldPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primaryBlue, AppColors.primaryBlueDark],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(shieldPath, shieldPaint);

    // Speech bubble (white) in the center — represents "voice".
    final bubbleRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.44),
      width: w * 0.46,
      height: h * 0.34,
    );
    final bubblePaint = Paint()..color = Colors.white;
    final bubbleRRect = RRect.fromRectAndRadius(
      bubbleRect,
      Radius.circular(w * 0.10),
    );
    canvas.drawRRect(bubbleRRect, bubblePaint);

    // Speech bubble tail.
    final tailPath = Path();
    tailPath.moveTo(w * 0.42, h * 0.60);
    tailPath.lineTo(w * 0.40, h * 0.72);
    tailPath.lineTo(w * 0.52, h * 0.62);
    tailPath.close();
    canvas.drawPath(tailPath, bubblePaint);

    // Three dots inside bubble (chat indicator).
    final dotPaint = Paint()..color = AppColors.primaryBlue;
    final dotRadius = w * 0.028;
    final dotY = h * 0.44;
    for (final dx in [-0.10, 0.0, 0.10]) {
      canvas.drawCircle(Offset(w * (0.5 + dx), dotY), dotRadius, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CrewLogoPainter oldDelegate) => false;
}
