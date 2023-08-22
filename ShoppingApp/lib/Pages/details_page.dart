// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Pages/buy_page_single.dart';
import 'package:testingapp/Models/product_model.dart';

import '../Models/cart.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.product});
  final Product product;
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String cart = 'Add to Cart';
  @override
  Widget build(BuildContext context) {
    Cart cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details of this item'),
        centerTitle: true,
      ),
      body: Column(
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => BuyPageSingle(
                            product: widget.product,
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('Buy Now'),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  cartProvider.addToCart(widget.product);
                  setState(() {
                    cart = 'Added to cart';
                  });
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.of(context).pop();
                },
                child: Text(cart),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
