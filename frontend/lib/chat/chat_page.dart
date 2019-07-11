import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class DetailView extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailItems(),
    );
  }
}

class DetailItemsState extends State<DetailItems> {
  final _title = '통기타';
  final _cost = '50,000원';
  final _uploadDate = '3일전';
  final _explanation = '상태 좋고 흥정 가능해요 \n1년정도 사용했어요';
  final _sellerName = 'diuni';
  // final images = [];

  final _titleFont = const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold);
  final _biggerFont = const TextStyle(fontSize: 17.0,);
  final _smallerFont = const TextStyle(fontSize: 15.0);
  final _sellerFont = const TextStyle(fontSize: 19.0);
  final _buttonFont = const TextStyle(fontSize: 12.0, color: Colors.grey);

  final _paddingFormat = const EdgeInsets.only(left: 26, top: 21, bottom: 12, right: 26);

  final bool alreadySaved = false;
  // this.dotSize = 8.0,
  //   this.dotSpacing = 25.0,
  //   this.dotIncreaseSize = 2.0,
  //   this.dotColor = Colors.white,
  //   this.dotBgColor,
  //   this.dotIncreasedColor = Colors.white,

  Widget _imageCarousel() {
    return Container(
      height: 290.0,
      child: Carousel(
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

  Widget _item() {
    return Container(
      padding: _paddingFormat,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_title, style: _titleFont),
                new Text(_cost, style: _smallerFont),
              ],
            ),
          ),
          new Text(_uploadDate, style: _smallerFont),
        ],
      ),
    );
  }

  Widget _itemInfo() {
    return Container(
      padding: _paddingFormat,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_explanation, style: _smallerFont),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _seller() {
    return Container(
      padding: _paddingFormat,
      child: new Row(
        children: <Widget>[
          new Image.asset(
            'assets/images/logo.jpg',
            width: 40,
            height: 40,
          ),
          SizedBox(width: 30,),
          new Text(_sellerName, style: _sellerFont),
        ],
      ),
    );
  }

  Widget _location() {
    return Container(
      padding: _paddingFormat,
      child: new Row(
        children: <Widget>[
          new Text('거래 선호 위치', style: _smallerFont),
          // new Image.asset(
          //   'assets/images/logo.jpg',
          //   width: 100,
          //   height: 60,
          // ),
        ],
      ),
    );
  }

  Widget _floating() {
    // change here to save the wishlist
      return Container(
      padding: _paddingFormat,
      child: new Row(
        children: <Widget>[
          SizedBox(width: 30,),
            new IconButton(
              icon: new Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null),
              onPressed: null,
          //     alreadySaved ? Icons.favorite : Icons.favorite_border,
          //     color: alreadySaved ? Colors.red : null
          //     ),
          //   label: "",
            ),
          SizedBox(width: 60,),
          Container(
            width: 160.0,
            height: 30,
            child: new RaisedButton(
              color: Colors.amber[200],
              child: Text('톡으로 연락하기', style: _buttonFont,),
              elevation: 0.0,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                
              },
            ),
          ),
        ],
      ),
    );
  }

  void onFavorite(){
    setState(() {
      if (alreadySaved) {
          //  _saved.remove(pair);
          } else {
          //  _saved.add(pair);
          }
    });
  }

  // void onTalk(){
  //   setState(() {
  //     name = 'favorite btn';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          _imageCarousel(),
          _item(),
          Divider(color: Colors.grey, height: 10.0, indent: 19.0, endIndent: 19.0,),
          _itemInfo(),
          _seller(),
          _location(),
          _floating(),
        ],
      ),
    );
  }
}

class DetailItems extends StatefulWidget {
  @override
  DetailItemsState createState() => DetailItemsState();
}