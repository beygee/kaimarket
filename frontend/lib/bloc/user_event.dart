import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:week_3/models/post.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class UserInit extends UserEvent {
  @override
  String toString() {
    return "Init";
  }
}

class UserDelete extends UserEvent {
  @override
  String toString() {
    return "Delete";
  }
}

class UserAddOrRemoveWish extends UserEvent {
  final Post item;

  getData() => this.item;

  UserAddOrRemoveWish({this.item});

  @override
  String toString() {
    return "AddOrRemoveWish";
  }
}

class UserAddPurchase extends UserEvent {
  final Post item;

  getData() => this.item;

  UserAddPurchase({this.item});

  @override
  String toString() {
    return "AddPurchase";
  }
}
