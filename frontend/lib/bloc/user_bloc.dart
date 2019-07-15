import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/user.dart';

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
          log.i(res.data);
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
      if (event is UserDelete && currentState is UserLoaded) {
        yield UserUninitialized();
      }
    } catch (_) {
      print(_);
      yield UserError();
    }
  }
}
