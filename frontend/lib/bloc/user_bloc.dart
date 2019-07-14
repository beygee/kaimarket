import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/dio.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    try{
    if (event is UserInit) {
      final posts = await _getAllPost();
      yield UserLoaded(wish: posts[0], sell: posts[1], purchased: posts[2]);
      return;
    }
    } catch (_) {
      print(_);
      yield UserError();
    }
  }

  Future<List<List<Post>>> _getAllPost() async{
    var wishRes = await dio.getUri(getUri('/api/posts'));
    var sellRes = await dio.getUri(getUri('/api/posts'));
    var purchasedRes = await dio.getUri(getUri('/api/posts'));
    List<List<Post>> lists = List<List<Post>>();
    List<Post> wishList = List<Post>();
    List<Post> sellList = List<Post>();
    List<Post> purchasedList = List<Post>();
    for (var iterator in wishRes.data){
      Post post = Post.fromJson(iterator);
      wishList.add(post);
    }
    for (var iterator in sellRes.data){
      Post post = Post.fromJson(iterator);
      sellList.add(post);
    }
    for (var iterator in purchasedRes.data){
      Post post = Post.fromJson(iterator);
      purchasedList.add(post);
    }
    
    return lists;
  }
}
