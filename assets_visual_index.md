# Assets Visual Index

Quick visual reference for all assets in the SmartKrishi app.

## 📸 Asset Gallery

### 1. Onboarding Screens

#### Screen 1: Buy Fresh Produce
```
┌──────────────────────────────────┐
│     Buy fresh produce            │
│   directly from farmers          │
│                                  │
│   400x600px | SVG | Green Theme  │
│   File: onboarding1.svg          │
│   Usage: OnboardingScreen Page 1 │
└──────────────────────────────────┘

Theme Colors:
🟢 Light Green: #90EE90
🟢 Dark Green: #228B22

Elements:
- Circular produce graphic
- Text overlay
- Page indicators
```

#### Screen 2: See How Food is Grown
```
┌──────────────────────────────────┐
│     See how your food            │
│        is grown                  │
│                                  │
│   400x600px | SVG | Blue Theme   │
│   File: onboarding2.svg          │
│   Usage: OnboardingScreen Page 2 │
└──────────────────────────────────┘

Theme Colors:
🔵 Light Blue: #87CEEB
🔵 Dark Blue: #4682B4

Elements:
- Analytics dashboard
- Metrics (Soil, Water, Sun)
- Farm data visualization
```

#### Screen 3: Track Farm to Doorstep
```
┌──────────────────────────────────┐
│   Track food from farm           │
│      to doorstep                 │
│                                  │
│   400x600px | SVG | Green Theme  │
│   File: onboarding3.svg          │
│   Usage: OnboardingScreen Page 3 │
└──────────────────────────────────┘

Theme Colors:
🟢 Light Green: #90EE90
🟢 Dark Green: #006400

Elements:
- Map with markers
- Route tracking
- Farm to home journey
- Delivery visualization
```

### 2. Authentication Assets

#### Google Logo
```
┌──────────────────────────────────┐
│     [Google Logo]                │
│                                  │
│   24x24px | SVG | Multi-color    │
│   File: google_logo.svg          │
│   Usage: LoginScreen Auth Button │
└──────────────────────────────────┘

Colors:
🔵 Blue: #4285F4
🔴 Red: #EA4335
🟡 Yellow: #FBBC04
🟢 Green: #34A853

Purpose: Google authentication button icon
```

### 3. Profile Assets

#### Profile Placeholder
```
┌──────────────────────────────────┐
│           [User Icon]            │
│                                  │
│   200x200px | SVG | Green Theme  │
│   File: profile_placeholder.svg  │
│   Usage: ProfileSetupScreen      │
└──────────────────────────────────┘

Theme Colors:
🟢 Light Green: #90EE90
🟢 Dark Green: #228B22

Elements:
- Person silhouette
- Circular profile frame
- Default avatar

Use When:
✓ User hasn't uploaded photo
✓ Profile loading
✓ Placeholder needed
```

## 🗂️ Asset Organization

```
assets/
│
└── images/
    │
    ├── 📱 Onboarding Assets
    │   ├── onboarding1.svg (Green - Produce)
    │   ├── onboarding2.svg (Blue - Analytics)
    │   └── onboarding3.svg (Green - Tracking)
    │
    ├── 🔐 Auth Assets
    │   └── google_logo.svg (Multi-color)
    │
    └── 👤 Profile Assets
        └── profile_placeholder.svg (Green)
```

## 💾 File Specifications

### Onboarding 1
| Property | Value |
|----------|-------|
| Filename | onboarding1.svg |
| Dimensions | 400x600px |
| Format | SVG (XML) |
| Color Space | RGB |
| Compression | Optimized |
| File Size | ~5KB |
| Used In | OnboardingScreen |
| Screen Position | Full page |

### Onboarding 2
| Property | Value |
|----------|-------|
| Filename | onboarding2.svg |
| Dimensions | 400x600px |
| Format | SVG (XML) |
| Color Space | RGB |
| Compression | Optimized |
| File Size | ~5KB |
| Used In | OnboardingScreen |
| Screen Position | Full page |

### Onboarding 3
| Property | Value |
|----------|-------|
| Filename | onboarding3.svg |
| Dimensions | 400x600px |
| Format | SVG (XML) |
| Color Space | RGB |
| Compression | Optimized |
| File Size | ~5KB |
| Used In | OnboardingScreen |
| Screen Position | Full page |

### Google Logo
| Property | Value |
|----------|-------|
| Filename | google_logo.svg |
| Dimensions | 24x24px |
| Format | SVG (XML) |
| Color Space | RGB |
| Compression | Optimized |
| File Size | ~2KB |
| Used In | LoginScreen |
| Screen Position | Button icon |

### Profile Placeholder
| Property | Value |
|----------|-------|
| Filename | profile_placeholder.svg |
| Dimensions | 200x200px |
| Format | SVG (XML) |
| Color Space | RGB |
| Compression | Optimized |
| File Size | ~3KB |
| Used In | ProfileSetupScreen |
| Screen Position | Profile photo area |

## 🎨 Color Palette Used

### Primary Colors
```
┌─────────────────────────────────────┐
│ Teal/Green (Primary)                │
│ HEX: #1B8A6E                        │
│ RGB: 27, 138, 110                   │
│ Used in: Buttons, accents           │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Light Green (Gradient Start)        │
│ HEX: #90EE90                        │
│ RGB: 144, 238, 144                  │
│ Used in: Onboarding 1 & 3           │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Dark Green (Gradient End)           │
│ HEX: #228B22 / #006400              │
│ RGB: 34, 139, 34 / 0, 100, 0       │
│ Used in: Gradients                  │
└─────────────────────────────────────┘
```

### Accent Colors
```
┌─────────────────────────────────────┐
│ Sky Blue (Onboarding 2)             │
│ HEX: #87CEEB                        │
│ RGB: 135, 206, 235                  │
│ Used in: Analytics theme            │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│ Google Colors                       │
│ Blue: #4285F4                       │
│ Red: #EA4335                        │
│ Yellow: #FBBC04                     │
│ Green: #34A853                      │
│ Used in: Google logo                │
└─────────────────────────────────────┘
```

## 📊 Usage Statistics

### Assets by Screen
```
OnboardingScreen:
  - onboarding1.svg ✓
  - onboarding2.svg ✓
  - onboarding3.svg ✓

LoginScreen:
  - google_logo.svg ✓

ProfileSetupScreen:
  - profile_placeholder.svg ✓
```

### Assets by Type
```
Vector Illustrations:  3 (onboarding1-3)
Logos:                 1 (google)
Placeholders:          1 (profile)
Total:                 5 assets
```

### Assets by Theme
```
Green Theme:           3 (onboarding1, onboarding3, profile)
Blue Theme:            1 (onboarding2)
Multi-color:           1 (google)
```

## 🔄 Asset Usage Map

```
┌─────────────────────────────────────────────────┐
│              App Flow & Assets                  │
├─────────────────────────────────────────────────┤
│                                                 │
│  OnboardingScreen                              │
│  ├─ onboarding1.svg                           │
│  ├─ onboarding2.svg                           │
│  └─ onboarding3.svg                           │
│         ↓ (User taps Get Started)              │
│  LoginScreen                                   │
│  ├─ google_logo.svg                           │
│         ↓ (User enters phone)                  │
│  OTPVerificationScreen                        │
│         ↓ (User verifies OTP)                  │
│  ProfileSetupScreen                           │
│  ├─ profile_placeholder.svg                   │
│         ↓ (User completes profile)            │
│  HomeScreen (Coming Soon)                     │
│                                                 │
└─────────────────────────────────────────────────┘
```

## 📋 Asset Checklist

### Quality Checks
- [x] All SVGs are optimized
- [x] File sizes minimized
- [x] Dimensions correct
- [x] Colors accurate
- [x] No metadata bloat
- [x] Cross-platform tested
- [x] Accessibility compliant
- [x] Performance optimized

### Integration Checks
- [x] Files located in correct folder
- [x] Paths registered in pubspec.yaml
- [x] Constants defined in app_assets.dart
- [x] Screenshots updated
- [x] Documentation complete
- [x] Error handlers in place
- [x] Tested on simulator
- [x] Ready for production

## 🚀 Quick Access Reference

### File Locations
```
Windows/Mac/Linux location:
assets/images/onboarding1.svg

Code reference:
AppAssets.onboarding1

Direct path:
'assets/images/onboarding1.svg'
```

### Code Examples

**Use in Widget:**
```dart
import 'config/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(AppAssets.onboarding1)
```

**With Error Handling:**
```dart
SvgPicture.asset(
  AppAssets.googleLogo,
  width: 24,
  height: 24,
  errorBuilder: (context, error, stackTrace) {
    return Icon(Icons.error);
  },
)
```

## 📈 Future Asset Placeholders

Ready for these additions:
- [ ] App logo (SVG)
- [ ] Product images (PNG/JPG)
- [ ] Farmer avatar (SVG)
- [ ] Loading animation (SVG)
- [ ] Empty state (SVG)
- [ ] Error state (SVG)
- [ ] Success state (SVG)
- [ ] Icons set (SVG)

---

**Total Assets**: 5  
**Total Size**: ~25KB  
**Status**: ✅ Complete  
**Last Updated**: March 2026
