import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SocketEvent extends Equatable {
  SocketEvent([List props = const []]) : super(props);
}

class SocketInit extends SocketEvent {
  @override
  String toString() {
    return "Init";
  }
}

class SocketDelete extends SocketEvent {
  @override
  String toString() {
    return "Delete";
  }
}

class SocketChatEnter extends SocketEvent {
  final ValueChanged<dynamic> onMessage;
  
  SocketChatEnter({@required this.onMessage});

  @override
  String toString() {
    return "SocketChatEnter";
  }
}

class SocketChatLeave extends SocketEvent {
  @override
  String toString() {
    return "SocketChatLeave";
  }
}
