/// Image URLs configuration
/// Replace these URLs with your own images when ready!

class AppImages {
  // Logo - Cosmic/Space themed
  // Source: Unsplash (free to use)
  static const String logo = 
    'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=200&h=200&fit=crop';
  
  // Background images
  static const String cosmicBackground = 
    'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1920&h=1080&fit=crop';
  
  static const String starryBackground =
    'https://images.unsplash.com/photo-1506318137071-a8e063b4bec0?w=1920&h=1080&fit=crop';
  
  static const String nebula =
    'https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=1920&h=1080&fit=crop';
  
  // Zodiac Sign Images (using emoji as base64 data URIs - always work!)
  // You can replace these with real PNG/SVG URLs
  static const Map<String, String> zodiacImages = {
    'aries': 'https://cdn-icons-png.flaticon.com/128/8917/8917588.png',
    'taurus': 'https://cdn-icons-png.flaticon.com/128/8917/8917625.png',
    'gemini': 'https://cdn-icons-png.flaticon.com/128/8917/8917642.png',
    'cancer': 'https://cdn-icons-png.flaticon.com/128/8917/8917651.png',
    'leo': 'https://cdn-icons-png.flaticon.com/128/8917/8917665.png',
    'virgo': 'https://cdn-icons-png.flaticon.com/128/8917/8917674.png',
    'libra': 'https://cdn-icons-png.flaticon.com/128/8917/8917689.png',
    'scorpio': 'https://cdn-icons-png.flaticon.com/128/8917/8917704.png',
    'sagittarius': 'https://cdn-icons-png.flaticon.com/128/8917/8917712.png',
    'capricorn': 'https://cdn-icons-png.flaticon.com/128/8917/8917730.png',
    'aquarius': 'https://cdn-icons-png.flaticon.com/128/8917/8917751.png',
    'pisces': 'https://cdn-icons-png.flaticon.com/128/8917/8917770.png',
  };
  
  // Category icons
  static const String generalIcon = 'https://cdn-icons-png.flaticon.com/128/3774/3774299.png';
  static const String emotionalIcon = 'https://cdn-icons-png.flaticon.com/128/3588/3588592.png';
  static const String careerIcon = 'https://cdn-icons-png.flaticon.com/128/3281/3281307.png';
  static const String relationshipIcon = 'https://cdn-icons-png.flaticon.com/128/2107/2107845.png';
  static const String affirmationIcon = 'https://cdn-icons-png.flaticon.com/128/3588/3588314.png';
  
  // Decorative elements
  static const String stars = 'https://cdn-icons-png.flaticon.com/128/3588/3588275.png';
  static const String moon = 'https://cdn-icons-png.flaticon.com/128/3588/3588260.png';
  static const String crystal = 'https://cdn-icons-png.flaticon.com/128/3774/3774316.png';
}

/// HOW TO REPLACE THESE IMAGES:
/// 
/// 1. For your own images on the web:
///    - Upload to any image hosting (Imgur, your server, etc.)
///    - Replace the URL strings above
/// 
/// 2. For local images in your project:
///    - Place images in assets/images/
///    - Update pubspec.yaml to include assets/images/
///    - Change from URLs to: 'assets/images/your-image.png'
///    - Replace CachedNetworkImage with Image.asset() in widgets
/// 
/// 3. These are from free sources:
///    - Unsplash: https://unsplash.com (backgrounds)
///    - Flaticon: https://flaticon.com (icons)
///    - All are free to use!
