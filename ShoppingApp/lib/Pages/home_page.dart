// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Models/product_model.dart';
import 'package:testingapp/Pages/details_page.dart';
import 'package:testingapp/Cards/item_card.dart';
import 'package:testingapp/Models/product_provider.dart';
import 'package:testingapp/Models/theme_provider.dart';

import '../Models/cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var index = 0;
  final FocusNode _focusNode = FocusNode();
  String searchText = '';
  bool isSearch = false;
  String dark = 'Dark';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    Cart CartProvider = Provider.of<Cart>(context);
    AppColors AppColor = Provider.of<AppColors>(context);
    bool v = AppColor.darkMode;

    return Scaffold(
      //backgroundColor: AppColor.getColors[0],
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          color: AppColor.getColors[1],
        ),
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              bottom: BorderSide(
                color: AppColor.getColors[1],
              ),
              right: BorderSide(
                color: AppColor.getColors[1],
              ),
              left: BorderSide(
                color: AppColor.getColors[1],
              ),
              top: BorderSide(
                color: AppColor.getColors[1],
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 5,
            ),
            child: TextField(
              focusNode: _focusNode,
              onChanged: (text) {
                setState(() {
                  isSearch = true;
                  searchText = text.toLowerCase();
                  if (searchText == '') {
                    setState(() {
                      isSearch = false;
                    });
                  }
                });
              },
              //cursorColor: AppColor.getColors[1],
              decoration: InputDecoration(
                hintText: 'Search Products',
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                hintStyle: TextStyle(
                  color: AppColor.getColors[1],
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              dark,
              style: TextStyle(
                color: AppColor.getColors[1],
              ),
            ),
          ),
          Switch(
              value: v,
              activeColor: AppColor.getColors[1],
              onChanged: (value) {
                dark = dark == 'Dark' ? 'Light' : 'Dark';
                AppColor.changeTheme(v);
                AppColor.darkMode = v ? false : true;
              }),
          Icon(
            Icons.more_vert_rounded,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _focusNode.unfocus();
          });
        },
        child: FutureBuilder(
          future: productProvider.productList,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              final eProducts = snapshot.data!
                  .where(
                      (product) => !CartProvider.getCartList.contains(product))
                  .toList();
              List<Product> fProducts = isSearch == true
                  ? eProducts
                      .where((element) =>
                          element.title.toLowerCase().startsWith(searchText))
                      .toList()
                  : eProducts;
              List<String> categoryNames = [];
              for (int i = 0; i < fProducts.length; i++) {
                if (!categoryNames.contains(fProducts[i].category.name)) {
                  categoryNames.add(fProducts[i].category.name);
                }
              }

              log(categoryNames.toString());

              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: categoryNames.length,
                    itemBuilder: (context, value) {
                      log(categoryNames.toString());
                      final cProducts = fProducts
                          .where((product) =>
                              categoryNames[value] == product.category.name)
                          .toList();
                      return SizedBox(
                        height: 370,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categoryNames[value],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: cProducts.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          DetailsPage(
                                                              product:
                                                                  cProducts[
                                                                      index])));
                                        },
                                        child:
                                            ItemCard(product: cProducts[index]),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text('Error loading data');
            }
          }),
        ),
      ),
    );
  }
}
