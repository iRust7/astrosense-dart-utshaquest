# Android Emulator Troubleshooting

## Problem
```
The Android emulator exited with code 1 during startup
Android emulator stderr:
Address these issues and try again.
```

## Solutions (Try in order)

### 1. Enable Virtualization in BIOS
1. Restart PC and enter BIOS (F2, F10, or Del key)
2. Enable Intel VT-x or AMD-V
3. Save and restart

### 2. Check Windows Features
Run in PowerShell as Administrator:
```powershell
# Disable Hyper-V if it's conflicting
bcdedit /set hypervisorlaunchtype off

# OR enable Windows Hypervisor Platform
Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
```
Then restart PC.

### 3. Increase Emulator RAM
1. Open Android Studio
2. Tools → Device Manager
3. Edit your emulator (Medium_Phone_API_36.0)
4. Show Advanced Settings
5. Increase RAM to 2048 MB or more
6. Save

### 4. Use Alternative Emulator
Create a simpler emulator:
```bash
# Create new emulator with lower specs
flutter emulators --create --name "Pixel_4_API_30"

# Then launch it
flutter emulators --launch Pixel_4_API_30
```

### 5. Use Physical Device (Easiest!)
1. Enable Developer Options on your Android phone:
   - Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging
3. Connect phone via USB
4. Run: `flutter devices`
5. Run: `flutter run` (will auto-detect phone)

### 6. Check Emulator Logs
Get detailed error info:
```powershell
# Set verbose mode
$env:ANDROID_VERBOSE=1

# Try launching again
flutter emulators --launch Medium_Phone_API_36.0

# Check logs
cd $env:LOCALAPPDATA\Android\Sdk\emulator
.\emulator.exe -avd Medium_Phone_API_36.0 -verbose
```

## Quick Test: Use Chrome Instead
Your app works perfectly in Chrome! Test there for now:
```bash
flutter run -d chrome
```

## For Windows 11 Specifically
If using WSL2 or Hyper-V:
```powershell
# Check status
bcdedit /enum

# If hypervisorlaunchtype is 'auto', change to 'off'
bcdedit /set hypervisorlaunchtype off

# Restart PC
Restart-Computer
```

## Verify After Fix
```bash
flutter doctor -v
flutter devices
flutter emulators
flutter emulators --launch Medium_Phone_API_36.0
```

## Alternative: Just Use Chrome/Edge! 🌐
For this project, Chrome/Edge work perfectly. The Daily Ritual feature works great on web!

```bash
# Chrome (fast reload)
flutter run -d chrome

# Edge (alternative)
flutter run -d edge

# Hot reload works!
# Press 'r' in terminal to hot reload
# Press 'R' to hot restart
```
