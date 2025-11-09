import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../engine/insight_engine.dart';
import '../theme/app_theme.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/category_tile.dart';
import '../widgets/glowing_avatar.dart';
import '../widgets/zodiac_icon.dart';
import '../widgets/shimmer_placeholder.dart';
import 'profile_screen.dart';

/// Premium Dashboard Screen with modern UI and shimmer loading effects
class DashboardScreen extends StatefulWidget {
  final String userName;
  final String zodiacSign;

  const DashboardScreen({
    super.key,
    required this.userName,
    required this.zodiacSign,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late String _userName;
  late String _zodiacSign;
  String _currentInsight = '';
  String _currentCategory = 'General';
  bool _isLoadingInsight = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName;
    _zodiacSign = widget.zodiacSign;
    _loadInsight('General');
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _loadInsight(String category) {
    setState(() {
      _isLoadingInsight = true;
      _currentCategory = category;
    });

    // Simulate loading delay for premium feel
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        switch (category) {
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
        _isLoadingInsight = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Premium Header with Floating Effect
              SliverToBoxAdapter(
                child: _buildPremiumHeader(context),
              ),

              // Energy Status Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                  child: _buildEnergyCard(context),
                ),
              ),

              // Explore Insights Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Insights',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Discover cosmic wisdom tailored for you',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories Grid
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildListDelegate([
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(userName: _userName),
                          ),
                        );
                      },
                    ),
                  ]),
                ),
              ),

              // Current Insight Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildInsightCard(context),
                ),
              ),

              // Bottom spacing
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        _userName,
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_pulseController.value * 0.1),
                          child: child,
                        );
                      },
                      child: const Icon(
                        Icons.verified,
                        color: AppColors.accentGold,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userName: _userName),
                ),
              );
            },
            child: Hero(
              tag: 'avatar',
              child: GlowingAvatar(
                text: _userName.isNotEmpty ? _userName[0].toUpperCase() : 'S',
                size: 52,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnergyCard(BuildContext context) {
    return GlassmorphicCard(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryPurple, AppColors.accentGold],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.energy_savings_leaf,
              color: Colors.white,
              size: 28,
            ),
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
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  InsightEngine.generateEnergyStatus(),
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentGold,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.accentGold,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your $_currentCategory Insight',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Powered by cosmic intelligence',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryPurple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.refresh, color: AppColors.accentGold),
                iconSize: 22,
                onPressed: () => _loadInsight(_currentCategory),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GlassmorphicCard(
          child: _isLoadingInsight
              ? _buildShimmerLoading()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentInsight,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        height: 1.6,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.1,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: Icons.share_outlined,
                          label: 'Share',
                          onPressed: () {},
                        ),
                        _buildActionButton(
                          icon: Icons.bookmark_border,
                          label: 'Save',
                          onPressed: () {},
                        ),
                        _buildActionButton(
                          icon: Icons.favorite_border,
                          label: 'Like',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18, color: AppColors.textSecondary),
      label: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
