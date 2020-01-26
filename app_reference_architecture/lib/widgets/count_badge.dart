import 'package:flutter/material.dart';

class CountBadge extends StatelessWidget {
  final int count;

  const CountBadge({Key key, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          constraints: BoxConstraints(minWidth: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.red,
          ),
          child: Center(
            child: Text(
              count.toString(),
            ),
          ),
        )
      ],
    );
  }
}
