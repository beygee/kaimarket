import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:week_3/utils/utils.dart';

@immutable
abstract class SocketState extends Equatable {
  SocketState([List props = const []]) : super(props);
}

class SocketUninitialized extends SocketState {
  @override
  String toString() {
    return super.toString();
  }
}

class SocketError extends SocketState {
  @override
  String toString() {
    return super.toString();
  }
}

class SocketLoaded extends SocketState {
  final SocketIOManager manager;
  final SocketIO socket;

  SocketLoaded({@required this.manager, @required this.socket})
      : super([manager, socket]);

  void dispose() {
    manager.clearInstance(socket).then((_) {});
  }

  @override
  String toString() {
    return super.toString();
  }
}

//채팅방 들어갔을 때
class SocketChatLoaded extends SocketState {
  final SocketIOManager manager;
  final SocketIO socket;

  SocketChatLoaded({@required this.manager, @required this.socket})
      : super([manager, socket]);

  void dispose() {
    manager.clearInstance(socket).then((_) {});
  }

  @override
  String toString() {
    return super.toString();
  }
}
