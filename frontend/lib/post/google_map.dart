import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:week_3/styles/theme.dart';
import 'package:week_3/utils/utils.dart';

class GoogleMapPage extends StatefulWidget {
  final Function(double, double) onTap;

  GoogleMapPage({this.onTap});
  @override
  State<StatefulWidget> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<GoogleMapPage> {
  //Completer<GoogleMapController> _controller = Completer();

  GoogleMapController _controller;

  final kaist = CameraPosition(
    target: LatLng(36.3708602, 127.3625224),
    zoom: 15.2,
  );

  // for marker save
  final Set<Marker> _markers = {};

  // for add markemr
  LatLng _lastMapPosition;

  LatLng _selectMapPosition;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onTapMap(CameraPosition position) {
    _selectMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _lastMapPosition = kaist.target;
    _controller = controller;
  }

  moveToKaist() {
    setState(() {
      _controller.animateCamera(CameraUpdate.newCameraPosition(kaist));
    });
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: latlang,
        infoWindow: InfoWindow(
          title: '선호지역',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    //콜백함수 실행
    if (widget.onTap != null) {
      widget.onTap(latlang.latitude, latlang.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            // height: screenAwareSize(450.0, context),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                GoogleMap(
                  rotateGesturesEnabled: false,
                  onMapCreated: _onMapCreated,
                  mapType: MapType.normal,
                  markers: _markers,
                  onCameraMove: _onCameraMove,
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer()))
                    ..add(Factory<VerticalDragGestureRecognizer>(
                        () => VerticalDragGestureRecognizer()))
                    ..add(Factory<ScaleGestureRecognizer>(
                        () => ScaleGestureRecognizer()))
                    ..add(Factory<TapGestureRecognizer>(
                        () => TapGestureRecognizer())),
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  initialCameraPosition: kaist,
                  onTap: (latlang) {
                    _selectMapPosition = latlang;
                    _onAddMarkerButtonPressed(latlang);
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ThemeColor.primary, shape: BoxShape.circle),
                    child: Material(
                      color: Colors.transparent,
                      child: InkResponse(
                        splashColor: Colors.white.withOpacity(0.5),
                        highlightColor: Colors.white.withOpacity(0.2),
                        hoverColor: Colors.white.withOpacity(0.2),
                        focusColor: Colors.white.withOpacity(0.2),
                        onTap: () => moveToKaist(),
                        child: Padding(
                          padding:
                              EdgeInsets.all(screenAwareSize(10.0, context)),
                          child: Icon(
                            Icons.refresh,
                            size: 36.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: screenAwareSize(40.0, context),
          child: Center(
            child: Text("지도를 클릭하세요."),
          ),
        ),
      ],
    );
  }
}
