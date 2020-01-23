import 'package:flutter/material.dart';

class CountBadge extends StatelessWidget {
  final int count;

  const CountBadge({Key key, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      constraints: BoxConstraints(minWidth: 20, maxHeight: 20),
      child: Center(
        child: Text(
          count.toString(),
        ),
      ),
    );
  }
}
