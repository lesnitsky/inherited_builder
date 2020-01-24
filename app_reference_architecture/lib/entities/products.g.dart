// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class ProductsProvider extends InheritedWidget {
  ProductsProvider(
      {Key key,
      @required this.entries,
      @required this.onEntriesChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final List<Product> entries;

  final Function(List<Product>) onEntriesChanged;

  final Products model;

  static Products _oldModel;

  Products get oldModel => ProductsProvider._oldModel;
  @override
  updateShouldNotify(ProductsProvider oldWidget) {
    final shouldNotify = oldWidget.entries != entries;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static ProductsProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProductsProvider>();
  }

  setEntries(List<Product> newEntries) {
    onEntriesChanged(newEntries);
  }
}

class ProductsBuilder extends StatefulWidget {
  ProductsBuilder({Key key, @required this.entries, this.builder, this.child})
      : super(key: key);

  final List<Product> entries;

  final Widget child;

  final Widget Function(BuildContext, ProductsProvider) builder;

  @override
  _ProductsBuilderState createState() {
    return _ProductsBuilderState();
  }
}

class _ProductsBuilderState extends State<ProductsBuilder> {
  List<Product> entries;

  @override
  initState() {
    entries = widget.entries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Products(entries: entries);

    return ProductsProvider(
        model: model,
        child: widget.builder != null
            ? Builder(
                builder: (context) =>
                    widget.builder(context, ProductsProvider.of(context)))
            : widget.child,
        entries: entries,
        onEntriesChanged: (newValue) {
          setState(() {
            entries = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    entries = widget.entries;

    super.didUpdateWidget(oldWidget);
  }
}
