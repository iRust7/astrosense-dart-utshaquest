# Daily Ritual Game Loop - Design Document

## Overview
AstroSense now features an engaging 60-second daily ritual that transforms the app from a static menu into a fun, rewarding experience with progression, tension, and interactive moments.

## Core Loop (60 seconds)

### Step 1: Choose Your Focus (10s)
- **What**: User selects one of three categories
  - 🌟 General - Overall cosmic guidance
  - 💖 Emotional - Feelings and relationships  
  - 💼 Career - Professional opportunities
- **Why**: Gives agency and personalizes the experience

### Step 2: Mini-Interaction (5s)
- **What**: Interactive cosmic connection ritual
  - Tap the glowing orb to establish connection
  - Animated progress with particle effects
  - Creates anticipation and engagement
- **Why**: Breaks static feel, adds tactile interaction

### Step 3: Card Selection (20s)
- **What**: Choose 1 from 3 revealed insight cards
  - Each card has rarity (Common to Legendary)
  - Different rewards based on rarity
  - Keywords and detailed descriptions
- **Why**: Meaningful choice with visible consequences

### Step 4: Affirmation Selection (15s)
- **What**: Select 1 affirmation from 3 options
  - Saved to personal journal
  - Category-specific affirmations
  - Can be reviewed later
- **Why**: Personal investment, something to carry throughout the day

### Step 5: Rewards Screen (10s)
- **What**: Celebrate completion with visual rewards
  - ✨ XP gained (levels up character)
  - ⭐ Stardust earned (premium currency)
  - 🔥 Streak maintained/increased
  - 🎉 Level up notification (if applicable)
- **Why**: Dopamine hit, visible progress, reason to return

## Progression Systems

### Experience & Levels
- Base XP: 50-100 per ritual
- Rarity multiplier: +10 XP per rarity level
- Streak bonus: +5 XP per streak day (after 3 days)
- Level up formula: XP needed = 100 * level * 1.2

### Stardust (Premium Currency)
- Base: 25-50 per ritual
- Rarity bonus: +5 per rarity level
- Streak bonus: +2 per streak day
- Future uses: Unlock special cards, themes, features

### Streak System
- Tracks consecutive days
- Bonus rewards after 3, 7, 14, 30 days
- Visual fire icon with growing intensity
- Resets if day is skipped

### Card Rarity System
1. **Common** (Gray) - 60% chance
2. **Uncommon** (Green) - 25% chance
3. **Rare** (Blue) - 10% chance
4. **Epic** (Purple) - 4% chance
5. **Legendary** (Gold) - 1% chance

## UI/UX Improvements

### Main Screen CTA
- Large, prominent "Begin Today's Ritual" button
- Shows completion status (completed = checkmark)
- Disabled if already completed today
- Glowing animation when available

### Progress Bar
- Always visible at top
- Shows: Stardust, Level, Streak
- Updates in real-time during ritual

### Visual Feedback
- Smooth transitions between steps
- Progress dots showing current step (1-5)
- Card flip animations
- Particle effects on rewards
- Glow effects on interactive elements

### Tension & Excitement
- Limited to once per day (scarcity)
- Random card generation (unpredictability)
- Rarity chase (collection motivation)
- Streak pressure (loss aversion)
- Level progression (achievement)

## Why This Works

1. **Daily Habit Formation**
   - Single, clear action every day
   - Takes only 60 seconds
   - Immediate rewards

2. **Variable Rewards**
   - Different cards each time
   - Rarity adds excitement
   - Unpredictable insights

3. **Progression Visible**
   - XP bar shows growth
   - Levels increase status
   - Stardust accumulates

4. **Loss Aversion**
   - Streaks create commitment
   - Missing a day feels bad
   - Daily reset creates urgency

5. **Luxury Feel Maintained**
   - Premium animations
   - Beautiful glassmorphic cards
   - Cosmic theme throughout
   - High-quality copy

## Future Enhancements

### Short-term
- [ ] Save progress to local storage
- [ ] Add achievement system
- [ ] Special weekend rituals
- [ ] Card collection view

### Medium-term
- [ ] Social features (share insights)
- [ ] Stardust shop
- [ ] Unlock special card sets
- [ ] Personalized insights based on history

### Long-term
- [ ] Multiplayer events
- [ ] Seasonal content
- [ ] Advanced analytics
- [ ] AI-powered personalization

## Technical Implementation

### New Files Created
1. `lib/models/user_progress.dart` - Progress tracking
2. `lib/models/ritual_card.dart` - Card system
3. `lib/services/ritual_service.dart` - Game logic
4. `lib/services/affirmation_service.dart` - Affirmations
5. `lib/screens/daily_ritual_screen.dart` - Main ritual flow

### Modified Files
1. `lib/screens/home_screen.dart` - Added CTA and stats
2. Updated to use new progress system

### Dependencies
- No new dependencies required
- Uses existing Flutter animations
- Leverages current design system

## Metrics to Track

1. **Engagement**
   - Daily Active Users (DAU)
   - Ritual completion rate
   - Average time in ritual

2. **Retention**
   - 7-day retention
   - 30-day retention
   - Streak distribution

3. **Progression**
   - Average level
   - Stardust earned
   - Card collection rate

4. **Satisfaction**
   - Session length after ritual
   - Feature usage rates
   - User feedback scores
