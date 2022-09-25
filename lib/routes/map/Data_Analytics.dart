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

class DataTemp {
  final DateTime time;
  final num db;

  DataTemp(this.time, this.db);
}

class AnalyticsPage extends StatelessWidget {

@override
Widget build(BuildContext context) {
  CollectionReference channelFeed = FirebaseFirestore.instance.collection('channelfeed');

  ChannelFeed cf = new ChannelFeed(channelFeed);
  //Map<String, dynamic> df = jsonDecode(cf.fetchData("IPH-ZEUS"));
  //print('df:  ${df}');


  return Sizer(builder: (context, orientation, deviceType) {
    return Scaffold(
          appBar: AppBar(
            leading: _DropDownMenu(),
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


class _DropDownMenu extends StatefulWidget {
  const _DropDownMenu({Key? key}) : super(key: key);

  @override
  State<_DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<_DropDownMenu> {
  String dropdownValue = 'Zeus 1';

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
        });
      },

      //Drop Down List
      items: <String>['Zeus 1', 'Zeus 2', 'Zeus 3', 'Zeus 4']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}



@override
class _TemperatureCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {

    //Temperature Container Formatting
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 45.w,
        onTap: (){},
      child:

          //Temperature Container
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              const Text('Temperature',
              textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF015486),
                  fontSize: 12,
                ),
              ),

             //Temperature Box Formatting
             Expanded(
              child: SizedBox(
                height: double.infinity,
               width: double.infinity,
               child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
             )
             ),
            ],
          ),
    );
  }
}



@override
class _pHCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {

    //PH Container Formatting
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 50.w,
        onTap: (){},
      child:

      //PH Container
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('pH',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),

            //PH Box Formatting
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}



@override
class _ConductivityCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {

    //Electrical Conductivity Formatting
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 60.w,
      onTap: (){},
      child:

        //Electrical Conductivity Container
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Electrical Conductivity',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),

            //Electrical Conductivity Box Formatting
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}



@override
class _DateCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {

    //Date Formatting
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 35.w,
      onTap: (){},
      child:

        //Date Container
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Date',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),

            //Date Box Formatting
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}



@override
class _StockCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {

    //Fertilizer Stock Formatting
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 40.w,
      onTap: (){},
      child:

        //Fertilizer Stock Container
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Fertilizer Stock',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),

            //Fertilizer Stock Box Formatting
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png'),
                )
            ),
          ],
        ),
    );
  }
}



@override
class _VolumeCard extends StatelessWidget{
  @override
  Widget build (BuildContext context) {
    //Dosing Tank Volume Container
    return CustomCard(
        borderRadius: 15,
        borderColor: Color(0xFF015486),
        color: Colors.white,
        height: 16.h,
        width: 55.w,
      onTap: (){},
      child:

        //Dosing Tank Volume
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            const Text('Dosing Tank Volume',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF015486),
                fontSize: 12,
              ),
            ),

            //Dosing Tank Volume Box Formatting
            Expanded(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset('lib/assets/images/PlaceHolderPic2.png',),
                )
            ),
          ],
        ),
    );
  }
}



