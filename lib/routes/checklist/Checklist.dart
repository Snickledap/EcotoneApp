import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../NavBar.dart';

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
  // Generate a list of available hobbies here
  List<Map> checklist= [
    {"name": "Feed system 1:2 ratio of Food to Water ", "isChecked": false},
    {"name": "Drain Soil Sauce", "isChecked": false},
    {"name": "Check dosing and holding tank levels", "isChecked": false},
    {"name": "Input Data Into QR Form", "isChecked": false,},
    {"name": "Fill out involveMint", "isChecked": false},
    {"name": "Complete BioGas Form ", "isChecked": false},
    {"name": "Clean Area After Finished ", "isChecked": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Check List'),
          centerTitle: true,
        ),
        body:Container(
          alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'CHECKLIST',
                      style: TextStyle(
                           color: Color(0xFF015486),
                           fontSize: 40.0,
                    ),
                  ),
                ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Column(
                    children: checklist.map((task) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: CheckboxListTile(
                              value: task["isChecked"],
                              title: Text(task["name"],
                                   style: TextStyle(
                                     color: Color(0xFF015486),
                                   ),
                              ),
                              activeColor: Color(0xFF015486),
                              checkColor: Colors.white,
                              tileColor: Colors.white30,
                              onChanged: (newValue) {
                                setState(() {
                                  task["isChecked"] = newValue;
                                });
                              }),
                        ),
                      );
                    }).toList()),
                const Padding(padding: EdgeInsets.all(60)),
                Container(alignment: Alignment.center,height:60, width: 400, child:
                SizedBox(
                    height: 60,
                    width: 300,
                    child:ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: const Color(0xFF015486),
                      onPrimary: Colors.white,
                      elevation: 4,
                    ),
                    onPressed: (){},
                      child:
                      Text(
                          "Submit",
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center
                      ),
                    )
                )
                )
              ],
            )
        ),
      bottomNavigationBar: NavBar(),
    );
  }
}
