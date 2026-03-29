import 'package:flutter/material.dart';

class VerifiedPage extends StatelessWidget {
  final String productName;
  final String farmName;
  final String image;
  final String waterSaved;
  final String carbonImpact;

  const VerifiedPage({
    super.key,
    required this.productName,
    required this.farmName,
    required this.image,
    required this.waterSaved,
    required this.carbonImpact,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F1),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Quality Verified"),
        leading: const BackButton(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ✅ VERIFIED ICON
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Color(0xFF1B8A6E),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 16),

            const Text(
              "Verified Authentic",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "This product has been cryptographically secured and verified.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            /// PRODUCT CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset(image, height: 80),

                  const SizedBox(height: 10),

                  Text(
                    productName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  Text(farmName),

                  const SizedBox(height: 20),

                  /// TIMELINE
                  Column(
                    children: const [
                      _TimelineTile("Harvested", "Oct 24"),
                      _TimelineTile("Packed", "Oct 25"),
                      _TimelineTile("Shipped", "Oct 26"),
                      _TimelineTile("Verified", "Today"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🌱 SUSTAINABILITY
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text("Sustainability Impact",
                      style: TextStyle(color: Colors.white)),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Water Saved",
                          style: TextStyle(color: Colors.white)),
                      Text(waterSaved,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Carbon Footprint",
                          style: TextStyle(color: Colors.white)),
                      Text(carbonImpact,
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 135, 178, 167),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("View Farm Profile"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            )
          ],
        ),
      ),
    );
  }
}

/// TIMELINE TILE
class _TimelineTile extends StatelessWidget {
  final String title;
  final String date;

  const _TimelineTile(this.title, this.date);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 10, color: Colors.green),
        const SizedBox(width: 10),
        Expanded(child: Text(title)),
        Text(date),
      ],
    );
  }
}