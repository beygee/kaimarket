import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3/utils/utils.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketIOManager manager = SocketIOManager();

  @override
  SocketState get initialState => SocketUninitialized();

  @override
  Stream<SocketState> mapEventToState(
    SocketEvent event,
  ) async* {
    if (event is SocketInit && currentState is SocketUninitialized) {
      //액세스 토큰을 얻어온다.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.containsKey("access_token")
          ? prefs.getString("access_token")
          : '';

      //소켓 초기화
      SocketIO socket = await manager.createInstance(SocketOptions(
          "http://" + hostUrl + '/test1',
          query: {'auth_token': token}));

      //채팅방 나가 있어도 메시지를 전달받게 함.
      await socket.on("global_message", (data) {
        // log.i(data);
      });

      socket.on('error', (e) {
        log.e(e);
      });

      await socket.onConnect((data) {
        log.i('소켓 연결');
      });

      await socket.connect();

      yield SocketLoaded(manager: manager, socket: socket);
    } else if (event is SocketDelete && currentState is SocketLoaded) {
      (currentState as SocketLoaded).dispose();
      yield SocketUninitialized();
    } else if (event is SocketDelete && currentState is SocketChatLoaded) {
      (currentState as SocketChatLoaded).dispose();
      yield SocketUninitialized();
    } else if (event is SocketChatEnter && currentState is SocketLoaded) {
      //소켓 이벤트 붙이기
      final socket = (currentState as SocketLoaded).socket;
      final manager = (currentState as SocketLoaded).manager;
      await socket.on("message", event.onMessage);
      yield SocketChatLoaded(manager: manager, socket: socket);
    } else if (event is SocketChatLeave && currentState is SocketChatLoaded) {
      //소켓 이벤트 빼버리기
      final socket = (currentState as SocketChatLoaded).socket;
      final manager = (currentState as SocketChatLoaded).manager;
      await socket.off('message');
      yield SocketLoaded(manager: manager, socket: socket);
    }
  }

  @override
  void dispose() {
    if (currentState is SocketLoaded) {
      (currentState as SocketLoaded).dispose();
    }
    if (currentState is SocketChatLoaded) {
      (currentState as SocketChatLoaded).dispose();
    }
    super.dispose();
  }
}
