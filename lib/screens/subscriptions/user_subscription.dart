class UserSubscription {
  final String id;
  final String planId;
  final String title;
  final String frequency;
  final double totalPrice;
  final String nextDelivery;
  final String deliveryDay;
  final List<String> items;
  final List<String> extras;
  final String status; // ACTIVE, PAUSED, CANCELLED
  final DateTime startDate;
  final int totalDeliveries;
  final int deliveriesReceived;

  UserSubscription({
    required this.id,
    required this.planId,
    required this.title,
    required this.frequency,
    required this.totalPrice,
    required this.nextDelivery,
    required this.deliveryDay,
    required this.items,
    required this.extras,
    required this.status,
    required this.startDate,
    required this.totalDeliveries,
    required this.deliveriesReceived,
  });

  double get progress => totalDeliveries > 0 ? deliveriesReceived / totalDeliveries : 0;
}
