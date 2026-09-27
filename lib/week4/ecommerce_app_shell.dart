import 'package:flutter/material.dart';
import 'state/ecommerce_controller.dart';
import 'screens/product_catalog_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_history_screen.dart';
import 'screens/ecommerce_auth_screen.dart';

/// Week 4 Capstone Project: Production-Ready E-Commerce App
/// Features:
/// - Firebase Backend Integration & Auth
/// - Dynamic Product Catalog & Search
/// - Reactive Cart Management with Badges
/// - Mock Payment & Checkout (UPI, Card, COD)
/// - Real-time Orders Tracking Timeline
class EcommerceAppShell extends StatefulWidget {
  const EcommerceAppShell({super.key});

  @override
  State<EcommerceAppShell> createState() => _EcommerceAppShellState();
}

class _EcommerceAppShellState extends State<EcommerceAppShell> {
  late final EcommerceController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = EcommerceController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final screens = [
          ProductCatalogScreen(
            controller: _controller,
            onGoToCart: () => _switchTab(1),
          ),
          CartScreen(
            controller: _controller,
            onStartShopping: () => _switchTab(0),
            onViewOrders: () => _switchTab(2),
          ),
          OrderHistoryScreen(
            controller: _controller,
            onStartShopping: () => _switchTab(0),
          ),
          EcommerceAuthScreen(
            controller: _controller,
            onViewOrders: () => _switchTab(2),
          ),
        ];

        return Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: screens[_currentIndex],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: _switchTab,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront_rounded),
                label: 'Shop',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: _controller.cartCount > 0,
                  label: Text('${_controller.cartCount}'),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
                selectedIcon: Badge(
                  isLabelVisible: _controller.cartCount > 0,
                  label: Text('${_controller.cartCount}'),
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
                label: 'Cart',
              ),
              const NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long_rounded),
                label: 'Orders',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded),
                label: 'Account',
              ),
            ],
          ),
        );
      },
    );
  }
}
