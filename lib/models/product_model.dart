import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  int id;
  String title;
  String description;
  double price;
  String imageUrl;
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

  get getId => id;

  set setId(id) => this.id = id;

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getDescription => description;

  set setDescription(description) => this.description = description;

  get getPrice => price;

  set setPrice(price) => this.price = price;

  get getImageUrl => imageUrl;

  set setImageUrl(imageUrl) => this.imageUrl = imageUrl;
}
