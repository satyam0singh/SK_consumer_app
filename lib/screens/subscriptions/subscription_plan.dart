class SubscriptionPlan {
  final String id;
  final String title;
  final String frequency;
  final double price;
  final String deliveryTime;
  final List<String> includes;
  final String image;
  final bool isPopular;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.frequency,
    required this.price,
    required this.deliveryTime,
    required this.includes,
    required this.image,
    this.isPopular = false,
  });
}
