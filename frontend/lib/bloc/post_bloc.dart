import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/dio.dart';
import 'package:week_3/utils/utils.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    try{
    if (event is PostInit) {
      final posts = await _getAllPost();
      yield PostLoaded(posts: posts);
    }
    if (event is PostSelectCategory){
      List<Post> categoryPosts;
      categoryPosts = await _getCategoryPost(event.getSelectedCategory().toString());
      log.i(categoryPosts);
      log.i(event.getSelectedCategory().toString());
      yield PostSelectedCategory(categoryPosts: categoryPosts);
    }
    if (event is PostSearch){
      final searchedPosts = await _getSearchedPost(event.getData().toString());
      yield PostSearched(searchedPosts: searchedPosts);
    }
    } catch (_) {
      print(_);
      yield PostError();
    }
  }

  Future<List<Post>> _getAllPost() async{
    var response = await dio.getUri(getUri('/api/posts'));
    List<Post> list = List<Post>();
    for (var iterator in response.data){
      Post post = Post.fromJson(iterator);
      list.add(post);
    }
    
    return list;
  }

  Future<List<Post>> _getCategoryPost(String selectedCategory) async{
    var response = await dio.getUri(getUri('/api/posts',{'category':selectedCategory}));
    List<Post> list = List<Post>();
    for (var iterator in response.data){
      Post post = Post.fromJson(iterator);
      list.add(post);
    }
    return list;
  }

  Future<List<Post>> _getSearchedPost(String searchdata) async{
    var response = await dio.getUri(getUri('/api/posts',{'q':searchdata}));
    List<Post> list = List<Post>();
    for (var iterator in response.data){
      Post post = Post.fromJson(iterator);
      list.add(post);
    }
    return list;
  }
}

  // void _getAllPosts() async {
  //   final store = Provider.of<Store>(context);
  //   var res = await dio.getUri(getUri('/api/posts'));
  //   List<Post> list = List<Post>();
  //   for (var iterator in res.data) {
  //     Post post = Post.fromJson(iterator);
  //     list.add(post);
  //   }
  //   store.addPosts(list);
  // }