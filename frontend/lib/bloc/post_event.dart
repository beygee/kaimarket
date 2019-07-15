import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:week_3/models/post.dart';

@immutable
abstract class PostEvent extends Equatable {
  PostEvent([List props = const []]) : super(props);
}

class PostFetch extends PostEvent {
  final int selectedCategory;
  final String searchText;

  PostFetch({this.selectedCategory = 0, this.searchText = ''});
  @override
  String toString() {
    return "Fetch";
  }
}

class PostInsert extends PostEvent {
  @override
  String toString() {
    return "Insert";
  }
}

class PostDelete extends PostEvent {
  @override
  String toString() {
    return "Delete";
  }
}

class SearchWish extends PostEvent {
  final bool wish;
  String postId;

  SearchWish({this.postId, this.wish});

  @override
  String toString() {
    return "searchWish";
  }
}
