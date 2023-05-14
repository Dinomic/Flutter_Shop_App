import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
