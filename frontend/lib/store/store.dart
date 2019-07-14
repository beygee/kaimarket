import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/models/user.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:week_3/utils/utils.dart';

class Store with ChangeNotifier {
  //내 정보
  User user;

  //홈에 있는 포스트 목록
  List<Post> posts = List<Post>();

  //소켓
  SocketIOManager manager = SocketIOManager();
  SocketIO socket;

  //앱 초기화 시 실행
  void initSocket() async {
    log.i("연결되어라");
    socket = await manager.createInstance("http://$hostUrl");
    socket.onConnectError(log.i);
    socket.onConnectTimeout(log.i);
    socket.onError(log.i);
    socket.onDisconnect(log.i);
    await socket.onConnect((data) {
      log.i('연결');
    });
    await socket.connect();
  }

  @override
  void dispose() {
    log.i("ASD");
    manager.clearInstance(socket).then((data) {});
    super.dispose();
  }

  //유저 초기화
  void initUser(Map<String, dynamic> json) {
    this.user = User.fromJson(json);
    notifyListeners();
  }

  //포스트를 추가한다.
  void addPosts(List<Post> saved) {
    posts.addAll(saved);
    notifyListeners();
  }
}
