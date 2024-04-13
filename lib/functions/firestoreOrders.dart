import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/cart.model.dart';
import 'package:foodapp/models/order.model.dart';
import 'package:uuid/uuid.dart';

Future<void> createOrder(List<CartItem> cartItems) async {
  FirebaseFirestore.instance.collection("wedeliver");
  final userId = FirebaseAuth.instance.currentUser!.uid;

  // var cartData = context.watch<CartProvider>();
  // int totalQuantity = cartData.items;
  // int totalPrice = cartData.totalPrice;
  // List<CartItem> allItems = cartData.allItems;

  final orderData = {
    'userId': userId,
    'orderId': Uuid().v4(),
    'products': cartItems
        .map((item) => {
              'productId': item.id,
              'quantity': item.quantity,
              'Pname': item.name,
              'price': int.parse(item.price),
            })
        .toList(),
    'timestamp': Timestamp.now(),
    'status': 1
  };

  print("orderData $orderData");

  await FirebaseFirestore.instance
      .collection('wedeliver')
      .add(orderData)
      .then((value) => print("order created"))
      .catchError((error) => print("Failed to add order: $error"));
  ;
}

Future<List<Orders>> getOrders() async {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final orders = await FirebaseFirestore.instance
      .collection('wedeliver')
      .where('userId', isEqualTo: userId)
      .get();

  return orders.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;

    print("data $data");

    return Orders(
      orderId: data['orderId'],
      userId: data['userId'],
      products: (data['products'] as List)
          .map((item) => OrderItem(
                productId: item['productId'],
                pname: item['Pname'],
                quantity: item['quantity'],
                price: item['price'],
              ))
          .toList(),
      createdAt: data['timestamp'],
      status: data['status'], // This should now work
    );
  }).toList();
}
