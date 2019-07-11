import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("load"),
      ),
    );
  }
}
