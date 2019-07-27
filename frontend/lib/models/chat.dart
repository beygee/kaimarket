import 'package:week_3/models/user.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';

class Chat {
  int id;
  User seller;
  User buyer;
  Post post;
  List<Message> messages;

  //최근 메시지
  Message recentMessage;
  int buyerNonReadCount;
  int sellerNonReadCount;

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['id'],
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
  int userId;
  String text;
  String createdAt;
  bool showTime;
  bool me;

  Message({this.userId, this.text, this.createdAt, this.showTime, this.me});

  Message.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        text = json['text'],
        createdAt = json['createdAt'],
        showTime = json['showTime'];
}
