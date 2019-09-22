export './loading_wrapper.dart';
export './base_height.dart';
export './dio.dart';
export './custom_ink_splash_factory.dart';
export 'package:week_3/styles/theme.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flushbar/flushbar.dart';
import 'package:dio/dio.dart' show DioError;

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

showError(String text, BuildContext context, {String title}) {
  Flushbar(
    title: title,
    message: text,
    icon: Icon(Icons.close, color: Colors.white),
    shouldIconPulse: false,
    duration: Duration(milliseconds: 2000),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red[400],
    borderRadius: 15.0,
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: EdgeInsets.all(20.0),
    animationDuration: Duration(milliseconds: 300),
    onTap: (bar) {
      bar.dismiss(context);
    },
  )..show(context);
}

showSuccess(String text, BuildContext context, {String title}) {
  Flushbar(
    title: title,
    message: text,
    icon: Icon(Icons.check, color: Colors.white),
    shouldIconPulse: false,
    duration: Duration(milliseconds: 2000),
    flushbarStyle: FlushbarStyle.FLOATING,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.green[400],
    borderRadius: 15.0,
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: EdgeInsets.all(20.0),
    animationDuration: Duration(milliseconds: 300),
    onTap: (bar) {
      bar.dismiss(context);
    },
  )..show(context);
}

//로거 모듈
var log = Logger();

//넘버 포맷
String getMoneyFormat(int price) {
  final numberFormat = new NumberFormat("#,##0", "en_US");
  return numberFormat.format(price);
}

//디바운서
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

//flatten

List flatten(List list) {
  try {
    List flat = [];

    list.forEach((e) {
      flat.addAll(e);
    });
    return flat;
  } catch (e) {
    log.e(e);
    return [];
  }
}

//연플 DIO Error 처리
bool $error(List<String> msgs, Exception e, BuildContext context,
    {bool noValid = false}) {
  if (e is DioError) {
    if (e.response.statusCode == 403) {
      for (int i = 1; i <= msgs.length; i++) {
        if (e.response.data["code"] == i) {
          showError(msgs[i - 1], context);
          return true;
        }
      }
    }
  }

  return false;
}

//UTC DateTime Parse
DateTime parseUTC(String utcTimeFormat) {
  try {
    return DateTime.parse(utcTimeFormat);
  } catch (_) {
    return null;
  }
}

//시간 포맷
String dateFormat(DateTime date, String format) {
  return DateFormat(format).format(date);
}

//상대 시간
String fromNow(DateTime date) {
  timeago.setLocaleMessages("ko", timeago.KoMessages());
  return timeago.format(date, locale: "ko");
}

//유저 아이디를 통해 아스키 코드 알고리즘을 통해 아바타 이미지 만들기
String getRandomAvatarUrlByPostId(int postId) {
  int idx = postId.hashCode % 7;

  return 'assets/avatar/$idx.png';
}
