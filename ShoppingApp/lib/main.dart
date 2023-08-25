// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Models/deliveries.dart';
import 'package:testingapp/Models/theme_provider.dart';

import 'package:testingapp/Pages/home_page.dart';
import 'package:testingapp/Models/product_model.dart';
import 'package:testingapp/Models/product_provider.dart';
import 'API/apis.dart';
import 'Models/cart.dart';
import 'Pages/cart_page.dart';
import 'Pages/delivery_page.dart';

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
      ChangeNotifierProvider(
        create: (context) => AppColors(),
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
    AppColors AppColor = Provider.of<AppColors>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: AppColor.getColors[1],
          ),
          bodyMedium: TextStyle(
            color: AppColor.getColors[1],
          ),
          bodySmall: TextStyle(
            color: AppColor.getColors[1],
          ),
          labelMedium: TextStyle(
            color: Colors.white,
          ),
        ),
        primarySwatch: Colors.grey,
        buttonTheme: ButtonThemeData(
          buttonColor: AppColor.getColors[1],
          textTheme: ButtonTextTheme.accent,
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: AppColor.getColors[1],
            fontSize: 20,
          ),
          iconTheme: IconThemeData(
            color: AppColor.getColors[1],
          ),
          backgroundColor: AppColor.getColors[0],
        ),
        scaffoldBackgroundColor: AppColor.getColors[0],
      ),
      home: Scaffold(
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          // unselectedLabelStyle: TextStyle(
          //   color: AppColor.getColors[1],
          // ),
          // selectedLabelStyle: TextStyle(
          //   color: Colors.white,
          // ),
          unselectedItemColor: AppColor.getColors[1],
          backgroundColor: AppColor.getColors[0],
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.motorcycle_rounded,
              ),
              label: 'Deliveries',
            )
          ],
        ),
      ),
    );
  }
}
