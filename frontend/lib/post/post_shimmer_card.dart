import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:week_3/utils/utils.dart';

class PostShimmerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: screenAwareSize(350.0, context),
                color: Colors.black,
              ),
              SizedBox(height: screenAwareSize(20.0, context)),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 100.0,
                  height: screenAwareSize(20.0, context),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenAwareSize(8.0, context)),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 150.0,
                  height: screenAwareSize(16.0, context),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenAwareSize(10.0, context)),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 150.0,
                  height: screenAwareSize(12.0, context),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenAwareSize(20.0, context)),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.black,
              ),
              SizedBox(height: screenAwareSize(20.0, context)),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 80.0,
                  height: screenAwareSize(16.0, context),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenAwareSize(20.0, context)),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Container(
                  width: 200.0,
                  height: screenAwareSize(40.0, context),
                  color: Colors.black,
                ),
              ),
              SizedBox(height: screenAwareSize(20.0, context)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  height: screenAwareSize(30.0, context),
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
