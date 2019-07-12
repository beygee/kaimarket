import 'package:flutter/material.dart';

class SelectMapPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => SelectMapPageState();
}

class SelectMapPageState extends State<SelectMapPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: Text(
          '선호 지역 선택',
          style: TextStyle(fontSize: 15.0
          ),
        ),        
      ),
      body: Text('test'),
    );
  }
}