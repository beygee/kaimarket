import 'package:intl/intl.dart';

class Book {
  final String title;
  final String link;
  final String image;
  final String author;
  final int price;
  final int discount;
  final String publisher;
  String pubdate;
  final String isbn;
  final String description;

  Book(
      {this.title,
      this.link,
      this.image,
      this.author,
      this.price,
      this.discount,
      this.pubdate,
      this.publisher,
      this.isbn,
      this.description});

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        link = json['link'],
        image = json['image'],
        author = json['author'],
        price = int.parse(json['price'] != '' ? json['price'] : '0'),
        discount = int.parse(json['discount'] != '' ? json['discount'] : '0'),
        // pubdate = DateTime.parse(json['pubdate']),
        publisher = json['publisher'],
        isbn = json['isbn'],
        description = json['description'] {
    //
    String date = json['pubdate'];
    final formatter = DateFormat('yyyy년 MM월 dd일');

    if (date.length == 8) {
      pubdate = formatter.format(DateTime.parse(date));
    } else {
      //판독 불가
      int year = int.parse(date.substring(0, 1));
      if (year > 20) {
        pubdate = formatter.format(DateTime.parse('19' + date));
      } else {
        pubdate = formatter.format(DateTime.parse('20' + date));
      }
    }
  }
}
