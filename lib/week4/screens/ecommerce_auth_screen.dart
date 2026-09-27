import 'package:flutter/material.dart';
import '../state/ecommerce_controller.dart';

class EcommerceAuthScreen extends StatelessWidget {
  final EcommerceController controller;
  final VoidCallback onViewOrders;

  const EcommerceAuthScreen({
    super.key,
    required this.controller,
    required this.onViewOrders,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: colorScheme.primaryContainer,
                        foregroundColor: colorScheme.onPrimaryContainer,
                        child: Text(
                          controller.userName.isNotEmpty ? controller.userName[0].toUpperCase() : 'U',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        controller.userName,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        controller.userEmail,
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),

                      const SizedBox(height: 12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified_user_rounded, size: 14, color: Colors.green),
                            SizedBox(width: 4),
                            Text(
                              'Firebase Authenticated Customer',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(height: 36),

                      // Quick Action Tiles
                      ListTile(
                        leading: const Icon(Icons.receipt_long_rounded),
                        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${controller.orders.length} orders placed'),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: onViewOrders,
                      ),

                      const Divider(height: 12),

                      ListTile(
                        leading: const Icon(Icons.favorite_rounded, color: Colors.red),
                        title: const Text('Wishlist Items', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${controller.wishlistIds.length} saved products'),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${controller.wishlistIds.length} items currently in wishlist.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),

                      const Divider(height: 12),

                      ListTile(
                        leading: const Icon(Icons.location_on_outlined),
                        title: const Text('Shipping Addresses', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('1 saved address (Bengaluru)'),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: () {},
                      ),

                      const Divider(height: 12),

                      ListTile(
                        leading: const Icon(Icons.security_rounded),
                        title: const Text('Security & Privacy', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Firebase Cloud authentication active'),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                        onTap: () {},
                      ),

                      const SizedBox(height: 24),

                      OutlinedButton.icon(
                        onPressed: () {
                          controller.logout();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Session reset. Re-authenticate anytime.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text('Sign Out'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 44),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
