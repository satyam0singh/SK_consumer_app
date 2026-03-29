import 'package:flutter/material.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/models/cart_item_model.dart';

class SuggestedProduct {
  final String id;
  final String name;
  final String image;
  final double price;
  final String farmName;

  SuggestedProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.farmName,
  });
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartRepository _cartRepo = CartRepository();
  List<CartItemModel> cartItems = [];
  bool _isLoading = true;

  late List<SuggestedProduct> suggestedProducts;

  @override
  void initState() {
    super.initState();
    _initializeSuggested();
    _loadCart();
  }

  void _initializeSuggested() {
    suggestedProducts = [
      SuggestedProduct(
        id: 's1',
        name: 'Curly Kale',
        image: 'assets/images/kale.jpg',
        price: 3.20,
        farmName: 'Green Acres Organics',
      ),
      SuggestedProduct(
        id: 's2',
        name: 'Cucumbers',
        image: 'assets/images/cucumbers.jpg',
        price: 1.50,
        farmName: 'Green Acres Organics',
      ),
      SuggestedProduct(
        id: 's3',
        name: 'Fresh',
        image: 'assets/images/fresh.jpg',
        price: 2.00,
        farmName: 'Green Acres Organics',
      ),
      SuggestedProduct(
        id: 's4',
        name: 'Sunflower Seeds',
        image: 'assets/images/sunflower.jpg',
        price: 4.50,
        farmName: 'Sunrise Harvests',
      ),
      SuggestedProduct(
        id: 's5',
        name: 'Farm Fresh Eggs',
        image: 'assets/images/eggs.jpg',
        price: 5.00,
        farmName: 'Sunrise Harvests',
      ),
    ];
  }

  Future<void> _loadCart() async {
    try {
      final items = await _cartRepo.getCart();
      if (mounted) {
        setState(() {
          cartItems = items;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get deliveryFee => 2.50;
  double get farmServiceFee => 1.00;
  double get savingsAmount => 2.00; // Example savings
  double get total => subtotal + deliveryFee + farmServiceFee;

  void updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      setState(() => cartItems[index].quantity = newQuantity);
    }
  }

  void removeItem(int index) {
    setState(() => cartItems.removeAt(index));
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
          'Smart Cart',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart items grouped by farm
                  ..._buildCartGroups(),

                  const SizedBox(height: 24),

                  // Suggested products
                  if (suggestedProducts.isNotEmpty) ...[
                    _buildSuggestedSection(),
                    const SizedBox(height: 24),
                  ],

                  // Order summary
                  _buildOrderSummary(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  List<Widget> _buildCartGroups() {
    final groupedByFarm = <String, List<CartItemModel>>{};
    for (var item in cartItems) {
      groupedByFarm.putIfAbsent(item.farmName, () => []).add(item);
    }

    return groupedByFarm.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.storefront_outlined,
                  size: 20,
                  color: Color(0xFF1B8A6E),
                ),
                const SizedBox(width: 8),
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...entry.value.asMap().entries.map((itemEntry) {
              final index = cartItems.indexOf(itemEntry.value);
              return _buildCartItemCard(itemEntry.value, index);
            }),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildCartItemCard(CartItemModel item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
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
          // Product image
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
                item.imageUrl.isNotEmpty ? item.imageUrl : 'assets/images/placeholder.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 40, color: Colors.grey[400]);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.price.toStringAsFixed(2)} / ${item.unit}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          // Quantity selector
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, size: 18),
                    onPressed: () => updateQuantity(index, item.quantity - 1),
                    constraints: BoxConstraints.tight(const Size(24, 24)),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () => updateQuantity(index, item.quantity + 1),
                    constraints: BoxConstraints.tight(const Size(24, 24)),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '₹${item.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),

          // Remove button
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            onPressed: () => removeItem(index),
            constraints: BoxConstraints.tight(const Size(24, 24)),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'SUGGESTED FROM ${cartItems.isNotEmpty ? cartItems[0].farmName.toUpperCase() : "STORES"}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 150, // ⬅️ slightly increased to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: suggestedProducts.length,
            itemBuilder: (context, index) {
              final product = suggestedProducts[index];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SizedBox(
                  width: 110, // ⬅️ fixed width constraint
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.image,
                                size: 36,
                                color: Colors.grey[400],
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(), // ✅ FIX: distributes space safely

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B8A6E),
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1B8A6E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
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
                _buildSummaryRow(
                  'Subtotal (${cartItems.length} items)',
                  '₹${subtotal.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 12),
                _buildSummaryRow(
                  'Delivery Fee',
                  '₹${deliveryFee.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 12),
                _buildSummaryRow(
                  'Farm Service Fee',
                  '₹${farmServiceFee.toStringAsFixed(2)}',
                ),
                const Divider(height: 20),
                _buildSummaryRow(
                  'Total',
                  '₹${total.toStringAsFixed(2)}',
                  isTotal: true,
                ),
              ],
            ),
          ),

          // Savings banner
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.local_offer, size: 18, color: Colors.green[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You\'re saving ₹${savingsAmount.toStringAsFixed(2)} on this order with farm-direct pricing!',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Checkout button
          SizedBox(
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
                Navigator.pushNamed(context, '/checkout');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 14 : 12,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.grey[700],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 12,
            fontWeight: FontWeight.bold,
            color: isTotal ? const Color(0xFF1B8A6E) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
