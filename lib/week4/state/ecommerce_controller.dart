import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../models/order_model.dart';

class EcommerceController extends ChangeNotifier {
  // User state
  bool _isLoggedIn = true;
  String _userEmail = 'customer@pulse.store';
  String _userName = 'Himanshu Raj';

  // Product catalog
  final List<Product> _products = [];

  // Cart
  final Map<String, CartItem> _cart = {};

  // Orders
  final List<OrderModel> _orders = [];

  // Wishlist
  final Set<String> _wishlistIds = {};

  EcommerceController() {
    _seedCatalog();
    _seedInitialOrder();
  }

  // Getters
  bool get isLoggedIn => _isLoggedIn;
  String get userEmail => _userEmail;
  String get userName => _userName;
  List<Product> get products => List.unmodifiable(_products);
  List<CartItem> get cartItems => _cart.values.toList();
  List<OrderModel> get orders => List.unmodifiable(_orders);
  Set<String> get wishlistIds => _wishlistIds;

  int get cartCount => _cart.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _cart.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get deliveryFee => subtotal > 1000 || subtotal == 0 ? 0.0 : 99.0;

  double get grandTotal => subtotal + deliveryFee;

  void _seedCatalog() {
    _products.addAll(const [
      Product(
        id: 'p1',
        title: 'Sony WH-1000XM5 Wireless Headphones',
        description:
            'Industry-leading active noise canceling with two processors, 8 microphones, and up to 30 hours of ultra-crisp audio playback.',
        price: 24990.0,
        originalPrice: 34990.0,
        rating: 4.8,
        reviewsCount: 1240,
        category: 'Audio',
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&q=80',
        features: ['Active Noise Canceling', '30hr Battery', 'Multipoint Connection', 'Hi-Res Audio'],
      ),
      Product(
        id: 'p2',
        title: 'Apple Watch Ultra 2 (GPS + Cellular)',
        description:
            'Rugged aerospace-grade titanium case with precision dual-frequency GPS, action button, and up to 36 hours of battery life.',
        price: 84900.0,
        originalPrice: 89900.0,
        rating: 4.9,
        reviewsCount: 890,
        category: 'Wearables',
        imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80',
        features: ['49mm Titanium Case', 'Dual GPS', '100m Water Resistant', 'Custom Action Button'],
      ),
      Product(
        id: 'p3',
        title: 'Mechanical Gaming Keyboard (RGB)',
        description:
            'Custom tactile hot-swappable mechanical switches, aircraft-grade aluminum top plate, and dynamic per-key RGB backlighting.',
        price: 4999.0,
        originalPrice: 7999.0,
        rating: 4.7,
        reviewsCount: 560,
        category: 'Accessories',
        imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500&q=80',
        features: ['Hot-Swappable Switches', 'RGB Backlight', 'Alloy Body', 'Braided Type-C Cable'],
      ),
      Product(
        id: 'p4',
        title: 'Dell UltraSharp 27" 4K USB-C Hub Monitor',
        description:
            'Brilliant 4K IPS display with 99% sRGB color gamut, 90W USB-C power delivery, and ultra-thin bezels.',
        price: 42999.0,
        originalPrice: 48999.0,
        rating: 4.8,
        reviewsCount: 310,
        category: 'Computing',
        imageUrl: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=500&q=80',
        features: ['4K UHD IPS', '90W Power Delivery', 'Factory Calibrated', 'Height-Adjustable Stand'],
      ),
      Product(
        id: 'p5',
        title: 'Ergonomic Vertical Wireless Mouse',
        description:
            'Designed to reduce forearm strain and wrist pressure with natural handshake grip and silent click dampening.',
        price: 2299.0,
        originalPrice: 3499.0,
        rating: 4.6,
        reviewsCount: 420,
        category: 'Accessories',
        imageUrl: 'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=500&q=80',
        features: ['57° Ergonomic Angle', 'Silent Clicks', 'Bluetooth & 2.4G', 'USB-C Rechargeable'],
      ),
      Product(
        id: 'p6',
        title: 'Nomad Rugged MagSafe Case',
        description:
            'Horween leather protective bumper with 10ft drop resistance and integrated neodymium MagSafe charging ring.',
        price: 3299.0,
        originalPrice: 4499.0,
        rating: 4.7,
        reviewsCount: 230,
        category: 'Wearables',
        imageUrl: 'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?w=500&q=80',
        features: ['Genuine Horween Leather', '10ft Drop Protection', 'MagSafe Compatible'],
      ),
    ]);
  }

  void _seedInitialOrder() {
    _orders.add(
      OrderModel(
        orderId: 'ORD-98241',
        items: [
          CartItem(product: _products[2], quantity: 1),
        ],
        totalAmount: 4999.0,
        deliveryAddress: 'Flat 402, Green Avenue, Bengaluru, Karnataka - 560100',
        paymentMethod: 'UPI (Google Pay)',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        status: OrderStatus.shipped,
      ),
    );
  }

  // Cart operations
  void addToCart(Product product, {int qty = 1}) {
    if (_cart.containsKey(product.id)) {
      _cart[product.id]!.quantity += qty;
    } else {
      _cart[product.id] = CartItem(product: product, quantity: qty);
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    if (_cart.containsKey(productId)) {
      _cart[productId]!.quantity += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    if (_cart.containsKey(productId)) {
      if (_cart[productId]!.quantity > 1) {
        _cart[productId]!.quantity -= 1;
      } else {
        _cart.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeFromCart(String productId) {
    _cart.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // Wishlist operations
  void toggleWishlist(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  bool isWishlisted(String productId) => _wishlistIds.contains(productId);

  // Checkout & Order creation
  OrderModel placeOrder({
    required String address,
    required String paymentMethod,
  }) {
    final newOrder = OrderModel(
      orderId: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      items: List.from(_cart.values),
      totalAmount: grandTotal,
      deliveryAddress: address,
      paymentMethod: paymentMethod,
      orderDate: DateTime.now(),
      status: OrderStatus.placed,
    );

    _orders.insert(0, newOrder);
    clearCart();
    notifyListeners();
    return newOrder;
  }

  // Auth operations
  void login({required String email, required String name}) {
    _isLoggedIn = true;
    _userEmail = email;
    _userName = name;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
