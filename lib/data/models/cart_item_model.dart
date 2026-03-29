/// Cart item model with price snapshot (stored server-side).
class CartItemModel {
  final String productId;
  final String name;
  final double price;
  final String unit;
  final String farmName;
  int quantity;
  final String imageUrl;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    this.unit = 'kg',
    this.farmName = '',
    required this.quantity,
    this.imageUrl = '',
  });

  double get totalPrice => price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit']?.toString() ?? 'kg',
      farmName: json['farmName']?.toString() ?? '',
      quantity: (json['quantity'] ?? 1).toInt(),
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'price': price,
        'unit': unit,
        'farmName': farmName,
        'quantity': quantity,
        'imageUrl': imageUrl,
      };
}
