import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/cart_items.dart';
import 'package:app_reference_architecture/entities/checkout.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/services/checkout_service.dart';
import 'package:app_reference_architecture/widgets/checkout_button.dart';
import 'package:app_reference_architecture/widgets/receipt_bottomsheet.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  Widget buildContent(List<CartEntry> entries) {
    if (entries.length == 0)
      return Center(
        child: Text('Cart is empty'),
      );

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];

        return ListTile(
          title: Text(entry.product.name),
          trailing: Text(entry.count.toString()),
        );
      },
    );
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
                      child: buildContent(entries),
                    ),
                    if (entries.length > 0)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CheckoutButton(),
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
