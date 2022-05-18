import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/nested-bottom-navigation-bar/app.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Bottom Navigation Test',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: App(),
    );
  }
}
