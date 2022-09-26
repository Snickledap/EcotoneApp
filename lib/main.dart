import 'package:ecotone_app/Login_Page.dart';
import 'package:ecotone_app/routes/login/Google_Login_Setup.dart';
import 'package:ecotone_app/routes/map/QR_Scanning_Page.dart';
import 'package:ecotone_app/routes/profile/Consumer_Profile.dart';
import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/map/Map_Page.dart';
import 'package:ecotone_app/routes/checklist/Checklist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ecotone_app/routes/information/Information.dart';
import 'package:ecotone_app/routes/map/Data_Analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:ecotone_app/routes/checklist/Biogas Form.dart';




Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HomePage());
}
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(
            FirebaseAuth.instance),
        ),
        StreamProvider(create: (context) => context.read<FirebaseAuthMethods>().authState, initialData: null,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Home(),
      ),
      ),
    );
      }
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

class ConsumerRouteGenerator extends StatelessWidget{
  const ConsumerRouteGenerator({super.key});

  @override
  Widget build(BuildContext context){
    String initialRoute = "/Consumer_Profile";

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/Consumer_Profile':
            return PageTransition(child: ConsumerProfile(), type: PageTransitionType.fade);
          case '/BioGas':
            return PageTransition(child: BioGasForm(), type: PageTransitionType.fade);
          case '/QR':
            return PageTransition(child: QRScanningPage(), type: PageTransitionType.fade);
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
    FirebaseAuthMethods(FirebaseAuth.instance)
        .SignUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }
 void emailLogin() async {
  FirebaseAuthMethods(FirebaseAuth.instance)
      .loginWithEmail(
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.13),
              child: Container(
                height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width*.7,
                child: Center(
                  child: Image.asset("lib/assets/images/Ecotone_Logo_Transparent.png"),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 60)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.9,
            child: ElevatedButton(
              onPressed: (){
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signInWithGoogle(context);
              },
              child: Text("GET STARTED",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                ),
                ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF60c301)
              ),
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.08,
            width: MediaQuery.of(context).size.width*0.9,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                );
                },
              child: Text("I ALREADY HAVE AN ACCOUNT",
                  style: GoogleFonts.roboto(
                  fontSize: 18,
              ),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF309be9),
            ),
            ),
          ),
        ],
      ),
    );
  }
}