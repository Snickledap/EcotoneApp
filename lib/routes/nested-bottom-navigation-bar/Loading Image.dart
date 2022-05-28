import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root
  // of your application

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        body: Container(
          height: double.infinity,
            width: double.infinity,
            child: Image.asset('lib/assets/images/Loading_Screen_2.png'))
          ),
    );
  }
}