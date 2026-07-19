import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// CREW Admin Portal shield mark — a person icon inside the shield
/// (distinguishes it from the Student module's chat-bubble shield),
/// per the mockup's splash screen.
class AdminLogo extends StatelessWidget {
  const AdminLogo({super.key, this.size = 96});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Icon(Icons.shield_rounded, color: Colors.white, size: size * 0.52),
    );
  }
}
