// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glassmorphic_card.dart';
import '../widgets/glowing_avatar.dart';
import '../theme/app_theme.dart';

/// Profile and settings screen
class ProfileScreen extends StatefulWidget {
  final String? userName;
  final String? zodiacSign;
  
  const ProfileScreen({super.key, this.userName, this.zodiacSign});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String _userName;
  late String _zodiacSign;
  bool _notificationsEnabled = true;
  bool _profileLoaded = false;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName ?? 'Seeker';
    _zodiacSign = widget.zodiacSign ?? 'Cosmic Soul';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profileLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        setState(() {
          _userName = args['name'] ?? _userName;
          _zodiacSign = args['zodiac'] ?? _zodiacSign;
        });
      }
      _profileLoaded = true;
    }
  }

  void _showEditDialog(String field, String currentValue) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Edit $field',
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.white.withAlpha(13),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withAlpha(26)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (field == 'Name') {
                  _userName = controller.text.trim();
                } else {
                  _zodiacSign = controller.text.trim();
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: AppColors.accentGold),
            const SizedBox(width: 12),
            Text(
              'About AstroSense',
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version 1.0.0',
              style: GoogleFonts.inter(color: Colors.white.withAlpha(204)),
            ),
            const SizedBox(height: 16),
            Text(
              'AstroSense uses the Barnum Effect to provide personalized reflections that encourage self-discovery and mindfulness.',
              style: GoogleFonts.inter(
                fontSize: 14,
                height: 1.5,
                color: Colors.white.withAlpha(204),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '✨ For entertainment and reflection purposes only.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: AppColors.accentGold,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
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
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Profile & Settings',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Profile card
                      GlassmorphicCard(
                        showGlow: true,
                        child: Column(
                          children: [
                            GlowingAvatar(
                              text: _userName.isNotEmpty ? _userName[0].toUpperCase() : 'S',
                              size: 80,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _userName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, color: AppColors.accentGold, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  _zodiacSign,
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: AppColors.accentGold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Account section
                      Text(
                        'Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      GlassmorphicCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.person_outline, color: AppColors.accentGold),
                              title: Text('Name', style: GoogleFonts.inter(color: Colors.white)),
                              subtitle: Text(_userName, style: GoogleFonts.inter(color: Colors.white54)),
                              trailing: const Icon(Icons.edit, color: Colors.white38, size: 20),
                              onTap: () => _showEditDialog('Name', _userName),
                            ),
                            Divider(color: Colors.white.withAlpha(26), height: 1),
                            ListTile(
                              leading: const Icon(Icons.star_outline, color: AppColors.accentGold),
                              title: Text('Zodiac Sign', style: GoogleFonts.inter(color: Colors.white)),
                              subtitle: Text(_zodiacSign, style: GoogleFonts.inter(color: Colors.white54)),
                              trailing: const Icon(Icons.edit, color: Colors.white38, size: 20),
                              onTap: () => _showEditDialog('Zodiac', _zodiacSign),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Preferences section
                      Text(
                        'Preferences',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      GlassmorphicCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            SwitchListTile(
                              secondary: const Icon(Icons.notifications_outlined, color: AppColors.accentGold),
                              title: Text('Notifications', style: GoogleFonts.inter(color: Colors.white)),
                              subtitle: Text(
                                'Daily insights and reminders',
                                style: GoogleFonts.inter(color: Colors.white54),
                              ),
                              value: _notificationsEnabled,
                              activeTrackColor: AppColors.primaryPurple,
                              activeThumbColor: Colors.white,
                              onChanged: (value) {
                                setState(() => _notificationsEnabled = value);
                              },
                            ),
                            Divider(color: Colors.white.withAlpha(26), height: 1),
                            ListTile(
                              leading: const Icon(Icons.palette_outlined, color: AppColors.accentGold),
                              title: Text('Theme', style: GoogleFonts.inter(color: Colors.white)),
                              subtitle: Text('Dark Cosmic', style: GoogleFonts.inter(color: Colors.white54)),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // More section
                      Text(
                        'More',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      GlassmorphicCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.info_outline, color: AppColors.accentGold),
                              title: Text('About', style: GoogleFonts.inter(color: Colors.white)),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                              onTap: _showAboutDialog,
                            ),
                            Divider(color: Colors.white.withAlpha(26), height: 1),
                            ListTile(
                              leading: const Icon(Icons.help_outline, color: AppColors.accentGold),
                              title: Text('Help & Support', style: GoogleFonts.inter(color: Colors.white)),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                              onTap: () {},
                            ),
                            Divider(color: Colors.white.withAlpha(26), height: 1),
                            ListTile(
                              leading: const Icon(Icons.privacy_tip_outlined, color: AppColors.accentGold),
                              title: Text('Privacy Policy', style: GoogleFonts.inter(color: Colors.white)),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 16),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Logout button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.logout, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                'Sign Out',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Version text
                      Text(
                        'AstroSense v1.0.0',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.white.withAlpha(77),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
