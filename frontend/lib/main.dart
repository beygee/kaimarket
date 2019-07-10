import 'package:flutter/material.dart';
import 'package:week_3/login/login_page.dart';
import 'package:week_3/styles/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: ThemeColor.primary,
      ),
    );
  }
}
