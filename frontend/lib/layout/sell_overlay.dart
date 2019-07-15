import 'package:flutter/material.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/layout/sell_button.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:week_3/post/post_page.dart';
import 'package:week_3/post/post_book_select_page.dart';
import 'package:week_3/post/post_book_page.dart';

class SellOverlay extends StatelessWidget {
  final Animation listenable;
  final Animation<Offset> leftAnimation;
  final Animation<Offset> rightAnimation;
  final VoidCallback onPressCancel;

  SellOverlay(
      {this.listenable,
      this.onPressCancel,
      this.leftAnimation,
      this.rightAnimation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: listenable,
      builder: (context, child) {
        return listenable.value > 0
            ? FadeTransition(
                opacity: listenable,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: onPressCancel,
                        child: Container(
                          color: Colors.black26,
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: screenAwareSize(15.0, context),
                          child: Transform.translate(
                            offset: Offset(
                              -screenAwareSize(
                                      listenable.value * 70.0, context) *
                                  math.cos(math.pi / 3.2),
                              -screenAwareSize(
                                      listenable.value * 70.0, context) *
                                  math.sin(math.pi / 3.2),
                            ),
                            child: SellButton(
                              text: "도서",
                              fontSize: 8,
                              icon: FontAwesomeIcons.book,
                              iconSize: 14.0,
                              padding: 8.0,
                              onPressed: () {
                                onsellBook(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: screenAwareSize(15.0, context),
                          child: Transform.translate(
                            offset: Offset(
                              screenAwareSize(
                                      listenable.value * 70.0, context) *
                                  math.cos(math.pi / 3.2),
                              -screenAwareSize(
                                      listenable.value * 70.0, context) *
                                  math.sin(math.pi / 3.2),
                            ),
                            child: SellButton(
                              text: "다른 물품",
                              fontSize: 8,
                              icon: IconData(0xe60d, fontFamily: 'custom'),
                              iconSize: 14.0,
                              padding: 8.0,
                              onPressed: () {
                                onSellOther(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: screenAwareSize(15.0, context),
                          child: SellButton(
                            text: "취소",
                            fontSize: 8,
                            icon: Icons.remove,
                            iconSize: 20.0,
                            padding: 10.0,
                            onPressed: onPressCancel,
                            bgColor: Colors.white,
                            color: ThemeColor.primary,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Container();
      },
    );
  }

  void onsellBook(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostBookSelectPage(),
      ),
    );

    onPressCancel();
  }

  void onSellOther(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostPage(),
      ),
    );

    onPressCancel();
  }
}
