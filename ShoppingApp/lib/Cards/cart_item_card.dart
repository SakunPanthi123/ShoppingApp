// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Pages/buy_page_single.dart';
import 'package:testingapp/Models/product_model.dart';

import '../Models/cart.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  String cartText = 'Remove from Cart';
  @override
  Widget build(BuildContext context) {
    Cart cartProvider = Provider.of<Cart>(context);
    return Column(
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.product.images[0]),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          widget.product.title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.product.category.name),
            SizedBox(
              height: 10,
            ),
            Text(
              'Price: \$ ${widget.product.price.toString()}',
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(widget.product.description),
        ),
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                cartProvider.removeFromCart(widget.product);
              },
              child: Row(
                children: [
                  Text('Remove from'),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => BuyPageSingle(
                          product: widget.product,
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Buy Now'),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
