import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/chat/chat_card.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/chat.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      // log.i(res.data);
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
      body: new ListView(
        children: <Widget>[
          for (int i = 0; i < chats.length; i++)
            ChatCard(chat: chats[i], loggedUserId: loggedUserId),
          SizedBox(height: screenAwareSize(60.0, context),)
        ],
      ),
    );
  }
}

class ChatLists extends StatefulWidget {
  @override
  ChatListsState createState() => ChatListsState();
}
