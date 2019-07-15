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
    this.created,
    this.updated,
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
    created = p.created;
    updated = p.updated;
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
        isWish = json['isWish'],
        isSold = json['isSold'],
        bookMajor = json['bookMajor'],
        bookAuthor = json['bookAuther'],
        bookPublisher = json['bookPublisher'],
        bookPubDate = json['bookPubDate'],
        bookImage = json['bookImage'],
        bookPrice = json['bookPrice'] {
    try {
      images = json['images']
          .where((p) {
            return p is! String;
          })
          .map((image) {
            return image.cast<String, String>();
          })
          .toList()
          .cast<Map<String, String>>();

      if (json['category'] is! String) {
        category = CategoryList[json['category']['id']];
      }

      if (json['user'] is! String) {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isWish == other.isWish;

  @override
  int get hashCode => id.hashCode;
}
