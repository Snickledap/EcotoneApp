import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../NavBar.dart';

void main() => runApp(CheckList());

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Header
    return MaterialApp(
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
    {"name": "Complete BioGas Form ", "isChecked": false},
    {"name": "Clean Area After Finished ", "isChecked": false},
    {"name": "Fill out involveMint", "isChecked": false}
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
                Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.18)),
                SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                    width: MediaQuery.of(context).size.width*0.6,
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
              ]
            )
        ),

      //Bottom Navigation Bar
      bottomNavigationBar: NavBar(),
    );
  }
}
