import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/widgets/count_badge.dart';
import 'package:app_reference_architecture/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = ProductsProvider.of(context).entries;
    final cart = CartProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit shop'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.green,
              colorBrightness: Brightness.dark,
              icon: Icon(Icons.shopping_cart),
              label: Text('Checkout'),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
