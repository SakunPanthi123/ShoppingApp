// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/buy_page_single.dart';
import 'package:testingapp/deliveries.dart';

import 'cart.dart';
import 'delivery_page.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({super.key});

  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  @override
  Widget build(BuildContext context) {
    double price = 0;

    Cart CartProvider = Provider.of<Cart>(context);
    for (int i = 0; i < CartProvider.getCartList.length; i++) {
      price += CartProvider.getCartList[i].price;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Purchase Page',
          style: TextStyle(
            color: Colors.white,
          ),
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
              'Buy these Items:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: CartProvider.getCartList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 155,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                      CartProvider.getCartList[index].images[0],
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      CartProvider.getCartList[index].title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(CartProvider.getCartList[index]
                                              .description.length >=
                                          75
                                      ? CartProvider
                                          .getCartList[index].description
                                          .substring(0, 75)
                                      : CartProvider
                                          .getCartList[index].description),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Text(
                                      '\$ ${CartProvider.getCartList[index].price.toString()}',
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        CartProvider.removeFromCart(
                                            CartProvider.getCartList[index]);
                                        if (CartProvider.isEmpty()) {
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text('Remove'),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    BuyPageSingle(
                                                        product: CartProvider
                                                                .getCartList[
                                                            index])));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 15, 0),
                                        child: Text(
                                          'Buy',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 13,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Total \$ $price',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'for ${CartProvider.getCartList.length} items',
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
                            Text('Loading Payment'),
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
                      return dialog(price);
                    },
                  );
                }

                delayAnimation();
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  'Buy All',
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
    Cart CartProvider = Provider.of<Cart>(context);
    Deliveries DeliveriesProvider = Provider.of<Deliveries>(context);
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
                          style: TextStyle(fontSize: 20)),
                      TextSpan(
                          text: '\$ $price',
                          style: TextStyle(
                            fontSize: 30,
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
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.pop(context);
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
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DeliveryPage()));
                                        DeliveriesProvider.addListToDelivery(
                                            CartProvider.getCartList);
                                        CartProvider.clearCart = 0;
                                      },
                                      child: Text('Go to Delivery Page'))
                                ],
                              ),
                            ),
                          );
                        });
                    //
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
