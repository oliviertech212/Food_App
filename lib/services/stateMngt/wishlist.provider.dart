import "package:flutter/material.dart";
import "package:foodapp/models/products.model.dart";
import 'package:provider/provider.dart';




class WishlistProvider extends ChangeNotifier {
  List<Product> _items = [];
    int get totalPrice => _items.length * 42;
  get items => _items.length;
  get allItems => _items;

  List<Product> get wishlist => _items;

  void addProduct(Product item) {
    _items.add(item);
    notifyListeners();
  }

  void removeProduct(Product item) {
    _items.remove(item);
    notifyListeners();
  }
}
