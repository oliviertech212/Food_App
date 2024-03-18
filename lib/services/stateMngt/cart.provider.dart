import "package:flutter/material.dart";
import "package:foodapp/models/products.model.dart";
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Product> _items = [];

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;
  get items => _items.length;
  get allItems => _items;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the

  void remove(Product item) {
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void add(Product item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
