import 'package:flutter/material.dart';
import 'package:week_3/login/login_page.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/splash.dart';
import 'layout/default.dart';
import 'package:week_3/login/valid/valid_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_3/bloc/bloc.dart';
import 'utils/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocketBloc>(builder: (context) => SocketBloc()),
        BlocProvider<PostBloc>(builder: (context) => PostBloc()),
        BlocProvider<UserBloc>(builder: (context) => UserBloc()),
      ],
      child: LifecycleWatcher(),
    );
  }
}

class LifecycleWatcher extends StatefulWidget {
  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: ThemeColor.primary,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/home': (context) => DefaultLayout(),
        '/login': (context) => LoginPage(),
        '/valid': (context) => ValidPage(),
      },
    );
  }
}
