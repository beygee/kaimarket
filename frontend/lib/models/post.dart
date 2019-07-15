import 'package:flutter/material.dart';
import 'package:week_3/models/category.dart';
import 'package:week_3/models/book.dart';
import 'package:week_3/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:week_3/utils/utils.dart';

class Post extends Equatable {
  String id;
  String title;
  String content;
  int price;
  int view;
  int wish;
  int chat;
  String created;
  String updated;

  List<Map<String, String>> images = [];
  User user;
  double locationLat;
  double locationLng;
  Category category;

  //도서 변수
  bool isBook;
  String bookMajor;
  String bookAuthor;
  String bookPublisher;
  String bookPubDate;
  String bookImage;
  int bookPrice;

  Post({
    this.title,
    this.content,
    this.price = 0,
    this.view = 0,
    this.wish = 0,
    this.chat = 0,
    this.created,
    this.updated,

    //
    this.images,
    this.user,
    this.locationLat,
    this.locationLng,
    this.category,

    //도서 변수
    this.isBook = false,
    this.bookMajor,
    this.bookAuthor,
    this.bookPublisher,
    this.bookPubDate,
    this.bookPrice = 0,
    this.bookImage,
  });

  @override
  String toString() => 'Post { _id: $title }';

  Post.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        content = json['content'],
        price = json['price'],
        view = json['view'],
        wish = json['wish'],
        chat = json['chat'],
        locationLat = json['locationLat'].toDouble(),
        locationLng = json['locationLng'].toDouble(),
        created = json['created'],
        updated = json['updated'],
        isBook = json['isBook'],
        bookMajor = json['bookMajor'],
        bookAuthor = json['bookAuther'],
        bookPublisher = json['bookPublisher'],
        bookPubDate = json['bookPubDate'],
        bookImage = json['bookImage'],
        bookPrice = json['bookPrice'] {
    images = json['images']
        .map((image) {
          return image.cast<String, String>();
        })
        .toList()
        .cast<Map<String, String>>();

    category = CategoryList[json['category']['id']];
    user = User.fromJson(json['user']);
  }

  //책으로부터 정보 받아오기
  Post.fromBook(Book book)
      : title = book.title,
        bookAuthor = book.author,
        bookPublisher = book.publisher,
        bookPubDate = book.pubdate,
        bookPrice = book.price,
        bookImage = book.image,
        isBook = true,
        category = CategoryList[7];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'price': price,
      'view': view,
      'wish': wish,
      'chat': chat,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'created': created,
      'updated': updated,
      'isBook': isBook,
      'bookMajor': bookMajor,
      'bookAuther': bookAuthor,
      'bookPublisher': bookPublisher,
      'bookPubDate': bookPubDate,
      'bookImage': bookImage,
      'bookPrice': bookPrice,
      'category': category.toJson(),
      'images': images,
    };
  }
}
