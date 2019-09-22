// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    price: json['price'] as int,
    view: json['view'] as int,
    wish: json['wish'] as int,
    chat: json['chat'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    isWish: json['isWish'] as bool,
    isSold: json['isSold'] as bool,
    status: json['status'] as int,
    images: (json['images'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    locationLat: (json['locationLat'] as num)?.toDouble(),
    locationLng: (json['locationLng'] as num)?.toDouble(),
    category: _parseCategory(json['categoryId'] as int),
    isBook: json['isBook'] as bool,
    bookMajor: json['bookMajor'] as String,
    bookAuthor: json['bookAuthor'] as String,
    bookPublisher: json['bookPublisher'] as String,
    bookPubDate: json['bookPubDate'] as String,
    bookPrice: json['bookPrice'] as int,
    bookImage: json['bookImage'] as String,
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'price': instance.price,
      'view': instance.view,
      'wish': instance.wish,
      'chat': instance.chat,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'isWish': instance.isWish,
      'isSold': instance.isSold,
      'status': instance.status,
      'images': instance.images,
      'user': instance.user,
      'locationLat': instance.locationLat,
      'locationLng': instance.locationLng,
      'categoryId': instance.category,
      'isBook': instance.isBook,
      'bookMajor': instance.bookMajor,
      'bookAuthor': instance.bookAuthor,
      'bookPublisher': instance.bookPublisher,
      'bookPubDate': instance.bookPubDate,
      'bookImage': instance.bookImage,
      'bookPrice': instance.bookPrice,
    };
