import 'package:app_reference_architecture/constants/fruits.dart';
import 'package:app_reference_architecture/constants/vegetables.dart';
import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/products.dart';
import 'package:app_reference_architecture/pages/cart_page.dart';
import 'package:app_reference_architecture/widgets/clear_cart_button.dart';
import 'package:app_reference_architecture/widgets/count_badge.dart';
import 'package:app_reference_architecture/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = ProductsProvider.of(context);
    final cart = CartProvider.of(context);

    final products = productsProvider.entries;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit shop'),
        actions: <Widget>[
          CountBadge(
            count: cart.model.getTotalProductsCount(),
          ),
          IconButton(
            icon: Row(
              children: <Widget>[Icon(Icons.shopping_cart)],
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          onTap: (index) {
            productsProvider.setEntries([fruits, vegetables][index]);
          },
          tabs: <Widget>[
            Tab(child: Text('Fruits')),
            Tab(child: Text('Vegetables')),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductCard(product: product);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClearCartButton(),
          ),
        ],
      ),
    );
  }
}
