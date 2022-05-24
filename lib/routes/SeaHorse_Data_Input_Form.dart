import 'package:flutter/material.dart';


void main() => runApp(BioGasForm());
class BioGasForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bio Gas Form'),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           _TextBoxes(),
            _TextBoxes(),
            _SubmitButton(),
          ],
        ),
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