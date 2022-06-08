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

            //First Name Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your first name',
                  labelText: 'First Name',
                ),
              ),
            ),

            //Last Name Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your last name',
                  labelText: 'Last Name',
                ),
              ),
            ),

            //Email Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.alternate_email),
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
              ),
            ),

            //Password Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
                ),
              ),
            ),

            //Password Re-entry Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Re-enter Your Password',
                  labelText: 'Password Confirm',
                ),
              ),
            ),

            //Address Field
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.location_city),
                  hintText: 'Enter your address',
                  labelText: 'Address',
                ),
              ),
            ),

            //Phone Number Field
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.numbers),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone Number',
                ),
              ),
            ),

            //Button Format
            const Padding(padding: EdgeInsets.all(30)),
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

                //Button Text
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