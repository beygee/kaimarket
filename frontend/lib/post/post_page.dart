import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/home/home_page.dart';
import 'package:week_3/post/post_category_button.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/post/photo_button.dart';
import 'package:week_3/post/google_map.dart';
import 'package:week_3/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[100],
        title: Text(
          '판매하기',
          style: TextStyle(fontSize: 15.0),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
        child:  Column(
          children: <Widget>[
            SizedBox(height: screenAwareSize(10.0, context)),
            Column(
              children: <Widget>[
                Container(
                  alignment: FractionalOffset(0.5,0.5),
                  width: screenAwareSize(300.0, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ), 
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('카테고리 선택', style: TextStyle(fontSize: 15.0)),
                      ),
                       _buildCategoryList(context),
                  ],)
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child:   _buildPhotoList(context),
                ),
                Container(
                  alignment: FractionalOffset(0.5,0.5),
                  width: screenAwareSize(300.0, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ), 
                  ),
                  child: Column(
                    children: <Widget>[
                   _buildTitleInput(context),
                  ],)
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                  alignment: FractionalOffset(0.5,0.5),
                  width: screenAwareSize(300.0, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ), 
                  ),
                  child: Column(
                    children: <Widget>[
                   _buildPriceInput(context),
                  ],)
                ),
                ),
                Container(
                  alignment: FractionalOffset(0.5,0.5),
                  width: screenAwareSize(300.0, context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ), 
                  ),
                  child: Column(
                    children: <Widget>[
                   _buildContentInput(context),
                  ],)
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    '선호 거래지역', style: TextStyle(fontSize:15.0)
                  ),
                ),
                GoogleMapPage(),
                Padding(
                  padding: EdgeInsets.all(50.0),
                  child: MaterialButton(
                    onPressed: (){},
                    splashColor: Colors.green,
                    color: Colors.amber[200],
                    child: Text('등록하기'),
                  ),
                  // child: RaisedButton(
                  //   //등록하기 눌렀을때
                  //   onPressed: () {
                  //     Navigator.push(
                  //     context,MaterialPageRoute(builder: (context)=> HomePage()));},
                  //   splashColor: Colors.blue[200],
                  //   color: Colors.amber[200],
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  //   child: Text(
                  //     "등록하기",
                  //     style: TextStyle(
                  //       fontSize: 15.0,
                  //     )
                  //   ),
                  // )
                ),
                SizedBox(height: screenAwareSize(80, context))
              ],
            ),
          ],
        ),
       ),
      ),
    );
  }

 Widget _buildTitleInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "상품명",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPriceInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "가격",
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildContentInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "내용",
          border: InputBorder.none,
        ),
      ),
    );
  }

 Widget _buildPhotoList(context){
    List<PhotoButton> _buildGridCategoryList(int count) => List.generate(
    count, (i) => PhotoButton(icon: Icons.camera, ));
    
    return Container(
      height: screenAwareSize(65, context),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(6),
        mainAxisSpacing: 4,
        // crossAxisSpacing: 4,
        children: _buildGridCategoryList(5),
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

    List<PostCategoryButton> _buildGridCategoryList(int count) => List.generate(
    count, (i) => PostCategoryButton(icon: icons[i], text: names[i]));
    
    return Container(
      height: screenAwareSize(140, context),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(4),
        mainAxisSpacing: 4,
        // crossAxisSpacing: 4,
        children: _buildGridCategoryList(names.length),
      ),
    );
  }

  void imageSelectorGallery() async {
    var galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 45.0,
      maxWidth: 45.0,
    );
    setState(() {
      
    }
  );
  }
}