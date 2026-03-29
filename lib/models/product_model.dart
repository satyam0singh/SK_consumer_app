import 'package:flutter/material.dart';

/// Product model for SmartKrishi app
class Product {
  final String id;
  final String name;
  final String farmName;
  final double price;
  final String unit; // kg, grams, etc.
  final double rating;
  final int reviewCount;
  final int freshness; // percentage
  final String imageAsset;
  final double distance; // in km
  final bool organic;
  final bool isFavorite;
  final double originalPrice;
  final int discountPercent;

  Product({
    required this.id,
    required this.name,
    required this.farmName,
    required this.price,
    required this.unit,
    required this.rating,
    required this.reviewCount,
    required this.freshness,
    required this.imageAsset,
    required this.distance,
    required this.organic,
    this.isFavorite = false,
    this.originalPrice = 0,
    this.discountPercent = 0,
  });

  /// Calculate discount price
  double get discountedPrice {
    if (discountPercent > 0) {
      return originalPrice * (1 - (discountPercent / 100));
    }
    return price;
  }

  /// Get product title with unit
  String get displayName => '$name ($unit)';

  /// Get formatted price with currency
  String get formattedPrice => '₹$price/$unit';

  /// Get freshness indicator color
  Color get freshnessColor {
    if (freshness >= 90) return const Color(0xFF228B22);
    if (freshness >= 70) return Colors.amber;
    return Colors.red;
  }
}

/// Category model
class ProductCategory {
  final String id;
  final String name;
  final String description;
  final String iconAsset;
  final Color backgroundColor;
  final int productCount;

  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.iconAsset,
    required this.backgroundColor,
    this.productCount = 0,
  });
}

/// Farm/Farmer model
class Farm {
  final String id;
  final String name;
  final String farmerName;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final double distance; // in km
  final double distanceKm; // alias for distance
  final String certification; // e.g., "ORGANIC", "ECO-CERTIFIED"
  final String description;
  final List<String> specialties;
  final bool isOrganic;
  final int productCount;

  Farm({
    required this.id,
    required this.name,
    required this.farmerName,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.distance,
    this.distanceKm = 0,
    required this.certification,
    required this.description,
    required this.specialties,
    this.isOrganic = false,
    this.productCount = 0,
  });

  String get formattedRating => '$rating (${reviewCount} reviews)';
}

/// Flash sale item model
class FlashSale {
  final String id;
  final String title;
  final String subtitle;
  final double originalPrice;
  final double salePrice;
  final int discountPercent;
  final String imageAsset;
  final DateTime endsAt;
  final String farmName;

  FlashSale({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.originalPrice,
    required this.salePrice,
    required this.discountPercent,
    required this.imageAsset,
    required this.endsAt,
    required this.farmName,
  });

  /// Get remaining time string
  String get timeRemaining {
    final now = DateTime.now();
    final difference = endsAt.difference(now);

    if (difference.inHours > 0) {
      return 'Ends in ${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
    } else if (difference.inMinutes > 0) {
      return 'Ends in ${difference.inMinutes}m';
    } else {
      return 'Ending soon';
    }
  }
}

/// Search filter model
class SearchFilters {
  final double minPrice;
  final double maxPrice;
  final double maxDistance; // in km
  final bool onlyOrganic;
  final bool isOrganic; // alias for onlyOrganic
  final String? harvestDate; // "today", "yesterday", "last3days"
  final double minRating; // 3.0 or 4.0
  final String? selectedCategory;
  final List<String> selectedCategories; // for multiple categories

  const SearchFilters({
    this.minPrice = 100,
    this.maxPrice = 5000,
    this.maxDistance = 25,
    this.onlyOrganic = false,
    this.isOrganic = false,
    this.harvestDate,
    this.minRating = 0,
    this.selectedCategory,
    this.selectedCategories = const [],
  });

  /// Create a copy with modified fields
  SearchFilters copyWith({
    double? minPrice,
    double? maxPrice,
    double? maxDistance,
    bool? onlyOrganic,
    bool? isOrganic,
    String? harvestDate,
    double? minRating,
    String? selectedCategory,
    List<String>? selectedCategories,
  }) {
    return SearchFilters(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      maxDistance: maxDistance ?? this.maxDistance,
      onlyOrganic: onlyOrganic ?? this.onlyOrganic,
      isOrganic: isOrganic ?? this.isOrganic,
      harvestDate: harvestDate ?? this.harvestDate,
      minRating: minRating ?? this.minRating,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  /// Check if any filter is active
  bool get isActive {
    return minPrice != 100 ||
        maxPrice != 5000 ||
        maxDistance != 25 ||
        onlyOrganic ||
        isOrganic ||
        harvestDate != null ||
        minRating > 0 ||
        selectedCategory != null ||
        selectedCategories.isNotEmpty;
  }

  /// Reset all filters
  static SearchFilters reset() {
    return const SearchFilters();
  }
}

/// Trending crop item
class TrendingCrop {
  final String id;
  final String name;
  final String iconAsset;
  final int demandChange; // positive for increase, negative for decrease
  final Color backgroundColor;
  final String unit; // kg, grams, etc.
  final double averagePrice;
  final int farmCount; // number of farms selling this

  TrendingCrop({
    required this.id,
    required this.name,
    required this.iconAsset,
    required this.demandChange,
    required this.backgroundColor,
    this.unit = 'kg',
    this.averagePrice = 0,
    this.farmCount = 0,
  });

  String get demandText =>
      '${demandChange > 0 ? '+' : ''}$demandChange% Demand';

  Color get demandColor {
    if (demandChange > 0) return Colors.green;
    if (demandChange < 0) return Colors.red;
    return Colors.grey;
  }
}
