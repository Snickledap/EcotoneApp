import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Header
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Flutter Form Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Creating Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  // Create a global key that uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // Text Box #1
      Padding(
        padding: EdgeInsets.only(top: 40.0),
          child: new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
      ),

      // Text Box #1
      Padding(
        padding: EdgeInsets.only(top: 40.0),
          child: new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.calendar_today),
              hintText: 'Enter the current date',
              labelText: 'Date',
            ),
          ),
      ),

      // Text Box #1
      Padding(
        padding: EdgeInsets.only(top: 40.0),
          child: new TextFormField(
            decoration: const InputDecoration(
              icon: const Icon(Icons.numbers),
              hintText: 'Cumulative biogas production (m^3). Enter all digits listed on \n the flow meter to the third decimal place',
              labelText: 'BioGas',
            ),
          ),
      ),

          //Button Format
          const Padding(padding: EdgeInsets.all(170)),
          Container(alignment: Alignment.center,height:60, width: 600, child:

          //Button
          ElevatedButton(
              style:ElevatedButton.styleFrom(
                primary: Color(0xFF015486),
                onPrimary: Colors.white,
                elevation: 4,
              ),

              //Button Action
              onPressed: (){},

              //Button
              child: Align(
                alignment: Alignment.center,
                child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 24.0),
                    textAlign: TextAlign.center
                ),
              )
          )
          )
        ],
      )
      );
  }
}



