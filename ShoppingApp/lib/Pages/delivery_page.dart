// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testingapp/Models/deliveries.dart';
import 'package:testingapp/Models/theme_provider.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) {
    Deliveries DeliveriesProvider = Provider.of<Deliveries>(context);
    AppColors AppColor = Provider.of<AppColors>(context);
    bool noDeliveries = DeliveriesProvider.getDeliveries.isEmpty;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My deliveries',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: noDeliveries == false
            ? Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Items on your way',
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
                        itemCount: DeliveriesProvider.getDeliveries.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 155,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColor.getColors[1].withOpacity(.1),
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
                                            DeliveriesProvider
                                                .getDeliveries[index].images[0],
                                          ),
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 5),
                                          child: Text(
                                            DeliveriesProvider
                                                .getDeliveries[index].title,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(DeliveriesProvider
                                                    .getDeliveries[index]
                                                    .description
                                                    .length >=
                                                75
                                            ? DeliveriesProvider
                                                .getDeliveries[index]
                                                .description
                                                .substring(0, 75)
                                            : DeliveriesProvider
                                                .getDeliveries[index]
                                                .description),
                                        trailing: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 17),
                                          child: Text(
                                            textAlign: TextAlign.right,
                                            '\$ ${DeliveriesProvider.getDeliveries[index].price.toString()}\nPaid',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                                'Are you sure you want \nto cancel this delivery?\n\nYour money will be refunded \nwithin 2 working days.'),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  DeliveriesProvider.removeFromDelivery(
                                                                      DeliveriesProvider
                                                                              .getDeliveries[
                                                                          index]);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: Text(
                                                                  'Confirm',
                                                                )),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Text('Cancel delivery'),
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
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColor.getColors[1],
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'No items on route to delivery\n'),
                        TextSpan(text: 'Purchase an item to see it here'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 400,
                  ),
                ],
              ),
      ),
    );
  }
}
