import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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
      if (event is UserInit &&
          (state is UserUninitialized || state is UserError)) {
        //유저를 초기화해준다.
        var res = await dio.getUri(getUri('/api/me'));

        if (res.statusCode == 200) {
          User user = User.fromJson(res.data);
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
      if (event is UserDelete) {
        yield UserUninitialized();
      }
      if (event is UserGetWish && state is UserLoaded) {
        var res = await dio.getUri(getUri('/api/me/wish'));
        final _state = (state as UserLoaded);
        List<Post> posts = res.data
            .map((p) {
              return Post.fromJson(p);
            })
            .toList()
            .cast<Post>();

        yield UserLoaded(
            name: _state.name,
            id: _state.id,
            wish: posts,
            sales: _state.sales,
            chats: _state.chats);
      }
      if (event is SearchWishInUser && state is UserLoaded) {
        final _state = (state as UserLoaded);
        List<Post> wishlist = _state.wish;
        int postId = (event as SearchWishInUser).postId;
        bool wish = (event as SearchWishInUser).wish;

        wishlist = wishlist.map((p) {
          if (p.id != postId) return p;
          var post = p.copyWith(isWish: wish);
          return post;
        }).toList();

        yield UserLoaded(
            id: _state.id,
            name: _state.name,
            wish: wishlist,
            sales: _state.sales,
            chats: _state.chats);
      }
      if (event is UserChangeProfile && state is UserLoaded) {
        log.i("userchangeprofile");
        String profilename = event.profilename;
        await dio
            .postUri(getUri('/api/auth/name'), data: {"name": profilename});
        var _state = (state as UserLoaded);
        yield UserLoaded(
            id: _state.id,
            name: profilename,
            wish: _state.wish,
            sales: _state.sales,
            chats: _state.chats);
      }
    } catch (_) {
      print(_);
      yield state;
    }
  }
}
