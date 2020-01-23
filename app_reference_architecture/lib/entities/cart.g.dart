// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class CartProvider extends InheritedWidget {
  CartProvider(
      {Key key,
      @required this.products,
      @required this.onProductsChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final Map<String, int> products;

  final Function(Map<String, int>) onProductsChanged;

  final Cart model;

  static Cart _oldModel;

  Cart get oldModel => CartProvider._oldModel;
  @override
  updateShouldNotify(CartProvider oldWidget) {
    final shouldNotify = oldWidget.products != products;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static CartProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  setProducts(Map<String, int> newProducts) {
    onProductsChanged(newProducts);
  }
}

class CartBuilder extends StatefulWidget {
  CartBuilder({Key key, @required this.products, this.builder, this.child})
      : super(key: key);

  final Map<String, int> products;

  final Widget child;

  final Widget Function(BuildContext, Cart) builder;

  @override
  _CartBuilderState createState() {
    return _CartBuilderState();
  }
}

class _CartBuilderState extends State<CartBuilder> {
  Map<String, int> products;

  @override
  initState() {
    products = widget.products;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Cart(products: products);

    return CartProvider(
        model: model,
        child: (widget.builder ?? (_, __) => widget.child)(context, model),
        products: products,
        onProductsChanged: (newValue) {
          setState(() {
            products = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    products = widget.products;

    super.didUpdateWidget(oldWidget);
  }
}
