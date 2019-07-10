import 'package:flutter/material.dart';

//화면 비율 맞추기
const double baseHeight = 650.0;
double screenAwareSize(double size, BuildContext context) {
  double drawingHeight =
      MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
  return size * drawingHeight / baseHeight;
}
