import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Original vector "campus scene" illustration for the Signup screen —
/// two students in front of a campus building, echoing the mood of the
/// reference design without reproducing it. Drawn entirely with
/// CustomPainter (same approach as CrewLogo) so it's crisp at any size,
/// ships with zero image assets, and stays on-brand (primary blue +
/// secondary green + soft neutrals only).
class CampusIllustration extends StatelessWidget {
  const CampusIllustration({super.key, this.height = 170});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: CustomPaint(painter: _CampusScenePainter()),
    );
  }
}

class _CampusScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    _paintClouds(canvas, w, h);
    _paintTree(canvas, w * 0.10, h * 0.62, w * 0.11);
    _paintTree(canvas, w * 0.90, h * 0.60, w * 0.10);
    _paintBuilding(canvas, w, h);
    _paintGroundShadow(canvas, w, h);
    _paintStudent(
      canvas,
      w,
      h,
      centerX: w * 0.36,
      baseline: h * 0.98,
      scale: w * 0.16,
      bodyColor: AppColors.primaryBlue,
      accentColor: AppColors.primaryBlueDark,
      faceRight: true,
    );
    _paintStudent(
      canvas,
      w,
      h,
      centerX: w * 0.64,
      baseline: h * 1.00,
      scale: w * 0.155,
      bodyColor: AppColors.secondaryGreen,
      accentColor: const Color(0xFF0E9F6E),
      faceRight: false,
    );
  }

  void _paintClouds(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.08);
    for (final c in [
      Offset(w * 0.18, h * 0.14),
      Offset(w * 0.78, h * 0.10),
      Offset(w * 0.92, h * 0.22),
    ]) {
      canvas.drawCircle(c, w * 0.045, paint);
      canvas.drawCircle(c.translate(w * 0.035, h * 0.015), w * 0.035, paint);
      canvas.drawCircle(c.translate(-w * 0.035, h * 0.015), w * 0.03, paint);
    }
  }

  void _paintTree(Canvas canvas, double x, double y, double s) {
    final trunkPaint = Paint()..color = const Color(0xFFB8C2D0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(x, y + s * 0.85), width: s * 0.18, height: s * 0.9),
        Radius.circular(s * 0.06),
      ),
      trunkPaint,
    );
    final leafPaint = Paint()
      ..color = AppColors.secondaryGreen.withValues(alpha: 0.55);
    canvas.drawCircle(Offset(x, y), s * 0.55, leafPaint);
    canvas.drawCircle(Offset(x - s * 0.35, y + s * 0.2), s * 0.4, leafPaint);
    canvas.drawCircle(Offset(x + s * 0.35, y + s * 0.2), s * 0.4, leafPaint);
  }

  void _paintBuilding(Canvas canvas, double w, double h) {
    const baseColor = Color(0xFFDCE4F0);
    final roofColor = AppColors.primaryBlue.withValues(alpha: 0.35);

    final bodyRect = Rect.fromLTWH(w * 0.30, h * 0.30, w * 0.40, h * 0.42);
    canvas.drawRect(bodyRect, Paint()..color = baseColor);

    // Triangular pediment roof.
    final roofPath = Path()
      ..moveTo(w * 0.27, h * 0.30)
      ..lineTo(w * 0.50, h * 0.14)
      ..lineTo(w * 0.73, h * 0.30)
      ..close();
    canvas.drawPath(roofPath, Paint()..color = roofColor);

    // Columns.
    final columnPaint = Paint()..color = Colors.white.withValues(alpha: 0.8);
    for (final cx in [0.35, 0.435, 0.52, 0.605]) {
      canvas.drawRect(
        Rect.fromLTWH(w * cx, h * 0.34, w * 0.02, h * 0.34),
        columnPaint,
      );
    }

    // Entrance steps.
    final stepPaint = Paint()..color = const Color(0xFFC7D2E3);
    canvas.drawRect(
        Rect.fromLTWH(w * 0.28, h * 0.72, w * 0.44, h * 0.03), stepPaint);
    canvas.drawRect(
        Rect.fromLTWH(w * 0.31, h * 0.75, w * 0.38, h * 0.03), stepPaint);
  }

  void _paintGroundShadow(Canvas canvas, double w, double h) {
    final paint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.06);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.5, h * 1.02), width: w * 0.9, height: h * 0.1),
      paint,
    );
  }

  /// Simplified, friendly student figure: circle head, rounded body,
  /// one arm holding a small phone rectangle. Deliberately geometric
  /// (not photorealistic) to match the flat-vector CrewLogo style.
  void _paintStudent(
    Canvas canvas,
    double w,
    double h, {
    required double centerX,
    required double baseline,
    required double scale,
    required Color bodyColor,
    required Color accentColor,
    required bool faceRight,
  }) {
    final headCenter = Offset(centerX, baseline - scale * 1.55);

    // Backpack (drawn first, behind the body).
    final backpackPaint = Paint()..color = accentColor;
    final backpackOffsetX = faceRight ? -scale * 0.32 : scale * 0.32;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX + backpackOffsetX, baseline - scale * 0.75),
          width: scale * 0.5,
          height: scale * 0.8,
        ),
        Radius.circular(scale * 0.14),
      ),
      backpackPaint,
    );

    // Body (rounded trapezoid via RRect).
    final bodyPaint = Paint()..color = bodyColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, baseline - scale * 0.55),
          width: scale * 0.95,
          height: scale * 1.15,
        ),
        Radius.circular(scale * 0.3),
      ),
      bodyPaint,
    );

    // Head.
    canvas.drawCircle(
        headCenter, scale * 0.42, Paint()..color = const Color(0xFFF4C7A1));

    // Simple hair cap (arc).
    final hairPaint = Paint()..color = const Color(0xFF3B2A20);
    canvas.drawArc(
      Rect.fromCircle(center: headCenter, radius: scale * 0.44),
      3.4,
      3.0,
      false,
      hairPaint
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale * 0.22,
    );

    // Arm + phone (small rounded rectangle raised toward the face).
    final armPaint = Paint()
      ..color = bodyColor
      ..strokeWidth = scale * 0.22
      ..strokeCap = StrokeCap.round;
    final handX = faceRight ? centerX + scale * 0.55 : centerX - scale * 0.55;
    final handY = baseline - scale * 1.05;
    canvas.drawLine(
      Offset(centerX + (faceRight ? scale * 0.25 : -scale * 0.25),
          baseline - scale * 0.75),
      Offset(handX, handY),
      armPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
            center: Offset(handX, handY),
            width: scale * 0.26,
            height: scale * 0.4),
        Radius.circular(scale * 0.06),
      ),
      Paint()..color = const Color(0xFF1F2937),
    );
  }

  @override
  bool shouldRepaint(covariant _CampusScenePainter oldDelegate) => false;
}
