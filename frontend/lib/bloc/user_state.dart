import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:week_3/models/post.dart';

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
  final List<Post> wish;
  final List<Post> sell;
  final List<Post> purchased;
  
  UserLoaded({
    this.wish,
    this.sell,
    this.purchased
  }) : super([UserState]);

  @override
  String toString() {
    return super.toString();
  }
}