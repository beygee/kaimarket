import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';

class PostViewPage extends StatefulWidget {
  @override
  _PostViewPageState createState() => _PostViewPageState();
}

class _PostViewPageState extends State<PostViewPage> {
  static const double horizontalPadding = 16.0;

  final _explanation = '상태 좋고 흥정 가능해요 \n1년정도 사용했어요';

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      log.i("ASd");
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildImageCarousel(),
                SizedBox(height: screenAwareSize(10.0, context)),
                _buildPostHeader(context),
                _buildDivider(),
                _buildPostContent(context),
                _buildLocation(),
                _buildDivider(),
                _buildUserInfo(context),
                SizedBox(height: screenAwareSize(70.0, context)),
              ],
            ),
          ),
          _buildBottomTab(),
        ],
      ),
    );
  }

  Widget _buildBottomTab() {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: screenAwareSize(50.0, context),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 5.0, spreadRadius: -3.0),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    color: ThemeColor.primary,
                  ),
                  SizedBox(width: 5.0),
                  Text('찜', style: TextStyle(color: ThemeColor.primary)),
                ],
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(
                    vertical: screenAwareSize(10.0, context)),
                color: ThemeColor.primary,
                textColor: Colors.white,
                splashColor: Theme.of(context).primaryColorLight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.0,
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.comment,
                        color: Colors.white,
                        size: screenAwareSize(14.0, context),
                      ),
                      SizedBox(width: 10.0),
                      Text('톡으로 연락하기'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Container(
      height: screenAwareSize(350.0, context),
      child: Carousel(
        autoplay: false,
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/guitar.jpg'),
          AssetImage('assets/images/guitar2.jpg'),
          AssetImage('assets/images/guitar3.jpg'),
          AssetImage('assets/images/guitar4.jpg'),
        ],
        dotSize: 6.0,
        dotSpacing: 12.0,
        dotIncreaseSize: 1.6,
        dotIncreasedColor: Colors.amber[200],
        dotColor: Colors.amber[100],
        indicatorBgPadding: 10.0,
        dotBgColor: Colors.transparent,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(microseconds: 2000),
      ),
    );
  }

  Widget _buildPostHeader(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: screenAwareSize(10.0, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "15,500 원",
            style: TextStyle(
              fontSize: screenAwareSize(18.0, context),
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: screenAwareSize(5.0, context)),
          Text(
            "통기타",
            style: TextStyle(
              fontSize: screenAwareSize(
                14.0,
                context,
              ),
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: screenAwareSize(10.0, context)),
          Row(
            children: <Widget>[
              Icon(
                FontAwesomeIcons.clock,
                size: 12.0,
                color: Colors.grey[400],
              ),
              SizedBox(width: 3.0),
              Text(
                "16시간전",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: 20.0),
              Icon(
                FontAwesomeIcons.eye,
                size: 12.0,
                color: Colors.grey[400],
              ),
              SizedBox(width: 3.0),
              Text(
                "638",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
              ),
              SizedBox(width: 20.0),
              Icon(
                FontAwesomeIcons.heart,
                size: 12.0,
                color: Colors.grey[400],
              ),
              SizedBox(width: 3.0),
              Text(
                "23",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.0,
                ),
              ),
            ],
          )
        ],
      ),
    );
    // return Container(
    //   constraints: BoxConstraints.expand(),
    //   padding: EdgeInsets.symmetric(
    //       horizontal: horizontalPadding,
    //       vertical: screenAwareSize(20.0, context)),
    //   child:
    // );
  }

  Widget _buildPostContent(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: screenAwareSize(10.0, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "상품설명",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: screenAwareSize(15.0, context)),
          Text(_explanation, style: TextStyle(height: 1.2)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[200],
      margin: EdgeInsets.symmetric(vertical: screenAwareSize(10.0, context)),
    );
  }

  Widget _buildUserInfo(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: screenAwareSize(5.0, context)),
      child: Container(
        height: screenAwareSize(50.0, context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: screenAwareSize(50.0, context),
              height: screenAwareSize(50.0, context),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400], width: 1.0),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  //image:  NetworkImage(
                  //  "url"
                  image: ExactAssetImage('assets/images/logo.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "diuni",
                  style: TextStyle(
                    fontSize: screenAwareSize(14.0, context),
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  "판매내역 3",
                  style: TextStyle(
                    fontSize: screenAwareSize(10.0, context),
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: screenAwareSize(10.0, context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '거래 선호 위치',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: screenAwareSize(10.0, context)),
          Placeholder(
            fallbackHeight: 300.0,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
