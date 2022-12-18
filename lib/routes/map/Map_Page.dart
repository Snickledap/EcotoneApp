import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
final Stream<QuerySnapshot> Container_Location = FirebaseFirestore
    .instance
    .collection('Container_Location')
    .snapshots();
  LocationData? currentLocation;
class _MapState extends State<Map> {



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
            zoom: 2),
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },);
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

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
            StreamBuilder<QuerySnapshot>(stream: Container_Location,
                builder:
                    (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        "Something Went wrong with the snapshot of the Container Location");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  final data = snapshot.requireData;
                  return ListView.builder(
                    controller: widget.controller,
                    shrinkWrap: true,
                    itemCount: data.size,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01),
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                            },
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
                                        onPressed: () async{
                                          _googleMapController.animateCamera(
                                          CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                          target: LatLng(
                                          data.docs[index]["LatLng"].latitude,
                                          data.docs[index]["LatLng"].longitude
                                          ),
                                          zoom: 19)
                                          ));
                                          _addMarker(LatLng(
                                              data.docs[index]["LatLng"].latitude,
                                              data.docs[index]["LatLng"].longitude
                                          ),
                                          );

                                          print(data.runtimeType);
                                          },
                                        icon: const Icon(Icons.place)),
                                  )),
                            ),

                        ),
                      );
                    },
                  );
                }
            ),
          ],
        ),
      ),
    );

  }
 Future _addMarker(LatLng pos) async{
    if (_origin == null || (_origin != null && _destination != null)){
      setState((){
        _origin = Marker(
          markerId: const MarkerId("origin"),
          infoWindow: InfoWindow(title: "You are Here"),
          position:  LatLng(
              currentLocation!.latitude!, currentLocation!.longitude!),
        );
        _destination = null;
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
    final directions = await DirectionsRepository().getDirections(origin: pos, destination: pos);
    setState(() => _info = directions!);
 }

}

class MyBehavior extends ScrollBehavior{

  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
}
