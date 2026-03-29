import '../../core/network/api_client.dart';
import '../models/api_product.dart';

/// Repository for product data — fetches from API (which reads farmer DB).
class ProductRepository {
  final ApiClient _api = ApiClient();

  /// Fetch paginated products from API
  Future<ProductPage> getProducts({int limit = 20, String? lastKey}) async {
    final params = <String, String>{'limit': limit.toString()};
    if (lastKey != null) params['lastKey'] = lastKey;

    final data = await _api.get('getProducts', queryParams: params);

    final products = (data['products'] as List<dynamic>?)
            ?.map((e) => ApiProduct.fromJson(Map<String, dynamic>.from(e)))
            .toList() ??
        [];

    return ProductPage(
      products: products,
      lastKey: data['lastKey']?.toString(),
      hasMore: data['hasMore'] ?? false,
    );
  }

  /// Client-side search filter on fetched products
  List<ApiProduct> searchProducts(List<ApiProduct> products, String query) {
    if (query.isEmpty) return products;
    final q = query.toLowerCase();
    return products
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.farmerName.toLowerCase().contains(q) ||
            p.category.toLowerCase().contains(q))
        .toList();
  }
}

/// Paginated response wrapper
class ProductPage {
  final List<ApiProduct> products;
  final String? lastKey;
  final bool hasMore;

  ProductPage({
    required this.products,
    this.lastKey,
    this.hasMore = false,
  });
}
