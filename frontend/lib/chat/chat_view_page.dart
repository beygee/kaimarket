import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:week_3/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:week_3/post/post_view_page.dart';
import 'package:week_3/models/chat.dart';

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

  final _dialPartnerName = 'diuni';
  final _postId = '통기타의 아이디';
  final _postIsSold = true;
  final _postImage = 'assets/images/guitar3.jpg';

  final _partnerNameFont = TextStyle(fontSize: 20.0, color: Colors.grey[600]);
  final _chatFont = TextStyle(fontSize: 14.0, color: Colors.grey[500]);
  final _postFont = TextStyle(fontSize: 14.0, color: Colors.grey[600]);
  final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);

  var prev_time = "";
  var prev_user = "user.id";
  List<Widget> response;
  var existMessages = [];
  // test용
  var docs = [
    {'from': 'diuni', 'text': 'hi', 'time': '오후 8:30'},
    {'from': 'banana', 'text': 'hi I am banana', 'time': '오후 8:31'}
  ];

  Future initShow() async {
    var dbChats = await dio.getUri(getUri('/api/chats/' + widget.chat.id));
    var existMessages = Chat.fromJson(dbChats.data).messages;
    // showTime 계산해서 넣어주기
    // for (int i = 0; i < existMessages.length; i++)
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
    scrollController.animateTo(0.0,
        //scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300));
    //scrollController.jumpTo(scrollController.position.maxScrollExtent);

    bool showTime = true;
    // 서버에서 받은 메세지로 currentMessage에 넣어주기
    var currentMessage = {
      "from": data['from'],
      "text": data['text'],
      "time": data['time']
    };
    var prevMessage = existMessages[0];
    if (prevMessage.from == currentMessage['from'] &&
        prevMessage.time == currentMessage['time']) showTime = false;

    setState(() {
      existMessages.remove(prevMessage);
      existMessages.insert(0, {
        "text": prevMessage.text,
        "from": prevMessage.from,
        "time": prevMessage.time,
        "showTime": showTime,
      });
      existMessages.insert(0, {
        "text": messageController.text,
        "from": currentMessage['from'],
        "time": currentMessage['time'],
        "showTime": true,
      });
    });
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
            Row(children: <Widget>[
              _itemLeft(context),
              SizedBox(width: 15.0),
              _itemMiddle(context),
            ]),
            _itemRight(context),
          ],
        ),
      ),
    );
  }

  Widget _itemLeft(context) {
    return new Container(
      width: screenAwareSize(60.0, context),
      height: screenAwareSize(60.0, context),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(screenAwareSize(5.0, context)),
          image: new DecorationImage(
            fit: BoxFit.fill,
            //image: new NetworkImage(
            //  "url"
            image: ExactAssetImage(_postImage),
          )),
    );
  }

  Widget _itemMiddle(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            if (_postIsSold)
              Text(
                "[판매완료]",
                style: _postFont,
              ),
            SizedBox(width: 5.0),
            Text(
              "통기타",
              style: _postFont,
            ),
          ],
        ),
        Text(
          "15,500원",
          style: _postFont,
        ),
      ],
    );
  }

  Widget _itemRight(context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(screenAwareSize(5.0, context)),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PostViewPage()));
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
          contentPadding: EdgeInsets.all(screenAwareSize(5.0, context)),
          hintText: "Enter a message...",
          hintStyle: TextStyle(fontSize: 14.0),
        ),
        controller: messageController,
        maxLines: 1,
        // textAlignVertical: TextAlignVertical.center,
        // keyboardType: TextInputType.multiline,
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
          centerTitle: true,
          title: Text(
            _dialPartnerName,
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
                  shrinkWrap: true,
                  children: <Widget>[
                    //...existMessages
                    // ...docs
                    //     .map((doc) => MessageBubble(
                    //           from: docs['from'],
                    //           text: docs['text'],
                    //           time: docs['time'],
                    //         ))
                    //     .toList(),
                    new MessageBubble(
                      from: 'diuni',
                      text: 'heello 내 이름은 지윤팍팍 아임 지�� 유 쎄이 지 아 쎄 윤 지 윤 지 윤',
                      time: '오후 3:39',
                    ),
                    new MessageBubble(
                      from: 'diuni',
                      text: '짧은 거',
                      time: '오후 4:00',
                    ),
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

  final _chatFont = const TextStyle(fontSize: 14.0, color: Colors.grey);
  final _timeFont = const TextStyle(fontSize: 10.0, color: Colors.grey);

  MessageBubble({Key key, this.from, this.text, this.time}) : super(key: key);

  bool me = true;
  // me = (from == widget.user.id);

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
          if (me)
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
          if (!me)
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
