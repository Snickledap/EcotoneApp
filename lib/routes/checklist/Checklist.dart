import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../NavBar.dart';



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
  Map<String, bool> checklist1= {
     "Feed system 1:2 ratio of Food to Water": false,
     "Drain Soil Sauce": false,
     "Check dosing and holding tank levels": false,
     "Input Data Into QR Form": false,
     "Complete BioGas Form ": false,
     "Clean Area After Finished ": false,
     "Fill out involveMint": false
  };
  List <CheckListModel> selectedItems = [];

  @override
  Widget build(BuildContext context){

    CollectionReference checkListSubmit = FirebaseFirestore.instance.collection('Checklist');
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
                  height: 60.h,
                  width: 95.w,
                  child: ListView.builder(
                    itemCount: checklist1.length,
                    itemBuilder:  (BuildContext context, index){
                      String key = checklist1.keys.elementAt(index);
                      return  CheckboxListTile(
                        title:  Text(key),
                        value: checklist1[key],
                        onChanged: (bool ?value) {
                          setState(() {
                            checklist1[key] = value!;
                            selectedItems.clear();
                            checklist1.forEach((key, value) {
                              if (value) {
                                selectedItems.add(CheckListModel(key, value));
                              }
                            });
                          });
                        },
                      );
                    })
                  ),
                //Button Formatting
                  SizedBox(
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
                Padding(
                    padding: EdgeInsets.only(top: 1.h)
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
                    onPressed: (){
                      checkListSubmit.add({
                        'Name': "Team Member",
                        'Completed': selectedItems.toString().replaceAll('[', '').replaceAll(']', ''),
                        'Date':DateTime.now()})
                          .then((value) => print('Checklist Data Saved'))
                          .catchError((error) => print('Something went wrong and was not able upload;$error'));
                    },
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

class CheckListModel{
  String name;
  bool value;
  CheckListModel(this.name,this.value);
  @override
  String toString(){
    return name;
  }
}
