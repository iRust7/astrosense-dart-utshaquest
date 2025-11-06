import 'dart:math';

/// Engine that generates personalized insights using the Barnum Effect
class InsightEngine {
  static final Random _random = Random();

  static final List<String> _generalInsights = [
    "You often feel misunderstood, yet your quiet strength inspires others more than you realize.",
    "Lately you've been thinking about a change that might redefine how you see yourself.",
    "You have untapped potential waiting to be discovered through bold action.",
    "Sometimes you wonder if you're on the right path, but deep down you know your intuition guides you.",
    "You value authenticity and are drawn to people who share their true selves with you.",
    "There's a creative side to you that you don't always get to express fully.",
    "You tend to be hard on yourself, but others see qualities in you that you overlook.",
    "You often think deeply about life's bigger questions and your place in the world.",
    "You have a unique ability to understand different perspectives, even when you disagree.",
    "Sometimes you feel torn between what you want and what others expect of you.",
  ];

  static final List<String> _emotionalInsights = [
    "Your emotions run deeper than what you show on the surface.",
    "You've learned to protect your heart, but you still believe in meaningful connections.",
    "You feel things intensely, though you've mastered the art of composure.",
    "There's a sensitivity within you that you sometimes see as vulnerability, but it's actually your strength.",
    "You process emotions privately before sharing them with others.",
    "Your empathy allows you to sense what others are feeling, even when they don't speak.",
    "You've experienced disappointment, yet you remain open to new possibilities.",
    "You value emotional honesty and can tell when someone isn't being genuine.",
    "Sometimes you need solitude to recharge and make sense of your feelings.",
    "You're learning that it's okay to ask for support when you need it.",
  ];

  static final List<String> _careerInsights = [
    "You're driven by purpose more than recognition, though you deserve both.",
    "Your ambitions are quietly powerful, and you make steady progress even when others don't notice.",
    "You have leadership qualities that emerge naturally when the situation calls for it.",
    "You're capable of more than your current role allows you to demonstrate.",
    "Your attention to detail sets you apart in ways that create lasting value.",
    "You work best when you feel aligned with your values and vision.",
    "Opportunities often find you when you're focused on growth rather than validation.",
    "You have ideas that could make a significant impact if given the right platform.",
    "Your dedication is one of your greatest assets, even when results take time to show.",
    "You're building something meaningful, even if the full picture isn't clear yet.",
  ];

  static final List<String> _relationshipInsights = [
    "People are drawn to your energy, even when you don't actively seek attention.",
    "You value quality over quantity in your relationships and circles.",
    "Your loyalty runs deep, and those close to you know they can count on you.",
    "You're selective about who you let into your inner world, and for good reason.",
    "You have a gift for making others feel heard and understood.",
    "Sometimes you give more than you receive, but you're learning to find balance.",
    "Your presence brings calm to those around you, even in chaotic moments.",
    "You're searching for connections that feel genuine and reciprocal.",
    "Trust is earned with you, and once given, it's a precious gift.",
    "You inspire others simply by being true to yourself.",
  ];

  static final List<String> _affirmations = [
    "You deserve to take a step forward today — perfection can wait.",
    "Your journey is uniquely yours, and comparison steals your joy.",
    "The energy you put out into the world returns to you in unexpected ways.",
    "You are exactly where you need to be right now.",
    "Your growth happens in moments you might not even notice.",
    "It's okay to rest without feeling guilty about it.",
    "You have permission to change your mind and redirect your path.",
    "Small progress is still progress worth celebrating.",
    "You don't have to have it all figured out to move forward.",
    "Your worth isn't determined by your productivity.",
  ];

  /// Generates a general insight combining general and emotional templates
  static String generateGeneralInsight(String name, String zodiac) {
    final insight1 = _generalInsights[_random.nextInt(_generalInsights.length)];
    final insight2 = _emotionalInsights[_random.nextInt(_emotionalInsights.length)];
    return "$name, as a $zodiac, $insight1 $insight2";
  }

  /// Generates an emotional insight combining emotional and general templates
  static String generateEmotionalInsight(String name, String zodiac) {
    final insight1 = _emotionalInsights[_random.nextInt(_emotionalInsights.length)];
    final insight2 = _generalInsights[_random.nextInt(_generalInsights.length)];
    return "$name, $insight1 As a $zodiac, $insight2";
  }

  /// Generates a career insight combining career and general templates
  static String generateCareerInsight(String name, String zodiac) {
    final insight1 = _careerInsights[_random.nextInt(_careerInsights.length)];
    final insight2 = _generalInsights[_random.nextInt(_generalInsights.length)];
    return "$insight1 $zodiac energy supports your ambitions, $name. $insight2";
  }

  /// Generates a relationship insight combining relationship and emotional templates
  static String generateRelationshipInsight(String name, String zodiac) {
    final insight1 = _relationshipInsights[_random.nextInt(_relationshipInsights.length)];
    final insight2 = _emotionalInsights[_random.nextInt(_emotionalInsights.length)];
    return "$name, $insight1 Your $zodiac nature enhances these connections. $insight2";
  }

  /// Generates a random affirmation
  static String generateAffirmation() {
    return _affirmations[_random.nextInt(_affirmations.length)];
  }

  /// Generates a random energy status
  static String generateEnergyStatus() {
    final statuses = ['Balanced', 'Rising', 'Introspective', 'Flowing', 'Focused', 'Transformative'];
    return statuses[_random.nextInt(statuses.length)];
  }
}
