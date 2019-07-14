import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/user.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class Store with ChangeNotifier {
  //내 정보
  User user;

  //홈에 있는 포스트 목록
  List<Post> posts = List<Post>();

  //소켓

  //유저 초기화
  void initUser(Map<String, dynamic> json) {
    this.user = User.fromJson(json);
    notifyListeners();
  }

  //포스트를 추가한다.
  void addPosts(List<Post> saved) {
    for (Post iterator in saved){
      posts.add(iterator);
    }
    log.i('완료');
    notifyListeners();
  }
}
