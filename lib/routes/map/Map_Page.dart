import 'package:flutter/material.dart';

void main() => runApp(Map());

class Map extends StatelessWidget{

  Widget build(BuildContext context){
    return MaterialApp(
      home: Map(),
    );
  }
}

class Maping extends StatefulWidget {
  const Maping({Key? key}) : super(key: key);

  @override
  State<Maping> createState() => MapingState();
}

class MapingState extends State<Maping> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: SizedBox(
          width:double.infinity,
          height:double.infinity),
      bottomNavigationBar: NavBar(),
    );
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