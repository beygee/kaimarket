import 'package:flutter/material.dart';
import 'package:week_3/login/login_page.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/splash.dart';
import 'layout/default.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: ThemeColor.primary,
      ),
      initialRoute: '/splash',
      routes: {
        '/': (context) => DefaultLayout(),
        '/splash': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }

  // Widget _buildSplashScreen() {
  //   return SplashScreen(
  //     seconds: 2,
  //     navigateAfterSeconds: LoginPage(),
  //     title: Text("카이마켓",
  //         style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold)),
  //     image: Image.asset('assets/images/logo.jpg'),
  //     backgroundColor: Colors.white,
  //     styleTextUnderTheLoader: TextStyle(),
  //     photoSize: 120.0,
  //     onClick: () => print("Flutter"),
  //     // loaderColor: Colors.red,
  //   );
  // }
}
