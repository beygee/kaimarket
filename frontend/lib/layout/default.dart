import 'package:flutter/material.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/chat/chat_page.dart';
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
<<<<<<< HEAD
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildPageView(context),
        _buildBottomTabs(context),
      ],
=======
    return WillPopScope(
      onWillPop: () async {
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
>>>>>>> 4c7702b0c727d83912c95b05d20231f6ae6ad2cd
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
<<<<<<< HEAD
            return HomePage();
            case 1: 
            return PostPage();
            case 2: 
            return ChatPage();
=======
              return HomePage();
            case 1:
              return Container();
            case 2:
              return DetailView();
>>>>>>> 4c7702b0c727d83912c95b05d20231f6ae6ad2cd
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
            Positioned(
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
            ),
          ],
        ),
      ),
    );
  }
}

<<<<<<< HEAD
class TabButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final int index;
  final PageController controller;
  final int selectedIndex;
=======
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
>>>>>>> 4c7702b0c727d83912c95b05d20231f6ae6ad2cd

  TabButton({
    Key key,
    this.icon,
    this.text,
    this.iconSize = 20.0,
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
            size: screenAwareSize(iconSize, context),
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
