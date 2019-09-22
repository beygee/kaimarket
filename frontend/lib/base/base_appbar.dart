import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  BaseAppBar({
    this.title,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.of(context).canPop()
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey[500],
              ),
              iconSize: 30.0,
            )
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: title,
    );
  }
}
