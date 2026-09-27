import 'package:flutter/material.dart';
import '../state/ecommerce_controller.dart';
import 'order_success_screen.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  final EcommerceController controller;
  final VoidCallback onViewOrders;
  final VoidCallback onContinueShopping;

  const CheckoutPaymentScreen({
    super.key,
    required this.controller,
    required this.onViewOrders,
    required this.onContinueShopping,
  });

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  final _addressController = TextEditingController(
    text: 'Flat 402, Green Avenue, Bengaluru, Karnataka - 560100',
  );
  String _selectedPaymentMethod = 'UPI (Google Pay)';
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentOptions = [
    {
      'title': 'UPI (Google Pay, PhonePe, Paytm)',
      'subtitle': 'Fastest instant checkout via UPI ID / QR',
      'icon': Icons.qr_code_2_rounded,
      'color': Colors.deepPurple,
    },
    {
      'title': 'Credit / Debit Card',
      'subtitle': 'Visa, MasterCard, RuPay, Amex',
      'icon': Icons.credit_card_rounded,
      'color': Colors.blue,
    },
    {
      'title': 'Net Banking',
      'subtitle': 'All major Indian & international banks',
      'icon': Icons.account_balance_rounded,
      'color': Colors.teal,
    },
    {
      'title': 'Cash on Delivery (COD)',
      'subtitle': 'Pay cash or UPI upon delivery',
      'icon': Icons.local_atm_rounded,
      'color': Colors.green,
    },
  ];

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    final address = _addressController.text.trim();
    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a delivery address'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate payment gateway processing
    await Future.delayed(const Duration(milliseconds: 1000));

    if (!mounted) return;

    final order = widget.controller.placeOrder(
      address: address,
      paymentMethod: _selectedPaymentMethod,
    );

    setState(() {
      _isProcessing = false;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(
          order: order,
          onViewOrders: () {
            Navigator.pop(context);
            widget.onViewOrders();
          },
          onContinueShopping: () {
            Navigator.pop(context);
            widget.onContinueShopping();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final total = widget.controller.grandTotal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout & Payment'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Delivery Address Card
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, color: colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Delivery Address',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _addressController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Enter complete flat, street, city, pincode...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 2. Payment Method Card
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.payment_rounded, color: colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Payment Method (Mock Gateway)',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ..._paymentOptions.map((opt) {
                          final title = opt['title'] as String;
                          final isSelected = _selectedPaymentMethod == title;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.outlineVariant.withValues(alpha: 0.5),
                                width: isSelected ? 2 : 1,
                              ),
                              color: isSelected
                                  ? colorScheme.primaryContainer.withValues(alpha: 0.2)
                                  : null,
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                setState(() => _selectedPaymentMethod = title);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundColor: (opt['color'] as Color).withValues(alpha: 0.15),
                                      foregroundColor: opt['color'] as Color,
                                      child: Icon(opt['icon'] as IconData, size: 20),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                          const SizedBox(height: 2),
                                          Text(opt['subtitle'] as String, style: const TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked_rounded
                                          : Icons.radio_button_unchecked_rounded,
                                      color: isSelected ? colorScheme.primary : colorScheme.outline,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 3. Price Summary
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildSummaryLine('Subtotal', '₹${widget.controller.subtotal.toStringAsFixed(2)}'),
                        const SizedBox(height: 8),
                        _buildSummaryLine(
                          'Delivery Fee',
                          widget.controller.deliveryFee == 0
                              ? 'FREE'
                              : '₹${widget.controller.deliveryFee.toStringAsFixed(2)}',
                        ),
                        const Divider(height: 24),
                        _buildSummaryLine(
                          'Amount to Pay',
                          '₹${total.toStringAsFixed(2)}',
                          isBold: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Pay Now Button
                FilledButton(
                  onPressed: _isProcessing ? null : _processPayment,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          'Pay ₹${total.toStringAsFixed(0)} & Confirm Order',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryLine(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    );
  }
}
