import 'package:flutter/material.dart';
import 'package:sell_right/helpers/custom_trace.dart';

class ProductModelProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  ProductModelProvider({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void changeFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
