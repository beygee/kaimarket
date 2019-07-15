import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/post/post_view_page.dart';
import 'package:week_3/post/post_card.dart';
import 'package:week_3/bloc/user_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WishPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WishPageState();
}

class WishPageState extends State<WishPage> {
  UserBloc _userBloc;
  PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
    _userBloc.dispatch(UserGetWish());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("위시 리스트", 
          style: TextStyle(fontSize: 16.0)),
        backgroundColor: Colors.white,
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return BlocBuilder(
        bloc: _userBloc,
        builder: (BuildContext context, UserState state) {
          if (state is UserUninitialized) {
            return Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: SpinKitChasingDots(
                        size: 30.0,
                        color: Colors.amber[200],
                      ),
                    ),
                  ),
                  SizedBox(height: screenAwareSize(50.0, context))
                ],
              ),
            );
          }
          if (state is UserError) {
            return Center(
              child: Text('포스트를 불러오는데 실패했습니다.'),
            );
          }
          if (state is UserLoaded) {
            log.i('UserLoaded');
            if (state.wish == null) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: SpinKitChasingDots(
                        size: 30.0,
                        color: Colors.amber[200],
                      ),
                    ),
                  ),
                  SizedBox(height: screenAwareSize(50.0, context))
                ],
              );
            }
            if (state.wish.isEmpty) {
              return Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(child: Text("게시글이 없어요!")),
                    ),
                    SizedBox(height: screenAwareSize(50.0, context))
                  ],
                ),
              );
            }
            return SafeArea(
              child: ListView.separated(
                padding:
                    EdgeInsets.only(bottom: screenAwareSize(50.0, context)),
                physics: BouncingScrollPhysics(),
                itemCount: state.wish.length,
                itemBuilder: (BuildContext context, int idx) {
                  return _buildRow(context, state.wish[idx]);
                },
                separatorBuilder: (BuildContext context, int i) {
                  return Divider();
                },
              ),
            );
          }
        });
  }

  Widget _buildRow(context, Post post) {
    bool wish = true;

    return PostCard(
        post: post,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostViewPage(postId: post.id)));
        },
        onTapHeart: () async {
          _userBloc.dispatch(UserChangeWish(postId: post.id));
          _userBloc.dispatch(SearchWishInUser(postId: post.id, wish: true));
        },
        issaved: wish);
  }
}
