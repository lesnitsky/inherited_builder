import 'package:app_reference_architecture/entities/checkout.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkoutProvider = CheckoutProvider.of(context);

    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: _resolveButtonColor(checkoutProvider.model),
      colorBrightness: Brightness.dark,
      icon: !checkoutProvider.isLoading
          ? Icon(_resolveButtonIcon(checkoutProvider.model))
          : Container(
              width: 24,
              height: 20,
              padding: const EdgeInsets.only(right: 4),
              child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
      label: Text(_resolveButtonText(checkoutProvider.model)),
      onPressed: () {
        if (!checkoutProvider.isLoading && !checkoutProvider.success)
          checkoutProvider.startCheckout();
      },
    );
  }

  String _resolveButtonText(Checkout checkout) {
    if (checkout.success) {
      return 'Success';
    }

    if (checkout.error) {
      return 'Try again';
    }

    return 'Checkout';
  }

  Color _resolveButtonColor(Checkout checkout) {
    if (checkout.success) {
      return Colors.green;
    }

    if (checkout.error) {
      return Colors.red;
    }

    return Colors.blue;
  }

  IconData _resolveButtonIcon(Checkout checkout) {
    if (checkout.success) {
      return Icons.check;
    }

    if (checkout.error) {
      return Icons.warning;
    }

    return Icons.shopping_cart;
  }
}
