class SubscriptionItem {
  final String id;
  final String name;
  final String quantity;
  final String description;
  final String image;
  final bool isSwappable;

  SubscriptionItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.description,
    required this.image,
    this.isSwappable = true,
  });
}

class SubscriptionExtra {
  final String id;
  final String name;
  final String quantity;
  final double price;
  final String image;
  int quantity_selected;

  SubscriptionExtra({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    this.quantity_selected = 0,
  });
}
