import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/user.dart';
import 'package:week_3/bloc/user_event.dart';
import 'package:week_3/utils/dio.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserUninitialized();
  // ********** init 으로 user의 wishlist, purchaselist 갖고 있기
  // List<Post> wishList = [];
  // List<Post> purchasedList = [];

  // final _wishListController = StreamController<List<Post>>();
  // get _wishListStream => _wishListController.stream;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    try {
      if ((event is UserInit || event is UserError) &&
          currentState is UserUninitialized) {
        //유저를 초기화해준다.
        var res = await dio.getUri(getUri('/api/me'));

        if (res.statusCode == 200) {
          User user = User.fromJson(res.data);
          log.i('user init');
          yield UserLoaded(
            id: user.id,
            name: user.name,
            sales: user.sales,
            wish: user.wish,
            chats: user.chats,
          );
        } else {
          yield UserError();
        }
      }
      if (event is UserDelete && currentState is UserLoaded) {
        yield UserUninitialized();
      }
      if (event is UserChangeWish) {
        var res = await dio.post(
            getUri('/api/posts/').toString() + event.getPostId() + "/wish");
        final currentstate = (currentState as UserLoaded);

        yield UserLoaded(
            name: currentstate.name,
            id: currentstate.id,
            wish: currentstate.wish,
            sales: currentstate.sales,
            chats: currentstate.chats);
      }
      if (event is UserGetWish && currentState is UserLoaded) {
        var res = await dio.getUri(getUri('/api/me/wish'));
        final currentstate = (currentState as UserLoaded);
        List<Post> posts = res.data
            .map((p) {
              return Post.fromJson(p);
            })
            .toList()
            .cast<Post>();
        log.i(currentstate.name);
        log.i(posts[0].title);
        yield UserLoaded(
            name: currentstate.name,
            id: currentstate.id,
            wish: posts,
            sales: currentstate.sales,
            chats: currentstate.chats);
      }
      if (event is SearchWishInUser && currentState is UserLoaded) {
        List<Post> wishlist = (currentState as UserLoaded).wish;
        String postId = (event as SearchWishInUser).postId;
        bool wish = (event as SearchWishInUser).wish;

        wishlist = wishlist.map((p) {
          if (p.id != postId) return p;
          var post = Post.copyWith(p);
          post.isWish = wish;
          return post;
        }).toList();
        var currentstate = (currentState as UserLoaded);
        yield UserLoaded(
            id: currentstate.id,
            name: currentstate.name,
            wish: wishlist,
            sales: currentstate.sales,
            chats: currentstate.chats);
      }
    } catch (_) {
      print(_);
      yield UserError();
    }
  }
}
