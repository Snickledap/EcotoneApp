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
        body: Sign_Up(),
      ),
    );
  }
}
// Create a Form widget.
class Sign_Up extends StatefulWidget {
  @override
  Sign_UpState createState() {
    return Sign_UpState();
  }
}
// Create a corresponding State class. This class holds data related to the form.
class Sign_UpState extends State<Sign_Up> {
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
              padding: const EdgeInsets.fromLTRB(40.0, 30.0, 0,0),
              child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 40.0,
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.alternate_email),
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Renter Your Password',
                  labelText: 'Password Confirm',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.location_city),
                  hintText: 'Enter your address',
                  labelText: 'Address',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.numbers),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number',
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0)),
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
                      "Sign Up",
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