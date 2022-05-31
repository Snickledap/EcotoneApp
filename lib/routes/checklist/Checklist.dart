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
        title: const Text('Ecotone'),
      ),
      bottomNavigationBar: NavBar(),
      body: Container(
        child:  Column(
        children: <Widget>[SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                'Checklist: \n ',
                style: TextStyle(fontSize: 24),
                ),
                Column(
                children: checklist.map((task) {
              return CheckboxListTile(
                  value: task["isChecked"],
                  title: Text(task["name"]),
                  onChanged: (newValue) {
                    setState(() {
                      task["isChecked"] = newValue;
                    });
                  });
            }).toList()),
          ]
              ),
        ),
      ),
          const Padding(padding: EdgeInsets.all(60)),
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
            "Submit",
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center
            ),
          )
          )
          )
     ],
        )
    )
    );
  }
}
