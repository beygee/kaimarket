import 'package:flutter/material.dart';
import 'package:week_3/helper.dart';

class BaseDivider extends StatelessWidget {
  final Color color;

  BaseDivider({
    this.color = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 1,
      width: double.infinity,
    );
  }
}
