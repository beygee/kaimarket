import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/post/post_category_button.dart';
import 'package:week_3/post/select_map_page.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/post/photo_button.dart';
import 'package:week_3/utils/utils.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:week_3/models/book.dart';
import 'package:week_3/post/post_book_card.dart';
import 'package:intl/intl.dart';
import 'package:week_3/post/select_map_page.dart';

class PostBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostBookPageState();
}

class PostBookPageState extends State<PostBookPage> {
  static var selectedCategory;
  List<Asset> selectedPhotos = new List<Asset>();
  Book selectedBook = new Book(
      title: "제목",
      link: "링크",
      author: "저자",
      price: 10000,
      discount: 5000,
      publisher: "출판사",
      pubdate: "출판일",
      isbn: "ISBN",
      image: 'http://shop1.phinf.naver.net/20180731_187/kpdipgo1_1533026108545ghD2H_JPEG/9788931458107.jpg',
      description: "디스크립션");

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SelectMapPage()));
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

          _buildBookInfo(context, selectedBook),
          _buildTextInput(context, c_width, "희망가격"),
          _buildTextInput(context, c_width, "사용한 수업명"),
          SizedBox(height: screenAwareSize(5.0, context)),

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
                  selectedPhotos.length > 0
                      ? _buildPhotoList(context)
                      : Container(),
                  _buildContentInput(context),
                ],
              )),
        ],
      ),
    ));
  }

  Widget _buildBookInfo(context, book) {
    return Column(
      children: <Widget>[
        PostBookCard(
          book: selectedBook,
        ),
        Container(
          width: double.infinity,
          height: 1.0,
          color: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildTextInput(context, width, text) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenAwareSize(5, context)
      ),
      child: Container(
        alignment: FractionalOffset(0.5, 0.5),
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenAwareSize(10.0, context)),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                fontSize: 14.0,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentInput(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        maxLines: 8,
        decoration: InputDecoration(
          hintText:
              "책 상태를 자세하게 입력해주세요.",
          hintStyle: TextStyle(
            fontSize: 15.0,
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
          return PhotoButton(
            asset: selectedPhotos[idx],
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
