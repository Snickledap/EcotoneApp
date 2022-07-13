import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecotone_app/NavBar.dart';

void main() => runApp(MapPage());

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Google Maps Demo',
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kBrottier = CameraPosition(
    target: LatLng(40.437315, -79.992711),
    zoom: 19,
  );

  static final CameraPosition _kHome = CameraPosition(
      bearing: 0,
      target: LatLng(40.642213, -79.936522),
      tilt: 0,
      zoom: 19);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: Column(
        children:<Widget>[
         SizedBox(
           height: 400,
          width: 500,
          child:GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kBrottier,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
         ),
          SizedBox(
            height: 200,
            width: 400,
            child:ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(5),
              itemBuilder: (context, index) {
                return SizedBox(
                    height: 75,
                    width: 200,
                    child:ScrollConfiguration(
                        behavior: MyBehavior(),
                        child:ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            ListTile(
                              title: Text('Container'),
                              subtitle: Text('Specific Location of the Container'),
                              trailing: IconButton(onPressed: _goHome, icon: Icon(Icons.home)),
                            ),

                          ],
                        )
                    )
                );
              },
            )
          ),

        ]
          ),
      bottomNavigationBar:NavBar() ,

        );
  }

  Future<void> _goHome() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kHome));
  }
}


class MyBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
  }