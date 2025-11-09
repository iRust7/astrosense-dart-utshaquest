// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/category_tile.dart';
import '../widgets/glowing_avatar.dart';
import '../widgets/zodiac_icon.dart';
import '../widgets/lottie_animation.dart';
import '../engine/insight_engine.dart';
import '../theme/app_theme.dart';
import '../models/user_progress.dart';
import 'daily_ritual_screen.dart';

/// Main home screen with insights and categories
class HomeScreen extends StatefulWidget {
  final String? userName;
  final String? zodiacSign;
  
  const HomeScreen({super.key, this.userName, this.zodiacSign});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _userName;
  late String _zodiacSign;
  String _currentInsight = '';
  String _currentCategory = 'General';
  bool _insightLoaded = false;
  bool _isLoadingInsight = false;
  UserProgress _progress = UserProgress();

  @override
  void initState() {
    super.initState();
    _userName = widget.userName ?? 'Seeker';
    _zodiacSign = widget.zodiacSign ?? 'Cosmic Soul';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_insightLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _userName = args['name'] ?? _userName;
          _zodiacSign = args['zodiac'] ?? _zodiacSign;
        });
      }
      // Load initial insight after getting user data
      _loadInsight('General');
      _insightLoaded = true;
    }
  }

  void _loadInsight(String category) {
    setState(() {
      _currentCategory = category;
      _isLoadingInsight = true;
    });

    // Simulate loading with shimmer effect
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _isLoadingInsight = false;
        switch (category) {
          case 'General':
            _currentInsight = InsightEngine.generateGeneralInsight(_userName, _zodiacSign);
            break;
          case 'Emotional':
            _currentInsight = InsightEngine.generateEmotionalInsight(_userName, _zodiacSign);
            break;
          case 'Career':
            _currentInsight = InsightEngine.generateCareerInsight(_userName, _zodiacSign);
            break;
          case 'Relationship':
            _currentInsight = InsightEngine.generateRelationshipInsight(_userName, _zodiacSign);
            break;
          case 'Affirmation':
            _currentInsight = InsightEngine.generateAffirmation();
            break;
          default:
            _currentInsight = InsightEngine.generateGeneralInsight(_userName, _zodiacSign);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withAlpha(153),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              _userName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.verified, color: AppColors.accentGold, size: 20),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/profile',
                          arguments: {'name': _userName, 'zodiac': _zodiacSign},
                        );
                      },
                      child: GlowingAvatar(
                        text: _userName.isNotEmpty ? _userName[0].toUpperCase() : 'S',
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildProgressStats(),
              ),
              const SizedBox(height: 16),

              // Main CTA - Begin Today's Ritual
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildDailyRitualCTA(),
              ),
              const SizedBox(height: 24),

              // Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Insights',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.0,
                      children: [
                        CategoryTile(
                          icon: Icons.auto_awesome,
                          label: 'General',
                          onTap: () => _loadInsight('General'),
                        ),
                        CategoryTile(
                          icon: Icons.favorite,
                          label: 'Emotional',
                          onTap: () => _loadInsight('Emotional'),
                        ),
                        CategoryTile(
                          icon: Icons.work_outline,
                          label: 'Career',
                          onTap: () => _loadInsight('Career'),
                        ),
                        CategoryTile(
                          icon: Icons.people_outline,
                          label: 'Relationships',
                          onTap: () => _loadInsight('Relationship'),
                        ),
                        CategoryTile(
                          icon: Icons.spa_outlined,
                          label: 'Affirmation',
                          onTap: () => _loadInsight('Affirmation'),
                        ),
                        CategoryTile(
                          icon: Icons.settings,
                          label: 'Settings',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/profile',
                              arguments: {'name': _userName, 'zodiac': _zodiacSign},
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Current insight card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your $_currentCategory Insight',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          IconButton(
                            icon: const Icon(Icons.refresh, color: AppColors.accentGold),
                            onPressed: () => _loadInsight(_currentCategory),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ScaleTransition(scale: animation, child: child),
                            );
                          },
                          child: _isLoadingInsight
                              ? const LoadingPlaceholder(
                                  message: 'Channeling cosmic insights...',
                                  animationSize: 100,
                                )
                              : GlassmorphicCard(
                                  key: ValueKey(_currentInsight),
                                  showGlow: true,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ZodiacIcon(
                                              zodiacSign: _zodiacSign,
                                              size: 40,
                                              showGlow: true,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                _zodiacSign,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.accentGold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          _currentInsight.isNotEmpty 
                                              ? _currentInsight 
                                              : 'Loading your cosmic insight...',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            height: 1.6,
                                            color: Colors.white.withAlpha(230),
                                          ),
                                        ),
                                        const SizedBox(height: 24),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(Icons.share, size: 16, color: Colors.white54),
                                              label: Text(
                                                'Share',
                                                style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
                                              ),
                                            ),
                                            TextButton.icon(
                                              onPressed: () {},
                                              icon: const Icon(Icons.bookmark_border, size: 16, color: Colors.white54),
                                              label: Text(
                                                'Save',
                                                style: GoogleFonts.inter(fontSize: 12, color: Colors.white54),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressStats() {
    return GlassmorphicCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn('⭐', '${_progress.stardust}', 'Stardust'),
          Container(width: 1, height: 40, color: Colors.white24),
          _buildStatColumn('🎯', 'Lv ${_progress.level}', 'Level'),
          Container(width: 1, height: 40, color: Colors.white24),
          _buildStatColumn('🔥', '${_progress.currentStreak}', 'Streak'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 4),
            Text(
              value,
              style: GoogleFonts.orbitron(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyRitualCTA() {
    final hasCompletedToday = _progress.hasCompletedTodayRitual;
    
    return GestureDetector(
      onTap: hasCompletedToday ? null : () async {
        final result = await Navigator.push<UserProgress>(
          context,
          MaterialPageRoute(
            builder: (context) => DailyRitualScreen(
              userName: _userName,
              zodiacSign: _zodiacSign,
              initialProgress: _progress,
            ),
          ),
        );
        if (result != null) {
          setState(() {
            _progress = result;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: hasCompletedToday
              ? LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.3),
                    Colors.grey.withOpacity(0.2),
                  ],
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFF6A4C93),
                    Color(0xFF9B59B6),
                  ],
                ),
          boxShadow: hasCompletedToday ? null : [
            BoxShadow(
              color: const Color(0xFF6A4C93).withOpacity(0.6),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Animated gradient overlay
              if (!hasCompletedToday)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: const AlwaysStoppedAnimation(0.0),
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          hasCompletedToday ? '✓' : '🔮',
                          style: const TextStyle(fontSize: 36),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hasCompletedToday
                                ? 'Ritual Complete!'
                                : 'Begin Today\'s Ritual',
                            style: GoogleFonts.cinzel(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            hasCompletedToday
                                ? 'Come back tomorrow for your next journey'
                                : 'Connect with the cosmos and unlock your daily insights',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!hasCompletedToday)
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
