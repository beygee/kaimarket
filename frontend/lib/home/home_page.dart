import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/post/detail_view.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/home/category_button.dart';
import 'package:week_3/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              _buildSuggestions(),
              SizedBox(height: screenAwareSize(50.0, context)),
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
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search),
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
        physics: BouncingScrollPhysics(),
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
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int idx) {
          return _buildRow(context);
        },
        separatorBuilder: (BuildContext context, int i) {
          return Divider();
        },
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
        height: screenAwareSize(100.0, context),
        padding: EdgeInsets.symmetric(
            horizontal: 10.0, vertical: screenAwareSize(5.0, context)),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/0.jpg',
                width: screenAwareSize(100.0, context),
                height: screenAwareSize(90.0, context),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '통기타',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: screenAwareSize(14.0, context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.favorite),
                          ),
                        ],
                      ),
                      SizedBox(height: screenAwareSize(5.0, context)),
                      Text(
                        '상태 좋고 흥정 가능해kjhkjhkhkdsada요1년 정도 사용했어요1년 정도 사용했어요1년 정도 사용했어요',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: screenAwareSize(10.0, context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "3일 전",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: screenAwareSize(9.0, context),
                        ),
                      ),
                      Text(
                        "50,000원",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenAwareSize(11.0, context),
                        ),
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
