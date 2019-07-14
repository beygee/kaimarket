import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/utils/base_height.dart';
import 'dart:developer';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:week_3/utils/utils.dart';

class ChatViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Chat();
  }
}

class Chat extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  final _paddingFormat =
      EdgeInsets.only(left: 26, top: 12, bottom: 12, right: 26);

  final _dialPartnerName = 'diuni';
  final _postId = '통기타의 아이디';

  final _partnerNameFont = TextStyle(fontSize: 20.0, color: Colors.grey[600]);
  final _chatFont = TextStyle(fontSize: 12.0, color: Colors.grey[500]);
  final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);

  // socket
  SocketIOManager socketManager = SocketIOManager();
  SocketIO socket;

  initialize() async {
    socket = await socketManager.createInstance('http://' + hostUrl);
    socket.onConnect((data) {
      log.i("connected...");
    });
    socket.connect();
    socket.on("init", (data) {
      socket.emit("init", ["access_token"]);
    });
    socket.on("message", (data) {
      log.i(data);
      // db에 메세지 보내기
      //
    });
    // Map<String, dynamic> docs;
    // Message message_first =
    //     Message(from: 'diuni', text: 'hi', me: true, time: '오후 3:44');
    // Message message_second = Message(
    //     from: 'banana', text: "hi I'm banana", me: false, time: '오후 3:45');
    // docs = {'1': message_first, '2': message_second};
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  void dispose() {
    // socket.emit("end", []);
    socketManager.clearInstance(socket);
    log.i("연결 해제");
    super.dispose();
  }

  Future callback() async {
    if (messageController.text.length > 0) {
      await socket.emit("message", [messageController.text]);
      // db에 저장도 하기
      //log.i('add message to db');
      messageController.clear();
      // scrollController.animateTo(scrollController.position.maxScrollExtent,
      //    curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }

  Widget _typingbar(context) {
    return Container(
      width: 270.0,
      height: screenAwareSize(50.0, context),
      child: TextField(
        onSubmitted: (value) => callback(),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(screenAwareSize(5.0, context)),
          hintText: "Enter a message...",
          hintStyle: TextStyle(fontSize: 14.0),
        ),
        controller: messageController,
        maxLines: 2,
        autofocus: true,
        style: TextStyle(fontSize: 14.0),
        scrollPadding: EdgeInsets.all(2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              _dialPartnerName,
              style: _partnerNameFont,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  controller: scrollController,
                  children: <Widget>[
                    // db에서 가져오기
                    new Message(
                      from: 'diuni',
                      text: 'heello 내 이름은 지윤팍팍 아임 지윤 유 쎄이 지 아 쎄 윤 지 윤 지 윤',
                      me: true,
                      time: '오후 3:39',
                      showTime: false,
                    ),
                    new Message(
                      from: 'diuni',
                      text: '짧은 거',
                      me: false,
                      time: '오후 4:00',
                      showTime: true,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 30.0),
                  child: new Row(
                    children: <Widget>[
                      _typingbar(context),
                      SendButton(
                        text: "Send",
                        callback: callback,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: callback,
        icon: Icon(
          Icons.send,
          color: Colors.grey[400],
        ));
  }
}

class Message extends StatelessWidget {
  final String from;
  final String text;
  final String time;
  final bool showTime;

  final bool me;
  // me = (from == user.name);

  final _chatFont = const TextStyle(fontSize: 14.0, color: Colors.grey);
  final _timeFont = const TextStyle(fontSize: 10.0, color: Colors.grey);

  const Message(
      {Key key, this.from, this.text, this.me, this.time, this.showTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     // width: 320.0,
      padding: EdgeInsets.only(top: screenAwareSize(10.0, context)),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (showTime && me)
            new Text(
              time,
              style: _timeFont,
            ),
          Column(
            //crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: me ? Colors.white : Colors.amber[200],
                borderRadius: BorderRadius.circular(30.0),
                elevation: 0.0,
                child: Container(
                  constraints: BoxConstraints(maxWidth: 250),
                  padding: EdgeInsets.symmetric(
                      vertical: screenAwareSize(15.0, context),
                      horizontal: 24.0),
                  child: Text(
                    text,
                    style: _chatFont,
                  ),
                ),
              ),
            ],
          ),
          if (showTime != time && !me)
            new Text(
              time,
              style: _timeFont,
            ),
        ],
      ),
      // updatePrev_time(time);
    );
  }
}
