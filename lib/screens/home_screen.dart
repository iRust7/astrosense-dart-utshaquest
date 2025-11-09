// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/category_tile.dart';
import '../widgets/glowing_avatar.dart';
import '../widgets/zodiac_icon.dart';
import '../widgets/shimmer_placeholder.dart';
import '../engine/insight_engine.dart';
import '../theme/app_theme.dart';

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

              // Energy status card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GlassmorphicCard(
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [AppColors.primaryPurple, AppColors.accentGold],
                          ),
                        ),
                        child: const Icon(Icons.energy_savings_leaf, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Energy Today',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.white.withAlpha(153),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              InsightEngine.generateEnergyStatus(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.accentGold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                    ],
                  ),
                ),
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
                              ? const InsightShimmerPlaceholder()
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
}
