# AstroSense - Image Assets Guide

## 🎨 Current Status

The app now includes **temporary placeholder visuals** using:
- ✨ **Emoji-based icons** for zodiac signs
- 🎨 **CSS-based animated logo** 
- 🌟 **Shimmer loading placeholders**
- 🎭 **Gradient backgrounds**

## 📁 Where to Add Your Custom Images

### 1. **App Logo** (High Priority)
Replace the emoji logo with your custom logo:

**Location:** `assets/images/`

**Files needed:**
- `logo.png` - Main app logo (512x512px, PNG with transparency)
- `logo_small.png` - Small version (128x128px)
- `logo_white.png` - White version for dark backgrounds

**Update in code:**
- File: `lib/widgets/cosmic_logo.dart`
- Replace the Icon widget with Image.asset()

```dart
// Replace this:
Icon(Icons.auto_awesome, size: 50, color: Colors.white)

// With this:
Image.asset('assets/images/logo.png', width: 50, height: 50)
```

---

### 2. **Zodiac Sign Images** (Medium Priority)
Replace emoji zodiac symbols with beautiful icons:

**Location:** `assets/icons/zodiac/`

**Files needed** (SVG or PNG, 128x128px):
- `aries.png`
- `taurus.png`
- `gemini.png`
- `cancer.png`
- `leo.png`
- `virgo.png`
- `libra.png`
- `scorpio.png`
- `sagittarius.png`
- `capricorn.png`
- `aquarius.png`
- `pisces.png`

**Update in code:**
- File: `lib/widgets/zodiac_icon.dart`
- Replace Text emoji with Image.asset()

```dart
// Replace:
Text(data['emoji'], style: TextStyle(fontSize: size * 0.5))

// With:
Image.asset(
  'assets/icons/zodiac/${signLower}.png',
  width: size * 0.6,
  height: size * 0.6,
)
```

---

### 3. **Background Images** (Low Priority)
Add cosmic/space themed backgrounds:

**Location:** `assets/bg/`

**Files needed:**
- `cosmic_bg.jpg` - Main cosmic background (1920x1080px)
- `stars.png` - Starfield overlay (transparent PNG)
- `constellation.png` - Constellation patterns

**Update in code:**
- File: `lib/widgets/premium_gradient_background.dart`
- Add as background layer:

```dart
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/bg/cosmic_bg.jpg'),
      fit: BoxFit.cover,
      opacity: 0.3,
    ),
  ),
)
```

---

### 4. **Favicon** (Web Only)
Replace the emoji favicon with a real icon:

**Location:** `web/`

**Files needed:**
- `favicon.png` (192x192px)
- `icons/Icon-192.png` (192x192px)
- `icons/Icon-512.png` (512x512px)

**Update in code:**
- File: `web/index.html` (line ~32)

```html
<!-- Replace the data URI with: -->
<link rel="icon" type="image/png" href="favicon.png"/>
```

---

### 5. **Category Icons** (Optional)
Custom icons for insight categories:

**Location:** `assets/icons/categories/`

**Files needed:**
- `general.png`
- `emotional.png`
- `career.png`
- `relationship.png`
- `affirmation.png`

---

## 🖼️ Free Image Resources

While you prepare your custom images, here are great sources for **free, commercial-use** cosmic/astrology images:

### **Logos & Icons:**
1. **Flaticon** - https://www.flaticon.com/
   - Search: "zodiac", "astrology", "cosmic"
   - Free with attribution

2. **Icons8** - https://icons8.com/
   - Search: "zodiac signs", "constellation"
   - Free with attribution

3. **Font Awesome** - https://fontawesome.com/
   - Has built-in astrology icons

### **Backgrounds:**
1. **Unsplash** - https://unsplash.com/
   - Search: "cosmos", "night sky", "stars", "galaxy"
   - Free, no attribution required

2. **Pexels** - https://www.pexels.com/
   - Search: "space", "nebula", "starry night"
   - Free, no attribution required

3. **Pixabay** - https://pixabay.com/
   - Search: "astrology", "zodiac", "cosmic"
   - Free, no attribution required

### **Illustrations:**
1. **unDraw** - https://undraw.co/
   - Search: "space", "universe"
   - Customizable colors, free

2. **Storyset** - https://storyset.com/
   - Search: "space", "cosmic"
   - Animated SVG, free with attribution

---

## 🔧 How to Add Images to Your Project

### Step 1: Create Folders
```bash
mkdir -p assets/images
mkdir -p assets/icons/zodiac
mkdir -p assets/bg
```

### Step 2: Add Images
Place your downloaded images in the appropriate folders.

### Step 3: Update pubspec.yaml
Ensure these lines are in your `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/icons/
    - assets/icons/zodiac/
    - assets/bg/
    - assets/images/
```

### Step 4: Run Flutter Pub Get
```bash
flutter pub get
```

### Step 5: Hot Reload
Press `r` in the terminal or save files to see changes!

---

## 📱 Current Placeholder Features

The app currently uses these **code-generated visuals**:

1. **✨ Animated Cosmic Logo**
   - Pulsing glow effect
   - Rotating stars
   - Gradient colors
   - Location: `lib/widgets/cosmic_logo.dart`

2. **♈ Zodiac Emoji Icons**
   - 12 zodiac symbols
   - Color-coded by sign
   - Glowing effect
   - Location: `lib/widgets/zodiac_icon.dart`

3. **⚡ Shimmer Placeholders**
   - Loading animations
   - Card placeholders
   - Avatar placeholders
   - Location: `lib/widgets/shimmer_placeholder.dart`

4. **🌌 Gradient Backgrounds**
   - Cosmic purple-to-dark gradient
   - Animated orbs
   - Star patterns
   - Location: `lib/widgets/premium_gradient_background.dart`

---

## ✅ What's Already Implemented

- [x] Logo widget with animation
- [x] Zodiac icon system (emoji-based)
- [x] Shimmer loading states
- [x] Favicon (emoji-based)
- [x] Loading screen
- [x] Gradient backgrounds
- [x] Responsive layouts

## 🎯 What You Need to Replace

- [ ] App logo image
- [ ] Zodiac sign images (12 files)
- [ ] Background cosmic images
- [ ] Favicon PNG
- [ ] Category icons (optional)

---

## 💡 Design Tips

When creating/selecting images:

1. **Colors:** Use purples (#7C3AED), golds (#C4A657), and dark blues
2. **Style:** Modern, minimalist, cosmic/space themed
3. **Format:** PNG with transparency for icons, JPG for backgrounds
4. **Size:** Keep files under 200KB for fast loading
5. **Consistency:** Use the same style across all images

---

## 🚀 Quick Start Recommendations

**Priority 1: Logo**
Download a cosmic/astrology logo from Flaticon, customize colors to purple/gold

**Priority 2: Zodiac Icons**  
Get a zodiac icon pack from Icons8 (12 icons, same style)

**Priority 3: Background**
One cosmic/galaxy background from Unsplash

This will make your app look 10x more professional immediately!

---

*Last updated: November 9, 2025*
