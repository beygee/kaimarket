import 'package:flutter/material.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/post/post_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/my/my_page.dart';

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
          switch(idx){
            case 0:
            return HomePage();
            case 1: 
            return PostPage();
            case 2: 
            return Container();
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
                    iconSize: 20.0,
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
                    iconSize: 20.0,
                    index: 2,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
                Expanded(
                  child: TabButton(
                    icon: FontAwesomeIcons.user,
                    text: "내 메뉴",
                    iconSize: 20.0,
                    index: 3,
                    controller: _pageController,
                    selectedIndex: _selectedTabIndex,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: screenAwareSize(15.0, context),
              child: RawMaterialButton(
                padding: EdgeInsets.all(screenAwareSize(10.0, context)),
                shape: CircleBorder(),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    Text("판매",
                        style: TextStyle(color: Colors.white, fontSize: 12.0))
                  ],
                ),
                fillColor: ThemeColor.primary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final int index;
  final PageController controller;
  final int selectedIndex;

  TabButton({
    Key key,
    this.icon,
    this.text,
    this.iconSize = 28.0,
    @required this.index,
    @required this.controller,
    this.selectedIndex,
  }) : super(key: key);

  bool get bActive => selectedIndex == index;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        controller.jumpToPage(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            icon,
            size: iconSize,
            color: bActive ? ThemeColor.primary : Colors.black,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 12.0,
                color: bActive ? ThemeColor.primary : Colors.black,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
