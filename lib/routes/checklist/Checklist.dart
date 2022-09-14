import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../NavBar.dart';

void main() => runApp(CheckList());

class CheckList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Checklist',
          home: ChecklistPage(),
        );
      }
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
                children: <Widget>[  //Check Box Logic
                SizedBox(
                  height: 60.h,
                  width: 95.w,
                  child: Column(
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
                ),
                //Button Formatting
                Padding(padding: EdgeInsets.only(top: 5.h)),
                SizedBox(
                    height: 10.h,
                    width: 60.w,
                    child:ElevatedButton(
                    style:ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF015486),
                      elevation: 4,
                    ),
                    //Button Action
                    onPressed: (){},
                      //Button Text
                      child:
                      Text("Submit",
                          style: TextStyle(fontSize: 17.sp),
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
