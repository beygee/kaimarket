import 'package:flutter/material.dart';
import 'package:week_3/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:week_3/models/book.dart';

class PostBookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  PostBookCard({@required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return _buildBookList(context);
  }

  Widget _buildBookList(context) {
    final TextStyle titleColumn = TextStyle(
      fontSize: screenAwareSize(10.0, context),
      color: Colors.grey[400],
      height: 1.5,
    );
    final TextStyle contentColumn = TextStyle(
      fontSize: screenAwareSize(10.0, context),
      height: 1.5,
    );

    final numberFormat = new NumberFormat("#,##0", "en_US");

    return Container(
      color: Colors.white,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // splashColor: ThemeColor.primary,
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(screenAwareSize(15.0, context)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: screenAwareSize(14.0, context),
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: screenAwareSize(10.0, context),
                      ),
                      Table(
                        columnWidths: {0: FixedColumnWidth(60.0)},
                        children: [
                          TableRow(
                            children: [
                              Text("저자", style: titleColumn),
                              Text(
                                book.author,
                                style: contentColumn,
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text("출판사", style: titleColumn),
                              Text(book.publisher, style: contentColumn),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text("출판일", style: titleColumn),
                              Text(book.pubdate, style: contentColumn),
                            ],
                          ),
                          TableRow(
                            children: [
                              Text("정가", style: titleColumn),
                              Text(numberFormat.format(book.price) + '원',
                                  style: contentColumn),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.0),
                Image.network(
                  book.image,
                  height: screenAwareSize(100.0, context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
