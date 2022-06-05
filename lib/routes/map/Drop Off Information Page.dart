import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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
        body: Drop_Off(),
      ),
    );
  }
}
// Create a Form widget.
class Drop_Off extends StatefulWidget {
  @override
  Drop_OffState createState() {
    return Drop_OffState();
  }
}
// Create a corresponding State class. This class holds data related to the form.
class Drop_OffState extends State<Drop_Off> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first and last name',
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.location_on),
                  hintText: 'Enter the Seahorse location',
                  labelText: 'Location',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  hintText: 'Enter the date added',
                  labelText: 'Date',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.scale),
                  hintText: 'Enter the weight of the drop off',
                  labelText: 'Weight',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.description),
                  hintText: 'Description of items dropped off',
                  labelText: 'Description',
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            Container(alignment: Alignment.center,height:60, width: 600, child:
            ElevatedButton(
                style:ElevatedButton.styleFrom(
                  primary: Color(0xFF015486),
                  onPrimary: Colors.white,
                  elevation: 4,
                ),
                onPressed: (){},
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