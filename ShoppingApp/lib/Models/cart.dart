// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:testingapp/Models/product_model.dart';

class Cart extends ChangeNotifier {
  List<Product> _cartList = [];

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartList.remove(product);
    notifyListeners();
  }

  bool isEmpty() {
    if (_cartList.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  List<Product> get getCartList => _cartList;

  set clearCart(int a) {
    _cartList = [];
    notifyListeners();
  }
}
