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
      log.i(posts[0]);
      yield PostLoaded(posts: posts);
      return;
    }
    if (event is PostInsert){
      // final 
    }
    if (event is PostDelete){

    }
    } catch (_) {
      print(_);
      yield PostError();
    }
  }

  // bool _hasReachedMax(PostState state) =>
  //   state is PostLoaded && state.hasReachdedMax;

  Future<List<Post>> _getAllPost() async{
    var response = await dio.getUri(getUri('/api/posts'));
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