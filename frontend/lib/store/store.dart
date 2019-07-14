import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';

class Store with ChangeNotifier{
  List<Post> posts = List<Post>();

  void addPosts(List<Post> saved) {
    posts.addAll(saved);
    log.i(posts);
    notifyListeners();
  }
}