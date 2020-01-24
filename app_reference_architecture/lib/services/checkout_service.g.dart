// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_service.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class CheckoutServiceProvider extends InheritedWidget {
  CheckoutServiceProvider(
      {Key key,
      @required this.backendUrl,
      @required this.onBackendUrlChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final String backendUrl;

  final Function(String) onBackendUrlChanged;

  final CheckoutService model;

  static CheckoutService _oldModel;

  CheckoutService get oldModel => CheckoutServiceProvider._oldModel;
  @override
  updateShouldNotify(CheckoutServiceProvider oldWidget) {
    final shouldNotify = oldWidget.backendUrl != backendUrl;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static CheckoutServiceProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CheckoutServiceProvider>();
  }

  setBackendUrl(String newBackendUrl) {
    onBackendUrlChanged(newBackendUrl);
  }
}

class CheckoutServiceBuilder extends StatefulWidget {
  CheckoutServiceBuilder(
      {Key key, @required this.backendUrl, this.builder, this.child})
      : super(key: key);

  final String backendUrl;

  final Widget child;

  final Widget Function(BuildContext, CheckoutServiceProvider) builder;

  @override
  _CheckoutServiceBuilderState createState() {
    return _CheckoutServiceBuilderState();
  }
}

class _CheckoutServiceBuilderState extends State<CheckoutServiceBuilder> {
  String backendUrl;

  @override
  initState() {
    backendUrl = widget.backendUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = CheckoutService(backendUrl: backendUrl);

    return CheckoutServiceProvider(
        model: model,
        child: widget.builder != null
            ? Builder(
                builder: (context) => widget.builder(
                    context, CheckoutServiceProvider.of(context)))
            : widget.child,
        backendUrl: backendUrl,
        onBackendUrlChanged: (newValue) {
          setState(() {
            backendUrl = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    backendUrl = widget.backendUrl;

    super.didUpdateWidget(oldWidget);
  }
}
