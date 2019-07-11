import 'package:flutter/material.dart';
import 'package:week_3/home/photo_config.dart';
import 'package:week_3/utils/base_height.dart';

const String _kGalleryAssetsPackage = 'madcamp_week_3/frontend';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Photo> _photos = <Photo>[
    Photo(
      assetName: 'assets/images/0.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '0.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/1.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '1.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/2.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '2.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/3.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '3.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/4.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '4.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/5.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '5.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/6.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '6.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/7.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '7.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/8.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '8.jpg',
      caption: 'Test caption'
    ),
    Photo(
      assetName: 'assets/images/9.jpg',
      assetPackage: _kGalleryAssetsPackage,
      title: '9.jpg',
      caption: 'Test caption'
    ),
  ];
  final Set<Photo> _saved = Set<Photo>();
  final TextStyle _biggerFont = TextStyle(fontSize:18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
          _categoryList(),
          _buildSuggestions(),
          ],
        ),
      );
    }
  
  Widget _categoryList() => Container(
            // 위에 탭바에서 띄우는간격
            margin: EdgeInsets.symmetric(vertical: 5),
            // 높이
            height: screenAwareSize(70, context),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.music_note, color: Colors.green),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리2",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.photo, color: Colors.blue),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리3",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera, color: Colors.orange),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리4",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.orange,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.chat, color: Colors.purple),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리5",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.purple,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.photo, color: Colors.blue),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리3",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.photo, color: Colors.blue),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리3",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ) 
                      ))

                    ],
                  ),
                ),
                Container(
                  width: 80.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.photo, color: Colors.blue),
                      Container(margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        "카테고리3",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ) 
                      ))

                    ],
                  ),
                ),
              ],
              )
          );

  Widget _buildSuggestions(){
    return Expanded(
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView.separated(
          itemCount: _photos.length,
          
          itemBuilder: (BuildContext _context, int i){
            return _buildRow(_photos[i]);
          },
          separatorBuilder: (BuildContext _context, int i){
            return Divider();
          },
        ),
      ),
    );
  }

  Widget _buildRow(Photo photo){
    return Container(
      height: 120.0,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset(
            photo.assetName,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child:
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenAwareSize(5, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '제목',
                    style: _biggerFont,
                  ),
                  Text(
                    '날짜'
                  )
                ],
              ),
              Text(
                '부제',
              ),
              Text(
                '부제2',
              ),
              Text(
                '부제3',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  
                  SizedBox(width: screenAwareSize(10, context),),
                  Icon(Icons.favorite),
                ],
              ),
            ],
          ),
          ),
           SizedBox(width: screenAwareSize(10, context),),
          ],
          
      ),
    );
  }
}