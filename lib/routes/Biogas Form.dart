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
          children: const <Widget>[
            TextField(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Whatever you want',
                  contentPadding: EdgeInsets.only(top: 10.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.red,
                  ),
                ),
              ),
            TextField(
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Whatever you want',
                contentPadding: EdgeInsets.only(top: 10.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}



