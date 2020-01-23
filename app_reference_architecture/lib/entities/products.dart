import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'products.g.dart';

class Product {
  final String id;
  final String name;

  const Product({this.id, this.name});
}

@Inherited()
class Products {
  final List<Product> entries;
  const Products({this.entries});
}
