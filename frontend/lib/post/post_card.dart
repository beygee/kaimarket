import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostCard extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onTapHeart;
  final Post post;
  final bool issaved;
  final bool small;

  PostCard(
      {@required this.post,
      this.onTap,
      this.onTapHeart,
      this.issaved,
      this.small = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: screenAwareSize(small ? 80.0 : 110.0, context),
            padding: EdgeInsets.symmetric(
                horizontal: 10.0, vertical: screenAwareSize(5.0, context)),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: post.isBook
                      ? CachedNetworkImage(
                          imageUrl: post.bookImage,
                          width: screenAwareSize(small ? 70.0 : 100.0, context),
                          height:
                              screenAwareSize(small ? 70.0 : 100.0, context),
                          fit: BoxFit.cover,
                        )
                      : CachedNetworkImage(
                          imageUrl:
                              getUri('').toString() + post.images[0]['url'],
                          width: screenAwareSize(small ? 70.0 : 100.0, context),
                          height:
                              screenAwareSize(small ? 70.0 : 100.0, context),
                          fit: BoxFit.cover,
                        ),
                ),
                //  Image.network(
                //     ,
                //     width: screenAwareSize(100.0, context),
                //     height: screenAwareSize(90.0, context),
                //     fit: BoxFit.cover,
                //   )
                // : Image.network(
                //     getUri('').toString() + post.images[0]['thumb'],
                //     width: screenAwareSize(100.0, context),
                //     height: screenAwareSize(90.0, context),
                //     fit: BoxFit.cover,
                //   )),
                SizedBox(width: small ? 10.0 : 15.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: screenAwareSize(
                                    small ? 150.0 : 150, context),
                                child: Text(
                                  post.title,
                                  maxLines: small ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: screenAwareSize(
                                        small ? 12.0 : 14.0, context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenAwareSize(5.0, context)),
                              if (post.isBook) ...[
                                Text("수업명: " + post.bookMajor,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: screenAwareSize(9.0, context),
                                    )),
                                SizedBox(height: screenAwareSize(2.0, context))
                              ],
                              Container(
                                width: screenAwareSize(
                                    small ? 100.0 : 150, context),
                                child: Text(
                                  post.content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: post.isBook ? 1 : small ? 2 : 3,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: screenAwareSize(9.0, context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          small
                              ? Container()
                              : GestureDetector(
                                  onTap: onTapHeart,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      screenAwareSize(5.0, context),
                                    ),
                                    child: issaved
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.amber[200],
                                          )
                                        : Icon(Icons.favorite_border,
                                            color: Colors.amber[200]),
                                  ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            post.updated,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: screenAwareSize(9.0, context),
                            ),
                          ),
                          Text(
                            getMoneyFormat(post.price) + "원",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                              fontSize: screenAwareSize(11.0, context),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: screenAwareSize(10, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
