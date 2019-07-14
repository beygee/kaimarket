import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/post.dart';

@immutable
abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {
  @override
  String toString() => 'PostUninitialized';
}

class PostError extends PostState {
  @override
  String toString() => 'PostError';

}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded({
    this.posts,
  }) : super([PostState]);

  PostLoaded copyWith({
    List<Post> posts,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return super.toString();
  }
}

class PostSearched extends PostState{
  final List<Post> searchedPosts;
  PostSearched({
    this.searchedPosts,
  }) : super([PostState]);

  @override
  String toString() {
    return super.toString();
  }
}

class PostSelectedCategory extends PostState{
  final List<Post> categoryPosts;
  PostSelectedCategory({
    this.categoryPosts,
  }) : super([PostState]);

  @override
  String toString() {
    return super.toString();
  }
}