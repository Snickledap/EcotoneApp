import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar_Consumer.dart';
import 'package:get/get.dart';

import '../../main.dart';




String points = "100";



void main() {
  runApp(const ConsumerProfile());
}

class ConsumerProfile extends StatelessWidget {
  const ConsumerProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      home: _ConsumerProfile(),
    );
  }
}

class _ConsumerProfile extends StatefulWidget {
  const _ConsumerProfile({Key? key}) : super(key: key);

  @override
  _ConsumerProfileState createState() => _ConsumerProfileState();
}

class _ConsumerProfileState extends State<_ConsumerProfile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //Header
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                //Username Text Formatting
                const Padding(padding: EdgeInsets.all(10)),

              //Username Text
              Text(
              "Hello, Consumer",
              style: TextStyle(fontSize: 24),
              ),

                //Point # Text Formatting
                const Padding(padding: EdgeInsets.all(10)),

                //Point # Text
                const Text(
                  "Your Soil Sauce Points",
                  style: TextStyle(fontSize: 30),
                ),

                //Points Variable
                Text(
                "$points",
                style: TextStyle(fontSize: 30),
            ),

                //Scan Button Formatting
                const Padding(padding: EdgeInsets.all(35)),
                SizedBox(
                    height:60,
                    width: 350,

                    //Scan Button
                    child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Color(0xFF3B7621),
                      onPrimary: Colors.white,
                      elevation: 4,
                    ),

                    //Scan Button Action
                    onPressed: (){},

                      //Scan Button Text
                      child: Text(
                        "Scan",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center
                      ),
              )
              ),

                //Shop Button Formatting
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height:55,
                  width:350,

                  //Shop Button
                  child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Color(0xFF015486),
                        onPrimary: Colors.white,
                        elevation: 4,
                    ),

                  //Shop Button Action
                  onPressed: (){Get.to(() => RouteGenerator());},

                    //Shop Button Text
                    child: Text(
                      "Team Facing App",
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center
                    ),
                  )
              ),

                //Sign Out Button Formatting
                const Padding(padding: EdgeInsets.all(45)),
                SizedBox(
                    height:55,
                    width:350,

                    //Sign Out Button
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Color(0xFF860101),
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),

                    //Sign Out Button Action
                    onPressed: (){},


                      //Sign Out Button Text
                      child: Text(
                        "Sign Out",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center
                    ),
                    )
            )
            ],
        )
    ),

      //Bottom Navigation Bar
      bottomNavigationBar: NavBar_Consumer(),
    );

  }
}