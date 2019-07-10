export './loading_wrapper.dart';
export './base_height.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//Scaffold에 스낵바 만들기. Builder로 감싸주어야함.
showSnackBar(BuildContext context, String text) {
  Scaffold.of(context).removeCurrentSnackBar();
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 1000),
    ),
  );
}

//개발 모드에 따른 hostUrl
const bool bDebug = true;
const String hostUrl = bDebug ? "13.209.73.209:3000" : "143.248.36.78:3000";
// const String hostUrl = bDebug ? "143.248.191.124:3000" : "143.248.36.78:3000";
Uri getUri(String path) => Uri.http(hostUrl, path);

//로거 모듈
var log = Logger();
