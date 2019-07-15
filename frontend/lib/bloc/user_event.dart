import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

class UserAddOrRemoveWish extends UserEvent {
  @override
  String toString() {
    return "AddOrRemoveWish";
  }
}

class UserAddPurchase extends UserEvent {
  @override
  String toString() {
    return "AddPurchase";
  }
}