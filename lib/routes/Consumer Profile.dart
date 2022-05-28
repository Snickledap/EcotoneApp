import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
String points = "100";
String username = "Chris Niles";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Checklist',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ecotone'),
        ),
        body: Container(
            child:  Column(
              children: <Widget>[SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                        "Hello, $username",
                        style: TextStyle(fontSize: 24),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text(
                          "\n \n \n \n \nYour Soil Sauce Points",
                          style: TextStyle(fontSize: 30),
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Text(
                          "$points",
                          style: TextStyle(fontSize: 30),
                        ),

                        const Padding(padding: EdgeInsets.all(35)),
                        Container(alignment: Alignment.center,height:60, width: 400, child:
                        ElevatedButton(
                            style:ElevatedButton.styleFrom(
                              primary: Color(0xFF3B7621),
                              onPrimary: Colors.white,
                              elevation: 4,
                            ),
                            onPressed: (){},
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "Scan",
                                  style: TextStyle(fontSize: 24.0),
                                  textAlign: TextAlign.center
                              ),
                            )
                        )
                        ),
                        const Padding(padding: EdgeInsets.all(20)),
                        Container(alignment: Alignment.center,height:60, width: 400, child:
                        ElevatedButton(
                            style:ElevatedButton.styleFrom(
                              primary: Color(0xFF015486),
                              onPrimary: Colors.white,
                              elevation: 4,
                            ),
                            onPressed: (){},
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "Shop",
                                  style: TextStyle(fontSize: 24.0),
                                  textAlign: TextAlign.center
                              ),
                            )
                        ),
                        ),
                      const Padding(padding: EdgeInsets.all(80)),
                      Container(alignment: Alignment.center,height:60, width: 400, child:
                      ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            primary: Color(0xFF860101),
                            onPrimary: Colors.white,
                            elevation: 4,
                          ),
                          onPressed: (){},
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "Sign Out",
                                style: TextStyle(fontSize: 24.0),
                                textAlign: TextAlign.center
                            ),
                          )
                      )
                      )
                      ],
                      )
                   ]
                  ),
                    ]
              )
              )
              )
              ],
            )
        )
    );
  }
}