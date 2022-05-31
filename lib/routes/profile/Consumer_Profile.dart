import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';



String points = "100";
String username = "Chris Niles";



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
      title: 'Checklist',
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Profile'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(10)),
              Text(
              "Hello, $username",
              style: TextStyle(fontSize: 24),
              ),
                const Padding(padding: EdgeInsets.all(10)),
                const Text(
                  "Your Soil Sauce Points",
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                "$points",
                style: TextStyle(fontSize: 30),
            ),
                const Padding(padding: EdgeInsets.all(35)),
                SizedBox(
                    height:60,
                    width: 350,
                    child: ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: Color(0xFF3B7621),
                      onPrimary: Colors.white,
                      elevation: 4,
                    ),
                    onPressed: (){},
                      child: Text(
                        "Scan",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center
                      ),
              )
              ),
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height:55,
                  width:350,
                  child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Color(0xFF015486),
                        onPrimary: Colors.white,
                        elevation: 4,
                    ),
                  onPressed: (){},
                    child: Text(
                      "Shop",
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center
                    ),
                  )
              ),
                const Padding(padding: EdgeInsets.all(45)),
                SizedBox(
                    height:55,
                    width:350,
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        primary: Color(0xFF860101),
                        onPrimary: Colors.white,
                        elevation: 4,
                      ),
                    onPressed: (){},
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
      bottomNavigationBar: NavBar(),
    );

  }
}