import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/post/post_view_page.dart';
import 'package:week_3/post/post_card.dart';

class WishPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WishPageState();
}

class WishPageState extends State<WishPage> {
  List<Post> wishes = List<Post>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return SafeArea(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: screenAwareSize(50.0, context)),
        physics: BouncingScrollPhysics(),
        // wishes에 있는 개수만큼 찍게끔 설정해야함.
        // itemCount: wishes.length,
        itemCount: 10,
        itemBuilder: (BuildContext context, int idx) {
          return _buildRow(context);
        },
        separatorBuilder: (BuildContext context, int i) {
          return Divider();
        },
      ),
    );
  }

  Widget _buildRow(context) {
    return PostCard(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PostViewPage()));
      },
    );
  }
}
