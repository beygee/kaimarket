import 'package:flutter/material.dart';
import 'package:week_3/post/post_card.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/styles/theme.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:week_3/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/post/post_view_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  UserBloc _userBloc;
  String loggedUserId = '';
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
    final UserLoaded user = _userBloc.currentState;
    loggedUserId = user.id;
    fetchList();
  }

  Future fetchList() async {
    var res = await dio.getUri(getUri('/api/me/sales'));
    if (res.statusCode == 200) {
      if (mounted) {
        setState(() {
          posts = res.data
              .map((post) {
                return Post.fromJson(post);
              })
              .toList()
              .cast<Post>();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ProfileHeaderClipper(),
            child: CustomPaint(
              painter: ProfileHeaderPainter(),
              child: Container(
                width: size.width,
                height: screenAwareSize(370.0, context),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: screenAwareSize(70.0, context),
            ),
            child: Column(
              children: <Widget>[
                ..._buildProfile(context),
                SizedBox(height: screenAwareSize(10.0, context)),
                _buildTabView(context),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildProfile(context) {
    return [
      CircleAvatar(
        backgroundImage: AssetImage(getRandomAvatarUrlByPostId(loggedUserId)),
        radius: screenAwareSize(40.0, context),
      ),
      SizedBox(height: screenAwareSize(10.0, context)),
      Text(
        (_userBloc.currentState as UserLoaded).name,
        style: TextStyle(
            color: Colors.grey[600], fontSize: screenAwareSize(16.0, context)),
      ),
      SizedBox(height: screenAwareSize(5.0, context)),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // SizedBox(
          //   width: 120.0,
          //   child: RaisedButton(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10.0)),
          //     elevation: 0.0,
          //     hoverColor: ThemeColor.primary,
          //     highlightColor: ThemeColor.primary,
          //     focusColor: ThemeColor.primary,
          //     focusElevation: 0.0,
          //     highlightElevation: 0.0,
          //     hoverElevation: 0.0,
          //     splashColor: ThemeColor.primary,
          //     color: Colors.transparent,
          //     onPressed: () {},
          //     child: Text(
          //       "키워드 알림",
          //       style: TextStyle(
          //         color: Colors.grey[500],
          //         fontSize: screenAwareSize(12.0, context),
          //       ),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          // SizedBox(width: 20.0),
          SizedBox(
            width: 120.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0.0,
              splashColor: ThemeColor.primary,
              hoverColor: ThemeColor.primary,
              highlightColor: ThemeColor.primary,
              focusColor: ThemeColor.primary,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              hoverElevation: 0.0,
              color: Colors.transparent,
              onPressed: _onLogout,
              child: Text(
                "로그아웃",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: screenAwareSize(12.0, context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildTabView(context) {
    return Expanded(
      child: Container(
          constraints: BoxConstraints.expand(),
          margin: EdgeInsets.only(
              left: 35.0, right: 35.0, bottom: screenAwareSize(80.0, context)),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                spreadRadius: -8.0,
                offset: Offset(0, 5.0),
                color: Colors.black12,
              )
            ],
            borderRadius: BorderRadius.circular(screenAwareSize(15.0, context)),
          ),
          child: DefaultTabController(
            length: 1,
            child: Column(
              children: <Widget>[
                TabBar(
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenAwareSize(10.0, context)),
                        child: Text("판매 내역",
                            style: TextStyle(
                                fontSize: screenAwareSize(12.0, context))),
                      ),
                    ),
                    // Tab(
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: screenAwareSize(10.0, context)),
                    //     child: Text("구매 내역",
                    //         style: TextStyle(
                    //             fontSize: screenAwareSize(12.0, context))),
                    //   ),
                    // ),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                ),
                _buildTabPane(context)
              ],
            ),
          )),
    );
  }

  Widget _buildTabPane(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < posts.length; i++)
                PostCard(
                  post: posts[i],
                  issaved: false,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PostViewPage(postId: posts[i].id)));
                  },
                  small: true
                )
            ],
          ),
        ),
      ),
    );
  }

  _onLogout() async {
    await FacebookLogin().logOut();

    //토큰 지운다.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', '');

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}

class ProfileHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60.0);

    var bezierControlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 60.0);
    path.quadraticBezierTo(
        bezierControlPoint.dx, bezierControlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ProfileHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Gradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,
        Color(0xfffff9ea),
        Colors.amber[100],
        Colors.amber[300],
      ],
      stops: [0.05, 0.3, 0.7, 1.0],
    );
    Paint paint = Paint()..shader = gradient.createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(ProfileHeaderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ProfileHeaderPainter oldDelegate) => false;
}
