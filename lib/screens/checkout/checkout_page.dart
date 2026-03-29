import 'package:flutter/material.dart';

class DeliveryAddress {
  final String id;
  final String label;
  final String address;

  DeliveryAddress({
    required this.id,
    required this.label,
    required this.address,
  });
}

class DeliveryTimeSlot {
  final String id;
  final String label;
  final String description;
  final String time;

  DeliveryTimeSlot({
    required this.id,
    required this.label,
    required this.description,
    required this.time,
  });
}

class PaymentMethod {
  final String id;
  final String name;
  final String displayName;
  final IconData icon;
  final String? balance;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.displayName,
    required this.icon,
    this.balance,
  });
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late String selectedAddress;
  late String selectedTimeSlot;
  late String selectedPaymentMethod;
  late List<DeliveryAddress> addresses;
  late List<DeliveryTimeSlot> timeSlots;
  late List<PaymentMethod> paymentMethods;

  // Order summary values
  final double subtotal = 1240.00;
  final double deliveryFee = 45.00;
  final double farmServiceFee = 20.00;

  @override
  void initState() {
    super.initState();
    _initializeCheckoutData();
  }

  void _initializeCheckoutData() {
    addresses = [
      DeliveryAddress(
        id: 'home',
        label: 'Home',
        address: '123 Agriculture Lane, Rural District, State - 123456',
      ),
    ];

    timeSlots = [
      DeliveryTimeSlot(
        id: 'morning',
        label: 'Morning (6 AM - 11 AM)',
        description: 'Fresh harvest delivery',
        time: '6 AM - 11 AM',
      ),
      DeliveryTimeSlot(
        id: 'evening',
        label: 'Evening (4 PM - 9 PM)',
        description: 'Convenient end-of-day',
        time: '4 PM - 9 PM',
      ),
      DeliveryTimeSlot(
        id: 'anytime',
        label: 'Anytime (8 AM - 8 PM)',
        description: 'Most flexible option',
        time: '8 AM - 8 PM',
      ),
    ];

    paymentMethods = [
      PaymentMethod(
        id: 'upi',
        name: 'UPI (GPay/PhonePe)',
        displayName: 'UPI (GPay/PhonePe)',
        icon: Icons.payment,
      ),
      PaymentMethod(
        id: 'cod',
        name: 'Cash on Delivery',
        displayName: 'Cash on Delivery',
        icon: Icons.local_atm,
      ),
      PaymentMethod(
        id: 'wallet',
        name: 'SmartKrishi Wallet',
        displayName: 'SmartKrishi Wallet',
        icon: Icons.account_balance_wallet,
        balance: '₹450.00',
      ),
    ];

    selectedAddress = addresses[0].id;
    selectedTimeSlot = timeSlots[0].id;
    selectedPaymentMethod = paymentMethods[0].id;
  }

  double get totalAmount => subtotal + deliveryFee + farmServiceFee;

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
          'Checkout',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            _buildDeliveryAddressSection(),

            const SizedBox(height: 24),

            // Delivery Time Slot
            _buildDeliveryTimeSlotSection(),

            const SizedBox(height: 24),

            // Payment Method
            _buildPaymentMethodSection(),

            const SizedBox(height: 24),

            // Order Summary
            _buildOrderSummarySection(),

            const SizedBox(height: 24),

            // Place Order Button
            _buildPlaceOrderSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryAddressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.home,
                    color: Color(0xFF1B8A6E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        addresses[0].address,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Change',
                    style: TextStyle(
                      color: Color(0xFF1B8A6E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryTimeSlotSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Delivery Time Slot',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...timeSlots.map((slot) {
            return GestureDetector(
              onTap: () {
                setState(() => selectedTimeSlot = slot.id);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: selectedTimeSlot == slot.id
                        ? const Color(0xFF1B8A6E)
                        : Colors.transparent,
                    width: 2,
                  ),
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
                    Radio<String>(
                      value: slot.id,
                      groupValue: selectedTimeSlot,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedTimeSlot = value);
                        }
                      },
                      activeColor: const Color(0xFF1B8A6E),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slot.label,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            slot.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) {
            return GestureDetector(
              onTap: () {
                setState(() => selectedPaymentMethod = method.id);
              },
              child: Container(
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
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: selectedPaymentMethod == method.id
                            ? const Color(0xFF1B8A6E)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        method.icon,
                        color: selectedPaymentMethod == method.id
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            method.displayName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (method.balance != null)
                            Text(
                              method.balance!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF1B8A6E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildOrderSummarySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
                _buildSummaryRow('Subtotal', '₹${subtotal.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                _buildSummaryRow(
                    'Delivery Fee', '₹${deliveryFee.toStringAsFixed(2)}'),
                const SizedBox(height: 12),
                _buildSummaryRow('Farm Service Fee',
                    '₹${farmServiceFee.toStringAsFixed(2)}'),
                const Divider(height: 20),
                _buildSummaryRow('Total Amount',
                    '₹${totalAmount.toStringAsFixed(2)}',
                    isTotal: true),
              ],
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

  Widget _buildPlaceOrderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grand Total',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    '₹${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
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
                          content: Text('Order placed successfully!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
