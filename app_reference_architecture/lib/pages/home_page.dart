import 'package:app_reference_architecture/constants/fruits.dart';
import 'package:app_reference_architecture/constants/vegetables.dart';
import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/widgets/count_badge.dart';
import 'package:app_reference_architecture/widgets/product_card.dart';
import 'package:flutter/material.dart';

import 'cart_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProvider.of(context);
    final cart = CartProvider.of(context);

    final products = productsProvider.entries;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit shop'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductsBuilder(
                  entries: [...fruits, ...vegetables],
                  child: CartPage(),
                ),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 40),
              child: Row(
                children: <Widget>[
                  Icon(Icons.shopping_cart),
                  Transform.translate(
                    offset: Offset(-5, 0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child:
                          CountBadge(count: cart.model.getTotalProductsCount()),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                color: productsProvider.entries == fruits ? Colors.blue : null,
                child: Text('Fruits'),
                onPressed: () {
                  productsProvider.setEntries(fruits);
                },
              ),
              FlatButton(
                color:
                    productsProvider.entries == vegetables ? Colors.blue : null,
                child: Text('Vegetables'),
                onPressed: () {
                  productsProvider.setEntries(vegetables);
                },
              ),
            ],
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
