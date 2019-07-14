import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostEvent extends Equatable {
  PostEvent([List props = const []]) : super(props);
}

class PostInit extends PostEvent {
  @override
  String toString() {
    return "Init";
  }
}

class PostInsert extends PostEvent {
  @override
  String toString(){
    return "Insert";
  }
}

class PostDelete extends PostEvent {
  @override
  String toString() {
    return "Delete";
  }
}
