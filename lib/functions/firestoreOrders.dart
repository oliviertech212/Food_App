import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/models/cart.model.dart';

Future<void> createOrder(List<CartItem> cartItems) async {
  FirebaseFirestore.instance.collection("wedeliver");
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final orderData = {
    'userId': userId,
    'products': cartItems
        // .map((item) => {'productId': item.productId, 'quantity': item.quantity})
        .toList(),
    // 'totalPrice': total,
    'timestamp': Timestamp.now(),
    'status': 'placed', // Initial status
  };

  await FirebaseFirestore.instance
      .collection('orders')
      .add(orderData)
      .then((value) => print("order created"))
      .catchError((error) => print("Failed to add order: $error"));
  ;
}

Future<dynamic> getOrders() {
  CollectionReference orders =
      FirebaseFirestore.instance.collection('wedeliver');

  return orders.get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((doc) {
      print("orders $doc");
      print('${doc.id} => ${doc.data()}');
      return;
    });
  }).catchError((error) => print("Failed to fetch orders: $error"));
}
