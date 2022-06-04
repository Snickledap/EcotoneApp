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
        body: Login(),
      ),
    );
  }
}
// Create a Form widget.
class Login extends StatefulWidget {
  @override
  LoginState createState() {
    return LoginState();
  }
}
// Create a corresponding State class. This class holds data related to the form.
class LoginState extends State<Login> {

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
            //Email Entry Field
            Padding(
              padding: EdgeInsets.all(25.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.alternate_email),
                  hintText: 'Enter your Email',
                  labelText: 'Email',
                ),
              ),
            ),

            //Password Entry Field
            Padding(
              padding: EdgeInsets.all(25.0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
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
                      "Login",
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