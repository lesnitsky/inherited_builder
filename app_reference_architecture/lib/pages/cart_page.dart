import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/cart_items.dart';
import 'package:app_reference_architecture/entities/checkout.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/services/checkout_service.dart';
import 'package:app_reference_architecture/widgets/receipt_bottomsheet.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: CartItemsBuilder(
        cart: CartProvider.of(context).model,
        products: ProductsProvider.of(context).model,
        builder: (context, cartItemsProvider) {
          final entries = cartItemsProvider.model.getEntries();

          return CheckoutBuilder(
            service: CheckoutServiceProvider.of(context).model,
            error: false,
            isLoading: false,
            success: false,
            purchaseItems: entries,
            receipt: null,
            builder: (context, checkoutProvider) {
              return ReceiptBottomsheet(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: entries.length > 0
                          ? ListView.builder(
                              itemCount: entries.length,
                              itemBuilder: (context, index) {
                                final entry = entries[index];

                                return ListTile(
                                  title: Text(entry.product.name),
                                  trailing: Text(entry.count.toString()),
                                );
                              },
                            )
                          : Center(
                              child: Text('Cart is empty'),
                            ),
                    ),
                    if (entries.length > 0)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton.icon(
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
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                ),
                          label:
                              Text(_resolveButtonText(checkoutProvider.model)),
                          onPressed: () {
                            if (!checkoutProvider.isLoading &&
                                !checkoutProvider.success)
                              checkoutProvider.startCheckout();
                          },
                        ),
                      )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
