import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//유니크 로딩 래퍼
typedef AsyncFunction = Future<dynamic> Function();
typedef LoadingBuilder = Widget Function(BuildContext context, bool loading);

class LoadingWrapper extends StatefulWidget {
  final LoadingBuilder builder;

  LoadingWrapper({Key key, @required this.builder}) : super(key: key);

  @override
  LoadingWrapperState createState() => LoadingWrapperState();
}

class LoadingWrapperState extends State<LoadingWrapper> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, loading);
  }

  loadFuture(AsyncFunction asyncFunc,
      {ValueChanged onCompleted, ValueChanged onError}) async {
    if (loading) {
      return;
    }
    setState(() {
      loading = true;
    });

    try {
      var data = await asyncFunc();
      if (onCompleted != null) {
        onCompleted(data);
      }
    } catch (e) {
      if (onError != null) {
        onError(e);
      } else {
        var log = Logger();
        log.e(e);
      }
    } finally {
      setState(() {
        loading = false;
      });
    }
  }
}
