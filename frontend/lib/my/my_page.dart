import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:week_3/utils/utils.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    _messaging.getToken().then((token) {
      log.i(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
