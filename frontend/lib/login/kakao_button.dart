import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';

class KakaoLoginButton extends StatelessWidget {
  final Color color;
  final Color iconColor;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  KakaoLoginButton(
      {@required this.color,
      this.iconColor,
      @required this.text,
      this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(
        vertical: screenAwareSize(10.0, context),
        horizontal: 10.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      color: color,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            child: Stack(
              overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  left: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: screenAwareSize(7, context),
                        bottom: screenAwareSize(6, context),
                        top: screenAwareSize(6, context),
                        left: screenAwareSize(6, context)
                      ),
                      child: Icon(
                        icon,
                        color: Colors.brown,
                        size: screenAwareSize(14.0, context),
                      ),
                    ),
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
      onPressed: onPressed ?? () {},
    );
  }
}