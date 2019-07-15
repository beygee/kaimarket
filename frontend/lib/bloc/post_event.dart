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

class PostSelectCategory extends PostEvent{
  final int selectedcategory;

  PostSelectCategory({
    this.selectedcategory
  });

  @override
  String toString() {
    return "SelectCategory";
  }
}

class PostSearch extends PostEvent{
  final String searchdata;

  getData()=> this.searchdata;

  PostSearch({
    this.searchdata
  });

  @override
  String toString() {
    return "Search";
  }
}