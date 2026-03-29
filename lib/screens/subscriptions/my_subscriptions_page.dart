import 'package:flutter/material.dart';
import 'user_subscription.dart';
import 'manage_subscription_page.dart';

class MySubscriptionsPage extends StatefulWidget {
  const MySubscriptionsPage({super.key});

  @override
  State<MySubscriptionsPage> createState() => _MySubscriptionsPageState();
}

class _MySubscriptionsPageState extends State<MySubscriptionsPage> {
  late List<UserSubscription> userSubscriptions;

  @override
  void initState() {
    super.initState();
    _initializeSubscriptions();
  }

  void _initializeSubscriptions() {
    userSubscriptions = [
      UserSubscription(
        id: 'u1',
        planId: '1',
        title: 'Weekly Veggie Box',
        frequency: 'WEEKLY',
        totalPrice: 25.00,
        nextDelivery: 'Tomorrow, 7:00 AM',
        deliveryDay: 'Every Tuesday',
        items: [
          '5kg Organic Greens',
          'Carrots',
          'Potatoes',
          'Seasonal Peppers',
          'Cherry Tomatoes',
          'Organic Garlic',
          'Red Bell Peppers',
          'Organic Broccoli'
        ],
        extras: ['Cherry Tomatoes (+₹99)', 'Organic Garlic (+₹49)'],
        status: 'ACTIVE',
        startDate: DateTime(2026, 1, 15),
        totalDeliveries: 52,
        deliveriesReceived: 12,
      ),
      UserSubscription(
        id: 'u2',
        planId: '4',
        title: 'Organic Dairy Bundle',
        frequency: 'WEEKLY',
        totalPrice: 35.00,
        nextDelivery: 'Sunday, 6:30 AM',
        deliveryDay: 'Every Sunday',
        items: [
          '1L Pure Ghee',
          '500ml Yogurt',
          '250g Paneer',
          'Fresh Milk'
        ],
        extras: [],
        status: 'ACTIVE',
        startDate: DateTime(2026, 2, 01),
        totalDeliveries: 12,
        deliveriesReceived: 8,
      ),
    ];
  }

  String getStatusColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return 'Active';
      case 'PAUSED':
        return 'Paused';
      case 'CANCELLED':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color getStatusBgColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return Colors.green[50]!;
      case 'PAUSED':
        return Colors.orange[50]!;
      case 'CANCELLED':
        return Colors.red[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case 'ACTIVE':
        return Colors.green[700]!;
      case 'PAUSED':
        return Colors.orange[700]!;
      case 'CANCELLED':
        return Colors.red[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.subscriptions_rounded, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Subscriptions',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: userSubscriptions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.card_giftcard,
                      size: 64, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'No active subscriptions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B8A6E),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Browse Subscriptions',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: userSubscriptions
                    .map((subscription) =>
                        _buildSubscriptionCard(subscription))
                    .toList(),
              ),
            ),
    );
  }

  Widget _buildSubscriptionCard(UserSubscription subscription) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ManageSubscriptionPage(subscription: subscription),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subscription.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: getStatusBgColor(subscription.status),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      getStatusColor(subscription.status),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: getStatusTextColor(subscription.status),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            Divider(height: 0, color: Colors.grey[200]),

            // Subscription Details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Next Delivery
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Next Delivery',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subscription.nextDelivery,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${subscription.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B8A6E),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Frequency
                  Row(
                    children: [
                      Icon(Icons.repeat, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Frequency',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subscription.deliveryDay,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Items Count
                  Row(
                    children: [
                      Icon(Icons.shopping_bag, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Items',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${subscription.items.length} items in basket',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Progress Bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Deliveries',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${subscription.deliveriesReceived}/${subscription.totalDeliveries}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B8A6E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: subscription.progress,
                          minHeight: 6,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF1B8A6E),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Manage Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Color(0xFF1B8A6E)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManageSubscriptionPage(subscription: subscription),
                          ),
                        );
                      },
                      child: const Text(
                        'Manage Subscription',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B8A6E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
