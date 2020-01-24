import 'dart:convert';
import 'dart:io';

import 'package:app_reference_architecture/constants/fruits.dart';
import 'package:app_reference_architecture/constants/vegetables.dart';
import 'package:app_reference_architecture/entities/cart_items.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/entities/receipt.dart';
import 'package:app_reference_architecture/services/checkout_service.dart';
import 'package:flutter/material.dart';
import 'package:inherited_builder/annotations.dart';

part 'checkout.g.dart';

@Inherited()
class Checkout {
  final CheckoutService service;
  final List<CartEntry> purchaseItems;
  final bool success;
  final bool isLoading;
  final bool error;
  final Receipt receipt;

  Checkout({
    this.purchaseItems,
    this.success = false,
    this.isLoading = false,
    this.error = false,
    this.receipt,
    this.service,
  });

  static countProductsOfType(
    List<CartEntry> entries,
    List<Product> productsOfType,
  ) {
    return entries
        .where((i) => productsOfType.contains(i.product))
        .fold(0, (t, c) => t + c.count);
  }
}

extension CheckoutActions on CheckoutProvider {
  startCheckout() async {
    this.setIsLoading(true);
    final fruitsCount = Checkout.countProductsOfType(purchaseItems, fruits);
    final vegetablesCount =
        Checkout.countProductsOfType(purchaseItems, vegetables);

    try {
      final receipt = await this.service.checkout(
            fruitsCount: fruitsCount,
            vegetablesCount: vegetablesCount,
          );

      if (receipt != null) {
        this.setSuccess(true);
        this.setReceipt(receipt);
      }
    } catch (err) {
      this.setError(true);
    } finally {
      this.setIsLoading(false);
    }
  }
}
