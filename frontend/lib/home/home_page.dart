import 'package:flutter/material.dart';
import 'package:week_3/post/post_view_page.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/home/category_button.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/post/post_card.dart';
import 'package:week_3/models/category.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/bloc/user_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:week_3/models/post.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PostBloc _postBloc;
  UserBloc _userBloc;

  int selectedCategory = 0;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
    _postBloc.dispatch(PostFetch());
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Column(
            children: <Widget>[
              SizedBox(
                  height: MediaQuery.of(context).padding.top), //상단 상태바 높이 띄우기
              _buildSearchInput(context),
              _buildCategoryList(context),
              SizedBox(height: screenAwareSize(10.0, context)),
              BlocBuilder(
                bloc: _postBloc,
                builder: (BuildContext context, PostState state) {
                  if (state is PostUninitialized) {
                    return Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: SpinKitChasingDots(
                                size: 30.0,
                                color: ThemeColor.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: screenAwareSize(50.0, context))
                        ],
                      ),
                    );
                  }
                  if (state is PostError) {
                    return Center(
                      child: Text('포스트를 불러오는데 실패했습니다.'),
                    );
                  }
                  if (state is PostLoaded) {
                    if (state.posts.isEmpty) {
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
                    return Expanded(
                        child: _buildSuggestions(context, state.posts));
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchInput(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: screenAwareSize(20.0, context),
        bottom: screenAwareSize(10.0, context),
      ),
      child: TextField(
        onSubmitted: (_) => _searchPosts(),
        controller: searchController,
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () => _searchPosts(),
            child: Icon(Icons.search),
          ),
          hintText: "상품을 검색해보세요",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenAwareSize(15.0, context)),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.black.withOpacity(0.03),
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        ),
      ),
    );
  }

  void _searchPosts() {
    _postBloc.dispatch(PostFetch(
        searchText: searchController.text, selectedCategory: selectedCategory));
  }

  Widget _buildCategoryList(context) {
    return Container(
      height: screenAwareSize(70, context),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, idx) {
          return HomeCategoryButton(
            active: selectedCategory == idx,
            icon: CategoryList[idx].icon,
            text: CategoryList[idx].name,
            onPressed: () {
              setState(() {
                selectedCategory = idx;
                _postBloc.dispatch(PostFetch(
                    selectedCategory: selectedCategory,
                    searchText: searchController.text));
              });
            },
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemCount: CategoryList.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildSuggestions(context, posts) {
    return RefreshIndicator(
      displacement: 20.0,
      onRefresh: () async {
        _searchPosts();
      },
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: screenAwareSize(50.0, context)),
        // physics: BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int idx) {
          return _buildRow(context, posts[idx]);
        },
        separatorBuilder: (BuildContext context, int i) {
          return Divider();
        },
      ),
    );
  }

  Widget _buildRow(context, Post post) {
    bool wish = post.isWish;

    return PostCard(
        post: post,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostViewPage(postId: post.id)));
        },
        onTapHeart: () async {
          //서버 통신....
          var res = await dio.postUri(getUri('/api/posts/${post.id}/wish'));
          log.i(res.data);

          bool bWish = res.data['wish'];

          // _userBloc.dispatch(UserChangeWish(postId: post.id));
          // post.isWish = !post.isWish;
          _postBloc.dispatch(SearchWish(postId: post.id, wish: bWish));

          if (bWish) {
            Fluttertoast.showToast(
              msg: "찜 목록에 추가하였습니다.",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: screenAwareSize(10.0, context),
            );
          } else {
            Fluttertoast.showToast(
              msg: "찜 목록에서 제거하였습니다.",
              toastLength: Toast.LENGTH_SHORT,
              fontSize: screenAwareSize(10.0, context),
            );
          }
        },
        issaved: wish);
  }
}
