import 'package:flutter/material.dart';
import 'package:week_3/models/category.dart';
import 'package:week_3/models/book.dart';
import 'package:week_3/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:week_3/utils/utils.dart';

class Post extends Equatable {
  int id;
  String title;
  String content;
  int price;
  int view;
  int wish;
  int chat;
  String createdAt;
  String updatedAt;
  bool isWish;
  bool isSold;

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
    this.createdAt,
    this.updatedAt,
    this.isWish,
    this.isSold,

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

  Post.copyWith(Post p) {
    id = p.id;
    title = p.title;

    content = p.content;
    price = p.price;
    view = p.view;
    wish = p.wish;
    chat = p.chat;
    createdAt = p.createdAt;
    updatedAt = p.updatedAt;
    isWish = p.isWish;
    isSold = p.isSold;

    images = p.images;
    user = p.user;
    locationLat = p.locationLat;
    locationLng = p.locationLng;
    category = p.category;

    //도서 변수
    isBook = p.isBook;
    bookMajor = p.bookMajor;
    bookAuthor = p.bookAuthor;
    bookPublisher = p.bookPublisher;
    bookPubDate = p.bookPubDate;
    bookImage = p.bookImage;
    bookPrice = p.bookPrice;
  }

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        price = json['price'],
        view = json['view'],
        wish = json['wish'],
        chat = json['chat'],
        locationLat = json['locationLat'].toDouble(),
        locationLng = json['locationLng'].toDouble(),
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isBook = json['isBook'],
        isWish = json['isWish'],
        isSold = json['isSold'],
        bookMajor = json['bookMajor'],
        bookAuthor = json['bookAuthor'],
        bookPublisher = json['bookPublisher'],
        bookPubDate = json['bookPubDate'],
        bookImage = json['bookImage'],
        bookPrice = json['bookPrice'] {
    try {
      if (json['images'] != null) {
        images = json['images']
            ?.where((p) {
              return p is! String;
            })
            .map((image) {
              return image.cast<String, String>();
            })
            .toList()
            .cast<Map<String, String>>();
      }

      if (json['categoryId'] != null) {
        category = CategoryList[json['categoryId']];
      }

      if (json['user'] != null) {
        user = User.fromJson(json['user']);
      }
    } catch (e) {
      log.e(e);
    }
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
      'id': id,
      'title': title,
      'content': content,
      'price': price,
      'view': view,
      'wish': wish,
      'chat': chat,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isBook': isBook,
      'bookMajor': bookMajor,
      'bookAuthor': bookAuthor,
      'bookPublisher': bookPublisher,
      'bookPubDate': bookPubDate,
      'bookImage': bookImage,
      'bookPrice': bookPrice,
      'categoryId': category.id,
      'images': images,
    };
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Post &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            isWish == other.isWish;
  }

  @override
  int get hashCode => id.hashCode;
}
