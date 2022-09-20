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
        return RouteGenerator();
    } else if (snapshot.hasError) {
        return Center(child: Text("Something Went Wrong with the Sign in"));
    } else {
        return Sign_In();
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

@override
void dispose(){
  super.dispose();
  emailController.dispose();
  passwordController.dispose();
}

  void emailSignUp() async{
    EmailFirebaseAuth(FirebaseAuth.instance)
        .SignUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
              child: Container(
                height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width*.5,
                child: Center(
                  child: Image.asset("lib/assets/images/Ecotone_Logo_Transparent.png"),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.00001)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.6,
            child: ElevatedButton(
              onPressed: (){
                final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: const Text("Sign In with Google",
                  style: TextStyle(fontSize: 18)
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.6,
            child: ElevatedButton(
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return Dialog(
                        insetPadding: EdgeInsets.symmetric(vertical:200, horizontal: 50),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                child: InkResponse(
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.transparent,
                                  ),
                                )
                            ),
                            Form(
                              key:_formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: Image.asset("lib/assets/images/Ecotone_Logo_Transparent.png"),
                                      height: 100,
                                      width: 100,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            hintText:"Enter Your Email",
                                          ) ,
                                    ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: TextFormField(
                                        obscureText: true,
                                      controller:passwordController,
                                        decoration: InputDecoration(
                                          hintText: "Enter Your Password",
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                            )
                          ],
                        ),
                      );
                    }
                );
              },
              child: const Text("Sign Up with Email",
                  style: TextStyle(fontSize: 18)
              ),
            ),
          ),
        ],
      ),
    );
  }
}