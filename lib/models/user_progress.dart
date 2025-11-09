/// User progress tracking for gamification
class UserProgress {
  final int level;
  final int xp;
  final int xpToNextLevel;
  final int stardust;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastRitualDate;
  final List<String> unlockedAchievements;
  final Map<String, int> categoryCompletions;

  UserProgress({
    this.level = 1,
    this.xp = 0,
    this.xpToNextLevel = 100,
    this.stardust = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastRitualDate,
    this.unlockedAchievements = const [],
    this.categoryCompletions = const {},
  });

  /// Calculate XP needed for next level
  static int calculateXPNeeded(int level) {
    return (100 * level * 1.2).round();
  }

  /// Check if ritual was completed today
  bool get hasCompletedTodayRitual {
    if (lastRitualDate == null) return false;
    final now = DateTime.now();
    return lastRitualDate!.year == now.year &&
           lastRitualDate!.month == now.month &&
           lastRitualDate!.day == now.day;
  }

  /// Create copy with updated values
  UserProgress copyWith({
    int? level,
    int? xp,
    int? xpToNextLevel,
    int? stardust,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastRitualDate,
    List<String>? unlockedAchievements,
    Map<String, int>? categoryCompletions,
  }) {
    return UserProgress(
      level: level ?? this.level,
      xp: xp ?? this.xp,
      xpToNextLevel: xpToNextLevel ?? this.xpToNextLevel,
      stardust: stardust ?? this.stardust,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastRitualDate: lastRitualDate ?? this.lastRitualDate,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      categoryCompletions: categoryCompletions ?? this.categoryCompletions,
    );
  }
}

/// Reward for completing a ritual
class RitualReward {
  final int xp;
  final int stardust;
  final bool levelUp;
  final int newLevel;
  final bool streakBonus;
  final String message;

  RitualReward({
    required this.xp,
    required this.stardust,
    this.levelUp = false,
    this.newLevel = 1,
    this.streakBonus = false,
    this.message = '',
  });
}
