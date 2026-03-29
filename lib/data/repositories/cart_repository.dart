import '../../core/network/api_client.dart';
import '../models/cart_item_model.dart';

/// Repository for cart operations — all data flows through API.
class CartRepository {
  final ApiClient _api = ApiClient();

  /// Fetch current user's cart
  Future<List<CartItemModel>> getCart() async {
    final data = await _api.get('getCart');

    if (data is List) {
      return data
          .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  /// Add item to cart (server handles duplicate merging)
  Future<void> addToCart(CartItemModel item) async {
    await _api.post('addToCart', item.toJson());
  }

  /// Remove a single product from cart
  Future<void> removeFromCart(String productId) async {
    await _api.post('removeFromCart', {'productId': productId});
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    await _api.post('clearCart', {});
  }
}
