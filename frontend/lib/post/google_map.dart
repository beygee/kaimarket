import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget{
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

  // for maptype change
  MapType _currentMapType = MapType.normal;

  // for marker save
  final Set<Marker> _markers = {};

  // for add markemr
  LatLng _lastMapPosition = kaist.target;

  LatLng _selectMapPosition;

  void _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  void _onTapMap(CameraPosition position){
    _selectMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller){
    // _controller.complete(controller);
    _controller = controller;
  }

  moveToKaist(){
    setState(() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(kaist));
    _markers.clear();
    });
  }

  void _onAddMarkerButtonPressed(LatLng latlang){
    setState(() {
     _markers.add(Marker(
       markerId: MarkerId(_lastMapPosition.toString()),
       position: latlang,
       infoWindow: InfoWindow(
         title: 'Selected',
         snippet: 'test',
       ),
       icon: BitmapDescriptor.defaultMarker,
     ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          height: 300.0,
          width: MediaQuery.of(context).size.width,
          child: Stack(
        children: <Widget>[
          GoogleMap(
          onMapCreated: _onMapCreated,
          mapType: MapType.normal,
          markers: _markers,
          onCameraMove: _onCameraMove,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          onTap: (latlang){
            if(_markers.length>=1){
              _markers.clear();
            }
            _selectMapPosition = latlang;
          },
          initialCameraPosition: kaist
         ),
         Padding(
          padding:  const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: moveToKaist,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.refresh, size: 36.0),
                ),
                SizedBox(height: 16.0),
                FloatingActionButton(
                  onPressed: ()=>_onAddMarkerButtonPressed(_selectMapPosition),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add_location, size: 36.0),
                )
              ],
            )
          ),
         )
        ]
      ),
        ),
      )
    );

  }
}