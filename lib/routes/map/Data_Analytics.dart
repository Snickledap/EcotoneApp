import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:ecotone_app/NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:graphic/graphic.dart';

String last_date= "5/28/2022";

//These names should match the collection names in Firestore, will change the drop down menu
List<String> systemNames = <String>[
  "IPH-ZEUS",
  "Seahorse 1"
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
    final response = await http.get(Uri.parse("apiKey"));

    return response;
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

class AnalyticsPage extends StatelessWidget {

@override
Widget build(BuildContext context) {
  CollectionReference channelFeed = FirebaseFirestore.instance.collection('channelfeed');

  String dropdownValue = systemNames[0];
  ChannelFeed cf = new ChannelFeed(channelFeed);
  //List<dynamic> df = jsonDecode(cf.fetchData("IPH-ZEUS"));
  //print('df:  ${df}');



  return Sizer(builder: (context, orientation, deviceType) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Analytics"),
            leadingWidth: 17.w,
            backgroundColor: const Color(0xFF309BE9), //Ecotone Colors
            actions: [
              TextButton(
                style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue)
              ),
                onPressed: (){},
                child: Text('All',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
                ),
              )
            ],
          ),
          body: SizedBox(
            child: Column(
              children:<Widget>[
                Container(  //Dropdown for selecting system
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                        dropdownValue = newValue!;
                        //print("New value:  ${newValue}");
                        //print("Dropdown value:  ${dropdownValue}");
                      },
                    //Drop Down List
                    items: systemNames.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 350,
                  height: 300,
                  child: Chart(
                    data: [ DataTemp(DateTime(2022, 9, 19), 5),
                      DataTemp(DateTime(2022, 9, 26), 25),
                      DataTemp(DateTime(2022, 10, 3), 100),
                      DataTemp(DateTime(2022, 10, 10), 75),],
                    variables: {
                      'time': Variable(
                        accessor: (DataTemp d) => d.time,
                        scale: TimeScale(formatter: (time) =>
                            DateFormat('MM-dd').format(time))
                      ),
                      'values': Variable(
                        accessor: (DataTemp v) => v.db,
                      ),
                    },
                    elements: [
                      LineElement(
                        shape: ShapeAttr(value: BasicLineShape(dash: [5, 2])),
                        selected: {
                          'touchMove': {1}
                        },
                      )
                    ],
                    coord: RectCoord(color: const Color(0xffdddddd)),
                    axes: [
                      Defaults.horizontalAxis,
                      Defaults.verticalAxis,
                    ],
                    selections: {
                      'touchMove': PointSelection(
                        on: {
                          GestureType.scaleUpdate,
                          GestureType.tapDown,
                          GestureType.longPressMoveUpdate
                        },
                        dim: Dim.x,
                      )
                    },
                    tooltip: TooltipGuide(
                      followPointer: [false, true],
                      align: Alignment.topLeft,
                      offset: const Offset(-20, -20),
                    ),
                  ),
                )
              ]
            )
          ),

          //Bottom Navigation Bar
          bottomNavigationBar: NavBar(),
    );
  }
  );
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





