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
              child: Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Color(0xFF015486),
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.alternate_email),
                  hintText: 'Enter your Email',
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 0,0),
              child: new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter Your Password',
                  labelText: 'Password',
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(30.0, 50.0, 0,0)),
            Container(alignment: Alignment.center,height:60, width: 600, child:
            Padding(
              padding: const EdgeInsets.fromLTRB(180.0,0.0,0.0,0.0),
              child: ElevatedButton(
                  style:ElevatedButton.styleFrom(
                    primary: Color(0xFF015486),
                    onPrimary: Colors.white,
                    elevation: 4,
                  ),
                  onPressed: (){},
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                        "Login",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center
                    ),
                  )
              ),
            )
            )
          ],
        )
    );
  }
}