import 'package:app_reference_architecture/entities/products.dart';
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'cart.g.dart';

@Inherited()
class Cart {
  final Map<String, int> products;

  const Cart({this.products});

  int getProductsCount(Product product) => this.products[product.id] ?? 0;
  int getTotalProductsCount() => this.products.values.fold(0, (t, v) => t + v);

  bool equals(Cart other) {
    return other.products.length == products.length &&
        other.products.entries.every((e) {
          return products[e.key] == e.value;
        });
  }

  bool hasProduct(Product product) => products.containsKey(product.id);
}

extension CartActions on CartProvider {
  addProduct(Product product) {
    final count = this.products[product.id] ?? 0;

    this.setProducts({
      ...this.products,
      '${product.id}': count + 1,
    });
  }

  removeProduct(Product product) {
    final newCount = (this.products[product.id] ?? 0) - 1;

    this.setProducts({
      ...this.products,
      '${product.id}': newCount.clamp(0, double.infinity),
    });
  }
}
