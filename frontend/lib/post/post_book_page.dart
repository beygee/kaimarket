import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/post/post_category_button.dart';
import 'package:week_3/post/select_map_page.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/post/photo_button.dart';
import 'package:week_3/utils/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostBookPageState();
}

class PostBookPageState extends State<PostBookPage> {
  static var selectedCategory;
 List<Asset> selectedPhotos = new List<Asset>();

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.97;
    // 키보드 떴을때 위로 끌어올리기.
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: _buildTotal(context),
            ),
            _buildBottomTabs(context),
          ],
        ));
  }

  Widget _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.amber[100],
      title: Text(
        "책 판매하기",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("완료"),
          ),
        ),
      ],
    );
  }

  Widget _buildTotal(context) {
    double c_width = MediaQuery.of(context).size.width * 0.97;
    // 키보드 떴을때 위로 끌어올리기.
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
        child: SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenAwareSize(5.0, context)),

          ///// 카테고리 선택
          Container(
              alignment: FractionalOffset(0.5, 0.5),
              width: c_width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(10.0, context)),
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
                ],
              )),

          // //// 사진버튼
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: _buildPhotoList(context),
          // ),

          SizedBox(height: screenAwareSize(5.0, context)),
          ///// 상품명
          Container(
              alignment: FractionalOffset(0.5, 0.5),
              width: c_width,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(10.0, context)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildTitleInput(context),
                ],
              )),

          ///// 가격
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
                alignment: FractionalOffset(0.5, 0.5),
                width: c_width,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(screenAwareSize(10.0, context)),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    _buildPriceInput(context),
                  ],
                )),
          ),

          ///// 내용
          Container(
              alignment: FractionalOffset(0.5, 0.5),
              width: c_width,
              height: screenAwareSize(300, context),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(10.0, context)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Column(
                children: <Widget>[
                  selectedPhotos.length > 0 ? _buildPhotoList(context) : Container(),
                  _buildContentInput(context),
                ],
              )),
        ],
      ),
    ));
  }

  Widget _buildTitleInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "상품명",
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPriceInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          hintText: "가격",
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildContentInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      // child: AutoSizeText(

      //   style: TextStyle(fontSize: 20),
      //   maxLines: 4,
      // ),
      child: TextField(
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "내용을 입력하세요",
          hintStyle: TextStyle(
            fontSize: 20.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPhotoList(context) {

    return Container(
      height: screenAwareSize(75, context),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, idx) {
          return PhotoButton(asset: selectedPhotos[idx],
            onPressed: () {
              setState(() {
              selectedPhotos.removeAt(idx);
              });
            },
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemCount: selectedPhotos.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildCategoryList(context) {
    List<String> names = [
      "디지털/가전",
      '생활/가구',
      '탈것',
      '뷰티/미용',
      '여성의류',
      '남성의류',
      '기타'
    ];
    List<IconData> icons = [
      FontAwesomeIcons.desktop,
      FontAwesomeIcons.couch,
      FontAwesomeIcons.bicycle,
      Icons.movie,
      Icons.movie,
      Icons.movie,
      Icons.movie
    ];

    List<PostCategoryButton> _buildGridCategoryList(int count) {
      return List.generate(
          count,
          (i) => PostCategoryButton(
              icon: icons[i],
              text: names[i],
              ));
    }

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

  Widget _buildBottomTabs(context) {
    return Positioned(
      height: screenAwareSize(50.0, context),
      left: 0.0,
      right: 0.0,
      bottom: 0,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: screenAwareSize(50.0, context),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.black12,
              )
            ]),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.camera_alt),
                    iconSize: 40,
                    onPressed: () async {
                      var galleryFiles = await MultiImagePicker.pickImages(
                        maxImages: 10,
                        enableCamera: true,
                      );
                      setState(() {
                        selectedPhotos = galleryFiles;
                      });
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}