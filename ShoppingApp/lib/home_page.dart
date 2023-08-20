// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/item_card.dart';
import 'package:testingapp/product_provider.dart';

import 'cart.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    Cart CartProvider = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.home,
          color: Colors.white,
        ),
        title: TextField(
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
          decoration: InputDecoration(
            label: Text(
              'Search Products',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _focusNode.unfocus();
            });
          },
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 780,
                  child: FutureBuilder(
                    future: productProvider.productList,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final product = snapshot.data!;
                        final fProducts = snapshot.data!
                            .where((product) =>
                                !CartProvider.getCartList.contains(product))
                            .toList();

                        return ListView.builder(
                            itemCount: fProducts.length,
                            itemBuilder: (context, index) {
                              return isSearch == false
                                  ?
                                  // filter and remove the items already present in cart

                                  ItemCard(product: fProducts[index])
                                  :

                                  // search implementation
                                  product[index]
                                          .title
                                          .toLowerCase()
                                          .startsWith(searchText)
                                      ? ItemCard(
                                          product: product[index],
                                        )
                                      : Row();
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Text('Error loading data');
                      }
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
