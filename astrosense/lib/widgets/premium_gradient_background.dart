import 'package:flutter/material.dart';
import 'dart:ui';
import '../theme/app_theme.dart';

/// Premium animated gradient background with particles effect
class PremiumGradientBackground extends StatefulWidget {
  final Widget child;
  
  const PremiumGradientBackground({super.key, required this.child});

  @override
  State<PremiumGradientBackground> createState() => _PremiumGradientBackgroundState();
}

class _PremiumGradientBackgroundState extends State<PremiumGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.backgroundDark,
                Color.lerp(
                  AppColors.surfaceDark,
                  AppColors.primaryPurple.withOpacity(0.1),
                  (_controller.value * 0.3),
                )!,
                AppColors.gradientEnd,
                Color.lerp(
                  AppColors.backgroundDark,
                  AppColors.accentGold.withOpacity(0.05),
                  (1 - _controller.value) * 0.2,
                )!,
              ],
              stops: const [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Subtle moving particles effect
              Positioned.fill(
                child: CustomPaint(
                  painter: ParticlesPainter(_controller.value),
                ),
              ),
              // Blur overlay for depth
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
                  child: Container(
                    color: Colors.black.withOpacity(0.02),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter for floating particles
class ParticlesPainter extends CustomPainter {
  final double animation;
  
  ParticlesPainter(this.animation);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;
    
    // Draw floating particles
    for (int i = 0; i < 30; i++) {
      final x = (size.width * (i * 0.05)) + (animation * size.width * 0.1);
      final y = (size.height * ((i * 0.03) % 1)) + (animation * size.height * 0.05);
      final radius = 1.0 + (i % 3);
      
      canvas.drawCircle(
        Offset(x % size.width, y % size.height),
        radius,
        paint,
      );
    }
  }
  
  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
