// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Pages/buy_page.dart';
import 'package:testingapp/Models/theme_provider.dart';

import '../Models/cart.dart';
import '../Cards/cart_item_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppColors AppColor = Provider.of<AppColors>(context);
    Cart CartProvider = Provider.of<Cart>(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cart Page',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: CartProvider.getCartList.length,
                itemBuilder: (context, index) {
                  return CartItemCard(
                    product: CartProvider.getCartList[index],
                  );
                }),
          ),
          CartProvider.getCartList.isNotEmpty
              ? Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => BuyPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(107, 14, 107, 14),
                        child: Text(
                          'Buy all Items',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                  ],
                )
              : Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColor.getColors[1],
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'No items in 🛒\n'),
                          TextSpan(text: 'Add an item to proceed to buy'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
