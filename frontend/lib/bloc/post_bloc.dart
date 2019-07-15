import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/dio.dart';
import 'package:week_3/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    print(currentState);
    try {
      if (event is PostFetch) {
        yield PostUninitialized();
        final searchText = (event as PostFetch).searchText;
        final selectedCategory = (event as PostFetch).selectedCategory;

        //데이터 받아오기
        var res = await dio.getUri(getUri('/api/posts',
            {'q': searchText, 'category': selectedCategory.toString()}));

        List<Post> posts = res.data
            .map((p) {
              return Post.fromJson(p);
            })
            .toList()
            .cast<Post>();
        yield PostLoaded(posts: posts);
      }
    } catch (_) {
      print(_);
      yield PostError();
    }
  }

  Future<List<Post>> _getAllPost() async {
    var response = await dio.getUri(getUri('/api/posts'));
    List<Post> list = List<Post>();
    for (var iterator in response.data) {
      Post post = Post.fromJson(iterator);
      list.add(post);
    }

    return list;
  }

  // @override
  // //이벤트의 흐름에서 디바운스시킨다.
  // Stream<PostState> transform(
  //     Stream<PostEvent> events, Stream<PostState> next(PostEvent event)) {
  //   return super.transform(
  //     (events as Observable<PostEvent>)
  //         .debounceTime(Duration(milliseconds: 500)),
  //     next,
  //   );
  // }
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
