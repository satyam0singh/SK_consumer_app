import 'package:flutter/material.dart';
import 'subscription_plan.dart';

class SubscriptionDetailPage extends StatefulWidget {
  final SubscriptionPlan plan;

  const SubscriptionDetailPage({super.key, required this.plan});

  @override
  State<SubscriptionDetailPage> createState() =>
      _SubscriptionDetailPageState();
}

class _SubscriptionDetailPageState extends State<SubscriptionDetailPage> {
  String selectedFrequency = 'weekly';

  final List<Map<String, String>> items = [
    {
      "name": "Organic Potatoes",
      "qty": "1.5 kg • Fresh Harvest",
      "img": "assets/images/mountain_potato.png"
    },
    {
      "name": "Baby Carrots",
      "qty": "500g • Sweet & Crunchy",
      "img": "assets/images/carrots.svg"
    },
    {
      "name": "Fresh Spinach",
      "qty": "250g • Hydroponic",
      "img": "assets/images/kale.jpg"
    },
    {
      "name": "Tomatoes",
      "qty": "1 kg • Farm Fresh",
      "img": "assets/images/tomatoes.png"
    },
  ];

  final List<Map<String, String>> extras = [
    {"name": "Cherry Tomatoes", "price": "+₹99 • 250g"},
    {"name": "Organic Garlic", "price": "+₹49 • 3 bulbs"},
    {"name": "Red Bell Peppers", "price": "+₹89 • 2 pieces"},
    {"name": "Organic Broccoli", "price": "+₹129 • 500g"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      /// APP BAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          widget.plan.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.info_outline, color: Color(0xFF1B8A6E)),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 TOP BANNER
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image, size: 60),
                ),
                Positioned(
                  top: 12,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B8A6E),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "ORGANIC CERTIFIED",
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 DELIVERY FREQUENCY
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Delivery Frequency",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFreqBtn("Weekly", "weekly"),
                  const SizedBox(width: 12),
                  _buildFreqBtn("Bi-weekly", "biweekly"),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 ITEMS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "What's inside (4 items)",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "↔ Swap All",
                    style: TextStyle(color: Color(0xFF1B8A6E)),
                  )
                ],
              ),
            ),

            const SizedBox(height: 12),

            ...items.map((item) => _buildItemCard(item)).toList(),

            const SizedBox(height: 24),

            /// 🔹 EXTRAS
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Add Extras",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Customize your basket with seasonal favorites",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),

            const SizedBox(height: 12),

            ...extras.map((e) => _buildExtraCard(e)).toList(),

            const SizedBox(height: 24),

            /// 🔹 TOTAL
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ESTIMATED TOTAL",
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey[600])),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "₹25.00 / week",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B8A6E)),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text("4 Items Selected"),
                      )
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B8A6E),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "Subscribe Now →",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// 🔹 FREQUENCY BUTTON
  Widget _buildFreqBtn(String text, String value) {
    final selected = selectedFrequency == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFrequency = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color:
                selected ? const Color(0xFF1B8A6E) : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 ITEM CARD
  Widget _buildItemCard(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            color: Colors.grey[200],
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item["qty"]!,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: const Text("SWAP"),
          )
        ],
      ),
    );
  }

  /// 🔹 EXTRA CARD
  Widget _buildExtraCard(Map<String, String> extra) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            color: Colors.grey[200],
            child: const Icon(Icons.image),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(extra["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(extra["price"]!,
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1B8A6E),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
    );
  }
}