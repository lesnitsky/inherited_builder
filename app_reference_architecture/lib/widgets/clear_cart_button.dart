import 'package:app_reference_architecture/entities/cart.dart';
import 'package:flutter/material.dart';

class ClearCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Theme.of(context).primaryColor,
      colorBrightness: Theme.of(context).primaryColor.computeLuminance() < 0.5
          ? Brightness.dark
          : Brightness.light,
      child: Text('Clear cart'),
      onPressed: () {
        CartProvider.of(context).clear();
      },
    );
  }
}
