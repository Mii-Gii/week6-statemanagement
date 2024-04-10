import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCheckout extends StatelessWidget {
  const MyCheckout({super.key});

  static var primaryColor = Color(0xFFED7117);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'),backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          const Divider(height: 4, color: Colors.black),
          context.watch<ShoppingCart>().cart.isEmpty
          ? Padding(
            padding: EdgeInsets.all(16),
            child: TextButton( onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              
            }, child: const Text("Go back to Product Catalog")),
          )
          : Flexible(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Total: ' +
                            (context.watch<ShoppingCart>().cartTotal)
                                .toString()),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<ShoppingCart>().removeAll();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Payment Successful!'),
                              duration: Duration(seconds: 1, milliseconds: 100),
                            ));
                          },
                          child: const Text('Pay Now'))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? const Center(child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('No items to checkout!'),
          ))
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text(products[index].name),
                      trailing: Text(products[index].price.toString(), style: new TextStyle(fontSize: 16),));
                },
              )),
            ],
          ));
  }
}
