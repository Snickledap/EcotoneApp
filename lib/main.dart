import 'package:ecotone_app/routes/login_and_signup/login_page.dart';
import 'package:ecotone_app/routes/login_and_signup/signup_page.dart';
import 'package:ecotone_app/routes/login_and_signup/login_setup.dart';
import 'package:ecotone_app/routes/map/qr_scanning_page.dart';
import 'package:ecotone_app/routes/profile/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecotone_app/routes/map/map_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const HomePage());
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          home: Builder(
            builder: (BuildContext context) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.13),
                          child: SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .5,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * .7,
                            child: Center(
                              child: Image.asset(
                                  "lib/assets/images/Ecotone_Logo_Transparent.png"),
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 60)),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator
                                .push(context, MaterialPageRoute(
                                builder: (context) => const SignUpPage()
                            ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF60c301)
                          ),
                          child: Text("GET STARTED",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.08,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator
                                .push(context, MaterialPageRoute(
                                builder: (context) => const LoginPage()
                            ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF309be9),
                          ),
                          child: Text("I ALREADY HAVE AN ACCOUNT",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          )
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}



class RouteGenerator extends StatelessWidget{
  const RouteGenerator({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: "/Consumer_Profile",
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/Consumer_Profile':
            return PageTransition(child: const ProfilePage(), type: PageTransitionType.fade);
          case '/Map':
            return PageTransition(child: const MapPage(), type: PageTransitionType.fade);
          case '/QR':
            return PageTransition(child: const QRScanningPage(), type: PageTransitionType.fade);
          default:
            return null;
        }
      },
    );
  }
}
