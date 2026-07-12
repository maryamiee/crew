import 'package:flutter/material.dart';
import 'crew_logo.dart';

/// Animated version of [CrewLogo] — used on the Login screen to give the
/// brand mark a subtle sense of life without being distracting.
///
/// Two layered animations:
/// 1. One-time entrance: fade + scale-in when the screen first appears.
/// 2. Continuous "breathing" loop: a very gentle scale pulse (1.00 -> 1.05)
///    that keeps the mark feeling alive while the student reads the form.
///
/// Both are intentionally slow and low-amplitude — this is a trust/safety
/// app, so the motion should read as "calm and alive", not "flashy".
class AnimatedCrewLogo extends StatefulWidget {
  const AnimatedCrewLogo({super.key, this.size = 72});

  final double size;

  @override
  State<AnimatedCrewLogo> createState() => _AnimatedCrewLogoState();
}

class _AnimatedCrewLogoState extends State<AnimatedCrewLogo>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _breatheController;
  late final Animation<double> _entranceScale;
  late final Animation<double> _entranceFade;
  late final Animation<double> _breatheScale;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _entranceScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: Curves.easeOutBack),
    );
    _entranceFade = CurvedAnimation(parent: _entranceController, curve: Curves.easeOut);

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _breatheScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_entranceController, _breatheController]),
      builder: (context, child) {
        final combinedScale = _entranceScale.value * _breatheScale.value;
        return Opacity(
          opacity: _entranceFade.value,
          child: Transform.scale(
            scale: combinedScale,
            child: child,
          ),
        );
      },
      child: CrewLogo(size: widget.size),
    );
  }
}
