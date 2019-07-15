import 'package:week_3/models/user.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';

class Chat {
  String id;
  User seller;
  User buyer;
  Post post;
  List<Message> messages;

  //최근 메시지
  Message recentMessage;
  int buyerNonReadCount;
  int sellerNonReadCount;

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        seller = User.fromJson(json['seller']),
        buyer = User.fromJson(json['buyer']),
        post = Post.fromJson(json['post']),
        buyerNonReadCount = json['buyerNonReadCount'],
        sellerNonReadCount = json['sellerNonReadCount'] {
    if (json['recentMessage'] != null) {
      recentMessage = Message.fromJson(json['recentMessage']);
    }

    messages = json['messages'].length > 0
        ? json['messages']
            .map((message) {
              return Message.fromJson(message);
            })
            .toList()
            .cast<Message>()
        : <Message>[];
  }
}

class Message {
  String from;
  String text;
  String time;
  bool showTime;
  bool me;

  Message({this.from, this.text, this.time, this.showTime, this.me});

  Message.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        text = json['text'],
        time = json['time'],
        showTime = json['showTime'];
}
