import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Premium shimmer loading widget for skeleton screens
class PremiumShimmer extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final Color? baseColor;
  final Color? highlightColor;
  
  const PremiumShimmer({
    super.key,
    required this.child,
    this.enabled = true,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;
    
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.white.withOpacity(0.1),
      highlightColor: highlightColor ?? Colors.white.withOpacity(0.2),
      period: const Duration(milliseconds: 1500),
      child: child,
    );
  }
}

/// Pre-built shimmer skeleton for cards
class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  
  const ShimmerCard({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
    );
  }
}

/// Pre-built shimmer skeleton for text lines
class ShimmerText extends StatelessWidget {
  final double? width;
  final double height;
  
  const ShimmerText({
    super.key,
    this.width,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(height / 2),
      ),
    );
  }
}

/// Pre-built shimmer skeleton for circular avatars
class ShimmerCircle extends StatelessWidget {
  final double size;
  
  const ShimmerCircle({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
