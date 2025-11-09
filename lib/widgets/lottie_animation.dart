import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Magic cube loading animation - Universal loading indicator
class MagicCubeLoading extends StatelessWidget {
  final double size;
  
  const MagicCubeLoading({
    super.key,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/magic cube.json',
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}

/// Magic sparkle animation - For zodiac sign exploration
class MagicSparkleAnimation extends StatelessWidget {
  final double size;
  final bool repeat;
  
  const MagicSparkleAnimation({
    super.key,
    this.size = 100,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/Magic Sprinkle.json',
      width: size,
      height: size,
      fit: BoxFit.contain,
      repeat: repeat,
    );
  }
}

/// Loading placeholder with magic cube animation
class LoadingPlaceholder extends StatelessWidget {
  final String? message;
  final double animationSize;
  
  const LoadingPlaceholder({
    super.key,
    this.message,
    this.animationSize = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MagicCubeLoading(size: animationSize),
          if (message != null) ...[
            const SizedBox(height: 16),
            Flexible(
              child: Text(
                message!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
