import 'package:flutter/material.dart';
import 'package:week_3/helper.dart';

class BaseColorHeader extends StatelessWidget {
  final Color color;
  final double height;
  final Widget child;
  final EdgeInsets padding;

  BaseColorHeader({
    this.color = ThemeColor.primary,
    this.height = 200.0,
    this.child,
    this.padding = const EdgeInsets.all(20.0),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: height,
          color: color,
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: padding,
            child: child,
          ),
        )
      ],
    );
  }
}
