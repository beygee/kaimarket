import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  static final kaist = CameraPosition(
    target: LatLng(36.3708602, 127.3625224),
    zoom: 15.0,
  );

  // for marker save
  final Set<Marker> _markers = {};

  // for add markemr
  LatLng _lastMapPosition = kaist.target;

  LatLng _selectMapPosition;

  int markerpressed;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onTapMap(CameraPosition position) {
    _selectMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    _controller = controller;
  }

  moveToKaist() {
    setState(() {
      _controller.animateCamera(CameraUpdate.newCameraPosition(kaist));
      _markers.clear();
    });
  }

  void _onAddMarkerButtonPressed(LatLng latlang) {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: latlang,
        infoWindow: InfoWindow(
          title: 'selected',
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
    markerpressed = 0;

    return Container(
      height: screenAwareSize(450.0, context),
      width: MediaQuery.of(context).size.width,
      child: Stack(children: <Widget>[
        GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.normal,
          markers: _markers,
          onCameraMove: _onCameraMove,
          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer()))
            ..add(
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer())),
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          tiltGesturesEnabled: true,
          initialCameraPosition: kaist,
          onTap: (latlang) {
            if (_markers.length >= 1) {
              _markers.clear();
            }
            _selectMapPosition = latlang;
            if (markerpressed == 1) {
              _onAddMarkerButtonPressed(latlang);
            }
          },
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  IconButton(
                    onPressed: () => moveToKaist(),
                    icon: Icon(Icons.refresh, size: 36.0),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      if (markerpressed == 0) {
                        markerpressed = 1;
                      } else {
                        markerpressed = 0;
                      }
                    },
                    icon: Icon(Icons.add_location, size: 36.0),
                    color: Colors.black,
                  )
                ],
              )),
        )
      ]),
    );
  }
}
