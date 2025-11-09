import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../config/app_images.dart';

/// Zodiac sign visual representation with icons
class ZodiacIcon extends StatelessWidget {
  final String zodiacSign;
  final double size;
  final bool showGlow;

  const ZodiacIcon({
    super.key,
    required this.zodiacSign,
    this.size = 60,
    this.showGlow = true,
  });

  /// Get emoji and icon for each zodiac sign
  Map<String, dynamic> _getZodiacData(String sign) {
    final signLower = sign.toLowerCase();
    
    switch (signLower) {
      case 'aries':
        return {'emoji': '♈', 'icon': Icons.whatshot, 'color': const Color(0xFFFF6B6B)};
      case 'taurus':
        return {'emoji': '♉', 'icon': Icons.landscape, 'color': const Color(0xFF4ECDC4)};
      case 'gemini':
        return {'emoji': '♊', 'icon': Icons.people, 'color': const Color(0xFFFFE66D)};
      case 'cancer':
        return {'emoji': '♋', 'icon': Icons.water_drop, 'color': const Color(0xFF95E1D3)};
      case 'leo':
        return {'emoji': '♌', 'icon': Icons.wb_sunny, 'color': const Color(0xFFFFA07A)};
      case 'virgo':
        return {'emoji': '♍', 'icon': Icons.eco, 'color': const Color(0xFF98D8C8)};
      case 'libra':
        return {'emoji': '♎', 'icon': Icons.balance, 'color': const Color(0xFFB4A7D6)};
      case 'scorpio':
        return {'emoji': '♏', 'icon': Icons.flash_on, 'color': const Color(0xFFE63946)};
      case 'sagittarius':
        return {'emoji': '♐', 'icon': Icons.arrow_upward, 'color': const Color(0xFF457B9D)};
      case 'capricorn':
        return {'emoji': '♑', 'icon': Icons.terrain, 'color': const Color(0xFF6C757D)};
      case 'aquarius':
        return {'emoji': '♒', 'icon': Icons.waves, 'color': const Color(0xFF06FFA5)};
      case 'pisces':
        return {'emoji': '♓', 'icon': Icons.water, 'color': const Color(0xFF9B59B6)};
      default:
        return {'emoji': '✨', 'icon': Icons.auto_awesome, 'color': AppColors.primaryPurple};
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _getZodiacData(zodiacSign);
    final Color color = data['color'];
    final String imageUrl = AppImages.zodiacImages[zodiacSign.toLowerCase()] ?? '';

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.6),
          ],
        ),
        boxShadow: showGlow
            ? [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Center(
        child: imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl,
                width: size * 0.6,
                height: size * 0.6,
                color: Colors.white,
                placeholder: (context, url) => Text(
                  data['emoji'],
                  style: TextStyle(
                    fontSize: size * 0.5,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Text(
                  data['emoji'],
                  style: TextStyle(
                    fontSize: size * 0.5,
                    color: Colors.white,
                  ),
                ),
              )
            : Text(
                data['emoji'],
                style: TextStyle(
                  fontSize: size * 0.5,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}

/// Zodiac card with icon and name
class ZodiacCard extends StatelessWidget {
  final String zodiacSign;
  final VoidCallback? onTap;
  final bool isSelected;

  const ZodiacCard({
    super.key,
    required this.zodiacSign,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryPurple.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryPurple
                : Colors.white.withOpacity(0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZodiacIcon(
              zodiacSign: zodiacSign,
              size: 50,
              showGlow: isSelected,
            ),
            const SizedBox(height: 8),
            Text(
              zodiacSign,
              style: TextStyle(
                color: isSelected ? AppColors.accentGold : Colors.white,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Get all zodiac signs list
List<String> get allZodiacSigns => [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces',
    ];
