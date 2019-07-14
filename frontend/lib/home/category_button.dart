import 'package:flutter/material.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';

class HomeCategoryButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool active;

  HomeCategoryButton(
      {this.icon, this.text, this.onPressed, this.active = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            width: screenAwareSize(50.0, context),
            height: screenAwareSize(50.0, context),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: -5.0,
                  offset: Offset(0, 5.0),
                  color: Colors.black26,
                ),
              ],
              borderRadius:
                  BorderRadius.circular(screenAwareSize(20.0, context)),
              color: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(20.0, context)),
                onTap: onPressed,
                child: Padding(
                  padding: EdgeInsets.all(screenAwareSize(10.0, context)),
                  child: Icon(
                    icon,
                    size: screenAwareSize(16.0, context),
                    color: active
                        ? ThemeColor.primary
                        : Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            )),
        SizedBox(height: screenAwareSize(5.0, context)),
        Text(
          text,
          style: TextStyle(
            fontSize: screenAwareSize(9.0, context),
            color: active ? ThemeColor.primary : Colors.black.withOpacity(0.7),
          ),
        )
      ],
    );
  }
}
