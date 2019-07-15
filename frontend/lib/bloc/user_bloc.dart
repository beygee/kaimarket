import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/dio.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserUninitialized();
  // ********** init 으로 user의 wishlist, purchaselist 갖고 있기
  List<Post> wishList = [];
  List<Post> purchasedList = [];

  // final _wishListController = StreamController<List<Post>>();
  // get _wishListStream => _wishListController.stream;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    try {
      if (event is UserInit && currentState is UserUninitialized) {
        //유저를 초기화해준다.
  // d

        // final posts = await _getAllPost();
        // // yield UserLoaded(wish: posts[0], sell: posts[1], purchased: posts[2]);
        // // ******* userload 할 때 initialize 해주기
        // wishList = posts[0];
        // purchasedList = posts[2];
      }
      if (event is UserAddOrRemoveWish) {
        //   final wishes = await _addOrRemoveWish(item);
        //    yield UserAddedOrRemovedWish(wish: wishes);
        return;
      }
      if (event is UserAddPurchase) {
        //    final purchases = await _addPurchase(item);
        //   yield UserAddedPurchase(purchase: purchases);
        return;
      }
    } catch (_) {
      print(_);
      yield UserError();
    }
  }

  Future<List<List<Post>>> _getAllPost() async {
    var wishRes = await dio.getUri(getUri('/api/posts'));
    var sellRes = await dio.getUri(getUri('/api/posts'));
    var purchasedRes = await dio.getUri(getUri('/api/posts'));
    List<List<Post>> lists = List<List<Post>>();
    List<Post> wishList = List<Post>();
    List<Post> sellList = List<Post>();
    List<Post> purchasedList = List<Post>();
    for (var iterator in wishRes.data) {
      Post post = Post.fromJson(iterator);
      wishList.add(post);
    }
    for (var iterator in sellRes.data) {
      Post post = Post.fromJson(iterator);
      sellList.add(post);
    }
    for (var iterator in purchasedRes.data) {
      Post post = Post.fromJson(iterator);
      purchasedList.add(post);
    }

    return lists;
  }

  Future<List<Post>> _addOrRemoveWish(Post item) async {
    // ?? /api/wishes 뭐 이런거 아닌가,,,
    // var wishRes = await dio.getUri(getUri('/api/posts'));
    // List<Post> wishList = List<Post>();
    // for (var iterator in wishRes.data){
    //   Post post = Post.fromJson(iterator);
    //   wishList.add(post);
    // }
    if (wishList.contains(item)) {
      wishList.remove(item);
    } else {
      wishList.add(item);
    }
    // _wishListController.sink.add(wishList);
    // ****db에 업데이트******
  }

  Future<List<Post>> _addPurchase(Post item) async {
    purchasedList.add(item);
    // ****db에 업데이트******
  }
}
