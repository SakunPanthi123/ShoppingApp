// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Models/deliveries.dart';
import 'package:testingapp/Pages/delivery_page.dart';
import 'package:testingapp/Models/product_model.dart';
import 'package:testingapp/Models/theme_provider.dart';

import '../Models/cart.dart';

class BuyPageSingle extends StatefulWidget {
  final Product product;
  const BuyPageSingle({super.key, required this.product});

  @override
  State<BuyPageSingle> createState() => _BuyPageSingleState();
}

class _BuyPageSingleState extends State<BuyPageSingle> {
  bool paymentCalled = false;

  @override
  Widget build(BuildContext context) {
    Cart CartProvider = Provider.of<Cart>(context);
    AppColors AppColor = Provider.of<AppColors>(context);
    for (int i = 0; i < CartProvider.getCartList.length; i++) {}
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchase Page',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Buy this Item:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 155,
                    decoration: BoxDecoration(
                      color: AppColor.getColors[1].withOpacity(.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          leading: Image(
                            image: NetworkImage(
                              widget.product.images[0],
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              widget.product.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(widget.product.description.length >= 75
                              ? widget.product.description.substring(0, 75)
                              : widget.product.description),
                          trailing: Padding(
                            padding: const EdgeInsets.only(top: 17),
                            child: Text(
                              '\$ ${widget.product.price.toString()}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Total \$ ${widget.product.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'for this Item',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              'Loading Payment',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
                Future<void> delayAnimation() async {
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return dialog(widget.product.price);
                    },
                  );
                }

                delayAnimation();
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Buy',
                  style: TextStyle(
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget dialog(double price) {
    Deliveries DeliveryProvider = Provider.of<Deliveries>(context);
    Cart CartProvider = Provider.of<Cart>(context);
    return Dialog(
      backgroundColor: Colors.white,
      //insetAnimationDuration: Duration(seconds: 1),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Confirm Payment of\n\n',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                          text: '\$ $price',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                    ]),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Future<void> paymentAnimation() async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(25, 35, 35, 35),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Text(
                                    'Confirming payment\n\nPlease donot exit',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.pop(context);
                    setState(() {
                      paymentCalled = true;
                    });
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(45),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Payment Successful!\n\nItem will be delivered to your doorstep within 2 days',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        DeliveryProvider.addToDelivery(
                                            widget.product);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DeliveryPage()));
                                      },
                                      child: Text('Go to Delivery Page'))
                                ],
                              ),
                            ),
                          );
                        });
                    CartProvider.clearCart = 0;
                    CartProvider.removeFromCart(widget.product);
                  }

                  paymentAnimation();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('Pay Now'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
