import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Google_Login_Setup.dart';

void main() => runApp(SignInPage());

//Header
class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
         child: MaterialApp(
            home: Scaffold(
              body: Sign_In(),
            ),
        )
  );
}


class Sign_In extends StatefulWidget {

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
              child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width*0.5,
                child: Center(
                  child: Image.asset("lib/assets/images/Loading_Screen.png"),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.6,
            child: ElevatedButton(
              onPressed: (){},
              child: Text("Sign In"),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.6,
            child: ElevatedButton(
              onPressed: (){
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Text("Sign In with Google"),
          ),
          ),
        ],
      ),
    );
  }
}
