import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class Category {
  final String name;
  final int id;
  final IconData icon;

  Category({this.name, this.id, this.icon});

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
    };
  }
}

List<Category> CategoryList = [
  Category(name: "전체", id: 0, icon: FontAwesomeIcons.thLarge),
  Category(name: "디지털/가전", id: 1, icon: FontAwesomeIcons.desktop),
  Category(name: "생활/가구", id: 2, icon: FontAwesomeIcons.couch),
  Category(name: "탈것", id: 3, icon: FontAwesomeIcons.bicycle),
  Category(name: "뷰티/미용", id: 4, icon: IconData(0xe603, fontFamily: 'custom')),
  Category(name: "여성의류", id: 5, icon: IconData(0xe60c, fontFamily: 'custom')),
  Category(name: "남성의류", id: 6, icon: IconData(0xe60b, fontFamily: 'custom')),
  Category(name: "도서", id: 7, icon: FontAwesomeIcons.book),
  Category(name: "기타", id: 8, icon: IconData(0xe60d, fontFamily: 'custom')),
];
