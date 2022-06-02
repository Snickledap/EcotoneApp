import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



void main() {
  runApp(Map());
}


class Map extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Map'),
        ),
          body: Column(
          children: <Widget>[
           Container(
             height: 400,
             width: 500,
             child: googleMap(),
           )
            //map
            //list
          ],
        ),
      )
    );
  }
}


class googleMap extends StatefulWidget{

  @override
  State<googleMap> createState() => googleMapState();
}

class googleMapState extends State<googleMap>{
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kBrottier = CameraPosition(
    target: LatLng(40.437509, -79.993047),
    zoom: 14.4746,
  );

  static final CameraPosition _kHome = CameraPosition(
      target: LatLng(40.64221310404301, -79.93630650628933),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kBrottier,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goHome,
        label: Text('Go Home'),
        icon: Icon(Icons.house),
      ),
    );
  }

  Future<void> _goHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
  }
}