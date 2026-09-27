import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../state/ecommerce_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  final EcommerceController controller;
  final VoidCallback onStartShopping;

  const OrderHistoryScreen({
    super.key,
    required this.controller,
    required this.onStartShopping,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final orders = controller.orders;

        if (orders.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Orders Placed Yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'When you purchase items, their live delivery status will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: onStartShopping,
                    icon: const Icon(Icons.shopping_bag_rounded),
                    label: const Text('Start Shopping'),
                  ),
                ],
              ),
            ),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: orders.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderId,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  'Placed on ${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                                  style: TextStyle(fontSize: 12, color: colorScheme.outline),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order.status).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _getStatusIcon(order.status),
                                    size: 14,
                                    color: _getStatusColor(order.status),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    order.statusDisplay,
                                    style: TextStyle(
                                      color: _getStatusColor(order.status),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const Divider(height: 24),

                        // Delivery Tracking Timeline
                        _buildTrackingTimeline(context, order.status),

                        const SizedBox(height: 16),

                        // Items list
                        ...order.items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 44,
                                    height: 44,
                                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                                    child: Image.network(
                                      item.product.imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.devices_rounded, size: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                                      ),
                                      Text(
                                        'Qty: ${item.quantity} • ₹${item.product.price.toStringAsFixed(0)} each',
                                        style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '₹${item.totalPrice.toStringAsFixed(0)}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                              ],
                            ),
                          );
                        }),

                        const Divider(height: 20),

                        // Address & Payment
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment: ${order.paymentMethod}',
                              style: TextStyle(fontSize: 12, color: colorScheme.outline),
                            ),
                            Text(
                              'Total: ₹${order.totalAmount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: colorScheme.primary,
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
        );
      },
    );
  }

  Widget _buildTrackingTimeline(BuildContext context, OrderStatus currentStatus) {
    final steps = ['Placed', 'Confirmed', 'Out for Delivery', 'Delivered'];
    final activeIndex = currentStatus.index;

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          final stepIndex = index ~/ 2;
          final isDone = stepIndex < activeIndex;
          return Expanded(
            child: Container(
              height: 3,
              color: isDone ? Colors.green : Colors.grey.shade300,
            ),
          );
        } else {
          final stepIndex = index ~/ 2;
          final isDone = stepIndex <= activeIndex;
          return CircleAvatar(
            radius: 8,
            backgroundColor: isDone ? Colors.green : Colors.grey.shade300,
            child: isDone
                ? const Icon(Icons.check, size: 10, color: Colors.white)
                : null,
          );
        }
      }),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return Colors.blue;
      case OrderStatus.confirmed:
        return Colors.purple;
      case OrderStatus.shipped:
        return Colors.orange.shade800;
      case OrderStatus.delivered:
        return Colors.green;
    }
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return Icons.shopping_bag_outlined;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline_rounded;
      case OrderStatus.shipped:
        return Icons.local_shipping_rounded;
      case OrderStatus.delivered:
        return Icons.done_all_rounded;
    }
  }
}
