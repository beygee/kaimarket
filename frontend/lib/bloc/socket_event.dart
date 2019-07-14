import 'package:equatable/equatable.dart';
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
