import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/chat/chat_page.dart';
import 'package:week_3/post/post_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/my/my_page.dart';
import 'package:week_3/layout/tab_button.dart';
import 'package:week_3/post/google_map.dart';

class DefaultLayout extends StatefulWidget {
  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  PageController _pageController = PageController();
  int _selectedTabIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildPageView(context),
        _buildBottomTabs(context),
      ],
    );
  }

  Widget _buildPageView(context) {
    return Positioned.fill(
      child: PageView.builder(
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
              return PostPage();
            case 2:
              return DetailView();
            case 3:
              return MyPage();
          }
        },
      ),
    );
  }

  Widget _buildBottomTabs(context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: screenAwareSize(50.0, context),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            color: Colors.black12,
          )
        ]),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Row(
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
                SizedBox(
                  width: screenAwareSize(50, context),
                ),
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
            _buildSellButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSellButton(context) {
    return Positioned(
      bottom: screenAwareSize(15.0, context),
      child: RawMaterialButton(
        padding: EdgeInsets.all(screenAwareSize(10.0, context)),
        shape: CircleBorder(),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.add,
              size: screenAwareSize(24.0, context),
              color: Colors.white,
            ),
            Text("판매",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenAwareSize(10.0, context)))
          ],
        ),
        fillColor: ThemeColor.primary,
        onPressed: () {},
      ),
    );
  }
}
