import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:week_3/utils/utils.dart';

class GoogleMapfixed extends StatelessWidget {
  LatLng picked;

  GoogleMapfixed({LatLng this.picked});

  final Set<Marker> _markers = {};

  GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    _controller = controller;
  }

  void _AddMarker(LatLng latlang) {
    _markers.add(Marker(
      markerId: MarkerId(picked.toString()),
      position: latlang,
      infoWindow: InfoWindow(
        title: '선호위치',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  moveToDefault() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(picked.latitude, picked.longitude), zoom: 15.0)));
  }

  @override
  Widget build(BuildContext context) {
    _AddMarker(picked);
    return Container(
        height: screenAwareSize(300.0, context),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              markers: _markers,

              // 제스쳐 주고싶으면 풀기
              // gestureRecognizers: Set()
              //   ..add(
              //       Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
              //   ..add(Factory<VerticalDragGestureRecognizer>(
              //       () => VerticalDragGestureRecognizer()))
              //   ..add(Factory<ScaleGestureRecognizer>(
              //       () => ScaleGestureRecognizer()))
              //   ..add(Factory<TapGestureRecognizer>(
              //       () => TapGestureRecognizer())),
              zoomGesturesEnabled: false,
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                  target: LatLng(picked.latitude, picked.longitude),
                  zoom: 15.0),
            ),
            //리프레시버튼
            // Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Align(
            //     alignment: Alignment.topRight,
            //     child: IconButton(
            //       onPressed: () => moveToDefault(),
            //       icon: Icon(Icons.refresh, size: 36.0),
            //       color: Colors.black,
            //     ),
            //   ),
            // )
          ],
        ));
  }
}
