import 'package:flutter/material.dart';

class Item{
  Item({
    this.title,
    this.content,
    this.price,
    this.viewCount,
    this.wishCount,
    this.chatCount,
    this.created,
    this.uri,
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
  List<String> uri;
  var user;
  var location;
  var category;
}