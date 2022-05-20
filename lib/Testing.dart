import 'package:flutter/material.dart';
import 'NavBar.dart';

void main() => runApp(Test());


class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Testing",
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
        title: RichText(text: const TextSpan(text: "Testing"))
      ),
      bottomNavigationBar: NavBar(),

    );
  }
}
