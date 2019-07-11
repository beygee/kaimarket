import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            // await dio.getUri(getUri('/api/me/test'));
          },
          child: Text("버튼"),
        ),
      ),
    );
  }
}
