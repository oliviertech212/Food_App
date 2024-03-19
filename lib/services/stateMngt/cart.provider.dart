import "package:flutter/material.dart";
import "package:foodapp/models/cart.model.dart";
import "package:foodapp/models/products.model.dart";
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<CartItem> _items = [];
  final List<Product> _products = [];

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;
  int get items => _items.fold(0, (value, element) => value + element.quantity);
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

  int totalSimilarItems(int id) {
    int total = 0;
    for (var item in _items) {
      if (item.id == id) {
        total += item.quantity;
      }
    }
    return total;
  }

  void increaseQuantity(int index) {
    _items[index].quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity -= 1;
    } else {
      removeAt(index);
    }
    notifyListeners();
  }

  void add(Product item) {
    int index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(
        id: item.id,
        name: item.name,
        price: item.price,
        image: item.image,
        quantity: 1,
      ));
    }
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
