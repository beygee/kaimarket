import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:week_3/post/post_view_page.dart';
import 'package:week_3/models/chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatViewPage extends StatefulWidget {
  final int chatId;
  ChatViewPage({this.chatId});

  @override
  _ChatViewPageState createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  SocketBloc _socketBloc;

  //로그인한 유저 정보
  UserBloc _userBloc;
  int loggedUserId = 0;

  final _paddingFormat =
      EdgeInsets.only(left: 26, top: 12, bottom: 12, right: 26);

  final _partnerNameFont = TextStyle(fontSize: 20.0, color: Colors.grey[600]);
  // final _chatFont = TextStyle(fontSize: 14.0, color: Colors.grey[500]);
  // final _postFont = TextStyle(fontSize: 14.0, color: Colors.grey[600]);
  // final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);

  List<Message> existMessages = [];

  Chat chat;

  Future initShow() async {
    var res =
        await dio.getUri(getUri('/api/chats/' + widget.chatId.toString()));
    setState(() {
      chat = Chat.fromJson(res.data);
    });
    existMessages = Chat.fromJson(res.data).messages;

    if (existMessages.length > 0) {
      // me 계산하기
      for (int i = 0; i < (existMessages.length - 1) / 2; i++) {
        Message tempMessage = existMessages[i];
        existMessages[i] = existMessages[existMessages.length - 1 - i];
        existMessages[existMessages.length - 1 - i] = tempMessage;
      }

      // showTime 계산하기
      existMessages[0].showTime = true;
      Message compareMessage = existMessages[0];
      if (existMessages.length != 1) {
        for (int i = 1; i < existMessages.length; i++) {
          if ((existMessages[i].userId == compareMessage.userId) &&
              (minute(existMessages[i].createdAt) == minute(compareMessage.createdAt))) {
            existMessages[i].showTime = false;
          } else {
            existMessages[i].showTime = true;
            compareMessage = existMessages[i];
          }
        }
      }
    }
    // reverse
    setState(() {
      for (int i = 0; i < existMessages.length; i++) {
        if (loggedUserId == existMessages[i].userId) {
          existMessages[i].me = true;
        } else {
          existMessages[i].me = false;
        }
      }
    });

    // scrollController.animateTo(
    //     //0.0,
    //     scrollController.position.minScrollExtent,
    //     curve: Curves.easeOut,
    //     duration: const Duration(milliseconds: 300));
    //scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String minute(String time) {
    return DateFormat("yyyy-MM-dd hh:mm").format(convertDateFromString(time));
  }

  @override
  void initState() {
    super.initState();
    //로그인 유저 정보 가져오기.
    _userBloc = BlocProvider.of<UserBloc>(context);
    final UserLoaded user = _userBloc.currentState;
    loggedUserId = user.id;

    _socketBloc = BlocProvider.of<SocketBloc>(context);
    _socketBloc.dispatch(SocketChatEnter(onMessage: (data) async {
      updateMessage(data);
    }));

    initShow();
  }

  @override
  void dispose() {
    _socketBloc.dispatch(SocketChatLeave());
    super.dispose();
  }

  void updateMessage(data) {
    log.i(data);
    bool showTime = true;
    var prevMessage;
    // 서버에서 받은 메세지
    var currentMessage = {
      "userId": data['userId'],
      "text": data['text'],
      "createdAt": data['createdAt']
    };
    if (existMessages.length > 0) {
      prevMessage = existMessages[0];
      if (prevMessage.userId == currentMessage['userId'] &&
          minute(prevMessage.createdAt) == minute(currentMessage['createdAt']))
        showTime = false;
    }

    setState(() {
      if (existMessages.length > 0) {
        existMessages.remove(prevMessage);
        existMessages.insert(
            0,
            Message(
              text: prevMessage.text,
              userId: prevMessage.userId,
              createdAt: prevMessage.createdAt,
              me: prevMessage.me,
              showTime: showTime,
            ));
      }
      existMessages.insert(
          0,
          Message(
            text: currentMessage['text'],
            userId: currentMessage['userId'],
            createdAt: currentMessage['createdAt'],
            me: currentMessage['userId'] == loggedUserId,
            showTime: true,
          ));
    });
    scrollController.animateTo(
        //0.0,
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300));
    //scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  Future callback(socket) async {
    if (messageController.text.length > 0) {
      // server로 보내기
      await socket.emit("message", [
        {
          'chatId': chat.id,
          "text": messageController.text,
          "userId": loggedUserId,
          "to": loggedUserId == chat.buyer.id ? chat.seller.id : chat.buyer.id,
        }
      ]);
      messageController.clear();
    }
  }

  Widget _buildItem(context) {
    return Container(
      height: screenAwareSize(80.0, context),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Row(children: <Widget>[
                _itemLeft(context),
                SizedBox(width: 15.0),
                _itemMiddle(context),
              ]),
            ),
            SizedBox(
              width: 5.0,
            ),
            _itemRight(context),
          ],
        ),
      ),
    );
  }

  Widget _itemLeft(context) {
    return new ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: chat.post.isBook
          ? CachedNetworkImage(
              imageUrl: chat.post.bookImage,
              width: screenAwareSize(60.0, context),
              height: screenAwareSize(60.0, context),
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              imageUrl: getUri('').toString() + chat.post.images[0]['url'],
              width: screenAwareSize(60.0, context),
              height: screenAwareSize(60.0, context),
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _itemMiddle(context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // if (chat.post.isSold)
              //   Text(
              //     "[판매완료]",
              //     style: _postFont,
              //   ),
              // SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  chat.post.title,
                  style: TextStyle(fontSize: screenAwareSize(14.0, context), color: Colors.grey[600]),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            getMoneyFormat(chat.post.price) + '원',
            style: TextStyle(fontSize: screenAwareSize(14.0, context), color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _itemRight(context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(screenAwareSize(5.0, context)),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PostViewPage(postId: chat.post.id)));
        },
        child: Container(
          height: screenAwareSize(45.0, context),
          width: 70.0,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(screenAwareSize(5.0, context)),
            border: Border.all(color: Colors.amber[600], width: 1.0),
          ),
          child: Center(
              child: Text(
            "게시글\n확인하기",
            style: TextStyle(
              fontSize: screenAwareSize(12.0, context),
              color: Colors.amber[600],
            ),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    );
  }

  Widget _typingbar(context) {
    return Container(
      // height: screenAwareSize(50.0, context),
      child: TextField(
        onSubmitted: (value) =>
            callback((_socketBloc.currentState as SocketChatLoaded).socket),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(screenAwareSize(10.0, context)),
          hintText: "Enter a message...",
          hintStyle: TextStyle(fontSize: 14.0),
        ),
        controller: messageController,
        maxLines: 1,
        style: TextStyle(fontSize: 14.0),
        scrollPadding: EdgeInsets.all(2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (chat == null) {
      return Scaffold();
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            loggedUserId == chat.buyer.id ? chat.seller.name : chat.buyer.name,
            style: _partnerNameFont,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Divider(
                height: 1.0,
              ),
              _buildItem(context),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: screenAwareSize(10.0, context)),
                  controller: scrollController,
                  reverse: true,
                  children: <Widget>[
                    ...existMessages
                        .map((message) => MessageBubble(
                              userId: message.userId,
                              text: message.text,
                              createdAt: message.createdAt,
                              me: message.me,
                              showTime: message.showTime,
                            ))
                        .toList(),
                  ],
                ),
              ),
              BlocBuilder(
                  bloc: _socketBloc,
                  builder: (context, state) {
                    return Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(child: _typingbar(context)),
                          SendButton(
                            text: "Send",
                            callback: () =>
                                callback((state as SocketChatLoaded).socket),
                          ),
                        ],
                      ),
                    );
                  })
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

class MessageBubble extends StatelessWidget {
  final int userId;
  final String text;
  String createdAt;
  bool me;
  bool showTime;

  final _chatFont = const TextStyle(fontSize: 14.0, color: Colors.grey);
  final _timeFont = const TextStyle(fontSize: 10.0, color: Colors.grey);

  MessageBubble(
      {Key key,
      this.userId,
      this.text,
      this.createdAt,
      this.me = true,
      this.showTime = true})
      : super(key: key);

  // time format 바꿔주기
  //time = new DateFormat("hh:mm a").format(time);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 320.0,
      padding: EdgeInsets.only(top: screenAwareSize(10.0, context)),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          if (me && showTime)
            Text(
              DateFormat("hh:mm a").format(convertDateFromString(createdAt)),
              style: _timeFont,
            ),
          Column(
            //crossAxisAlignment: me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: me ? Colors.white : Colors.amber[200],
                borderRadius: BorderRadius.circular(30.0),
                elevation: 0.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      padding: EdgeInsets.symmetric(
                          vertical: screenAwareSize(15.0, context),
                          horizontal: 24.0),
                      child: Text(
                        text,
                        style: _chatFont,
                      ),
                    ),
                    if (me)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CustomPaint(
                          painter: RightTriangle(),
                        ),
                      ),
                    if (!me)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: CustomPaint(
                          painter: LeftTriangle(),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (!me && showTime)
            Text(
              DateFormat("hh:mm a").format(convertDateFromString(createdAt)),
              style: _timeFont,
            ),
        ],
      ),
      // updatePrev_time(time);
    );
  }
}

DateTime convertDateFromString(String strDate) {
  DateTime todayDate = DateTime.parse(strDate);
  return todayDate.add(Duration(hours: 9));
}

class RightTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;

    var path = Path();
    path.lineTo(-25, 0);
    path.lineTo(-10, 15);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LeftTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.amber[200];

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(10, 15);
    path.lineTo(25, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
