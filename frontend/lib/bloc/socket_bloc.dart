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
      log.i("연결!!");

      //액세스 토큰을 얻어온다.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.containsKey("access_token")
          ? prefs.getString("access_token")
          : '';

      //소켓 초기화
      SocketIO socket = await manager.createInstance(SocketOptions(
          "http://" + hostUrl + '/test',
          query: {'auth_token': token}));

      await socket.on("message", (data) {
        log.i(data);
      });

      socket.on('error', (e) {
        log.e(e);
      });

      await socket.onConnect((data) {
        log.i('연결');
      });

      await socket.connect();

      yield SocketLoaded(manager: manager, socket: socket);
    } else if (event is SocketDelete && currentState is SocketLoaded) {
      (currentState as SocketLoaded).dispose();
      yield SocketUninitialized();
    }
  }

  @override
  void dispose() {
    if (currentState is SocketLoaded) {
      (currentState as SocketLoaded).dispose();
    }
    super.dispose();
  }
}
