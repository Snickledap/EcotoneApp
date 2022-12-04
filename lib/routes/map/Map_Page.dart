import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Map extends StatefulWidget {
  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late final Completer<GoogleMapController> _controller = Completer();
  LocationData? currentLocation;

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
        myLocationButtonEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
            target: LatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            zoom: 19),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },);
    }
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }


  @override
  final Stream<QuerySnapshot> Container_Location = FirebaseFirestore
      .instance
      .collection('Container_Location')
      .snapshots();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.4,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 1,
              child: getMapBody(),
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.29,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 1,
              child: StreamBuilder<QuerySnapshot>(stream: Container_Location,
                  builder:
                      (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text(
                          "Something Went wrong with the snapshot of the Container Location");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(shrinkWrap: true,
                      itemCount: data.size,
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01),
                      itemBuilder: (context, index) {
                        return SizedBox(
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
                                    GoogleMapController controller = await _controller
                                        .future;
                                    controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            CameraPosition(target: LatLng(data.docs[index]["LatLng"].latitude, data.docs[index]["LatLng"].longitude),
                                                zoom: 19)
                                        ));
                                  },
                                  icon: Icon(Icons.place)),
                            ));
                      },
                    );
                  }
              ),
            ),
          ]
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}


class MyBehavior extends ScrollBehavior{
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details){
    return child;
  }
}