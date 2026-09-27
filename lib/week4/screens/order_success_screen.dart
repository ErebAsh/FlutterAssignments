import 'package:flutter/material.dart';
import '../models/order_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onViewOrders;
  final VoidCallback onContinueShopping;

  const OrderSuccessScreen({
    super.key,
    required this.order,
    required this.onViewOrders,
    required this.onContinueShopping,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Placed'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Success Checkmark
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 72,
                        color: Colors.green.shade600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Payment & Order Successful!',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Thank you for your purchase. We are preparing your order.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),

                    const SizedBox(height: 24),

                    // Order Details Box
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow('Order ID', order.orderId),
                          const Divider(height: 18),
                          _buildDetailRow('Total Paid', '₹${order.totalAmount.toStringAsFixed(2)}'),
                          const Divider(height: 18),
                          _buildDetailRow('Payment Mode', order.paymentMethod),
                          const Divider(height: 18),
                          _buildDetailRow('Est. Delivery', '2-3 Business Days'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    FilledButton.icon(
                      onPressed: onViewOrders,
                      icon: const Icon(Icons.receipt_long_rounded),
                      label: const Text('View in My Orders'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                    ),

                    const SizedBox(height: 12),

                    OutlinedButton(
                      onPressed: onContinueShopping,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Continue Shopping'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}
