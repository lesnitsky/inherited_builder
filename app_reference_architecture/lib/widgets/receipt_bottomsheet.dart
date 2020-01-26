import 'package:app_reference_architecture/entities/cart.dart';
import 'package:app_reference_architecture/entities/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ReceiptBottomsheet extends StatefulWidget {
  final Widget child;

  const ReceiptBottomsheet({Key key, this.child}) : super(key: key);
  @override
  _ReceiptBottomsheetState createState() => _ReceiptBottomsheetState();
}

class _ReceiptBottomsheetState extends State<ReceiptBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Widget _dots() {
    return Expanded(
      flex: 1,
      child: LayoutBuilder(builder: (context, constraints) {
        final ticksCount = constraints.biggest.width ~/ 2;
        final colors = List.generate(ticksCount, (index) {
          return [
            Colors.grey,
            Colors.grey,
            Colors.white,
            Colors.white
          ][index % 4];
        });

        final stops = List.generate(ticksCount, (index) => index / ticksCount);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: colors,
                stops: stops,
              ),
            ),
            height: 1,
            width: constraints.biggest.width,
          ),
        );
      }),
    );
  }

  Widget _buildModal(CheckoutProvider checkoutProvider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.check_circle, color: Colors.green),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16).copyWith(left: 16),
                child: Text('Purchase complete!',
                    style: Theme.of(context).textTheme.title),
              ),
            ],
          ),
          Divider(),
          Text(
            'Fruit shop visitors bought a total of:',
            style: Theme.of(context).textTheme.subhead,
          ),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fruits'),
              _dots(),
              Text('${checkoutProvider.receipt.fruitsCount}')
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Vegetables'),
              _dots(),
              Text('${checkoutProvider.receipt.vegetablesCount}')
            ],
          ),
          Divider(),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final checkoutProvider = CheckoutProvider.of(context);
    final cart = CartProvider.of(context);

    if (checkoutProvider.oldModel?.receipt == null &&
        checkoutProvider.model?.receipt != null &&
        !cart.model.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return _buildModal(checkoutProvider);
          },
        );

        cart.clear();
        checkoutProvider.setReceipt(null);
      });
    }

    super.didChangeDependencies();
  }
}
