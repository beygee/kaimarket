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
    @required this.id,
    @required this.name,
    @required this.wish,
    @required this.sales,
    @required this.chats,
  }) : super([id, name, wish, sales, chats]);

  @override
  String toString() {
    return "UserLoaded";
  }
}