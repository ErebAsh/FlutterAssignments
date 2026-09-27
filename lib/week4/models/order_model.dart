import 'cart_item.dart';

enum OrderStatus {
  placed,
  confirmed,
  shipped,
  delivered,
}

class OrderModel {
  final String orderId;
  final List<CartItem> items;
  final double totalAmount;
  final String deliveryAddress;
  final String paymentMethod;
  final DateTime orderDate;
  final OrderStatus status;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.orderDate,
    this.status = OrderStatus.placed,
  });

  String get statusDisplay {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.shipped:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }
}
