import 'dart:math';
import '../models/ritual_card.dart';
import '../models/user_progress.dart';

/// Service for managing daily rituals and rewards
class RitualService {
  static final RitualService _instance = RitualService._internal();
  factory RitualService() => _instance;
  RitualService._internal();

  final Random _random = Random();

  /// Generate 3 random cards for a category
  List<RitualCard> generateCards(String category) {
    final allCards = _getCardsForCategory(category);
    allCards.shuffle(_random);
    return allCards.take(3).toList();
  }

  /// Get all cards for a category
  List<RitualCard> _getCardsForCategory(String category) {
    switch (category) {
      case 'General':
        return _generalCards;
      case 'Emotional':
        return _emotionalCards;
      case 'Career':
        return _careerCards;
      default:
        return _generalCards;
    }
  }

  /// Calculate rewards for completing a ritual
  RitualReward calculateReward(UserProgress progress, String category, int cardRarity) {
    final now = DateTime.now();
    final isNewStreak = progress.lastRitualDate == null ||
        !_isSameDay(progress.lastRitualDate!, now);

    // Base rewards
    int xpGained = 50 + (cardRarity * 10);
    int stardustGained = 25 + (cardRarity * 5);

    // Streak bonus
    final newStreak = isNewStreak ? progress.currentStreak + 1 : progress.currentStreak;
    final streakBonus = newStreak >= 3;
    if (streakBonus) {
      xpGained += (newStreak * 5);
      stardustGained += (newStreak * 2);
    }

    // Level up check
    final newXP = progress.xp + xpGained;
    final levelUp = newXP >= progress.xpToNextLevel;
    final newLevel = levelUp ? progress.level + 1 : progress.level;

    String message = levelUp
        ? '🎉 Level Up! You reached Level $newLevel!'
        : streakBonus
            ? '🔥 $newStreak-day streak! Bonus rewards!'
            : '✨ Ritual completed!';

    return RitualReward(
      xp: xpGained,
      stardust: stardustGained,
      levelUp: levelUp,
      newLevel: newLevel,
      streakBonus: streakBonus,
      message: message,
    );
  }

  /// Update user progress after completing a ritual
  UserProgress updateProgress(
    UserProgress progress,
    RitualReward reward,
    String category,
  ) {
    final now = DateTime.now();
    final isNewStreak = progress.lastRitualDate == null ||
        !_isSameDay(progress.lastRitualDate!, now);

    final newStreak = isNewStreak ? progress.currentStreak + 1 : progress.currentStreak;
    final newXP = reward.levelUp ? reward.xp - progress.xpToNextLevel : progress.xp + reward.xp;
    final newXPNeeded = reward.levelUp
        ? UserProgress.calculateXPNeeded(reward.newLevel)
        : progress.xpToNextLevel;

    final categoryCompletions = Map<String, int>.from(progress.categoryCompletions);
    categoryCompletions[category] = (categoryCompletions[category] ?? 0) + 1;

    return progress.copyWith(
      level: reward.newLevel,
      xp: newXP,
      xpToNextLevel: newXPNeeded,
      stardust: progress.stardust + reward.stardust,
      currentStreak: newStreak,
      longestStreak: max(progress.longestStreak, newStreak),
      lastRitualDate: now,
      categoryCompletions: categoryCompletions,
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  /// Sample cards database
  final List<RitualCard> _generalCards = [
    RitualCard(
      id: 'gen_1',
      title: 'The Cosmic Awakening',
      description: 'The universe is aligning in your favor. Today brings unexpected opportunities that will reshape your path.',
      category: 'General',
      icon: '✨',
      keywords: ['opportunity', 'awakening', 'transformation'],
      rarityLevel: 3,
    ),
    RitualCard(
      id: 'gen_2',
      title: 'Stardust Alignment',
      description: 'Your energy resonates with the cosmic frequency. Trust your intuition and follow the signs.',
      category: 'General',
      icon: '⭐',
      keywords: ['intuition', 'alignment', 'trust'],
      rarityLevel: 2,
    ),
    RitualCard(
      id: 'gen_3',
      title: 'The Mystic Path',
      description: 'A hidden opportunity awaits. Look beyond the obvious and embrace the mysterious.',
      category: 'General',
      icon: '🔮',
      keywords: ['mystery', 'opportunity', 'wisdom'],
      rarityLevel: 4,
    ),
    RitualCard(
      id: 'gen_4',
      title: 'Lunar Blessing',
      description: 'The moon illuminates your journey. Tonight, reflect on your progress and set new intentions.',
      category: 'General',
      icon: '🌙',
      keywords: ['reflection', 'intention', 'blessing'],
      rarityLevel: 2,
    ),
    RitualCard(
      id: 'gen_5',
      title: 'Solar Radiance',
      description: 'Your inner light shines brightly today. Share your warmth with others and watch miracles unfold.',
      category: 'General',
      icon: '☀️',
      keywords: ['light', 'sharing', 'miracles'],
      rarityLevel: 3,
    ),
  ];

  final List<RitualCard> _emotionalCards = [
    RitualCard(
      id: 'emo_1',
      title: 'Heart Chakra Opening',
      description: 'Your emotional barriers are dissolving. Allow yourself to feel deeply and connect authentically.',
      category: 'Emotional',
      icon: '💖',
      keywords: ['healing', 'connection', 'vulnerability'],
      rarityLevel: 4,
    ),
    RitualCard(
      id: 'emo_2',
      title: 'Emotional Alchemy',
      description: 'Transform your pain into power. Every emotion is a teacher guiding you toward growth.',
      category: 'Emotional',
      icon: '🦋',
      keywords: ['transformation', 'growth', 'healing'],
      rarityLevel: 3,
    ),
    RitualCard(
      id: 'emo_3',
      title: 'Inner Peace Portal',
      description: 'A deep calm washes over your soul. Today is perfect for meditation and self-reflection.',
      category: 'Emotional',
      icon: '🕊️',
      keywords: ['peace', 'meditation', 'calm'],
      rarityLevel: 5,
    ),
    RitualCard(
      id: 'emo_4',
      title: 'Joy Frequency',
      description: 'Your heart vibrates with pure joy. Share your happiness and it will multiply exponentially.',
      category: 'Emotional',
      icon: '😊',
      keywords: ['joy', 'happiness', 'sharing'],
      rarityLevel: 2,
    ),
    RitualCard(
      id: 'emo_5',
      title: 'Sacred Tears',
      description: 'Tears are holy water for the soul. Allow yourself to release what no longer serves you.',
      category: 'Emotional',
      icon: '💧',
      keywords: ['release', 'healing', 'letting go'],
      rarityLevel: 3,
    ),
  ];

  final List<RitualCard> _careerCards = [
    RitualCard(
      id: 'car_1',
      title: 'Abundance Gateway',
      description: 'Financial opportunities are opening. Your hard work is about to pay off in unexpected ways.',
      category: 'Career',
      icon: '💰',
      keywords: ['abundance', 'opportunity', 'success'],
      rarityLevel: 4,
    ),
    RitualCard(
      id: 'car_2',
      title: 'Leadership Awakening',
      description: 'Your leadership qualities are being recognized. Step into your power with confidence.',
      category: 'Career',
      icon: '👑',
      keywords: ['leadership', 'recognition', 'power'],
      rarityLevel: 5,
    ),
    RitualCard(
      id: 'car_3',
      title: 'Creative Breakthrough',
      description: 'A brilliant idea is forming. Trust your creative instincts and bring it to life.',
      category: 'Career',
      icon: '💡',
      keywords: ['creativity', 'innovation', 'breakthrough'],
      rarityLevel: 3,
    ),
    RitualCard(
      id: 'car_4',
      title: 'Professional Growth',
      description: 'Learning opportunities surround you. Invest in yourself and watch your career flourish.',
      category: 'Career',
      icon: '📈',
      keywords: ['growth', 'learning', 'development'],
      rarityLevel: 2,
    ),
    RitualCard(
      id: 'car_5',
      title: 'Success Magnet',
      description: 'You are attracting success effortlessly. Stay focused and maintain your momentum.',
      category: 'Career',
      icon: '🎯',
      keywords: ['success', 'focus', 'momentum'],
      rarityLevel: 4,
    ),
  ];
}
