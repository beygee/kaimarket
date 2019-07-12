import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';

class PhotoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  PhotoButton({this.icon, this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
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
          borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
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
    );
  }
}