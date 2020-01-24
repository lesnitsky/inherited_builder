import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    final productCount = cart.model.getProductsCount(product);

    return ListTile(
      title: Text(product.name),
      subtitle: Text(productCount.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 16,
            icon: Icon(Icons.remove),
            onPressed: productCount > 0
                ? () {
                    cart.removeProduct(product);
                  }
                : null,
          ),
          IconButton(
            iconSize: 16,
            icon: Icon(Icons.add),
            onPressed: () {
              cart.addProduct(product);
            },
          ),
        ],
      ),
    );
  }
}
