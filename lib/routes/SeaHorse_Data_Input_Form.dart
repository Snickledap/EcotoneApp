import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';


void main() => runApp(SeaHorseDataForm());

const question1 = 'Name';
const question2 = 'Date';
const question3 = 'Weight of food waste input (lb)';
const question4 = 'Food waste type (type of vegetables, fruits, carbs, etc)';
const question5 = 'Weight of water added (lb)';
const question6 = 'Fertilizer Drained (Gallon Containers)';
const question7 = 'Fertilizer Drained (16oz Containers)';
const question8 = 'Temperature of the stomach (Fahrenheit)';


class SeaHorseDataForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sea Horse Data Input Form'),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _TextBoxes(),
            _SubmitButton(),
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),

    );
  }
}


class _TextBoxes extends StatefulWidget {
  const _TextBoxes ({Key? key}) : super(key: key);

  @override
  State<_TextBoxes> createState() => _TextBoxesState();
}
class _TextBoxesState extends State<_TextBoxes> {

  Widget build(BuildContext context) {
    return TextField(

      style: TextStyle(
        color: Colors.black,
        fontFamily: 'OpenSans',
      ),
      decoration: InputDecoration(
        label: Text('Name'),
        border: OutlineInputBorder(),
        hintText: 'Your Answer',
        contentPadding: EdgeInsets.all( 10.0),
        ),
      );

  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        child: Text('Submit'),
    );
  }
}