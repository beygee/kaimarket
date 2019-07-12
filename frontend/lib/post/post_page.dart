import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child:  Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '카테고리', style: TextStyle(fontSize:18.0)
              ),
            ),
            Divider(),
            _buildGrid(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '선호지역', style: TextStyle(fontSize:18.0)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() => 
    Expanded(
      child: SafeArea(
        top: false,
        bottom: false,
        child: GridView.count(
          crossAxisCount: 5,
          padding: const EdgeInsets.all(4),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 1.0,
          children: <Widget>[
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    final snackBar = SnackBar(content: Text("Tap"));
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 80.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.movie, color: Colors.red),
                        Container(margin: const EdgeInsets.only(top: 8),
                          child: Text(
                          "카테고리1",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                            ), 
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
}