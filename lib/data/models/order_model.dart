/// Order model with userId, server-calculated totals, and status lifecycle.
class OrderModel {
  final String orderId;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;
  final String status; // PLACED → CONFIRMED → SHIPPED → DELIVERED
  final int createdAt;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.subtotal,
    this.deliveryFee = 2.50,
    this.serviceFee = 1.00,
    required this.totalAmount,
    this.deliveryAddress = '',
    this.paymentMethod = 'COD',
    this.status = 'PLACED',
    this.createdAt = 0,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      deliveryFee: (json['deliveryFee'] ?? 2.50).toDouble(),
      serviceFee: (json['serviceFee'] ?? 1.00).toDouble(),
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      deliveryAddress: json['deliveryAddress']?.toString() ?? '',
      paymentMethod: json['paymentMethod']?.toString() ?? 'COD',
      status: json['status']?.toString() ?? 'PLACED',
      createdAt: (json['createdAt'] ?? 0).toInt(),
    );
  }

  /// Human-readable order number (first 8 chars of Firebase key)
  String get displayOrderNumber =>
      'SK-${orderId.length > 8 ? orderId.substring(orderId.length - 6).toUpperCase() : orderId.toUpperCase()}';

  /// Formatted date from timestamp
  DateTime get createdDate =>
      DateTime.fromMillisecondsSinceEpoch(createdAt);
}

class OrderItem {
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String unit;
  final String farmName;

  OrderItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    this.unit = 'kg',
    this.farmName = '',
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: (json['quantity'] ?? 1).toInt(),
      unit: json['unit']?.toString() ?? 'kg',
      farmName: json['farmName']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'quantity': quantity,
        'unit': unit,
        'farmName': farmName,
      };
}
