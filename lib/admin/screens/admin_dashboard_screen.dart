import 'package:flutter/material.dart';
import '../features/theme/app_colors.dart';
import '../features/theme/app_tokens.dart';
import '../features/widgets/stat_card.dart';

/// SCREEN 05 — Admin Dashboard
/// Matches mockup: greeting + notification bell + avatar, Total Reports
/// hero card (green, with delta), 3-across stat row, Reports Overview
/// line chart, Category Distribution donut with legend.
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Row(
            children: [
              IconButton(icon: const Icon(Icons.menu_rounded), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.notifications_none_rounded), onPressed: () {}),
              const SizedBox(width: 4),
              const CircleAvatar(radius: 18, backgroundColor: AppColors.primaryLight, child: Icon(Icons.person_rounded, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Good Morning,', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const Text('Maryam Khan 👋', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const Text('Super Admin', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: AppSpacing.lg),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: AppRadius.card,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Reports', style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('1,246', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800)),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6),
                      child: Text('+12% from last month', style: TextStyle(color: Colors.white70, fontSize: 11.5)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          Row(children: const [
            Expanded(child: StatCard(label: 'Pending', value: '112', delta: '+8%', color: AppColors.warning)),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: StatCard(label: 'In Progress', value: '320', delta: '+15%', color: AppColors.info)),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: StatCard(label: 'Resolved', value: '814', delta: '+16%', color: AppColors.primary)),
          ]),
          const SizedBox(height: AppSpacing.xl),

          const Text('Reports Overview', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.sm),
          Container(
            height: 140,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
            child: CustomPaint(painter: _LineChartPainter(), size: Size.infinite),
          ),
          const SizedBox(height: AppSpacing.xl),

          const Text('Category Distribution', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: AppRadius.card, boxShadow: AppElevation.card),
            child: Row(
              children: [
                SizedBox(width: 96, height: 96, child: CustomPaint(painter: _DonutPainter())),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _LegendRow(color: Color(0xFFEF4444), label: 'Bullying', percent: '35%'),
                      _LegendRow(color: Color(0xFFF59E0B), label: 'Harassment', percent: '25%'),
                      _LegendRow(color: Color(0xFF2563EB), label: 'Infrastructure', percent: '20%'),
                      _LegendRow(color: AppColors.primary, label: 'Safety', percent: '15%'),
                      _LegendRow(color: Color(0xFF94A3B8), label: 'Other', percent: '5%'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.color, required this.label, required this.percent});
  final Color color;
  final String label;
  final String percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12.5, color: AppColors.textPrimary))),
        Text(percent, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
      ]),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [0.6, 0.45, 0.5, 0.3, 0.55, 0.35, 0.4];
    final path = Path();
    final fillPath = Path();
    final dx = size.width / (points.length - 1);
    for (int i = 0; i < points.length; i++) {
      final x = dx * i;
      final y = size.height * points[i];
      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, Paint()..color = AppColors.primary.withValues(alpha: 0.08));
    canvas.drawPath(path, Paint()..color = AppColors.primary..style = PaintingStyle.stroke..strokeWidth = 2.5..strokeCap = StrokeCap.round);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final segments = [
      (0.35, const Color(0xFFEF4444)),
      (0.25, const Color(0xFFF59E0B)),
      (0.20, const Color(0xFF2563EB)),
      (0.15, AppColors.primary),
      (0.05, const Color(0xFF94A3B8)),
    ];
    final rect = Offset.zero & size;
    double start = -1.5708;
    for (final (fraction, color) in segments) {
      final sweep = fraction * 6.28319;
      canvas.drawArc(rect.deflate(4), start, sweep, false,
          Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 14..strokeCap = StrokeCap.butt);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
