import 'package:flutter/material.dart';
import 'subscription_plan.dart';
import 'subscription_detail_page.dart';
import 'my_subscriptions_page.dart';

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  late List<SubscriptionPlan> subscriptions;
  String selectedFrequency = 'all';

  @override
  void initState() {
    super.initState();
    _initializeSubscriptions();
  }

  void _initializeSubscriptions() {
    subscriptions = [
      SubscriptionPlan(
        id: '1',
        title: 'Weekly Veggie Box',
        frequency: 'WEEKLY',
        price: 25.00,
        deliveryTime: 'Every Tuesday Morning',
        includes: [
          '5kg Organic Greens',
          'Carrots',
          'Potatoes',
          'Seasonal Peppers'
        ],
        image: 'assets/images/vegetables.jpg',
        isPopular: true,
      ),
      SubscriptionPlan(
        id: '2',
        title: 'Monthly Grain Stash',
        frequency: 'MONTHLY',
        price: 45.00,
        deliveryTime: '1st Monday of every Month',
        includes: [
          '10kg Premium Basmati',
          '2kg Lentils',
          '1kg Whole Wheat Flour'
        ],
        image: 'assets/images/grains.jpg',
      ),
      SubscriptionPlan(
        id: '3',
        title: 'Seasonal Fruit Box',
        frequency: 'WEEKLY',
        price: 30.00,
        deliveryTime: 'Every Friday Evening',
        includes: [
          'Mangoes (seasonal)',
          'Apples',
          'Bananas',
          'Grapes'
        ],
        image: 'assets/images/fruits.jpg',
      ),
      SubscriptionPlan(
        id: '4',
        title: 'Organic Dairy Bundle',
        frequency: 'WEEKLY',
        price: 35.00,
        deliveryTime: 'Every Sunday Morning',
        includes: [
          '1L Pure Ghee',
          '500ml Yogurt',
          '250g Paneer',
          'Fresh Milk'
        ],
        image: 'assets/images/dairy.jpg',
      ),
      SubscriptionPlan(
        id: '5',
        title: 'Premium Spice Kit',
        frequency: 'MONTHLY',
        price: 28.00,
        deliveryTime: '15th of every Month',
        includes: [
          'Turmeric Powder',
          'Coriander Seeds',
          'Cumin Seeds',
          'Chili Powder'
        ],
        image: 'assets/images/spices.jpg',
      ),
      SubscriptionPlan(
        id: '6',
        title: 'Herbs & Leafy Greens',
        frequency: 'WEEKLY',
        price: 20.00,
        deliveryTime: 'Every Thursday Morning',
        includes: [
          'Fresh Mint',
          'Cilantro',
          'Spinach',
          'Methi'
        ],
        image: 'assets/images/herbs.jpg',
      ),
    ];
  }

  List<SubscriptionPlan> getFilteredSubscriptions() {
    switch (selectedFrequency) {
      case 'weekly':
        return subscriptions
            .where((sub) => sub.frequency == 'WEEKLY')
            .toList();
      case 'monthly':
        return subscriptions
            .where((sub) => sub.frequency == 'MONTHLY')
            .toList();
      default:
        return subscriptions;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredSubscriptions = getFilteredSubscriptions();

    return Scaffold(
      backgroundColor: Colors.grey[50],
     appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.pop(context),
  ),
  title: const Text(
    'Subscriptions',
    style: TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
  actions: [
    GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MySubscriptionsPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1B8A6E),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'My Subs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
),
      body: Column(
        children: [
          // Filter Tabs
          _buildFilterTabs(),

          // Subscriptions List
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: filteredSubscriptions
                    .map((plan) => _buildSubscriptionCard(plan))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final frequencyTabs = [
      {'id': 'all', 'label': 'All Plans'},
      {'id': 'weekly', 'label': 'Weekly'},
      {'id': 'monthly', 'label': 'Monthly'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: frequencyTabs.map((tab) {
          final isSelected = selectedFrequency == tab['id'];
          return GestureDetector(
            onTap: () =>
                setState(() => selectedFrequency = tab['id'] as String),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color(0xFF1B8A6E)
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                tab['label'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? const Color(0xFF1B8A6E)
                      : Colors.grey[600],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSubscriptionCard(SubscriptionPlan plan) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubscriptionDetailPage(plan: plan),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
          children: [
            // Image with Popular Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    plan.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
                if (plan.isPopular)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B8A6E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'MOST POPULAR',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Frequency
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan.frequency,
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xFF1B8A6E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${plan.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B8A6E),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    '/delivery',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Delivery Time
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          plan.deliveryTime,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Includes
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Includes: ${plan.includes.join(', ')}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Subscribe Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B8A6E),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionDetailPage(plan: plan),
                          ),
                        );
                      },
                      child: const Text(
                        'Subscribe Now',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
