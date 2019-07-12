import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/post/detail_view.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/home/category_button.dart';
import 'package:week_3/utils/utils.dart';

const String _kGalleryAssetsPackage = 'madcamp_week_3/frontend';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextStyle _biggerFont = TextStyle(fontSize: 18.0);

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
              SizedBox(height: screenAwareSize(10.0, context)),
              _buildCategoryList(context),
              _buildSuggestions(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
          hintText: "상품을 검색해보세요",
        ),
      ),
    );
  }

  Widget _buildCategoryList(context) {
    List<String> names = [
      "전체",
      "디지털/가전",
      '생활/가구',
      '탈것',
      '뷰티/미용',
      '여성의류',
      '남성의류',
      '도서',
      '기타'
    ];
    List<IconData> icons = [
      FontAwesomeIcons.thLarge,
      FontAwesomeIcons.desktop,
      FontAwesomeIcons.couch,
      FontAwesomeIcons.bicycle,
      Icons.movie,
      Icons.movie,
      Icons.movie,
      FontAwesomeIcons.bookOpen,
      Icons.movie
    ];
    return Container(
      height: screenAwareSize(70, context),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (context, idx) {
          return HomeCategoryButton(
            icon: icons[idx],
            text: names[idx],
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemCount: 9,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildSuggestions() {
    return Expanded(
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (BuildContext context, int idx) {
            return _buildRow(context);
          },
          separatorBuilder: (BuildContext context, int i) {
            return Divider();
          },
        ),
      ),
    );
  }

  Widget _buildRow(context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DetailView()));
      },
      child: Container(
        height: 120.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/0.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: screenAwareSize(5, context)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('test', style: _biggerFont),
                      Text('날짜')
                    ],
                  ),
                  Text('부제'),
                  Text('부제2'),
                  Text('부제3'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: screenAwareSize(10, context),
                      ),
                      GestureDetector(
                        onTap: () {
                          // onHeartTap()
                        },
                        child: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenAwareSize(10, context),
            ),
          ],
        ),
      ),
    );
  }
}
