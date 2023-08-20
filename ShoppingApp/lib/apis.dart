// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testingapp/product_model.dart';

class APIs {
  static Future<List<Product>?> getProducts() async {
    final response =
        await http.get(Uri.parse("https://api.escuelajs.co/api/v1/products/"));

    List<Map<String, dynamic>> jsonList = [];
    for (int i = 0; i < 100; i++) {
      jsonList.add(jsonDecode(response.body)[i]);
    }

    try {
      return Product.getProductList(jsonList);
    } catch (e) {
      return null;
    }
  }
}
