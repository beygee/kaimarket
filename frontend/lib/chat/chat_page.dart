import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/chat/chat_card.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/chat.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/chat/chat_view_page.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChatLists();
  }
}

class ChatListsState extends State<ChatLists> {
  List<Chat> chats = [];

  UserBloc _userBloc;
  String loggedUserId = '';

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    final UserLoaded user = _userBloc.currentState;
    loggedUserId = user.id;
    fetchList();
  }

  Future fetchList() async {
    var res = await dio.getUri(getUri('/api/chats'));
    if (res.statusCode == 200) {
      log.i(res.data);
      if (mounted) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "채팅방 목록",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: screenAwareSize(60.0, context)),
        itemBuilder: (context, i) {
          return ChatCard(
            chat: chats[i],
            loggedUserId: loggedUserId,
            onPressed: () {
              setState(() {
                chats[i].buyerNonReadCount = 0;
                chats[i].sellerNonReadCount = 0;
              });

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChatViewPage(chat: chats[i])));
            },
          );
        },
        itemCount: chats.length,
        separatorBuilder: (context, idx) {
          return Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.grey[200],
          );
        },
      ),
    );
  }
}

class ChatLists extends StatefulWidget {
  @override
  ChatListsState createState() => ChatListsState();
}
