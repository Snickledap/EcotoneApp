import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../NavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Map> checklist1= [
    {"name": "Feed system 1:2 ratio of Food to Water", "isChecked": false},
    {"name": "Drain Soil Sauce", "isChecked": false},
    ];
  List<Map> checklist2= [
    {"name": "Check dosing and holding tank levels", "isChecked": false},
    {"name": "Input Data Into QR Form", "isChecked": false,},
    {"name": "Complete BioGas Form ", "isChecked": false},
    {"name": "Clean Area After Finished ", "isChecked": false},
    {"name": "Fill out involveMint", "isChecked": false}
  ];

  @override
  Widget build(BuildContext context){

    Future<void> _launchFeedingForm() async {
      final Uri _url = Uri.parse('https://docs.google.com/forms/u/0/d/1Q19Drp78QNgefURf_scAc7scYmZe0DnEcdT2Rgr63lI/viewform?edit_requested=true');
      if (!await launchUrl(_url)) {
        throw 'Could not launch Form';
      }
    }
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
                  height: 15.h,
                  width: 95.w,
                  child: Column(
                      children:
                      checklist1.map((task) {
                        return CheckboxListTile(
                            value: task["isChecked"],
                            title: Text(task["name"]),
                            onChanged: (newValue) {
                              setState(() {
                                task["isChecked"] = newValue;
                              });
                            }
                            );
                      }).toList(),
                  ),
                ),
                  Center(
                    child: SizedBox(
                      height: 5.h,
                      width: 45.w,
                      child:
                        ElevatedButton(
                          style:ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF015486),
                            elevation: 4,
                          ),
                          child: Text('Feeding and Draining Form'),
                          onPressed: _launchFeedingForm,
                        )
                    ),
                  ),
                  SizedBox(
                    height: 45.h,
                    width: 95.w,
                    child: Column(
                        children: checklist2.map((task) {
                          return CheckboxListTile(
                              value: task["isChecked"],
                              title: Text(task["name"]),
                              onChanged: (newValue) {
                                setState(() {
                                  task["isChecked"] = newValue;
                                });
                              }
                          );
                        }).toList()),
                  ),
                //Button Formatting
                Padding(
                    padding: EdgeInsets.only(top: 3.h)
                ),
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
