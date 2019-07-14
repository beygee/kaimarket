import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/chat/chat_view_page.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/chat.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatLists();
  }
}

class ChatListsState extends State<ChatLists> {
  final _profileImage = 'assets/images/logo.jpg';
  final _userName = 'diuni';
  final _recentMsg = '언제 시간 되시나요?';
  final _time = '오후 3:39';
  final _noneReadNum = '1';

  final _userNameFont = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  final _chatFont = TextStyle(fontSize: 12.0, color: Colors.grey[500]);
  final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);
  final _numFont = TextStyle(fontSize: 10.0, color: Colors.white);

  final _paddingFormat =
      EdgeInsets.only(left: 26, top: 12, bottom: 12, right: 26);

  List<Chat> chats = [];

  @override
  void initState() {
    super.initState();

    fetchList();
  }

  Future fetchList() async {
    var res = await dio.getUri(getUri('/api/chats'));
    if (res.statusCode == 200) {
      setState(() {
        List<Chat> test = res.data.map((chat) {
          return Chat.fromJson(chat);
        }).toList();
        // log.i(test);
      });

      // log.i(chats);
    }
  }

  Widget _chatLeft() {
    return new Container(
      width: 62,
      height: 62,
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey[400], width: 1.0),
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            //image: new NetworkImage(
            //  "url"
            image: ExactAssetImage(_profileImage),
          )),
    );
  }

  Widget _chatMiddle(context) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(_userName, style: _userNameFont),
        SizedBox(
          height: screenAwareSize(5.0, context),
        ),
        new Text(_recentMsg, style: _chatFont),
      ],
    ));
  }

  Widget _circleNum() {
    return new Container(
      width: 15,
      height: 15,
      decoration: new BoxDecoration(
        color: Colors.amber[700],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: new Text(_noneReadNum, style: _numFont),
      ),
    );
  }

  Widget _chatRight(context) {
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new Text(_time, style: _timeFont),
        SizedBox(
          height: screenAwareSize(10.0, context),
        ),
        _circleNum(),
      ],
    ));
  }

  Widget _chatRow(context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatViewPage()));
      },
      child: Container(
        padding: _paddingFormat,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              _chatLeft(),
              SizedBox(
                width: 30,
              ),
              _chatMiddle(context),
            ]),
            SizedBox(
              width: 40,
            ),
            _chatRight(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          _chatRow(context),
          _chatRow(context),
          _chatRow(context),
        ],
      ),
    );
  }
}

class ChatLists extends StatefulWidget {
  @override
  ChatListsState createState() => ChatListsState();
}
