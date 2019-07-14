import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/chat/chat_card.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/chat.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatLists();
  }
}

class ChatListsState extends State<ChatLists> {
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
        chats = res.data
            .map((chat) {
              return Chat.fromJson(chat);
            })
            .toList()
            .cast<Chat>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new ListView(
        children: <Widget>[
          chats.length > 0 ? ChatCard(chat: chats[0]) : Container(),
        ],
      ),
    );
  }
}

class ChatLists extends StatefulWidget {
  @override
  ChatListsState createState() => ChatListsState();
}
