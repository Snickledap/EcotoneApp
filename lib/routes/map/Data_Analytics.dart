import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

String last_date= "5/28/2022";

//These names should match the collection names in Firestore, will change the drop down menu
List<String> systemNames = <String>[
  "IPH-ZEUS",
];

String selectedSystem = "IPH-ZEUS";

class Analytics extends StatelessWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnalyticsPage(),
    );
  }
}


/*
class DisplayChart {

  Chart createChart() {
    return Chart();
  }
}
*/


class DataTemp {
  final DateTime time;
  final num db;

  DataTemp(this.time, this.db);
}

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  AnalyticsPageState createState() => AnalyticsPageState();
}


class AnalyticsPageState extends State<AnalyticsPage> {

  late CollectionReference cr;
  late String dropdownValue = systemNames[0];

  @override
  void initState() {
    super.initState();

    cr = FirebaseFirestore.instance.collection('channelfeed');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Map<String, dynamic> df = jsonDecode(cf.fetchData("IPH-ZEUS"));
    //print('df:  ${df}');

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Analytics"),
            leadingWidth: 17.w,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
          ),
          bottomNavigationBar: NavBar(),
          body: SizedBox(
            child: Column(
                children: <Widget>[
                  Center(
                    child: Container( //Dropdown for selecting system
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                            //print("New value:  ${newValue}");
                            //print("Dropdown value:  ${dropdownValue}");
                          },
                          //Drop Down List
                          items: systemNames.map<DropdownMenuItem<String>>((
                              String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                    ),
                  ), //Dropdown menu for system selection
                  FutureBuilder<dynamic>(
                        future: getData(),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          else {
                            if (snapshot.error != null) {
                              return Center(child: Text('An error occured'));
                            }
                            else {  //Where you use the data
                              //print("From after the future returned: ${snapshot.data}");
                              return Container(
                                height: 500,
                                width: 400,
                                child: ListView.builder(
                                  itemCount: 3,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          DataChart(snapshot.data),
                                          Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                          DataChart(snapshot.data)
                                        ],
                                      ),
                                    );
                                  },

                                ),
                              );


                                     }

                            }
                          }
                          ),


                ]
    ),
          )
      );
     });
  }
  //This function retrieves the api_key from Firestore and uses it to download the .json data from ThingSpeak
  Future<dynamic> getData() async {
    late String apiKey;

    //This line gets the API keys stored in Firestore
    await cr.doc(dropdownValue).get().then((DocumentSnapshot ds) {
      print('Document name: $dropdownValue');
      print('Document data: ${ds.data()}');

      apiKey = (ds.data()! as Map<String, dynamic>)['field6'];

      //print('apiKey:  $apiKey');
    });

    //http GET request using the URL obtained from Firestore (apikey)
    //response
    var response = await http.get(Uri.parse(apiKey));

    //A http response object is formatted into header + body
    //The bod contains the actual info we need in String form
    //Use jsonDecode to turn the String into a json object and store it in a Map
    Map<String, dynamic> obj = jsonDecode(response.body);

    //These lines remove nulls
    List temp = obj["feeds"];
    List reversedTemp = temp.reversed.toList();
    String timestamp = reversedTemp[0].keys.first;
    String fieldName = reversedTemp[0].keys.last;
    //print(temp[0][fieldName].runtimeType);
    List temp2 = [];
    List reversedTemp2 = temp2.reversed.toList();
    for(var i in reversedTemp) {
      if(i[fieldName] != null) {
        reversedTemp2.add([i[timestamp], i[fieldName]]);
      }
    }
    //print(temp);
    //print(temp2);
    return reversedTemp2;
  }
}


class SystemSelectMenu extends StatefulWidget {
  const SystemSelectMenu({Key? key}) : super(key: key);

  @override
  State<SystemSelectMenu> createState() => _SystemSelectMenuState();
}

class _SystemSelectMenuState extends State<SystemSelectMenu> {
  static String dropdownValue = 'IPH-ZEUS';

  @override
  Widget build(BuildContext context) {

    //Drop Down Menu
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          //print("New value:  ${newValue}");
          //print("Dropdown value:  ${dropdownValue}");

        });
      },

      //Drop Down List
      items: systemNames.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  String getDropdownValue() {
    return dropdownValue;
  }
}

//Self-defined class to place data into appropriate locations for visualization
class DataChart extends StatelessWidget {

  late List<dynamic> data;

  //This constructor accepts a List
  DataChart(this.data, {super.key});



  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: Colors.black)
      ),
      height: 125,
      width: 125,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Center(
          child: Text(
              'Internal Stomach Temperature'+ '\n'+ '\n'+data[1].last +' F',
          textAlign:TextAlign.center,
          ),
        ),
          onTap:(){
          showDialog(
          context: context,
          builder: (BuildContext context){
         return AlertDialog(
           icon: Align(
             alignment: Alignment.topLeft,
               child:IconButton(
                onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back),
           )),
           title: Text('Internal Stomach Temperature',
           textAlign: TextAlign.center,),
          content: Padding(
            padding: EdgeInsets.all(2),
            child: SizedBox(
              height: 350,
              width: 400,
              child: ListView.builder(
                reverse: false,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                  print(data[0].runtimeType);
                  return ListTile(
                    title: Text(
                           DateFormat.yMd()
                              .add_jm()
                              .format(
                                DateTime
                                  .parse(data[index][0])
                                    .toLocal())
                                      .toString()
                            + "  Temperature: "
                            + data[index][1]
                            +' F')
                  );
                  }
                  ),

            ),
            ),
          );
          }
      );
  }
  ),
    );
  }



}



