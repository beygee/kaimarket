import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/layout/sell_overlay.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/chat/chat_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/my/my_page.dart';
import 'package:week_3/layout/tab_button.dart';
import 'package:week_3/layout/sell_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:week_3/wish/wish_page.dart';
import 'package:provider/provider.dart';
import 'package:week_3/store/store.dart';
import 'package:week_3/models/post.dart';

class DefaultLayout extends StatefulWidget {
  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout>
    with TickerProviderStateMixin {
  GlobalKey<LoadingWrapperState> _loadingWrapperKey =
      GlobalKey<LoadingWrapperState>();

  PageController _pageController = PageController();
  int _selectedTabIndex = 0;

  AnimationController _sellButtonController;
  Animation _sellButtonAnimation;
  Animation<Offset> _leftSmallSellButtonAnimation;

  //두번 백 버튼 누를시 꺼지게
  DateTime currentBackPressTime = DateTime.now();

  void _getAllPosts() async {
    final store = Provider.of<Store>(context);
    var res = await dio.getUri(getUri('/api/posts'));
<<<<<<< HEAD
    List<Post> list = List<Post>();
    for (var iterator in res.data) {
      Post post = Post.fromJson(iterator);
      list.add(post);
    }
    store.addPosts(list);
=======
    // log.i(res.data[0]);
    // store.addPosts(res);
>>>>>>> c2aab8d2f6de6a7b529a4fd4b398047d0c8d0c6f
  }

  @override
  void initState() {
    super.initState();
    _sellButtonController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _sellButtonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _sellButtonController, curve: Curves.decelerate));

    _leftSmallSellButtonAnimation =
        Tween<Offset>(begin: Offset(0.0, -15.0), end: Offset(-60.0, -75.0))
            .animate(CurvedAnimation(
                parent: _sellButtonController, curve: Curves.decelerate));
    _getAllPosts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _sellButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log.i("test");
    // _getAllPosts();
    
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (now.difference(currentBackPressTime) > Duration(seconds: 1)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(
            msg: "뒤로 가기 버튼을 한 번 더 누르면 종료됩니다.",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: screenAwareSize(10.0, context),
          );
          return false;
        }
        return true;
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildPageView(context),
          _buildBottomTabs(context),
          _buildSellButton(context),
          _buildSellOverlay(context),
        ],
      ),
    );
  }

  Widget _buildPageView(context) {
    return Positioned.fill(
      child: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (idx) {
          setState(() {
            _selectedTabIndex = idx;
          });
        },
        controller: _pageController,
        itemCount: 4,
        itemBuilder: (context, idx) {
          switch (idx) {
            case 0:
              return HomePage();
            case 1:
              return ChatPage();
            case 2:
              return WishPage();
            case 3:
              return MyPage();
          }
        },
      ),
    );
  }

  Widget _buildBottomTabs(context) {
    return Positioned(
      height: screenAwareSize(50.0, context),
      left: 0.0,
      right: 0.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: screenAwareSize(50.0, context),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12,
              )
            ]),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TabButton(
                    icon: Icons.home,
                    text: "홈",
                    index: 0,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    icon: FontAwesomeIcons.commentDots,
                    text: "채팅",
                    iconSize: 16.0,
                    index: 1,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
                SizedBox(width: screenAwareSize(50.0, context)),
                Expanded(
                  child: TabButton(
                    icon: Icons.favorite_border,
                    text: "찜",
                    iconSize: 16.0,
                    index: 2,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    icon: FontAwesomeIcons.user,
                    text: "내 메뉴",
                    iconSize: 16.0,
                    index: 3,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellButton(context) {
    return Positioned(
      bottom: screenAwareSize(15.0, context),
      child: SellButton(
        text: "판매",
        fontSize: 8,
        icon: Icons.add,
        iconSize: 20.0,
        padding: 10.0,
        onPressed: _onPressedSellButton,
      ),
    );
  }

  _onPressedSellButton() {
    _sellButtonController.forward(from: 0.0);
  }

  _onPressCancel() {
    _sellButtonController.reverse();
  }

  Widget _buildSellOverlay(context) {
    return SellOverlay(
      listenable: _sellButtonAnimation,
      onPressCancel: _onPressCancel,
      leftAnimation: _leftSmallSellButtonAnimation,
    );
  }
}
