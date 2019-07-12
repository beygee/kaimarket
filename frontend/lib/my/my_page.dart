import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/styles/theme.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
                height: screenAwareSize(350.0, context),
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
                SizedBox(height: screenAwareSize(20.0, context)),
                Expanded(
                  child: Container(
                      constraints: BoxConstraints.expand(),
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            spreadRadius: -8.0,
                            offset: Offset(0, 5.0),
                            color: ThemeColor.primary.withOpacity(0.5),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(screenAwareSize(15.0, context)),
                          topRight:
                              Radius.circular(screenAwareSize(15.0, context)),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                              tabs: [
                                Tab(text: "판매 내역"),
                                Tab(text: "구매 내역"),
                              ],
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.grey,
                            ),
                            _buildTabView(context)
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabView(context) {
    return Expanded(
      child: Container(),
    );
  }

  Widget _buildHeader(context) {}

  List<Widget> _buildProfile(context) {
    return [
      CircleAvatar(
        child: Text("K"),
        radius: screenAwareSize(40.0, context),
      ),
      SizedBox(height: screenAwareSize(10.0, context)),
      Text(
        "Diuni",
        style: TextStyle(
            color: Colors.grey[600], fontSize: screenAwareSize(16.0, context)),
      ),
      SizedBox(height: screenAwareSize(20.0, context)),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0.0,
              splashColor: ThemeColor.primary,
              color: Colors.transparent,
              onPressed: () {},
              child: Text(
                "키워드 알림",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: screenAwareSize(12.0, context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          SizedBox(
            width: 120.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 0.0,
              splashColor: ThemeColor.primary,
              color: Colors.transparent,
              onPressed: () {},
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
