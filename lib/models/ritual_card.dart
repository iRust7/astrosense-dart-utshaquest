import 'package:flutter/material.dart';

/// Represents a card in the daily ritual
class RitualCard {
  final String id;
  final String title;
  final String description;
  final String category;
  final String icon;
  final List<String> keywords;
  final int rarityLevel; // 1-5, higher is rarer

  RitualCard({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    this.keywords = const [],
    this.rarityLevel = 1,
  });

  /// Get rarity color
  Color get rarityColor {
    switch (rarityLevel) {
      case 5:
        return const Color(0xFFFFD700); // Legendary - Gold
      case 4:
        return const Color(0xFFB19CD9); // Epic - Purple
      case 3:
        return const Color(0xFF4A90E2); // Rare - Blue
      case 2:
        return const Color(0xFF50C878); // Uncommon - Green
      default:
        return const Color(0xFFCCCCCC); // Common - Gray
    }
  }

  /// Get rarity name
  String get rarityName {
    switch (rarityLevel) {
      case 5:
        return 'Legendary';
      case 4:
        return 'Epic';
      case 3:
        return 'Rare';
      case 2:
        return 'Uncommon';
      default:
        return 'Common';
    }
  }
}
