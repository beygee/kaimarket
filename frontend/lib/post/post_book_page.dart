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
import 'package:intl/intl.dart';

class PostBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostBookPageState();
}

class PostBookPageState extends State<PostBookPage> {
  static var selectedCategory;
  List<Asset> selectedPhotos = new List<Asset>();
  Book selectedBook = new Book(title: "제목", link: "링크", author: "저자", price: 10000, discount: 5000, publisher: "출판사"
  , pubdate: "출판일", isbn: "ISBN", description: "디스크립션");

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
          
          _buildBookInfo(context, selectedBook),
          _buildTextInput(context, c_width, "희망가격"),
          _buildTextInput(context, c_width, "사용한 수업명"),

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

  Widget _buildBookInfo(context, book){
    final TextStyle titleColumn = TextStyle(
      fontSize: screenAwareSize(10.0, context),
      color: Colors.grey[400],
      height: 1.5,
    );
    final TextStyle contentColumn = TextStyle(
      fontSize: screenAwareSize(10.0, context),
      height: 1.5,
    );

    final numberFormat = new NumberFormat("#,##0", "en_US");
    return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(screenAwareSize(15.0, context)),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          book.title,
                          style: TextStyle(
                            fontSize: screenAwareSize(14.0, context),
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: screenAwareSize(10.0, context),
                        ),
                        Table(
                          columnWidths: {0: FixedColumnWidth(60.0)},
                          children: [
                            TableRow(
                              children: [
                                Text("저자", style: titleColumn),
                                Text(
                                  book.author,
                                  style: contentColumn,
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text("출판사", style: titleColumn),
                                Text(book.publisher, style: contentColumn),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text("출판일", style: titleColumn),
                                Text(book.pubdate, style: contentColumn),
                              ],
                            ),
                            TableRow(
                              children: [
                                Text("정가", style: titleColumn),
                                Text(numberFormat.format(book.price) + '원',
                                    style: contentColumn),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // Image.network(book.image),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset("assets/images/1.jpg"),
                  )
                  
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ],
        );
  }

  Widget _buildTextInput(context, c_width, text) {
    return Padding(
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
      // child: AutoSizeText(

      //   style: TextStyle(fontSize: 20),
      //   maxLines: 4,
      // ),
      child: TextField(
        maxLines: 8,
        decoration: InputDecoration(
          hintText: "책 상태를 자세하게 입력해주세요.             예시)                                                      구입날짜: 2019년 01월 01일                 상태:필기흔적없음, 깨끗함",
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
