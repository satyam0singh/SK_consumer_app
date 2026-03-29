import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../config/app_assets.dart';
/// Provider for sample data
class SampleDataProvider {
  /// Get all products
  List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        name: 'Organic Alphonso Mangoes',
        farmName: 'Direct from Mandi',
        price: 450,
        unit: 'kg',
        rating: 4.8,
        reviewCount: 156,
        freshness: 95,
        imageAsset: 'assets/images/mango.png',
        distance: 0,
        organic: true,
        originalPrice: 600,
        discountPercent: 25,
      ),
      Product(
        id: '2',
        name: 'Organic Roma Tomatoes',
        farmName: 'Ram Singh\'s Farm',
        price: 40,
        unit: 'kg',
        rating: 4.9,
        reviewCount: 128,
        freshness: 98,
        imageAsset: 'assets/images/tomatoes.png',
        distance: 1.2,
        organic: true,
      ),
      Product(
        id: '3',
        name: 'Vine Cherry Tomatoes',
        farmName: 'Green Valley Organic',
        price: 65,
        unit: '500g',
        rating: 4.7,
        reviewCount: 84,
        freshness: 95,
        imageAsset: 'assets/images/vine_cherry_tomatoes.png',
        distance: 2.8,
        organic: true,
      ),
      Product(
        id: '4',
        name: 'Mountain Potato',
        farmName: 'Himalayan Farms',
        price: 38,
        unit: 'kg',
        rating: 4.5,
        reviewCount: 92,
        freshness: 90,
        imageAsset: 'assets/images/mountainPotato.png',
        distance: 0,
        organic: true,
      ),
      Product(
        id: '5',
        name: 'Cherry Tomatoes',
        farmName: 'Fresh Valley',
        price: 85,
        unit: 'kg',
        rating: 4.6,
        reviewCount: 110,
        freshness: 92,
        imageAsset: AppAssets.cherryTomatoes,
        distance: 1.5,
        organic: false,
      ),
      Product(
        id: '6',
        name: 'Hybrid Salad Tomatoes',
        farmName: 'Modern Agri Hub',
        price: 32,
        unit: 'kg',
        rating: 4.3,
        reviewCount: 56,
        freshness: 90,
        imageAsset: AppAssets.hybridSaladTomatoes,
        distance: 4.5,
        organic: false,
      ),
    ];
  }

  /// Get products by category
  List<Product> getProductsByCategory(String categoryId) {
    // Filter based on category - this is sample logic
    return getAllProducts().take(3).toList();
  }

  /// Search products
  List<Product> searchProducts(
    String query, {
    SearchFilters filters = const SearchFilters(),
  }) {
    List<Product> results = getAllProducts();

    // Filter by search query
    if (query.isNotEmpty) {
      results = results
          .where(
            (product) =>
                product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.farmName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }

    // Apply filters
    results = results
        .where(
          (product) =>
              product.price >= filters.minPrice &&
              product.price <= filters.maxPrice &&
              product.distance <= filters.maxDistance &&
              (!filters.onlyOrganic || product.organic) &&
              product.rating >= filters.minRating,
        )
        .toList();

    return results;
  }

  /// Get all categories
  List<ProductCategory> getCategories() {
    return [
      ProductCategory(
        id: 'vegetables',
        name: 'Vegetables',
        description: 'Fresh greens',
        iconAsset: AppAssets.categoryVegetables,
        backgroundColor: const Color(0xFFD4F1D4),
        productCount: 120,
      ),
      ProductCategory(
        id: 'fruits',
        name: 'Fruits',
        description: 'Sweet & ripe',
        iconAsset: AppAssets.categoryFruits,
        backgroundColor: const Color(0xFFFFE4C4),
        productCount: 85,
      ),
      ProductCategory(
        id: 'grains',
        name: 'Grains',
        description: 'Essential staples',
        iconAsset: AppAssets.categoryGrains,
        backgroundColor: const Color(0xFFFFFACD),
        productCount: 42,
      ),
      ProductCategory(
        id: 'dairy',
        name: 'Dairy',
        description: 'Pure & fresh',
        iconAsset: AppAssets.categoryDairy,
        backgroundColor: const Color(0xFFE0F4FF),
        productCount: 38,
      ),
      ProductCategory(
        id: 'organic',
        name: 'Organic',
        description: 'Chemical-free',
        iconAsset: AppAssets.categoryOrganic,
        backgroundColor: const Color(0xFFF0F8F0),
        productCount: 156,
      ),
      ProductCategory(
        id: 'exotic',
        name: 'Exotic',
        description: 'Specialty items',
        iconAsset: AppAssets.categoryExotic,
        backgroundColor: const Color(0xFFFFE4F5),
        productCount: 34,
      ),
      ProductCategory(
        id: 'spices',
        name: 'Spices',
        description: 'Aromatic flavors',
        iconAsset: AppAssets.categorySpices,
        backgroundColor: const Color(0xFFFFE4E1),
        productCount: 56,
      ),
      ProductCategory(
        id: 'seeds',
        name: 'Seeds',
        description: 'High yield',
        iconAsset: AppAssets.categorySeeds,
        backgroundColor: const Color(0xFFF0FFF0),
        productCount: 28,
      ),
    ];
  }

  /// Get nearby farms
  List<Farm> getNearbyFarms() {
    return [
      Farm(
        id: '1',
        name: 'Green Acres Organics',
        farmerName: 'Rajesh N.',
        imageUrl: 'assets/images/farm1.png', // Use placeholder
        rating: 4.9,
        reviewCount: 128,
        distance: 1.2,
        certification: 'TRANSPARENCY PRO',
        description: 'Organic farm specializing in fresh vegetables',
        specialties: ['Tomatoes', 'Lettuce', 'Carrots'],
      ),
      Farm(
        id: '2',
        name: 'Sunshine Harvest',
        farmerName: 'Priya M.',
        imageUrl: 'assets/images/farm2.png', // Use placeholder
        rating: 4.7,
        reviewCount: 84,
        distance: 2.8,
        certification: 'ECO-CERTIFIED',
        description: 'Sustainable farming practices',
        specialties: ['Fruits', 'Grains', 'Dairy'],
      ),
    ];
  }

  /// Get flash sales
  List<FlashSale> getFlashSales() {
    final now = DateTime.now();
    return [
      FlashSale(
        id: '1',
        title: 'Organic Alphonso Mangoes',
        subtitle: 'Direct from Mandi',
        originalPrice: 600,
        salePrice: 450,
        discountPercent: 25,
        imageAsset: 'assets/images/mango.png',
        endsAt: now.add(const Duration(hours: 2, minutes: 45, seconds: 10)),
        farmName: 'Direct from Mandi',
      ),
      FlashSale(
        id: '2',
        title: 'Premium Tomatoes',
        subtitle: 'Today\'s Harvest',
        originalPrice: 85,
        salePrice: 65,
        discountPercent: 23,
        imageAsset: 'assets/images/tomatoes.png',
        endsAt: now.add(const Duration(hours: 3, minutes: 30)),
        farmName: 'Fresh Valley',
      ),
    ];
  }

  /// Get trending crops
  List<TrendingCrop> getTrendingCrops() {
    return [
      TrendingCrop(
        id: '1',
        name: 'Mustard',
        iconAsset: 'assets/images/mustard.jpg',
        demandChange: 12,
        backgroundColor: const Color(0xFFFFF9C4),
      ),
      TrendingCrop(
        id: '2',
        name: 'Turmeric',
        iconAsset: 'assets/images/turmeric.png',
        demandChange: 8,
        backgroundColor: const Color(0xFFFFF9C4),
      ),
      TrendingCrop(
        id: '3',
        name: 'Chilli',
        iconAsset: 'assets/images/chilli.png',
        demandChange: -3,
        backgroundColor: const Color(0xFFFFEBEE),
      ),
      TrendingCrop(
        id: '4',
        name: 'Cotton',
        iconAsset: 'assets/images/cotton.png',
        demandChange: 15,
        backgroundColor: const Color(0xFFE3F2FD),
      ),
    ];
  }
}
