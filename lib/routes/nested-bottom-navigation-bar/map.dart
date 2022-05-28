import 'package:flutter/material.dart';

void main() => runApp(Map());

class Map extends StatelessWidget{

  Widget build(BuildContext context){
    return MaterialApp(
      home: Map(),
    );
  }
}

class Maping extends StatefulWidget {
  const Maping({Key? key}) : super(key: key);

  @override
  State<Maping> createState() => MapingState();
}

class MapingState extends State<Maping> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Map'),
      ),
      body: SizedBox(
          width:double.infinity,
          height:double.infinity),
    );
  }
  }