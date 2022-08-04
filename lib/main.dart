import 'package:ecotone_app/routes/login/Google_Login_Setup.dart';
import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/map/Map_Page.dart';
import 'package:ecotone_app/routes/checklist/Checklist.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ecotone_app/routes/information/Information.dart';
import 'package:ecotone_app/routes/map/Data_Analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Home(),
        ),
      )
  );
  }


class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context)=> Scaffold(
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
      else if (snapshot.hasData) {
        return Map();
    } else if (snapshot.hasError) {
        return Center(child: Text("Something Went Wrong with the Sign in"));
    } else {
        return RouteGenerator();
      }
      },
    ),
  );
}




class RouteGenerator extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    String initialRoute = "/profile";

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/profile':
            return PageTransition(child: ProfilePage(), type: PageTransitionType.fade);
          case '/data_analytics':
            return PageTransition(child: AnalyticsPage(), type: PageTransitionType.fade);
          case '/map':
            return PageTransition(child: Map(), type: PageTransitionType.fade);
          case '/checklist':
            return PageTransition(child: ChecklistPage(), type: PageTransitionType.fade);
          case '/info':
            return PageTransition(child: InformationPage(), type: PageTransitionType.fade);
          case '/signin':
            return PageTransition(child: Sign_In(), type: PageTransitionType.fade);
          default:
            return null;
        }
      },
    );
  }
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