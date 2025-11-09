import 'dart:math';

/// Service for generating and managing affirmations
class AffirmationService {
  static final AffirmationService _instance = AffirmationService._internal();
  factory AffirmationService() => _instance;
  AffirmationService._internal();

  final Random _random = Random();

  /// Generate 3 random affirmations for selection
  List<String> generateAffirmations(String category) {
    final allAffirmations = _getAffirmationsForCategory(category);
    allAffirmations.shuffle(_random);
    return allAffirmations.take(3).toList();
  }

  List<String> _getAffirmationsForCategory(String category) {
    switch (category) {
      case 'General':
        return _generalAffirmations;
      case 'Emotional':
        return _emotionalAffirmations;
      case 'Career':
        return _careerAffirmations;
      default:
        return _generalAffirmations;
    }
  }

  final List<String> _generalAffirmations = [
    'I am aligned with the infinite abundance of the universe.',
    'Every moment brings new opportunities for growth and joy.',
    'I trust the cosmic timing of my life.',
    'I am a powerful creator of my reality.',
    'The universe supports my highest good.',
    'I radiate positive energy and attract miracles.',
    'I am worthy of all the blessings coming my way.',
    'My intuition guides me perfectly.',
    'I embrace change as a gateway to transformation.',
    'I am divinely protected and guided.',
  ];

  final List<String> _emotionalAffirmations = [
    'I honor my emotions as sacred messengers.',
    'My heart is open to giving and receiving love.',
    'I release all that does not serve my highest good.',
    'I am worthy of deep, authentic connections.',
    'My emotional intelligence grows stronger each day.',
    'I choose peace over worry, love over fear.',
    'I am healing, growing, and transforming.',
    'My feelings are valid and deserve to be heard.',
    'I embrace vulnerability as a strength.',
    'I am compassionate with myself and others.',
  ];

  final List<String> _careerAffirmations = [
    'I am a magnet for success and abundance.',
    'My skills and talents are valued and recognized.',
    'I attract opportunities that align with my purpose.',
    'I am confident in my professional abilities.',
    'Success flows to me easily and effortlessly.',
    'I am creating the career of my dreams.',
    'My work makes a positive impact on the world.',
    'I deserve to be well-compensated for my contributions.',
    'I am a natural leader and innovator.',
    'Prosperity and success are my birthright.',
  ];
}
