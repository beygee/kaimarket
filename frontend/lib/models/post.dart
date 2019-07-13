import 'package:flutter/material.dart';

class Post {
  Post({
    this.title,
    this.content,
    this.price = 0,
    this.viewCount = 0,
    this.wishCount = 0,
    this.chatCount = 0,
    this.created,
    this.urls,
    this.user,
    this.location,
    this.category,
  });

  String title;
  String content;
  int price;
  int viewCount;
  int wishCount;
  int chatCount;
  DateTime created;
  List<String> urls;
  var user;
  var location;
  var category;
}
