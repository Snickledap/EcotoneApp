import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;




Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Test());
}

class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Testing",
      home: Testing(),
    );
  }
}

class Temp{
  final int time;
  final int temperature;
  const Temp({
    required this.time,
    required this.temperature
});
  static Temp fromJson(json) => Temp(time: json['description'], temperature: json['id']);
}


class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => TestingState();
}

class TestingState extends State<Testing> {
  static Future<List<Temp>> tempsFuture = getTemps();

  static Future<List<Temp>> getTemps() async{
    const url = 'https://api.thingspeak.com/channels/1832300/fields/1.json?api_key=DLZY67BP7329400O&minutes=60';
    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body.map<Temp>(Temp.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) =>Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
        body: Center(
          child: FutureBuilder<List<Temp>>(
              future:tempsFuture,
             builder: (context, snapshot) {
                if (snapshot.hasError){
                  return Text('${snapshot.error}');
                }
               else if (snapshot.hasData) {
                 final temps = snapshot.data!;
                 return buildTemp(temps);
               } else {
                 return const Text('no data');
               }
             }
             )
          ),
        );


        Widget buildTemp(List<Temp> temps) => ListView.builder(
        itemCount: temps.length,
        itemBuilder: (context, index){
          final temp = temps[index];
          return Card(
            child: ListTile(
              leading: Icon(Icons.thermostat),
              title: Text(temp.temperature.toString()),
              subtitle: Text(temp.time.toString()),
            ),
          );
        }
        );
  }

