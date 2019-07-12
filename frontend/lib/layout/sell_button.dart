import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/styles/theme.dart';

class SellButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double iconSize;
  final double fontSize;
  final VoidCallback onPressed;
  final double padding;
  final Color color;
  final Color bgColor;

  SellButton(
      {this.text,
      this.icon,
      this.onPressed,
      this.padding,
      this.iconSize,
      this.fontSize,
      this.bgColor = ThemeColor.primary,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.all(screenAwareSize(padding, context)),
      shape: CircleBorder(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            size: screenAwareSize(iconSize, context),
            color: color,
          ),
          SizedBox(height: screenAwareSize(5, context)),
          Text(text,
              style: TextStyle(
                  color: color, fontSize: screenAwareSize(fontSize, context)))
        ],
      ),
      fillColor: bgColor,
      onPressed: onPressed,
    );
  }
}
