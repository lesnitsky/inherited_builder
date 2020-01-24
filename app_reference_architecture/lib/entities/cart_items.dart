import 'package:app_reference_architecture/entities/products.dart';
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

import 'cart.dart';

part 'cart_items.g.dart';

class CartEntry {
  final Product product;
  final int count;

  const CartEntry({this.product, this.count});
}

@Inherited()
class CartItems {
  final Products products;
  final Cart cart;

  const CartItems({this.products, this.cart});

  List<CartEntry> getEntries() => products.entries
      .where((p) => cart.hasProduct(p))
      .map((p) => CartEntry(product: p, count: cart.getProductsCount(p)))
      .toList();
}
