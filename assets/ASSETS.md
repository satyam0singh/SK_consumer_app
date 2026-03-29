# Assets Documentation - SmartKrishi

Complete guide to all assets used in the SmartKrishi consumer app.

## 📁 Folder Structure

```
assets/
└── images/
    ├── onboarding1.svg          # Onboarding screen 1 - Buy fresh produce
    ├── onboarding2.svg          # Onboarding screen 2 - See how food grows
    ├── onboarding3.svg          # Onboarding screen 3 - Track from farm to home
    ├── google_logo.svg          # Google login button icon
    └── profile_placeholder.svg  # User profile photo placeholder
```

## 🖼️ Image Assets

### Onboarding Images

#### `onboarding1.svg` (400x600px)
- **Purpose**: First onboarding screen hero image
- **Theme**: Green gradient with produce theme
- **Used By**: OnboardingScreen
- **Description**: Shows the concept of buying fresh produce directly from farmers

#### `onboarding2.svg` (400x600px)
- **Purpose**: Second onboarding screen hero image  
- **Theme**: Blue gradient with analytics theme
- **Used By**: OnboardingScreen
- **Description**: Shows farm analytics - soil health, water usage, sunlight metrics

#### `onboarding3.svg` (400x600px)
- **Purpose**: Third onboarding screen hero image
- **Theme**: Green gradient with tracking theme
- **Used By**: OnboardingScreen
- **Description**: Shows tracking journey from farm to home with route visualization

### Login Images

#### `google_logo.svg` (24x24px)
- **Purpose**: Google authentication button icon
- **Used By**: LoginScreen
- **Format**: Google brand colors (Blue, Red, Yellow, Green)

### Profile Images

#### `profile_placeholder.svg` (200x200px)
- **Purpose**: Default profile photo placeholder
- **Used By**: ProfileSetupScreen
- **Theme**: Green gradient with person silhouette
- **Description**: Shown when user hasn't uploaded a profile photo yet

## 📱 Usage Examples

### Using Assets Helper Class

Import and use the centralized assets configuration:

```dart
import 'config/app_assets.dart';

// Access single asset
SvgPicture.asset(AppAssets.googleLogo)

// Use from list
for (var image in AppAssets.onboardingImages) {
  SvgPicture.asset(image)
}
```

### Direct Usage in Screens

```dart
import 'package:flutter_svg/flutter_svg.dart';

// In onboarding_screen.dart
SvgPicture.asset(
  AppAssets.onboarding1,
  fit: BoxFit.cover,
)

// In login_screen.dart
SvgPicture.asset(
  AppAssets.googleLogo,
  width: 20,
  height: 20,
)

// In profile_setup_screen.dart
SvgPicture.asset(
  AppAssets.profilePlaceholder,
  fit: BoxFit.cover,
)
```

## 🎨 Design Guidelines

### Color Scheme
- **Primary Green**: #1B8A6E (Used in profile placeholder and buttons)
- **Light Green**: #90EE90 (Gradient start colors)
- **Dark Green**: #228B22 or #006400 (Gradient end colors)
- **Blue**: #4285F4, #4682B4 (Google logo and onboarding2)
- **Red**: #FF6347, #EA4335 (Accent colors)

### Image Sizes

| Asset | Dimension | Format |
|-------|-----------|--------|
| Onboarding 1-3 | 400x600px | SVG |
| Google Logo | 24x24px | SVG |
| Profile Placeholder | 200x200px | SVG |

### SVG Benefits Used
- ✅ Scalable without quality loss
- ✅ Small file size compared to PNG
- ✅ Easy to maintain and update colors
- ✅ Supports transparency and gradients

## 📝 Adding New Assets

### Step 1: Create the Asset File
1. Design your image (in Figma, Illustrator, or code)
2. Export as SVG file
3. Place in `assets/images/` folder

### Step 2: Register in Configuration
```dart
// In lib/config/app_assets.dart
static const String newAssetName = 'assets/images/new_asset.svg';
```

### Step 3: Update pubspec.yaml
The assets folder is already configured to load all images:
```yaml
flutter:
  assets:
    - assets/images/
```

### Step 4: Use in Code
```dart
import 'package:flutter_svg/flutter_svg.dart';
import 'config/app_assets.dart';

SvgPicture.asset(AppAssets.newAssetName)
```

## 🔧 Dependencies

- **flutter_svg**: ^2.0.0 - For rendering SVG images
- **flutter/material.dart** - For image display widgets

## 🚀 Future Asset Additions

### Recommended Next Steps
- [ ] App logo (SVG)
- [ ] Empty state illustrations
- [ ] Error state illustrations
- [ ] Loading animations
- [ ] Featured product images
- [ ] Farmer profile images
- [ ] Product category icons
- [ ] Navigation icons
- [ ] Custom fonts

### Asset Naming Convention
- **Format**: `snake_case.svg` (all lowercase, underscore separated)
- **Prefixes**: 
  - `onboarding_` - Onboarding screens
  - `icon_` - Small icon assets
  - `illustration_` - Large illustrations
  - `logo_` - Brand logos
  - `placeholder_` - Placeholder images

## 📌 Troubleshooting

### SVG Not Loading
1. Check file path in `app_assets.dart`
2. Verify `pubspec.yaml` has `assets:` section configured
3. Run `flutter pub get`
4. Run `flutter clean && flutter pub get`

### Image Appears Blurry
1. Ensure SVG has proper viewBox attribute
2. Use appropriate `fit: BoxFit` property
3. Check SVG dimensions match container

### Build Errors
1. Ensure flutter_svg is in pubspec.yaml
2. Run `flutter pub get` to install dependencies
3. Check for typos in asset paths

## 📚 Resources

- [Flutter SVG Documentation](https://pub.dev/packages/flutter_svg)
- [Flutter Assets Guide](https://flutter.dev/to/adding-assets)
- [SVG Optimization](https://www.svgomg.com/)

## 👥 Contributing

When adding new assets:
1. Follow naming conventions
2. Update this documentation
3. Add to `app_assets.dart`
4. Test in all screen sizes
5. Ensure accessibility (sufficient contrast, readable text)

---

**Last Updated**: March 2026
**Asset Count**: 5 SVG files
**Total Size**: ~25KB (optimized SVG)
