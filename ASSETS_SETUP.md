# Assets Setup Guide

Complete guide to setting up and managing assets in the SmartKrishi app.

## ✅ Current Setup Status

### Created Files
- ✅ `assets/images/` directory
- ✅ 5 SVG placeholder files created
- ✅ `pubspec.yaml` updated with `flutter_svg` dependency
- ✅ `lib/config/app_assets.dart` - Centralized asset configuration
- ✅ `lib/utils/placeholder_generator.dart` - Runtime placeholder generation
- ✅ All screens updated to use SVG images

## 🚀 Quick Start

### 1. Install Dependencies
```bash
cd smartkrishi_consumer_app
flutter pub get
```

### 2. Verify Asset Files
Check that these files exist in `assets/images/`:
- ✅ onboarding1.svg
- ✅ onboarding2.svg  
- ✅ onboarding3.svg
- ✅ google_logo.svg
- ✅ profile_placeholder.svg

### 3. Run the App
```bash
flutter run
```

## 📂 Asset Replacement Guide

### How to Replace SVG Placeholders with Real Images

#### Option A: Use Real SVG Files
1. Design your image in Figma, Illustrator, or any vector editor
2. Export as SVG (optimized)
3. Copy to `assets/images/` folder
4. Update filename in `app_assets.dart` if changed

#### Option B: Use PNG/JPG Files
1. Change file extension in code from `.svg` to `.png`
2. Place image in `assets/images/` folder
3. Update import statements to use `Image.asset` instead of `SvgPicture.asset`
4. Update `app_assets.dart`

**Example:**
```dart
// Before (SVG)
import 'package:flutter_svg/flutter_svg.dart';
SvgPicture.asset(AppAssets.onboarding1)

// After (PNG)
Image.asset(AppAssets.onboarding1) // Update to .png path
```

#### Option C: Use Network Images
1. Remove from local assets
2. Use Image.network() instead
3. Provide image URL

## 🎨 Asset Generator Tools

### Recommended Tools for Creating Assets

| Purpose | Tool | Format |
|---------|------|--------|
| Vector Graphics | Figma | SVG |
| Icons | Flaticon, Icons8 | SVG |
| Photo Editing | Photoshop, GIMP | PNG/JPG |
| Illustration | Procreate, Affinity | SVG/PNG |
| Image Optimization | SVGOMG | SVG |

### Online SVG Resources
- [Flaticon](https://www.flaticon.com/) - Free icons
- [Icons8](https://icons8.com/) - Quality icons
- [Unplash](https://unsplash.com/) - Free photos
- [Pexels](https://www.pexels.com/) - Stock images

## 📋 Asset Checklist

### Implementation Checklist
- [x] Create `assets/images/` folder
- [x] Add `flutter_svg` to `pubspec.yaml`
- [x] Create 5 SVG placeholder files
- [x] Update `pubspec.yaml` with assets configuration
- [x] Create `app_assets.dart` configuration file
- [x] Update all screens to use new assets
- [x] Create placeholder generator utility
- [x] Add this documentation

### Before Production Checklist
- [ ] Replace placeholder SVGs with real images
- [ ] Optimize all SVG files (remove metadata)
- [ ] Test on multiple screen sizes
- [ ] Test on Android and iOS
- [ ] Verify image loading performance
- [ ] Check for missing assets errors
- [ ] Update asset paths if file names change
- [ ] Add loading indicators for slow networks

## 🔍 Troubleshooting

### Issue: SVG Images Not Displaying

**Solution 1**: Verify pubspec.yaml
```yaml
flutter:
  assets:
    - assets/images/
```

**Solution 2**: Check flutter_svg is installed
```bash
flutter pub get
flutter pub upgrade flutter_svg
```

**Solution 3**: Run clean build
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: "Asset not found" Error

**Solution**: 
1. Verify exact file path:
   ```bash
   ls assets/images/  # On Mac/Linux
   dir assets\images\  # On Windows
   ```
2. Check `app_assets.dart` for correct paths
3. Ensure paths use forward slashes: `assets/images/file.svg`

### Issue: Images Load Slowly

**Solution**:
1. Optimize SVG file sizes using [SVGOMG](https://www.svgomg.com/)
2. Use `cacheColorFilter` with `SvgPicture`:
   ```dart
   SvgPicture.asset(
     AppAssets.onboarding1,
     cacheColorFilter: true,
   )
   ```

### Issue: Gradient Not Showing in SVG

**Solution**:
1. Ensure SVG has `<defs>` with gradient definitions
2. Apply gradient with correct ID reference
3. Test SVG in browser first

## 💡 Best Practices

### Performance
- ✅ Use SVG for icons and illustrations
- ✅ Use PNG/JPG for photos
- ✅ Compress images before adding
- ✅ Remove unused assets
- ✅ Use appropriate image sizes

### Organization
- ✅ Organize assets by category
- ✅ Use descriptive file names
- ✅ Update `app_assets.dart` for all assets
- ✅ Document new assets in `ASSETS.md`

### Code Quality
- ✅ Always use `AppAssets` constants
- ✅ Never hardcode image paths
- ✅ Handle missing images gracefully
- ✅ Use error builders for Image widgets

## 📱 Responsive Images

### Displaying Images at Different Sizes

```dart
// For different screen densities
SvgPicture.asset(
  AppAssets.onboarding1,
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height * 0.5,
  fit: BoxFit.cover,
)

// Mobile-first approach
final isMobile = MediaQuery.of(context).size.width < 600;
final imageSize = isMobile ? 300.0 : 600.0;
```

## 🚀 Deployment

### Before Release

1. **Asset Optimization**
   ```bash
   # Optimize all SVGs
   npx svgomg-cli assets/images/*.svg
   ```

2. **Size Check**
   - Ensure total assets < 50MB
   - Monitor APK/IPA size

3. **Testing**
   - Test on real devices
   - Verify image loading on 3G
   - Check accessibility

## 📚 Additional Resources

- [Flutter Assets Guide](https://flutter.dev/docs/development/ui/assets-and-images)
- [flutter_svg Package](https://pub.dev/packages/flutter_svg)
- [SVG Best Practices](https://developer.mozilla.org/en-US/docs/Web/SVG)
- [Image Optimization Guide](https://web.dev/image-sizing)

## 🔄 Update History

| Date | Changes |
|------|---------|
| March 2026 | Initial setup with 5 SVG placeholders |
| | Created AppAssets configuration |
| | Added flutter_svg dependency |
| | Updated all screens for SVG support |

## 📞 Support

For issues or questions:
1. Check troubleshooting section above
2. Review ASSETS.md in the assets folder
3. Check screen-specific documentation
4. Review Flutter assets documentation

---

**Version**: 1.0
**Last Updated**: March 2026
**Status**: Ready for Development
