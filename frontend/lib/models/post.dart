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
  int status;
  // status 0: 판매중, 1: 예약중, 2: 판매완료

  List<Map<String, dynamic>> images = [];
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
    this.id,
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
    this.status,

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
  }) : super([
          id,
          title,
          content,
          price,
          view,
          wish,
          chat,
          createdAt,
          updatedAt,
          isWish,
          isSold,
          status,
          images,
          user,
          locationLat,
          locationLng,
          category,
          isBook,
          bookMajor,
          bookAuthor,
          bookPublisher,
          bookPubDate,
          bookPrice,
          bookImage,
        ]);

  @override
  String toString() => 'Post { _id: $title }';

  Post copyWith({
    int id,
    String title,
    String content,
    int price,
    int view,
    int wish,
    int chat,
    String createdAt,
    String updatedAt,
    bool isWish,
    bool isSold,
    int status,
    List<Map<String, dynamic>> images,
    User user,
    double locationLat,
    double locationLng,
    Category category,
    bool isBook,
    String bookMajor,
    String bookAuthor,
    String bookPublisher,
    String bookPubDate,
    String bookImage,
    int bookPrice,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      view: view ?? this.view,
      wish: wish ?? this.wish,
      chat: chat ?? this.chat,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isWish: isWish ?? this.isWish,
      isSold: isSold ?? this.isSold,
      status: status ?? this.status,
      images: images ?? this.images,
      user: user ?? this.user,
      locationLat: locationLat ?? this.locationLat,
      locationLng: locationLng ?? this.locationLng,
      category: category ?? this.category,
      isBook: isBook ?? this.isBook,
      bookMajor: bookMajor ?? this.bookMajor,
      bookAuthor: bookAuthor ?? this.bookAuthor,
      bookPublisher: bookPublisher ?? this.bookPublisher,
      bookPubDate: bookPubDate ?? this.bookPubDate,
      bookImage: bookImage ?? this.bookImage,
      bookPrice: bookPrice ?? this.bookPrice,
    );
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
        status = json['status'],
        bookMajor = json['bookMajor'],
        bookAuthor = json['bookAuthor'],
        bookPublisher = json['bookPublisher'],
        bookPubDate = json['bookPubDate'],
        bookImage = json['bookImage'],
        bookPrice = json['bookPrice'] {
    try {
      if (json['images'] != null) {
        images = json['images']
            .map((image) {
              return image;
            })
            .toList()
            .cast<Map<String, dynamic>>();
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
      'categoryId': category?.id,
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
