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
  final Map<int, CartItem> _cartItems = {};

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
}