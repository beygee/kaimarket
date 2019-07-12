import 'package:flutter/material.dart';

class Post {
  Post({
    this.title,
    this.content,
    this.price,
    this.viewCount,
    this.wishCount,
    this.chatCount,
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
