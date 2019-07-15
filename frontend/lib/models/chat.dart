import 'package:week_3/models/user.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';

class Chat {
  String id;
  User seller;
  User buyer;
  Post post;
  List<Message> messages;

  Chat.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        seller = User.fromJson(json['seller']),
        buyer = User.fromJson(json['buyer']),
        post = Post.fromJson(json['post']) {
    messages = json['messages'].length > 0
        ? json['messages'].map((message) {
            return Message.fromJson(message);
          }).toList().cast<Message>()
        : <Message>[];
  }
}

class Message {
  String from;
  String text;
  String time;
  bool showTime;

  Message.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        text = json['text'],
        time = json['time'],
        showTime = json['showTime'];
}
