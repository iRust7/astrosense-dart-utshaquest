import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../models/user_progress.dart';
import '../models/ritual_card.dart';
import '../services/ritual_service.dart';
import '../services/affirmation_service.dart';

/// Daily Ritual Screen - The core game loop
class DailyRitualScreen extends StatefulWidget {
  final String userName;
  final String zodiacSign;
  final UserProgress? initialProgress;

  const DailyRitualScreen({
    super.key,
    required this.userName,
    required this.zodiacSign,
    this.initialProgress,
  });

  @override
  State<DailyRitualScreen> createState() => _DailyRitualScreenState();
}

class _DailyRitualScreenState extends State<DailyRitualScreen>
    with TickerProviderStateMixin {
  final RitualService _ritualService = RitualService();
  final AffirmationService _affirmationService = AffirmationService();

  late UserProgress _progress;
  late AnimationController _pageController;
  late AnimationController _pulseController;
  late AnimationController _cardFlipController;

  int _currentStep = 0; // 0: Category, 1: Interaction, 2: Card Select, 3: Affirmation, 4: Reward
  String _selectedCategory = '';
  List<RitualCard> _cards = [];
  RitualCard? _selectedCard;
  List<String> _affirmations = [];
  RitualReward? _reward;

  @override
  void initState() {
    super.initState();
    _progress = widget.initialProgress ?? UserProgress();
    
    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _cardFlipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pulseController.dispose();
    _cardFlipController.dispose();
    super.dispose();
  }

  void _nextStep() {
    setState(() {
      _currentStep++;
      _pageController.forward(from: 0);
    });
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _nextStep();
    });
  }

  void _completeInteraction() {
    setState(() {
      _cards = _ritualService.generateCards(_selectedCategory);
      _nextStep();
    });
  }

  void _selectCard(RitualCard card) {
    setState(() {
      _selectedCard = card;
      _affirmations = _affirmationService.generateAffirmations(_selectedCategory);
      _nextStep();
    });
  }

  void _selectAffirmation(String affirmation) {
    setState(() {
      // Calculate rewards
      _reward = _ritualService.calculateReward(
        _progress,
        _selectedCategory,
        _selectedCard!.rarityLevel,
      );
      // Update progress
      _progress = _ritualService.updateProgress(
        _progress,
        _reward!,
        _selectedCategory,
      );
      _nextStep();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: _buildCurrentStep(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () => Navigator.pop(context, _progress),
              ),
              _buildProgressIndicator(),
              Container(width: 48), // Balance
            ],
          ),
          const SizedBox(height: 12),
          _buildStatsBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: List.generate(5, (index) {
        final isActive = index <= _currentStep;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.white : Colors.white24,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }

  Widget _buildStatsBar() {
    return GlassmorphicCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('⭐', '${_progress.stardust}', 'Stardust'),
            _buildStatItem('🎯', 'Lv ${_progress.level}', 'Level'),
            _buildStatItem('🔥', '${_progress.currentStreak}', 'Streak'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              value,
              style: GoogleFonts.orbitron(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildCategorySelection();
      case 1:
        return _buildInteraction();
      case 2:
        return _buildCardSelection();
      case 3:
        return _buildAffirmationSelection();
      case 4:
        return _buildRewardScreen();
      default:
        return Container();
    }
  }

  Widget _buildCategorySelection() {
    return SingleChildScrollView(
      key: const ValueKey('category'),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Begin Today\'s Ritual',
            style: GoogleFonts.cinzel(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.purple.withOpacity(0.5),
                  blurRadius: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose your focus for today',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 40),
          _buildCategoryCard(
            'General',
            '✨',
            'Overall cosmic guidance for your day',
            const Color(0xFF6A4C93),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            'Emotional',
            '💖',
            'Navigate your feelings and relationships',
            const Color(0xFFE75480),
          ),
          const SizedBox(height: 16),
          _buildCategoryCard(
            'Career',
            '💼',
            'Unlock professional opportunities',
            const Color(0xFF4A90E2),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, String icon, String description, Color color) {
    return GestureDetector(
      onTap: () => _selectCategory(title),
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_pulseController.value * 0.02),
            child: GlassmorphicCard(
              showGlow: true,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [color, color.withOpacity(0.6)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(icon, style: const TextStyle(fontSize: 28)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.cinzel(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: color,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInteraction() {
    return _InteractionWidget(
      key: const ValueKey('interaction'),
      category: _selectedCategory,
      onComplete: _completeInteraction,
    );
  }

  Widget _buildCardSelection() {
    return SingleChildScrollView(
      key: const ValueKey('cards'),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Choose Your Path',
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Select the insight that resonates with you',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 30),
          ...List.generate(_cards.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildRitualCard(_cards[index]),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRitualCard(RitualCard card) {
    return GestureDetector(
      onTap: () => _selectCard(card),
      child: GlassmorphicCard(
        showGlow: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(card.icon, style: const TextStyle(fontSize: 32)),
                      const SizedBox(width: 12),
                      Text(
                        card.title,
                        style: GoogleFonts.cinzel(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: card.rarityColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: card.rarityColor, width: 1),
                    ),
                    child: Text(
                      card.rarityName,
                      style: GoogleFonts.orbitron(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: card.rarityColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                card.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              if (card.keywords.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: card.keywords.map((keyword) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        keyword,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAffirmationSelection() {
    return SingleChildScrollView(
      key: const ValueKey('affirmation'),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Set Your Intention',
            style: GoogleFonts.cinzel(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Choose an affirmation to carry with you today',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 30),
          ...List.generate(_affirmations.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildAffirmationCard(_affirmations[index]),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAffirmationCard(String affirmation) {
    return GestureDetector(
      onTap: () => _selectAffirmation(affirmation),
      child: GlassmorphicCard(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amber, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  affirmation,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardScreen() {
    return Center(
      key: const ValueKey('reward'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Transform.rotate(
                    angle: (1 - value) * math.pi * 2,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.6),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('✨', style: TextStyle(fontSize: 60)),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _reward?.message ?? 'Ritual Complete!',
              textAlign: TextAlign.center,
              style: GoogleFonts.cinzel(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GlassmorphicCard(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildRewardItem('✨ XP Gained', '+${_reward?.xp ?? 0}'),
                    const Divider(color: Colors.white24, height: 32),
                    _buildRewardItem('⭐ Stardust', '+${_reward?.stardust ?? 0}'),
                    const Divider(color: Colors.white24, height: 32),
                    _buildRewardItem('🔥 Streak', '${_progress.currentStreak} days'),
                    if (_reward?.levelUp ?? false) ...[
                      const Divider(color: Colors.white24, height: 32),
                      _buildRewardItem('🎉 New Level', '${_reward?.newLevel}'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, _progress),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
              child: Text(
                'Return to Dashboard',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.orbitron(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

/// Interactive animation widget for the ritual
class _InteractionWidget extends StatefulWidget {
  final String category;
  final VoidCallback onComplete;

  const _InteractionWidget({
    super.key,
    required this.category,
    required this.onComplete,
  });

  @override
  State<_InteractionWidget> createState() => _InteractionWidgetState();
}

class _InteractionWidgetState extends State<_InteractionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_isComplete) {
        setState(() => _isComplete = true);
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.onComplete();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connect with the Cosmos',
              style: GoogleFonts.cinzel(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                if (!_controller.isAnimating && !_isComplete) {
                  _controller.forward();
                }
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * math.pi * 4,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.purple.withOpacity(0.8),
                            Colors.blue.withOpacity(0.4),
                            Colors.transparent,
                          ],
                          stops: [
                            0.3 + (_controller.value * 0.3),
                            0.6,
                            1.0,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.6 * _controller.value),
                            blurRadius: 60,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _isComplete ? '✓' : '🔮',
                          style: TextStyle(
                            fontSize: 80,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isComplete
                  ? 'Connection established!'
                  : 'Tap the orb to begin',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            if (_controller.isAnimating) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  value: _controller.value,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 6,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
