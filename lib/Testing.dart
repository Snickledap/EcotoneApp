import 'package:flutter/material.dart';
import 'NavBar.dart';

void main() => runApp(Test());


class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "TestingKaya",
      home: Testing(),
    );
  }
}

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  State<Testing> createState() => TestingState();
}

class TestingState extends State<Testing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Information",
          style : TextStyle(
            color: Colors.blue,
            fontSize: 20.0,
            letterSpacing: 1.0,
          )
        ),
      ),
     //bottomNavigationBar: NavBar(),

    );
  }
}
