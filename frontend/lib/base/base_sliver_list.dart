import 'package:flutter/material.dart';
import 'package:week_3/helper.dart';
import 'package:rxdart/rxdart.dart';

class BaseSliverList extends StatelessWidget {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final EdgeInsets padding;

  BaseSliverList({
    @required this.itemBuilder,
    @required this.itemCount,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          itemBuilder,
          childCount: itemCount,
        ),
      ),
    );
  }
}
