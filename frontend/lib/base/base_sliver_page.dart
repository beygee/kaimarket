import 'package:flutter/material.dart';
import 'package:week_3/helper.dart';
import 'package:rxdart/rxdart.dart';

class BaseSliverPage extends StatefulWidget {
  //Scroll
  final int throttleDelay;
  final VoidCallback onScroll;
  final VoidCallback onScrollBottom;
  final RefreshCallback onRefresh;

  //Appber
  final double appBarHeight;
  final Widget appBarTitle;
  final Widget appBarChild;

  //slivers
  final List<Widget> slivers;

  BaseSliverPage({
    @required this.slivers,
    this.throttleDelay = 300,
    this.onScroll,
    this.onScrollBottom,
    this.onRefresh,
    this.appBarHeight,
    this.appBarTitle,
    this.appBarChild,
  });
  @override
  _BaseSliverPageState createState() => _BaseSliverPageState();
}

class _BaseSliverPageState extends State<BaseSliverPage> {
  ScrollController scrollController;
  final scrollThrottleSubject = ReplaySubject();

  @override
  void initState() {
    super.initState();

    scrollController = ScrollController();
    scrollController.addListener(_onScroll);

    scrollThrottleSubject
        .throttleTime(Duration(milliseconds: widget.throttleDelay))
        .listen((_) {
      if (widget.onScrollBottom != null) widget.onScrollBottom();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollThrottleSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget page = BaseNoneGlowScrollWrapper(
      child: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          _buildAppbar(context),
          ...widget.slivers,
        ],
      ),
    );

    //리프레시 인디케이터를 붙여준다.
    if (widget.onRefresh != null) {
      page = RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: page,
      );
    }

    return page;
  }

  Widget _buildAppbar(context) {
    final statusBarHeight = MediaQuery.of(context).padding.top.toDouble();
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: widget.appBarHeight != null
          ? widget.appBarHeight + statusBarHeight + 56
          : null,
      pinned: true,
      flexibleSpace: widget.appBarHeight != null
          ? FlexibleSpaceBar(
              background: Container(
                // alignment: Alignment.bottomCenter,
                padding:
                    EdgeInsets.fromLTRB(10, statusBarHeight + 10 + 56, 10, 10),
                color: Colors.white,
                child: widget.appBarChild,
              ),
            )
          : null,
      title: widget.appBarTitle ?? Text(""),
      centerTitle: true,
      leading: Navigator.of(context).canPop()
          ? IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey[500],
              ),
              iconSize: 30.0,
            )
          : null,
    );
  }

  //스크롤 리스트
  void _onScroll() {
    if (widget.onScroll != null) widget.onScroll();
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (maxScroll - currentScroll <= 500) {
      scrollThrottleSubject.add(true);
    }
  }
}
