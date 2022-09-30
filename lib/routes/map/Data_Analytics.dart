import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
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
                          else {
                            //print("From after the future returned: ${snapshot.data}");
                            return SizedBox(
                                height: 500,
                                child: DataChart(snapshot.data));
                          }
                        }
                      }

                  ),
                ]),
          )
      );
     });
  }
  //This function retrieves the api_key from Firestore and uses it to download the .json data from ThingSpeak
  Future<dynamic> getData() async {
    late String apiKey;
    await cr.doc(dropdownValue).get().then((DocumentSnapshot ds) {
      print('Document name: $dropdownValue');
      //print('Document data: ${ds.data()}');

      apiKey = (ds.data()! as Map<String, dynamic>)['api_key'];

      print('apiKey:  $apiKey');
    });

    var response = await http.get(Uri.parse(apiKey));

    Map<String, dynamic> obj = jsonDecode(response.body);

    //Remove nulls
    var temp = obj["feeds"];
    var temp2 = <dynamic>[];
    for(var i in temp) {
      if(i["field1"] != null) {
        temp2.add(i);
      }
    }
    print(temp2);
    return temp2;
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


class DataChart extends StatelessWidget {

  late List<dynamic> data;
  DataChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {


    return Scrollbar(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Time: " + data[index]["created_at"] + "  Temperature:" + data[index]["field1"])
          );
        }
      ),
    );
  }



}



