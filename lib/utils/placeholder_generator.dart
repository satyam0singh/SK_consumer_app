import 'package:flutter/material.dart';

/// Utility class for generating placeholder widgets
/// Useful when assets are missing or for development/testing
class PlaceholderGenerator {
  /// Generate a placeholder for onboarding screens
  static Widget generateOnboardingPlaceholder({
    required String title,
    required Color gradientStart,
    required Color gradientEnd,
    double width = 400,
    double height = 600,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStart, gradientEnd],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: Icon(Icons.landscape, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 40),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate a placeholder for profile images
  static Widget generateProfilePlaceholder({
    double size = 200,
    Color backgroundColor = const Color(0xFF1B8A6E),
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor,
            backgroundColor.withGreen((backgroundColor.green * 0.7).toInt()),
          ],
        ),
      ),
      child: Center(
        child: Icon(Icons.person, size: size * 0.5, color: Colors.white),
      ),
    );
  }

  /// Generate a placeholder for Google logo
  static Widget generateGooglePlaceholder({double size = 24}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size / 3,
              height: size / 3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF4285F4),
              ),
            ),
            const SizedBox(width: 2),
            Container(
              width: size / 3,
              height: size / 3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEA4335),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate a placeholder for missing images
  /// Shows a generic image placeholder with icon
  static Widget generateMissingImagePlaceholder({
    double width = 300,
    double height = 300,
    String? title,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_not_supported, size: 60, color: Colors.grey[500]),
          const SizedBox(height: 16),
          if (title != null)
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
        ],
      ),
    );
  }
}

/// Widget for handling image loading with fallback
class OptimizedImage extends StatelessWidget {
  final String assetPath;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool useSvg;

  const OptimizedImage({
    super.key,
    required this.assetPath,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.useSvg = true,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Error loading image: $assetPath - $error');
        return PlaceholderGenerator.generateMissingImagePlaceholder(
          width: width ?? 300,
          height: height ?? 300,
          title: 'Image not available',
        );
      },
    );
  }
}
