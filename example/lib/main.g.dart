// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// InheritedGenerator
// **************************************************************************

class AppStateProvider extends InheritedWidget {
  AppStateProvider(
      {Key key,
      @required this.count,
      @required this.onCountChanged,
      @required this.model,
      Widget child})
      : super(key: key, child: child);

  final int count;

  final Function(int) onCountChanged;

  final AppState model;

  static AppState _oldModel;

  AppState get oldModel => AppStateProvider._oldModel;
  @override
  updateShouldNotify(AppStateProvider oldWidget) {
    final shouldNotify = oldWidget.count != count;

    if (shouldNotify) {
      _oldModel = oldWidget.model;
    }

    return shouldNotify;
  }

  static AppStateProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
  }

  setCount(int newCount) {
    onCountChanged(newCount);
  }
}

class AppStateBuilder extends StatefulWidget {
  AppStateBuilder({Key key, @required this.count, this.builder, this.child})
      : super(key: key);

  final int count;

  final Widget child;

  final Widget Function(BuildContext, AppStateProvider) builder;

  @override
  _AppStateBuilderState createState() {
    return _AppStateBuilderState();
  }
}

class _AppStateBuilderState extends State<AppStateBuilder> {
  int count;

  @override
  initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = AppState(count: count);

    return AppStateProvider(
        model: model,
        child: widget.builder != null
            ? Builder(
                builder: (context) =>
                    widget.builder(context, AppStateProvider.of(context)))
            : widget.child,
        count: count,
        onCountChanged: (newValue) {
          setState(() {
            count = newValue;
          });
        });
  }

  @override
  didUpdateWidget(Widget oldWidget) {
    count = widget.count;

    super.didUpdateWidget(oldWidget);
  }
}
