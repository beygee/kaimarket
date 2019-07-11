import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(DetailView());

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
  final _explanation = '상태 좋고 흥정 가능해요 \n 1년정도 사용했어요';
  final _titleFont = const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
  final _biggerFont = const TextStyle(fontSize: 20.0,);
  final _smallerFont = const TextStyle(fontSize: 17.0);
  
  // Widget _buildSuggestions() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     itemBuilder: (),
  //   )
  // }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                new Text(_title, style: _titleFont),
                new Text(_cost, style: _smallerFont),
                new Text(_explanation, style: _biggerFont),
              ],
            ),
          ),
          new Text(_uploadDate, style: _smallerFont),
        ],
      ),
    );

    return Scaffold(
      body: new ListView(
        children: <Widget>[
          new Image.asset(
            'images/guitar.jpg',
            fit: BoxFit.cover
          ),
          titleSection
        ],
      ),
    );
  }
}

class DetailItems extends StatefulWidget {
  @override
  DetailItemsState createState() => DetailItemsState();
}