import 'package:flutter/material.dart';

class TrackingStep {
  final String title;
  final String description;
  final String time;
  final bool isCompleted;
  final bool isCurrent;
  final String? additionalInfo;

  TrackingStep({
    required this.title,
    required this.description,
    required this.time,
    required this.isCompleted,
    required this.isCurrent,
    this.additionalInfo,
  });
}

class TrackOrderPage extends StatefulWidget {
  final String orderNumber;
  final String arrivalTime;
  final String productImage;

  const TrackOrderPage({
    super.key,
    this.orderNumber = 'SK-88219',
    this.arrivalTime = '2:30 PM Today',
    this.productImage = 'assets/images/tomatoes.jpg',
  });

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  late List<TrackingStep> steps;

  @override
  void initState() {
    super.initState();
    _initializeSteps();
  }

  void _initializeSteps() {
    steps = [
      TrackingStep(
        title: 'Harvested',
        description: 'Fresh from SmartFarm, Bhaktapur',
        time: '06:45 AM',
        isCompleted: true,
        isCurrent: false,
      ),
      TrackingStep(
        title: 'Packed',
        description: 'Eco-friendly packaging confirmed',
        time: '08:20 AM',
        isCompleted: true,
        isCurrent: false,
      ),
      TrackingStep(
        title: 'In Transit',
        description: 'On the way to distribution center',
        time: 'Currently at Sitapaila',
        isCompleted: false,
        isCurrent: true,
        additionalInfo: 'Live: 4.2 km away',
      ),
      TrackingStep(
        title: 'Out for Delivery',
        description: 'Driver: Rabin K. (+977 980...)',
        time: '',
        isCompleted: false,
        isCurrent: false,
      ),
      TrackingStep(
        title: 'Delivered',
        description: 'Safe arrival at your doorstep',
        time: '',
        isCompleted: false,
        isCurrent: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
          'Track Order',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Help',
              style: TextStyle(
                color: Color(0xFF1B8A6E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Section
            _buildOrderInfoSection(),

            const SizedBox(height: 20),

            // Map Section (Placeholder)
            _buildMapSection(),

            const SizedBox(height: 24),

            // Delivery Progress Section
            _buildDeliveryProgressSection(),

            const SizedBox(height: 24),

            // Contact Support Button
            _buildContactSupportButton(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.productImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 40, color: Colors.grey[400]);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ORDER ID',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${widget.orderNumber}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: const Color(0xFF1B8A6E),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Arriving by ${widget.arrivalTime}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 240,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Stack(
        children: [
          // Map Placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 48,
                  color: const Color(0xFF1B8A6E),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Kathmandu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Live: 4.2 km away',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Route Line (simplified)
          Positioned(
            left: 20,
            top: 20,
            child: Icon(
              Icons.location_on_outlined,
              size: 24,
              color: Colors.green[700],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Icon(
              Icons.place,
              size: 24,
              color: const Color(0xFF1B8A6E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DELIVERY PROGRESS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          ...steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isLast = index == steps.length - 1;

            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline Circle
                    Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: step.isCompleted
                                ? const Color(0xFF1B8A6E)
                                : step.isCurrent
                                    ? const Color(0xFF1B8A6E).withOpacity(0.5)
                                    : Colors.grey[300],
                          ),
                          child: Icon(
                            step.isCompleted
                                ? Icons.check
                                : step.isCurrent
                                    ? Icons.circle
                                    : Icons.circle_outlined,
                            color: step.isCompleted || step.isCurrent
                                ? Colors.white
                                : Colors.grey[400],
                            size: 20,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 60,
                            color: step.isCompleted
                                ? const Color(0xFF1B8A6E)
                                : Colors.grey[300],
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    // Step Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: step.isCurrent
                                    ? const Color(0xFF1B8A6E)
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              step.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            if (step.time.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                step.time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                            if (step.additionalInfo != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                step.additionalInfo!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1B8A6E),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildContactSupportButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1B8A6E),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Contacting support...'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Contact Support',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
