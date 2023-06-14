import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _cartItems = {};

  Map<int, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get itemCount {
    return cartItems.length;
  }

  double get totalAmount {
    double result = 0.0;
    _cartItems.forEach((key, value) {
      result += (value.price * value.quantity);
    });
    return result;
  }

  void addItem(int productId, String title, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(int id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            quantity: value.quantity - 1,
            price: value.price),
      );
      notifyListeners();
    } else {
      _cartItems.remove(productId);
      notifyListeners();
    }
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
