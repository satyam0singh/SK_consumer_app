/// Consumer-friendly product model parsed from API response.
class ApiProduct {
  final String id;
  final String name;
  final double price;
  final String unit;
  final String category;
  final bool available;
  final int stock;
  final bool organic;
  final double rating;
  final String imageUrl;
  final String farmerName;
  final String farmerId;
  final String location;
  final String description;

  ApiProduct({
    required this.id,
    required this.name,
    required this.price,
    this.unit = 'kg',
    this.category = 'general',
    this.available = true,
    this.stock = 0,
    this.organic = false,
    this.rating = 0,
    this.imageUrl = '',
    this.farmerName = '',
    this.farmerId = '',
    this.location = '',
    this.description = '',
  });

  factory ApiProduct.fromJson(Map<String, dynamic> json) {
    return ApiProduct(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] ?? 0).toDouble(),
      unit: json['unit']?.toString() ?? 'kg',
      category: json['category']?.toString() ?? 'general',
      available: json['available'] ?? true,
      stock: (json['stock'] ?? 0).toInt(),
      organic: json['organic'] ?? false,
      rating: (json['rating'] ?? 0).toDouble(),
      imageUrl: json['imageUrl']?.toString() ?? '',
      farmerName: json['farmerName']?.toString() ?? '',
      farmerId: json['farmerId']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'unit': unit,
        'category': category,
        'available': available,
        'stock': stock,
        'organic': organic,
        'rating': rating,
        'imageUrl': imageUrl,
        'farmerName': farmerName,
        'farmerId': farmerId,
        'location': location,
        'description': description,
      };
}
