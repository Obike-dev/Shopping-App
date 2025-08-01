import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addProduct({required Map<String, dynamic> product}) {
    cart.add(product);
    notifyListeners();
  }

  void removeProduct({required Map<String, dynamic> product}) {
    cart.remove(product);
    notifyListeners();
  }
}
