// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/deliveries.dart';
import 'package:testingapp/home_page.dart';
import 'package:testingapp/product_model.dart';
import 'package:testingapp/product_provider.dart';

import 'apis.dart';
import 'cart.dart';
import 'cart_page.dart';
import 'delivery_page.dart';

void main() {
  Future<List<Product>?> productsList = APIs.getProducts();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Cart(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(productsList),
      ),
      ChangeNotifierProvider(
        create: (context) => Deliveries(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List screens = [HomePage(), CartPage(), DeliveryPage()];
  var index = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle_rounded),
              label: 'Deliveries',
            )
          ],
        ),
      ),
    );
  }
}
