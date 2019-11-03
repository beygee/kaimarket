import 'package:flutter/material.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:week_3/models/book.dart';
import 'package:html/parser.dart';
import 'package:week_3/post/post_book_page.dart';
import 'package:week_3/post/post_book_card.dart';

class PostBookSelectPage extends StatefulWidget {
  @override
  _PostBookSelectPageState createState() => _PostBookSelectPageState();
}

class _PostBookSelectPageState extends State<PostBookSelectPage> {
  TextEditingController searchController;
  FocusNode focusNode;
  GlobalKey<LoadingWrapperState> _loadingWrapperKey =
      GlobalKey<LoadingWrapperState>();

  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      key: _loadingWrapperKey,
      builder: (context, loading) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  '도서 판매하기',
                  style: TextStyle(fontSize: 16.0),
                ),
                actions: <Widget>[
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 16.0),
                  //     child: Text("다음"),
                  //   ),
                  // )
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      _buildSearchCard(),
                      _buildBookList(),
                    ],
                  ),
                ),
              ),
            ),
            loading
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black26,
                      child: Center(
                        child: SpinKitChasingDots(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        );
      },
    );
  }

  Widget _buildBookList() {
    return Column(
      children: books.map((book) {
        return Column(
          children: <Widget>[
            PostBookCard(
              book: book,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PostBookPage(book: book)));
              },
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSearchCard() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 16.0, vertical: screenAwareSize(24.0, context)),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text(
            "판매하실 책을 검색하세요.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenAwareSize(16.0, context)),
          TextField(
            focusNode: focusNode,
            controller: searchController,
            onSubmitted: (str) {
              _onSearchBooks();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: screenAwareSize(6.0, context)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.grey[300],
                  width: 1.0,
                  style: BorderStyle.solid,
                ),
              ),
              hintText: "도서명을 입력하세요.",
              suffixIcon: GestureDetector(
                onTap: () {
                  _onSearchBooks();
                },
                child: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearchBooks() {
    _loadingWrapperKey.currentState.loadFuture(() async {
      var res = await dio
          .getUri(getUri('/api/search/books', {'q': searchController.text}));
      if (res.statusCode == 200) {
        // log.i(res.data);
        books.clear();
        var jsons = res.data['items'];
        for (var json in jsons) {
          json['title'] = _parseHtmlString(json['title']);
          var book = Book.fromJson(json);
          setState(() {
            books.add(book);
          });
        }

        focusNode.unfocus();
      }
    });
  }

  String _parseHtmlString(String htmlString) {
    var document = parse(htmlString);
    String parsed = parse(document.body.text).documentElement.text;
    return parsed;
  }
}
