import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';

class BaseCard extends StatelessWidget {
  final EdgeInsets padding;
  final Widget child;

  BaseCard({
    this.child,
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurRadius: 10.0,
              color: Colors.black12,
              offset: Offset(0, 5.0),
            )
          ]),
      padding: padding,
      child: child,
    );
  }
}
