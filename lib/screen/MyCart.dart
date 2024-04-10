import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import "../provider/shoppingcart_provider.dart";

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  static var primaryColor = Color(0xFFED7117);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart"),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          const Divider(height: 4, color: Colors.black),
          Flexible(
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
                          },
                          child: const Text("Reset")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout');
                          },
                          child: const Text("Checkout")),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            child: const Text("Go back to Product Catalog"),
            onPressed: () {
              Navigator.pop(context);
              
            },
          ),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productname = "";
    return products.isEmpty
        ? Padding(
            padding: EdgeInsets.all(16),
            child: Text('No items added yet!'),
          )
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.shopping_cart_outlined),
                    title: Text(products[index].name),
                    trailing: IconButton(
                      icon: const Icon(Icons.highlight_remove),
                      onPressed: () {
                        productname = products[index].name;
                        context.read<ShoppingCart>().removeItem(productname);

                        if (products.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname removed!"),
                            duration:
                                const Duration(seconds: 1, milliseconds: 100),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cart Empty!"),
                            duration: Duration(seconds: 1, milliseconds: 100),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
            ],
          ));
  }
}
