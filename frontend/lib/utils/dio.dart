import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

//개발 모드에 따른 hostUrl
const bool bDebug = true;
const String hostUrl = bDebug ? "13.125.46.0:3005" : "143.248.36.78:3000";

//Dio Singleton
class MyDio {
  static final MyDio _singleton = MyDio._internal();

  final Dio dio = Dio();

  factory MyDio() {
    return _singleton;
  }

  MyDio._internal() {
    dio.options.connectTimeout = 5000;
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (Options options) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("access_token");
        //만일 토큰이 있으면 끼워서 보낸다.
        if (token != null) {
          options.headers["access_token"] = token;
        }
      }, onResponse: (Response res) async {
        //만약 토큰이 갱신되면 새로 넣어준다.
        String token = res.headers.value('access_token');
        if (token != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', token);
        }
      }),
    );
  }
}

Dio dio = MyDio().dio;

//현재 서버 경로 Uri
Uri getUri(String path, [Map<String, String> queryParameters]) =>
    Uri.http(hostUrl, path, queryParameters);

//모든 요청에 로그인 된 토큰을 Header bearer에 집어넣는다.
