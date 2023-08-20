import 'package:flutter/material.dart';
import 'package:testingapp/product_model.dart';

class ProductProvider extends ChangeNotifier {
  Future<List<Product>?> productList;
  ProductProvider(this.productList);
}
