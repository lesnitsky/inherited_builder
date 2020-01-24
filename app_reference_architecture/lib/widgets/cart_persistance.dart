import 'package:app_reference_architecture/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class CartPersistance extends StatefulWidget {
  final Widget child;

  const CartPersistance({Key key, this.child}) : super(key: key);
  @override
  _CartPersistanceState createState() => _CartPersistanceState();
}

class _CartPersistanceState extends State<CartPersistance> {
  Cart cart;
  final storage = new LocalStorage('cart');

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    final provider = CartProvider.of(context);

    if (provider == null || provider.oldModel == null) {
      super.didChangeDependencies();
      return;
    }

    cart = provider.oldModel;
    final newCart = provider.model;

    if (!cart.equals(newCart)) {
      storage.setItem('products', newCart.products);
    }

    super.didChangeDependencies();
  }
}
