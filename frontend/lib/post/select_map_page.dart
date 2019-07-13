import 'package:flutter/material.dart';
import 'package:week_3/post/google_map.dart';
import 'package:week_3/models/post.dart';
import 'package:week_3/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SelectMapPage extends StatefulWidget {
  final Post post;
  SelectMapPage({this.post});

  @override
  State<StatefulWidget> createState() => SelectMapPageState();
}

class SelectMapPageState extends State<SelectMapPage> {
  GlobalKey<LoadingWrapperState> _loadingWrapperKey =
      GlobalKey<LoadingWrapperState>();

  @override
  Widget build(BuildContext context) {
    return LoadingWrapper(
      key: _loadingWrapperKey,
      builder: (context, loading) {
        return Stack(children: <Widget>[
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                '선호 지역 선택',
                style: TextStyle(fontSize: 16.0),
              ),
              actions: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkResponse(
                    onTap: _onTapComplete,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("완료"),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(children: <Widget>[
                GoogleMapPage(
                  onTap: _onTapLagLng,
                ),
              ]),
            ),
          ),
          loading
              ? Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                    child: Center(
                      child: SpinKitChasingDots(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : Container()
        ]);
      },
    );
  }

  //지도에서 마커를 선택했을 시 좌표 값을 받아온다.
  _onTapLagLng(double lat, double lng) {
    widget.post.locationLat = lat;
    widget.post.locationLng = lng;
  }

  //데이터 작성 완료
  _onTapComplete() {
    _loadingWrapperKey.currentState.loadFuture(() async {
      await dio
          .postUri(getUri('/api/posts'), data: {'data': widget.post.toJson()});
      Navigator.popUntil(context, ModalRoute.withName('/'));
    });
  }
}
