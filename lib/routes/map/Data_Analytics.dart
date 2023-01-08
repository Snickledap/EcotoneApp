import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:graphic/graphic.dart';
import 'dart:convert';

String last_date= "5/28/2022";

//These names should match the collection names in Firestore, will change the drop down menu
List<String> systemNames = <String>[
  "IPH-ZEUS",
];

String selectedSystem = "IPH-ZEUS";

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Any());


}


class Any extends StatelessWidget {
  const Any({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnalyticsPage(),
    );
  }
}

class ChannelFeed {

  late CollectionReference channelFeed;
  late String apiKey;
  ChannelFeed(this.channelFeed);

  fetchApiKey(String systemLabel) async {

    await channelFeed.doc(systemLabel).get().then((DocumentSnapshot ds) {
      print('Document name: ${systemLabel}');
      print('Document data: ${ds.data()}');

      apiKey = (ds.data()! as Map<String, dynamic>)['api_key'];

      print('apiKey:  ${apiKey}');
    });
  }

  fetchData(String systemLabel) async{
    await fetchApiKey(systemLabel);
    var response = await http.get(Uri.parse(apiKey));
    print(jsonDecode(response.body));
    return response.body;
  }
}

/*
class DisplayChart {

  Chart createChart() {
    return Chart();
  }
}
*/


class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  AnalyticsPageState createState() => AnalyticsPageState();
}


class AnalyticsPageState extends State<AnalyticsPage> {

  late CollectionReference cr;
  late String dropdownValue = systemNames[0];

  late String apiKey;
  late String channel_id;

  late String timeStamp;

  late List listOfFieldNames;
  late List latestValues;
  late List fieldValues = [];



  @override
  void initState() {
    super.initState();

    cr = FirebaseFirestore.instance.collection('channelfeed');
    setState(() {});
  }

  //This function connects to Firebase to retrieve the API key and channel ID for a given Ecotone system
  void getZeusData() async{
    await cr.doc(dropdownValue).get().then((DocumentSnapshot ds) {

      apiKey = (ds.data()! as Map<String, dynamic>)['apiKey'];
      channel_id = (ds.data()! as Map<String, dynamic>)['channel_id'];
      //print('apiKey:  $apiKey');
    });
  }


  //This function retrieves the apiKey and channel_id of a given Ecotone system
  //and uses it to download data from a corresponding ThingSpeak channel
  Future<dynamic> getLatestData() async {

    getZeusData();

    //Build a URL to retrieve channel field data from ThingSpeak
    //Here, we are retrieving data from all fields at once in order to display the latest value available for each field
    String url = "https://api.thingspeak.com/channels/" + channel_id + "/feeds.json?api_key=" + apiKey + "&days=1";
    print(url);

    //http GET request using the URL obtained from Firestore (apikey)
    //response
    var response = await http.get(Uri.parse(url));

    //A http response object is formatted into header + body
    //The body contains the actual info we need in String form
    //Use jsonDecode to turn the String into a json object and store it in a Map<String, dynamic>
    Map<String, dynamic> obj = jsonDecode(response.body);


    //We grab the names for each field and corresponding values for use later
    Map<String, dynamic> channelHeader = obj["channel"];

    //print("testing: " + channelHeader.keys.toString());

    //fieldNames contains a list of lists containing and formatted like so: ["field", name of sensor data]
    listOfFieldNames = [];

    for(String i in channelHeader.keys) {
      if(i.contains("field")) {
        listOfFieldNames.add([i, channelHeader[i]]);
      }
    }
    print("Field Names: $listOfFieldNames");


    //From ThingSpeak, we grab the latest values captured by each sensor
    //We start at the bottom of the "feeds" list (it is listed in chronological order, so start at the end for the latest data)
    //and grab the value if the corresponding boolean in isLatestValueSaved is false AND value is not null
    List isLatestValueSaved = [];
    latestValues = []; //latestValues will hold the latest recorded values for each tracked data type
    for(var i = 0; i < listOfFieldNames.length; i++){
      isLatestValueSaved.add(false);
      latestValues.add(null);
    }


    var feeds = obj["feeds"];

    for(var i = feeds.length - 1; i >= 0; i--) {
      //For each data entry in "feeds", check for non-null values where isLatestValueSaved is false
      //If the latest value is not saved AND the value at current data entry is non-null, save it and set isLatestValueSaved to true
      for(var j = 0; j < isLatestValueSaved.length; j++) {
        if(!isLatestValueSaved[j] && feeds[i][listOfFieldNames[j][0]] != null) {
          isLatestValueSaved[j] = true;
          latestValues[j] = feeds[i][listOfFieldNames[j][0]];
        }
      }
    }

    //And now we have the latest values recorded for each data type from the specified Zeus system
    print("Latest values: " + latestValues.toString());
  }

  Future<dynamic> getFieldData(int index) async {


    String url = "https://api.thingspeak.com/channels/" + channel_id + "/fields/" + (index+1).toString() + ".json?api_key=" + apiKey + "&days=1";
    print(url);

    var response = await http.get(Uri.parse(url));

    //print(response.body.runtimeType);
    Map<String, dynamic> obj = jsonDecode(response.body);
    //print(obj["feeds"]);

    List<dynamic> feeds = obj["feeds"];
    //print("Feeds: " + feeds.toString());

    Map<String, dynamic> feedsTemp = feeds[0];
    //print("First entry in Feeds: " + feedsTemp.toString());

    List feedsKeys = feedsTemp.keys.toList();

    //print("Feeds keys: " + feedsKeys.toString());

    fieldValues = [];

    for(var i = 0; i < feeds.length; i++) {
      if(feeds[i][feedsKeys.last] != null)
        fieldValues.add([feeds[i][feedsKeys.first], feeds[i][feedsKeys.last]]);

    }

    //print("Field values: " + fieldValues.toString());

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
                        future: getLatestData(),
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
                                  itemCount: listOfFieldNames.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return
                                      Container(
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
                                                listOfFieldNames[index][1].toString()+ '\n'+ '\n' +' ${latestValues[index]}',
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
                                                      title: Text("${listOfFieldNames[index][1]}",
                                                        textAlign: TextAlign.center,),
                                                      content: Padding(
                                                        padding: EdgeInsets.all(2),
                                                        child: SizedBox(
                                                          height: 350,
                                                          width: 400,
                                                          child: FutureBuilder<dynamic>(
                                                            future: getFieldData(index),  /*FIELD DATA*********************/
                                                            builder: (ctx, snapshot) {
                                                              if(snapshot.connectionState == ConnectionState.waiting) {
                                                                return Center(child: CircularProgressIndicator());
                                                              }
                                                              else {
                                                                if (snapshot.error != null) {
                                                                  //print(fieldValues.toString());
                                                                  return Center(child: Text('An error occured'));
                                                                }
                                                                else {
                                                                  return ListView.builder(
                                                                      scrollDirection: Axis.vertical,
                                                                      shrinkWrap: true,
                                                                      itemCount: fieldValues.length,
                                                                      itemBuilder: (context, index) {
                                                                        return ListTile(
                                                                            title: Text("Time:" + fieldValues[index][0].toString()),
                                                                            subtitle: Text("Value: " + fieldValues[index][1].toString()),

                                                                        );
                                                                      }
                                                                  );
                                                                }
                                                              }
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
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                  print(data[0].runtimeType);
                  return ListTile(
                    title: Text("Time: " + data[index][0] + "  Value:" + data[index][1])
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





