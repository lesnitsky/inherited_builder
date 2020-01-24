import 'package:app_reference_architecture/constants/fruits.dart';
import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/pages/home_page.dart';
import 'package:app_reference_architecture/widgets/cart_persistance.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final storage = new LocalStorage('cart');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(color: Colors.white);
        }

        return CartBuilder(
          products: Map<String, int>.from(storage.getItem('products') ?? {}),
          child: ProductsBuilder(
            entries: fruits,
            builder: (context, products) => MaterialApp(
              debugShowCheckedModeBanner: false,
              home: CartPersistance(child: HomePage()),
            ),
          ),
        );
      },
    );
  }
}
