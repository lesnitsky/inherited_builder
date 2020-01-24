import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/cart_items.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CartItemsBuilder(
              cart: CartProvider.of(context).model,
              products: ProductsProvider.of(context).model,
              builder: (context, cartItems) {
                final entries = cartItems.getEntries();

                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return ListTile(
                      title: Text(entry.product.name),
                      trailing: Text(entry.count.toString()),
                    );
                  },
                );
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
