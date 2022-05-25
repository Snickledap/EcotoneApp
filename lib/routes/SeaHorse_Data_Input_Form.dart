import 'package:flutter/material.dart';
import 'package:ecotone_app/NavBar.dart';


void main() => runApp(SeaHorseDataForm());
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
            _SubmitButton(),
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),

    );
  }
}


class _TextBoxes extends StatelessWidget {
  @override
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