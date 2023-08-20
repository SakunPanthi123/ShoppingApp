// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:testingapp/product_model.dart';

class Deliveries extends ChangeNotifier {
  List<Product> _deliveries = [];

  List<Product> get getDeliveries => _deliveries;

  void addToDelivery(Product product) {
    _deliveries.add(product);
    notifyListeners();
  }

  void addListToDelivery(List<Product> products) {
    _deliveries.addAll(products);
  }

  void removeFromDelivery(Product product) {
    _deliveries.remove(product);
    notifyListeners();
  }
}
