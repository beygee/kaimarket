import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:week_3/home/category_button.dart';
import 'package:week_3/models/category.dart';
import 'package:week_3/post/select_map_page.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/post/photo_button.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/post/select_map_page.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/models/post.dart';
import 'package:dio/dio.dart';

class PostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  //텍스트 컨트롤러
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  int selectedCategory = 0;
  List<Map<String, String>> imageUrls = [];

  
  @override
  void dispose() {
    priceController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Builder(
          builder: (context) => _buildAppBar(context),
        ),
      ),
      body: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: _buildTotal(context),
            ),
            _buildBottomTabs(context),
          ],
        );
      }),
    );
  }

  Widget _buildAppBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        "판매하기",
        style: TextStyle(fontSize: 16.0),
      ),
      actions: <Widget>[
        Material(
          color: Colors.transparent,
          child: InkResponse(
            onTap: () => _onTapNextPage(context),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("다음"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotal(context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenAwareSize(15.0, context)),
          Text('카테고리 선택',
              style: TextStyle(
                  fontSize: screenAwareSize(12.0, context),
                  color: Colors.grey[600])),
          _buildCategoryList(context),
          _buildDivider(context),
          _buildTitleInput(context),
          _buildDivider(context),
          _buildPriceInput(context),
          _buildDivider(context),
          Column(
            children: <Widget>[
              imageUrls.length > 0 ? _buildPhotoList(context) : Container(),
              _buildContentInput(context),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitleInput(context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenAwareSize(10.0, context),
            vertical: screenAwareSize(5.0, context)),
        child: TextField(
          controller: titleController,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "상품명",
            hintStyle: TextStyle(
              fontSize: 14.0,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(context) {
    return Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );
  }

  Widget _buildPriceInput(context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenAwareSize(10.0, context),
            vertical: screenAwareSize(5.0, context)),
        child: TextField(
          controller: priceController,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "희망가격",
            hintStyle: TextStyle(
              fontSize: 14.0,
            ),
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }

  Widget _buildContentInput(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenAwareSize(10.0, context),
          vertical: screenAwareSize(5.0, context)),
      child: TextField(
        controller: contentController,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: "내용을 입력하세요",
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPhotoList(context) {
    return Container(
      height: screenAwareSize(70, context),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(screenAwareSize(10.0, context)),
        itemBuilder: (context, idx) {
          return PhotoButton(
            url: imageUrls[idx]['thumb'],
            onPressed: () {
              setState(() {
                imageUrls.removeAt(idx);
              });
            },
          );
        },
        separatorBuilder: (context, idx) {
          return SizedBox(
            width: 10.0,
          );
        },
        itemCount: imageUrls.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _buildBottomTabs(context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0,
      child: Container(
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
            Material(
              color: Colors.transparent,
              child: InkResponse(
                containedInkWell: true,
                onTap: _uploadImages,
                radius: 10.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenAwareSize(15.0, context),
                    vertical: screenAwareSize(15.0, context),
                  ),
                  child: Icon(Icons.camera_alt),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(context) {
    List<HomeCategoryButton> list = [];
    for (int i = 1; i < CategoryList.length; i++) {
      if (i == 7) continue;
      list.add(HomeCategoryButton(
        active: selectedCategory == i,
        icon: CategoryList[i].icon,
        text: CategoryList[i].name,
        onPressed: () {
          setState(() {
            selectedCategory = i;
          });
        },
      ));
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10.0, vertical: screenAwareSize(15.0, context)),
      child: Wrap(
        spacing: screenAwareSize(10.0, context),
        runSpacing: screenAwareSize(10.0, context),
        children: <Widget>[...list],
      ),
    );
  }

  //이미지를 서버에 업로드하고 url과 썸네일을 받아온다.
  _uploadImages() async {
    List<Asset> images = await MultiImagePicker.pickImages(
      maxImages: 10,
      enableCamera: true,
    );

    //서버 업로드
    try {
      var imageData = await Future.wait(images.map((image) async {
        var bytes = await image.requestOriginal();
        FormData formData = FormData.from({
          'image':
              UploadFileInfo.fromBytes(bytes.buffer.asUint8List(), image.name)
        });

        var res = await dio.postUri(getUri('/api/upload'), data: formData);
        return res.data;
      }).toList());

      setState(() {
        imageUrls = imageData.map((json) {
          return {
            'thumb': json['thumb'].toString(),
            'url': json['url'].toString(),
          };
        }).toList();
      });
    } catch (e) {
      log.e(e);
    }
  }

  void _onTapNextPage(context) {
    if (selectedCategory == 0) {
      showSnackBar(context, "카테고리를 선택해주세요.");
      return;
    }
    if (titleController.text == '') {
      showSnackBar(context, "상품명을 입력해주세요.");
      return;
    }
    if (priceController.text == '') {
      showSnackBar(context, "희망가격을 입력해주세요.");
      return;
    }
    if (contentController.text == '') {
      showSnackBar(context, "내용을 입력해주세요.");
      return;
    }
    if (imageUrls.length == 0) {
      showSnackBar(context, "상품의 이미지를 올려주세요.");
      return;
    }

    //포스트를 만들어 전달한다.
    Post post = Post();

    post.title = titleController.text;
    post.price = int.parse(priceController.text);
    post.content = contentController.text;
    post.images = imageUrls;
    post.category = CategoryList[selectedCategory];

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelectMapPage(post: post)));
  }
}
