import '../../core/network/api_client.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

/// Repository for order operations — all data flows through API.
class OrderRepository {
  final ApiClient _api = ApiClient();

  /// Fetch user's orders (sorted descending by createdAt)
  Future<List<OrderModel>> getOrders() async {
    final data = await _api.get('getOrders');

    if (data is List) {
      return data
          .map((e) => OrderModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  /// Create a new order from cart items (server calculates total)
  Future<Map<String, dynamic>> createOrder({
    required List<CartItemModel> items,
    required String deliveryAddress,
    String paymentMethod = 'COD',
  }) async {
    final result = await _api.post('createOrder', {
      'items': items.map((e) => e.toJson()).toList(),
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
    });

    return Map<String, dynamic>.from(result);
  }
}
