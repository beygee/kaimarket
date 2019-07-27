import 'package:flutter/material.dart';
import 'package:week_3/chat/chat_view_page.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/chat.dart';
import 'package:week_3/utils/base_height.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatCard extends StatelessWidget {
  final Chat chat;
  final int loggedUserId;
  final VoidCallback onPressed;

  ChatCard({this.chat, this.loggedUserId, this.onPressed});

  final _userNameFont = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  final _chatFont = TextStyle(fontSize: 12.0, color: Colors.grey[500]);
  final _timeFont = TextStyle(fontSize: 10.0, color: Colors.grey[400]);
  final _numFont = TextStyle(fontSize: 10.0, color: Colors.white);

  final _paddingFormat =
      EdgeInsets.only(left: 26, top: 12, bottom: 12, right: 26);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: _paddingFormat,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(children: <Widget>[
                  _chatLeft(context),
                  SizedBox(width: 10),
                  _chatMiddle(context),
                ]),
              ),
              SizedBox(width: 10),
              _chatRight(context),
              SizedBox(width: 10),
              _postImage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatLeft(context) {
    return new Container(
      width: screenAwareSize(50.0, context),
      height: screenAwareSize(50.0, context),
      decoration: new BoxDecoration(
          border: Border.all(color: Colors.grey[400], width: 1.0),
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.fill,
            //image: new NetworkImage(
            //  "url"
            image: ExactAssetImage(getRandomAvatarUrlByPostId(
                loggedUserId == chat.buyer.id
                    ? chat.seller.id
                    : chat.buyer.id)),
          )),
    );
  }

  Widget _chatMiddle(context) {
    return new Expanded(
        child:
            //Container(child:
            new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          loggedUserId == chat.buyer.id ? chat.seller.name : chat.buyer.name,
          style: _userNameFont,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: screenAwareSize(5.0, context),
        ),
        new Text(
          chat.recentMessage.text,
          style: _chatFont,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ));
  }

  Widget _circleNum(String strnum, context) {
    return new Container(
      width: screenAwareSize(15.0, context),
      height: screenAwareSize(15.0, context),
      decoration: new BoxDecoration(
        color: Colors.amber[700],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: new Text(strnum, style: _numFont),
      ),
    );
  }

  Widget _chatRight(context) {
    int num = loggedUserId == chat.buyer.id
        ? chat.buyerNonReadCount
        : chat.sellerNonReadCount;
    return new Container(
        child: new Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        if (chat.recentMessage.createdAt == null)
          new Text(" ", style: _timeFont),
        if (chat.recentMessage.createdAt != null)
          new Text(hourMinute(chat.recentMessage.createdAt), style: _timeFont),
        SizedBox(
          height: screenAwareSize(10.0, context),
        ),
        if (num == 0)
          SizedBox(
            width: screenAwareSize(15.0, context),
            height: screenAwareSize(15.0, context),
          ),
        if (num != 0) _circleNum(num.toString(), context),
      ],
    ));
  }

  String hourMinute(String time) {
    return DateFormat("hh:mm a").format(convertDateFromString(time));
  }

  Widget _postImage(context) {
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
}
