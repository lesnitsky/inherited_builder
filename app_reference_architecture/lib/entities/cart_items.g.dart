// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class CartItemsProvider extends InheritedWidget {
  CartItemsProvider(
      {Key key,
      @required this.products,
      @required this.cart,
      @required this.onProductsChanged,
      @required this.onCartChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final Products products;

  final Cart cart;

  final Function(Products) onProductsChanged;

  final Function(Cart) onCartChanged;

  final CartItems model;

  static CartItems _oldModel;

  CartItems get oldModel => CartItemsProvider._oldModel;
  @override
  updateShouldNotify(CartItemsProvider oldWidget) {
    final shouldNotify =
        oldWidget.products != products || oldWidget.cart != cart;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static CartItemsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartItemsProvider>();
  }

  setProducts(Products newProducts) {
    onProductsChanged(newProducts);
  }

  setCart(Cart newCart) {
    onCartChanged(newCart);
  }
}

class CartItemsBuilder extends StatefulWidget {
  CartItemsBuilder(
      {Key key,
      @required this.products,
      @required this.cart,
      this.builder,
      this.child})
      : super(key: key);

  final Products products;

  final Cart cart;

  final Widget child;

  final Widget Function(BuildContext, CartItemsProvider) builder;

  @override
  _CartItemsBuilderState createState() {
    return _CartItemsBuilderState();
  }
}

class _CartItemsBuilderState extends State<CartItemsBuilder> {
  Products products;

  Cart cart;

  @override
  initState() {
    products = widget.products;
    cart = widget.cart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = CartItems(products: products, cart: cart);

    return CartItemsProvider(
        model: model,
        child: widget.builder != null
            ? Builder(
                builder: (context) =>
                    widget.builder(context, CartItemsProvider.of(context)))
            : widget.child,
        products: products,
        cart: cart,
        onProductsChanged: (newValue) {
          setState(() {
            products = newValue;
          });
        },
        onCartChanged: (newValue) {
          setState(() {
            cart = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    products = widget.products;
    cart = widget.cart;

    super.didUpdateWidget(oldWidget);
  }
}
