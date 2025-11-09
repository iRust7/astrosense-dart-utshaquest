import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Cosmic logo widget with animated glow effect
class CosmicLogo extends StatefulWidget {
  final double size;
  final bool animate;

  const CosmicLogo({
    super.key,
    this.size = 100,
    this.animate = true,
  });

  @override
  State<CosmicLogo> createState() => _CosmicLogoState();
}

class _CosmicLogoState extends State<CosmicLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryPurple,
                AppColors.accentGold,
              ],
            ),
            boxShadow: widget.animate
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple
                          .withOpacity(0.5 * _pulseAnimation.value),
                      blurRadius: 30 * _pulseAnimation.value,
                      spreadRadius: 5 * _pulseAnimation.value,
                    ),
                    BoxShadow(
                      color: AppColors.accentGold
                          .withOpacity(0.3 * _pulseAnimation.value),
                      blurRadius: 40 * _pulseAnimation.value,
                      spreadRadius: 10 * _pulseAnimation.value,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.primaryPurple.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Main star icon
              Icon(
                Icons.auto_awesome,
                size: widget.size * 0.5,
                color: Colors.white,
              ),
              // Rotating outer stars
              if (widget.animate)
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * 3.14159,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: widget.size * 0.8,
                    height: widget.size * 0.8,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: widget.size * 0.35,
                          child: Icon(
                            Icons.star,
                            size: widget.size * 0.15,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: widget.size * 0.35,
                          child: Icon(
                            Icons.star,
                            size: widget.size * 0.15,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: widget.size * 0.35,
                          child: Icon(
                            Icons.star,
                            size: widget.size * 0.15,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: widget.size * 0.35,
                          child: Icon(
                            Icons.star,
                            size: widget.size * 0.15,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Zodiac constellation background pattern
class ZodiacPattern extends StatelessWidget {
  final double opacity;

  const ZodiacPattern({
    super.key,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: _ZodiacPatternPainter(opacity: opacity),
    );
  }
}

class _ZodiacPatternPainter extends CustomPainter {
  final double opacity;

  _ZodiacPatternPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Draw random stars pattern
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    for (int i = 0; i < 50; i++) {
      final x = (random * i * 7) % size.width;
      final y = (random * i * 11) % size.height;
      final radius = (i % 3) + 1.0;
      
      canvas.drawCircle(Offset(x, y), radius, paint);
      
      // Draw constellation lines occasionally
      if (i % 5 == 0 && i > 0) {
        final prevX = (random * (i - 5) * 7) % size.width;
        final prevY = (random * (i - 5) * 11) % size.height;
        canvas.drawLine(Offset(prevX, prevY), Offset(x, y), linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_ZodiacPatternPainter oldDelegate) => false;
}
