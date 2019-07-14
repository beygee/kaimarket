import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:week_3/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login/login_page.dart';
import 'layout/default.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("꺆로딩"),
        ),
      ),
    );
  }

  Future checkLogin() async {
    //토큰이 저장되어 있는지 확인한다
    try {
      var res = await dio.getUri(getUri('/api/me'));

      if (res.statusCode == 200) {
        if (res.data['valid']) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          Navigator.of(context).pushReplacementNamed('/valid');
        }
      }
    } catch (e) {
      //로그인 페이지 보내기
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
