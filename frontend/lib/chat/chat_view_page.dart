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
  final Chat chat;
  ChatViewPage({this.chat});

  @override
  _ChatViewPageState createState() => _ChatViewPageState();
}

class _ChatViewPageState extends State<ChatViewPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  SocketBloc _socketBloc;

  //로그인한 유저 정보
  UserBloc _userBloc;
  String loggedUserId = '';

  final _paddingFormat =
      EdgeInsets.only(left: 26, top: 12, bottom: 12, right: 26);

  final _partnerNameFont = TextStyle(fontSize: 20.0, color: Colors.grey[600]);
  final _chatFont = TextStyle(fontSize: 14.0, color: Colors.grey[500]);
  final _postFont = TextStyle(fontSize: 14.0, color: Colors.grey[600]);
  final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);

  List<Widget> response;
  List<Message> existMessages = [];
  // test용
  // var docs = [
  //   {'from': 'diuni', 'text': 'hi', 'time': '오후 8:30'},
  //   {'from': 'banana', 'text': 'hi I am banana', 'time': '오후 8:31'}
  // ];

  Future initShow() async {
    var dbChats = await dio.getUri(getUri('/api/chats/' + widget.chat.id));
    existMessages = Chat.fromJson(dbChats.data).messages;

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
          if ((existMessages[i].from == compareMessage.from) && (minute(existMessages[i].time) == minute(compareMessage.time))) {
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
        if (loggedUserId == existMessages[i].from) {
          existMessages[i].me = true;
        } else {
          existMessages[i].me = false;
        }
      }
    });

    scrollController.animateTo(
        //0.0,
        scrollController.position.minScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300));
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
      "from": data['from'],
      "text": data['text'],
      "time": data['time']
    };
    log.i (existMessages.length);
    if (existMessages.length > 0){
      prevMessage = existMessages[0];
      if (prevMessage.from == currentMessage['from'] &&
          minute(prevMessage.time) == minute(currentMessage['time']))
        showTime = false;
    }
    
    setState(() {
      if (existMessages.length > 0){
        existMessages.remove(prevMessage);
        existMessages.insert(
            0,
            Message(
              text: prevMessage.text,
              from: prevMessage.from,
              time: prevMessage.time,
              me: prevMessage.me,
              showTime: showTime,
            ));
      }
      existMessages.insert(
          0,
          Message(
            text: currentMessage['text'],
            from: currentMessage['from'],
            time: currentMessage['time'],
            me: currentMessage['from'] == loggedUserId,
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
    log.i("클릭");
    if (messageController.text.length > 0) {
      // server로 보내기
      await socket.emit("message", [
        {
          'chatId': widget.chat.id,
          "text": messageController.text,
          "from": loggedUserId,
          "to": loggedUserId == widget.chat.buyer.id
              ? widget.chat.seller.id
              : widget.chat.buyer.id,
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
      child: widget.chat.post.isBook
          ? CachedNetworkImage(
              imageUrl: widget.chat.post.bookImage,
              width: screenAwareSize(60.0, context),
              height: screenAwareSize(60.0, context),
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              imageUrl:
                  getUri('').toString() + widget.chat.post.images[0]['url'],
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
              // if (widget.chat.post.isSold)
              //   Text(
              //     "[판매완료]",
              //     style: _postFont,
              //   ),
              // SizedBox(width: 5.0),
              Expanded(
                child: Text(
                  widget.chat.post.title,
                  style: _postFont,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            getMoneyFormat(widget.chat.post.price) + '원',
            style: _postFont,
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
              builder: (context) => PostViewPage(postId: widget.chat.post.id)));
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
              fontSize: 12.0,
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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            loggedUserId == widget.chat.buyer.id
                ? widget.chat.seller.name
                : widget.chat.buyer.name,
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
                              from: message.from,
                              text: message.text,
                              time: message.time,
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
  final String from;
  final String text;
  String time;
  bool me;
  bool showTime;

  final _chatFont = const TextStyle(fontSize: 14.0, color: Colors.grey);
  final _timeFont = const TextStyle(fontSize: 10.0, color: Colors.grey);

  MessageBubble(
      {Key key,
      this.from,
      this.text,
      this.time,
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
              DateFormat("hh:mm a").format(convertDateFromString(time)),
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
              DateFormat("hh:mm a").format(convertDateFromString(time)),
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
