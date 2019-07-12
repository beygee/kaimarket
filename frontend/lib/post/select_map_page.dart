import 'package:flutter/material.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/post/google_map.dart';

class SelectMapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectMapPageState();
}

class SelectMapPageState extends State<SelectMapPage> {
  @override
  Widget build(BuildContext context) {

    double c_width = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: Text(
          '선호 지역 선택',
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      body: Column(
        children: <Widget>[
          GoogleMapPage(),
          Padding(
                    padding: EdgeInsets.all(50.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      },
                      splashColor: Colors.green,
                      color: Colors.amber[200],
                      child: Text('작성 완료'),
                    ),
        )
        ]
      )
            
    );
  }
}
