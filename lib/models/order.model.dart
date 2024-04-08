import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String orderId;
  final String userId;
  final List<OrderItem> products;
  final Timestamp createdAt;
  final DocumentReference status;

  Orders({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.createdAt,
    required this.status,
  });

  double get total {
    return products.fold(
        0, (total, current) => total + current.price * current.quantity);
  }
}

class OrderItem {
  final String productId;
  final String pname;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.pname,
    required this.quantity,
    required this.price,
  });
}
