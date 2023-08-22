// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Pages/buy_page_single.dart';
import 'package:testingapp/Models/product_model.dart';
import 'package:testingapp/Models/theme_provider.dart';

import '../Models/cart.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  String cartText = 'Add to Cart';
  @override
  Widget build(BuildContext context) {
    Cart CartProvider = Provider.of<Cart>(context);
    AppColors appColors = Provider.of<AppColors>(context);
    //ProductProvider productProvider = Provider.of<ProductProvider>(context);
    return Container(
      height: 335,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: appColors.getColors[1].withOpacity(.1),
      ),
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
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
          Positioned(
            top: 156,
            child: Container(
              height: 45,
              width: 240,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.product.title.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appColors.getColors[2],
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        '\$ ${widget.product.price.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appColors.getColors[2],
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 90,
              width: 240,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  widget.product.description.length > 100
                      ? widget.product.description.substring(0, 100)
                      : widget.product.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: appColors.getColors[2],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 6,
            child: SizedBox(
              width: 240,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      CartProvider.addToCart(widget.product);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.shopping_cart,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              BuyPageSingle(product: widget.product)));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Buy this Item',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
