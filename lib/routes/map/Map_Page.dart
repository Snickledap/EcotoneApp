
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'directions_model.dart';
import 'directions_repository.dart';


late GoogleMapController _googleMapController ;

class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  LocationData? currentLocation;

class _MapState extends State<Map> {

  late CollectionReference cl;
  @override
  void initState() {
    super.initState();
    cl = FirebaseFirestore.instance.collection('Container_Location');
    getCurrentLocation();
    getMapBody();
    //zeusLocation();
    setState(() {});
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
      print(location);
      print("this is the current location");
    },
    );
  }

  Widget getMapBody() {

    if (currentLocation == null) {
      return Center(child: Text("Loading"),);
    }
    else {
      return GoogleMap(
        myLocationEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        markers: {
          if(_origin != null) _origin!,
          if(_destination != null) _destination!
        },
        polylines: {
          if (_info != null)
            Polyline(
              polylineId: const PolylineId('overview_polyline'),
              color: Colors.red,
              width: 5,
              points: _info!.polylinePoints
                  .map((e) => LatLng(e.latitude, e.longitude))
                  .toList(),
            ),
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 19),
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },);
    }
  }

  // Future<dynamic> zeusLocation() async{
  //
  //   QuerySnapshot querySnapshot = await cl.get();
  //   List<dynamic> allLocationData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   //var locations = allLocationData[0];
  //   //var zeus = locations;
  //   print("All location data*** " + allLocationData.toString());
  //
  //   for(var i = 0; i < allLocationData.length; i++) {
  //     var location = jsonDecode(allLocationData[i]);
  //     print(location.runtimeType.toString());
  //   }
  //
  //   // List zeusLocation = allLocationData[0]?.key['LatLng'];
  //   // List zeusLatLng = allLocationData.map((e) => e['LatLng']).toList();
  //   // print(zeusLatLng);
  // }





  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: SlidingUpPanel(
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        minHeight: MediaQuery.of(context).size.height*0.06,
          maxHeight: MediaQuery.of(context).size.height*0.5,
          body: getMapBody(),
       panelBuilder: (controller) => PanelWidget(
        controller:controller,
    ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}


class PanelWidget extends StatefulWidget {
  @override
  PanelWidget({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  final zeusLatLngApple = [
    Uri.parse('https://maps.apple.com/?saddr=&daddr=${40.42045488761319},${-79.88424417581666}&directionsmode=driving'),
    Uri.parse('https://maps.apple.com/?saddr=&daddr=${40.451565},${-80.1770931}&directionsmode=driving')

  ];
  final zeusLatLngAndroid = [
    Uri.parse('https://www.google.com/maps/search/?api=1&query=${40.42045488761319},${-79.88424417581666}'),
    Uri.parse('https://www.google.com/maps/search/?api=1&query=${40.451565},${-80.1770931}')
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Zeus Locations",
              style: TextStyle(fontSize: 24),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Container_Location').snapshots(),
                builder:
                    (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text(
                            "Something Went wrong with the snapshot of the Container Location");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.requireData;
                        return ListView.builder(
                          controller: widget.controller,
                          shrinkWrap: true,
                          itemCount: data.size,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01),
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.09,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.02,
                                      child: ListTile(
                                        title: Text(
                                            '${data.docs[index]['Name']}'),
                                        subtitle: Text(
                                            '${data.docs[index]['Address']}'),
                                        trailing: IconButton(
                                            onPressed: () async {
                                              if (Platform.isIOS) {
                                                if (await canLaunchUrl(zeusLatLngApple[index])) {
                                                  await launchUrl(zeusLatLngApple[index]);
                                                } else {
                                                  if (await canLaunchUrl(zeusLatLngAndroid[index])) {
                                                    await launchUrl(zeusLatLngAndroid[index]);
                                                  } else {
                                                    throw 'Could not open the map.';
                                                  }
                                                }
                                              } else {
                                                if (await canLaunchUrl(zeusLatLngAndroid[index])) {
                                                  await launchUrl(zeusLatLngAndroid[index]);
                                                } else {
                                                  throw 'Could not open the map.';
                                                }
                                              }
                                              // _googleMapController
                                              //     .animateCamera(
                                              //     CameraUpdate
                                              //         .newCameraPosition(
                                              //         CameraPosition(
                                              //             target: zeusLatLng[index],
                                              //             zoom: 19)
                                              //     ));
                                              // _addMarker(zeusLatLng[index]
                                              // );

                                            },
                                            icon: const Icon(Icons.place)),
                                      )),
                                ),

                              ),
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    ),
          ],
        ),
      ),
    );

  }
 void _addMarker(LatLng pos) async{
    if (_origin == null || (_origin != null && _destination != null)){
      setState((){
        _origin = Marker(
          markerId: const MarkerId("origin"),
          infoWindow: InfoWindow(title: "You are Here"),
          position:  LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
        );
        _destination = null;
        _info = null;
      });
    } else{
      setState(() {
        _destination =Marker(
          markerId: MarkerId("Your destination"),
          infoWindow: InfoWindow(title: "destination"),
          position: pos,
        );
      });
    }
    final directions = await DirectionsRepository().getDirections(origin: _origin!.position, destination: pos);
    setState(() => _info = directions);
 }

}

class MyBehavior extends ScrollBehavior{

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
}



