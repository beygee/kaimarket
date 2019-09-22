import 'package:flutter/material.dart';

class BaseNoneGlowScrollWrapper extends StatelessWidget {
  final Widget child;
  BaseNoneGlowScrollWrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (listener) {
        listener.disallowGlow();
      },
      child: child,
    );
  }
}
