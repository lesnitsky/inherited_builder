// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class CheckoutProvider extends InheritedWidget {
  CheckoutProvider(
      {Key key,
      @required this.service,
      @required this.purchaseItems,
      @required this.success,
      @required this.isLoading,
      @required this.error,
      @required this.receipt,
      @required this.onServiceChanged,
      @required this.onPurchaseItemsChanged,
      @required this.onSuccessChanged,
      @required this.onIsLoadingChanged,
      @required this.onErrorChanged,
      @required this.onReceiptChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final CheckoutService service;

  final List<CartEntry> purchaseItems;

  final bool success;

  final bool isLoading;

  final bool error;

  final Receipt receipt;

  final Function(CheckoutService) onServiceChanged;

  final Function(List<CartEntry>) onPurchaseItemsChanged;

  final Function(bool) onSuccessChanged;

  final Function(bool) onIsLoadingChanged;

  final Function(bool) onErrorChanged;

  final Function(Receipt) onReceiptChanged;

  final Checkout model;

  static Checkout _oldModel;

  Checkout get oldModel => CheckoutProvider._oldModel;
  @override
  updateShouldNotify(CheckoutProvider oldWidget) {
    final shouldNotify = oldWidget.service != service ||
        oldWidget.purchaseItems != purchaseItems ||
        oldWidget.success != success ||
        oldWidget.isLoading != isLoading ||
        oldWidget.error != error ||
        oldWidget.receipt != receipt;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static CheckoutProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CheckoutProvider>();
  }

  setService(CheckoutService newService) {
    onServiceChanged(newService);
  }

  setPurchaseItems(List<CartEntry> newPurchaseItems) {
    onPurchaseItemsChanged(newPurchaseItems);
  }

  setSuccess(bool newSuccess) {
    onSuccessChanged(newSuccess);
  }

  setIsLoading(bool newIsLoading) {
    onIsLoadingChanged(newIsLoading);
  }

  setError(bool newError) {
    onErrorChanged(newError);
  }

  setReceipt(Receipt newReceipt) {
    onReceiptChanged(newReceipt);
  }
}

class CheckoutBuilder extends StatefulWidget {
  CheckoutBuilder(
      {Key key,
      @required this.service,
      @required this.purchaseItems,
      @required this.success,
      @required this.isLoading,
      @required this.error,
      @required this.receipt,
      this.builder,
      this.child})
      : super(key: key);

  final CheckoutService service;

  final List<CartEntry> purchaseItems;

  final bool success;

  final bool isLoading;

  final bool error;

  final Receipt receipt;

  final Widget child;

  final Widget Function(BuildContext, CheckoutProvider) builder;

  @override
  _CheckoutBuilderState createState() {
    return _CheckoutBuilderState();
  }
}

class _CheckoutBuilderState extends State<CheckoutBuilder> {
  CheckoutService service;

  List<CartEntry> purchaseItems;

  bool success;

  bool isLoading;

  bool error;

  Receipt receipt;

  @override
  initState() {
    service = widget.service;
    purchaseItems = widget.purchaseItems;
    success = widget.success;
    isLoading = widget.isLoading;
    error = widget.error;
    receipt = widget.receipt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Checkout(
        service: service,
        purchaseItems: purchaseItems,
        success: success,
        isLoading: isLoading,
        error: error,
        receipt: receipt);

    return CheckoutProvider(
        model: model,
        child: widget.builder != null
            ? Builder(
                builder: (context) =>
                    widget.builder(context, CheckoutProvider.of(context)))
            : widget.child,
        service: service,
        purchaseItems: purchaseItems,
        success: success,
        isLoading: isLoading,
        error: error,
        receipt: receipt,
        onServiceChanged: (newValue) {
          setState(() {
            service = newValue;
          });
        },
        onPurchaseItemsChanged: (newValue) {
          setState(() {
            purchaseItems = newValue;
          });
        },
        onSuccessChanged: (newValue) {
          setState(() {
            success = newValue;
          });
        },
        onIsLoadingChanged: (newValue) {
          setState(() {
            isLoading = newValue;
          });
        },
        onErrorChanged: (newValue) {
          setState(() {
            error = newValue;
          });
        },
        onReceiptChanged: (newValue) {
          setState(() {
            receipt = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    service = widget.service;
    purchaseItems = widget.purchaseItems;
    success = widget.success;
    isLoading = widget.isLoading;
    error = widget.error;
    receipt = widget.receipt;

    super.didUpdateWidget(oldWidget);
  }
}
