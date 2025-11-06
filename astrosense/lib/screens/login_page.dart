// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../theme/app_theme.dart';

/// Login page with animated entry
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _zodiacController = TextEditingController();
  late AnimationController _animController;
  bool _showValidation = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _zodiacController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_nameController.text.trim().isEmpty || _zodiacController.text.trim().isEmpty) {
      setState(() => _showValidation = true);
      _animController.forward(from: 0).then((_) => _animController.reverse());
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      '/dashboard',
      arguments: {
        'name': _nameController.text.trim(),
        'zodiac': _zodiacController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cosmic icon with glow
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryPurple, AppColors.accentGold],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryPurple.withAlpha(128),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Title
                    Text(
                      'AstroSense',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your Personal Cosmic Guide',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.accentGold,
                          ),
                    ),
                    const SizedBox(height: 48),

                    // Login form card
                    GlassmorphicCard(
                      showGlow: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Name field
                          Row(
                            children: [
                              const Icon(Icons.person_outline, color: AppColors.accentGold),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _nameController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your name',
                                    hintStyle: TextStyle(color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) => _handleLogin(),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.white12, height: 32),

                          // Zodiac field
                          Row(
                            children: [
                              const Icon(Icons.star_outline, color: AppColors.accentGold),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _zodiacController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter your zodiac sign',
                                    hintStyle: TextStyle(color: Colors.white54),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (_) => _handleLogin(),
                                ),
                              ),
                            ],
                          ),

                          // Validation message
                          if (_showValidation)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: AnimatedBuilder(
                                animation: _animController,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(10 * sin(_animController.value * pi * 3), 0),
                                    child: child,
                                  );
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Please enter both fields',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Login button with image background simulation
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.rocket_launch, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Begin Your Journey',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Decorative text
                    Text(
                      '✨ Discover your cosmic potential ✨',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withAlpha(128),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
