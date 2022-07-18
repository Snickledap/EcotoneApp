import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../NavBar.dart';

void main() {
  runApp(CheckList());
}

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Header
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Checklist',
      home: ChecklistPage(),
    );
  }
}

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({Key? key}) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {

  // Generate checklist here
  List<Map> checklist= [
    {"name": "Feed system 1:2 ratio of Food to Water", "isChecked": false},
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

      //Header
        appBar: AppBar(
          title: const Text('Checklist'),
          centerTitle: true,
        ),
        //Check Box Containers
        body:Container(
          alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Check Box Format
                const Padding(padding: EdgeInsets.all(10)),
                //Check Box Logic
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
                //Button Formatting
                const Padding(padding: EdgeInsets.all(60)),
                Container(alignment: Alignment.center,height:60, width: 400, child:
                SizedBox(
                    height: 60,
                    width: 300,

                    //Button
                    child:ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      primary: const Color(0xFF015486),
                      onPrimary: Colors.white,
                      elevation: 4,
                    ),

                    //Button Action
                    onPressed: (){},

                      //Button Text
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
      //Bottom Navigation Bar
      bottomNavigationBar: NavBar(),
    );
  }
}
