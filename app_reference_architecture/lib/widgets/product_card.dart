import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cart = CartProvider.of(context);
    final productCount = cart.model.getProductsCount(widget.product);

    return ListTile(
      title: Text(widget.product.name),
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
                    cart.removeProduct(widget.product);
                  }
                : null,
          ),
          IconButton(
            iconSize: 16,
            icon: Icon(Icons.add),
            onPressed: () {
              cart.addProduct(widget.product);
            },
          ),
        ],
      ),
    );
  }
}
