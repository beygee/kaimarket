import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';

class PostCategoryButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  bool picked = false;

  PostCategoryButton({this.icon, this.text, this.onPressed, this.picked});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: screenAwareSize(45.0, context),
            height: screenAwareSize(45.0, context),
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
            child: Padding(
              padding: EdgeInsets.all(screenAwareSize(10.0, context)),
              child: Icon(
                icon,
                size: screenAwareSize(16.0, context),
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: screenAwareSize(9.0, context),
              color: Colors.black.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
