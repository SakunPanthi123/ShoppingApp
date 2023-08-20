// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/buy_page_single.dart';
import 'package:testingapp/product_model.dart';

import 'cart.dart';

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
  String cartText = 'Add to Cart';
  @override
  Widget build(BuildContext context) {
    Cart CartProvider = Provider.of<Cart>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 25, 10, 0),
      child: Container(
        height: 650,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              colors: [const Color.fromARGB(255, 199, 180, 180), Colors.red]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.product.images[0],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '\$ ${widget.product.price.toString()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Category: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.product.category.name.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BuyPageSingle(
                              product: widget.product,
                            )));
                  },
                  child: Text(
                    'Buy this Item',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    CartProvider.removeFromCart(widget.product);
                  },
                  child: Text(
                    'Remove from Cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
