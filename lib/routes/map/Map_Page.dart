import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecotone_app/NavBar.dart';

void main() {
  runApp( Map_Page(),);
}


class Map_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kZeus = CameraPosition(
    target: LatLng(40.451565,-80.1770931),
    zoom: 19,
  );
  LocationData? currentLocation;

  void getCurrentLocation(){
    Location location = Location();
    location.getLocation().then((location){
      setState(() {
        currentLocation = location;

      });
      print(location);
      print("this is the current location");
      },
    );
  }

  Widget getMapBody (){
    if (currentLocation == null){
      return Center(child: Text("Loading"),);
    }
    else {
      return GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target:LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 19) ,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },);
    }
  }
  @override
  void initState(){
    getCurrentLocation();
    super.initState();
  }


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
              child: getMapBody(),
            ),
            SizedBox(
                height: 200,
                width: 400,
                child:ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
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
                                  title: Text('Zeus Container'),
                                  subtitle: Text('140 Andrew Dr, Pittsburgh, PA 15275'),
                                  trailing: IconButton(onPressed: _goToZeus, icon: Icon(Icons.place)),
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
  Future<void> _goToZeus() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kZeus));
  }
}



class MyBehavior extends ScrollBehavior{
    @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
  }