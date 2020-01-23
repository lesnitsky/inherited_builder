import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductsBuilder(
      entries: [
        const Product(id: 'apple', name: 'Apple'),
        const Product(id: 'orange', name: 'Orange'),
        const Product(id: 'banana', name: 'Banana'),
      ],
      builder: (context, products) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CartBuilder(
          products: {},
          child: HomePage(),
        ),
      ),
    );
  }
}
