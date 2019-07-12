import 'package:flutter/material.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/layout/sell_button.dart';
import 'dart:math' as math;

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
                              text: "판매",
                              fontSize: 8,
                              icon: Icons.add,
                              iconSize: 20.0,
                              padding: 8.0,
                              onPressed: onPressCancel,
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
                              text: "판매",
                              fontSize: 8,
                              icon: Icons.add,
                              iconSize: 20.0,
                              padding: 8.0,
                              onPressed: onPressCancel,
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
                            padding: 15.0,
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
}
