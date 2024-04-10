import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/Item.dart';
import "package:provider/provider.dart";
import '../provider/shoppingcart_provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> productsCatalog = [
    Item("Soap", 54.99, 3),
    Item("Shampoo", 119.99, 2),
    Item("Toothpaste", 69.99, 3),
    Item("Toothbrush", 22.49, 3),
    Item("Dental Floss", 89.49, 3),
  ];

  static var primaryColor = Color(0xFFED7117);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Grocery App"),backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),),
        body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.star),
                title: Text(
                    "${productsCatalog[index].name} - ${productsCatalog[index].price}"),
                trailing: TextButton(
                  child: const Text("Add"),
                  onPressed: () {
                    context
                        .read<ShoppingCart>()
                        .addItem(productsCatalog[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${productsCatalog[index].name} added!"),
                      duration: const Duration(seconds: 1, milliseconds: 100),
                    ));
                  },
                ),
              );
            },
            itemCount: productsCatalog.length),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, "/cart");
            
          },
        ));
  }
}
