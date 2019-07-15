import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/models/chat.dart';

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class UserUninitialized extends UserState {
  @override
  String toString() => 'UserUninitialized';
}

class UserError extends UserState {
  @override
  String toString() => 'UserError';
}

class UserLoaded extends UserState {
  final String id;
  final String name;

  final List<Post> wish;
  final List<Post> sales;
  final List<Chat> chats;

  UserLoaded({
    this.id,
    this.name,
    this.wish,
    this.sales,
    this.chats,
  }) : super([id, name, wish, sales, chats]);

  @override
  String toString() {
    return super.toString();
  }
}

class UserAddedOrRemovedWish extends UserState {
  final List<Post> wish;
  UserAddedOrRemovedWish({
    this.wish,
  }) : super([UserState]);

  @override
  String toString() {
    return super.toString();
  }
}

class UserAddedPurchase extends UserState {
  final List<Post> purchase;
  UserAddedPurchase({
    this.purchase,
  }) : super([UserState]);

  @override
  String toString() {
    return super.toString();
  }
}
